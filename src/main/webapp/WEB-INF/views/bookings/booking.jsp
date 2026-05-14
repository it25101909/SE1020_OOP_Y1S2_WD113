<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Request a Ride | Zip SL</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <style>
        :root {
            --primary: #f97316;
            --primary-hover: #ea580c;
            --bg-dark: #08080a;
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
            --glass-bg: rgba(20, 20, 25, 0.6);
            --glass-border: rgba(255, 255, 255, 0.1);
            --card-bg: rgba(20,20,25,0.6);
        }
        /* ===== LIGHT THEME ===== */
        [data-theme="light"] {
            --text-main: #1a1a2e;
            --text-muted: #4a5568;
            --glass-bg: rgba(255,255,255,0.8);
            --glass-border: rgba(0,0,0,0.12);
            --card-bg: rgba(255,255,255,0.85);
        }
        [data-theme="light"] body { background: #dde3f0; color: #1a1a2e; }
        [data-theme="light"] .bg-night { opacity: 0; pointer-events: none; }
        [data-theme="light"] .bg-light { opacity: 1 !important; }
        .bg-light {
            position: fixed; inset: 0; z-index: 0; pointer-events: none; overflow: hidden;
            opacity: 0; transition: opacity 0.5s ease;
            filter: blur(10px) brightness(0.8);
            transform: scale(1.1);
        }
        .bg-night {
            position: fixed; inset: 0; z-index: 0; pointer-events: none; overflow: hidden;
            opacity: 1; transition: opacity 0.5s ease;
            filter: blur(10px) brightness(0.7);
            transform: scale(1.1);
        }
        [data-theme="dark"] .bg-light { opacity: 0; pointer-events: none; }
        [data-theme="light"] .form-container { background: var(--card-bg); border-color: rgba(0,0,0,0.1); }
        [data-theme="light"] .form-container h2 { color: #1a1a2e; }
        [data-theme="light"] .input-group label { color: #4a5568; }
        [data-theme="light"] input, [data-theme="light"] select { background: rgba(0,0,0,0.05); border-color: rgba(0,0,0,0.1); color: #1a1a2e; }
        [data-theme="light"] .ride-option { background: rgba(0,0,0,0.03); border-color: rgba(0,0,0,0.08); }
        [data-theme="light"] .ride-option.active { border-color: var(--primary); background: rgba(249,115,22,0.08); }
        [data-theme="light"] .ride-option h4 { color: #1a1a2e; }

        #theme-toggle {
            position: fixed;
            top: 18px;
            right: 22px;
            z-index: 9999;
            background: var(--card-bg);
            border: 1px solid var(--glass-border);
            backdrop-filter: blur(12px);
            border-radius: 50px;
            padding: 8px 16px;
            font-size: 0.9rem;
            cursor: pointer;
            color: var(--text-main);
            font-family: 'Outfit', sans-serif;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        #theme-toggle:hover { transform: translateY(-2px) scale(1.05); border-color: var(--primary); }

    </style>
    <script>
        function updateToggleButton(theme) {
            const btn = document.getElementById('theme-toggle');
            if (btn) {
                btn.innerHTML = theme === 'light' ? 'Ã¢Ëœâ‚¬Ã¯Â¸Â Light' : 'Ã°Å¸Å’â„¢ Dark';
            }
        }

        function toggleTheme(){
            const html = document.documentElement;
            const currentTheme = html.getAttribute('data-theme') || 'dark';
            const next = currentTheme === 'dark' ? 'light' : 'dark';
            
            html.setAttribute('data-theme', next);
            localStorage.setItem('theme', next);
            updateToggleButton(next);
        }

        // Apply theme on load
        (function() {
            const savedTheme = localStorage.getItem('theme') || 'dark';
            document.documentElement.setAttribute('data-theme', savedTheme);
            window.addEventListener('DOMContentLoaded', () => updateToggleButton(savedTheme));
        })();
    </script>
</head>
<body>
    <button id="theme-toggle" onclick="toggleTheme()">Ã°Å¸Å’â„¢ Dark</button>
    <style>
        body { 
            font-family: 'Outfit', sans-serif; 
            background: #08080a;
            color: var(--text-main);
            display: flex; 
            flex-direction: column; 
            align-items: center; 
            margin: 0; 
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* Ambient Orbs */
        .orb {
            position: fixed;
            border-radius: 50%;
            filter: blur(100px);
            opacity: 0.2;
            z-index: 0;
            pointer-events: none;
        }
        .orb-1 { width: 400px; height: 400px; background: var(--primary); top: 10%; left: -10%; }
        .orb-2 { width: 500px; height: 500px; background: #4338ca; bottom: 10%; right: -10%; }

        .top-nav { 
            width: 100%; 
            padding: 20px 40px; 
            box-sizing: border-box; 
            margin-bottom: 20px; 
            z-index: 10;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .top-nav a { 
            color: var(--text-main); 
            font-size: 24px; 
            font-weight: 800; 
            text-decoration: none; 
            display: flex; 
            align-items: center; 
            gap: 10px; 
        }
        .top-nav a span { color: var(--primary); }
        .back-link {
            color: var(--text-muted);
            text-decoration: none;
            font-weight: 600;
            transition: 0.3s;
        }
        .back-link:hover { color: white; }
        
        .main-container { 
            display: flex; 
            gap: 30px; 
            width: 100%; 
            max-width: 1200px; 
            padding: 0 20px; 
            box-sizing: border-box; 
            margin-bottom: 40px; 
            z-index: 10;
            animation: fadeInUp 0.6s ease backwards;
        }

        .booking-card { 
            background: var(--glass-bg); 
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            padding: 35px; 
            border-radius: 24px; 
            border: 1px solid var(--glass-border);
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5); 
            flex: 1; 
            min-width: 400px; 
        }

        .map-container { 
            background: var(--glass-bg); 
            backdrop-filter: blur(20px);
            border-radius: 24px; 
            border: 1px solid var(--glass-border);
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5); 
            flex: 1.5; 
            overflow: hidden; 
            height: 650px; 
            position: relative; 
        }
        #map { height: 100%; width: 100%; }
        
        h2 { color: white; text-align: center; margin-bottom: 25px; margin-top: 0; font-weight: 700; }
        .form-group { margin-bottom: 18px; position: relative; }
        label { display: block; font-weight: 600; margin-bottom: 8px; color: var(--text-muted); font-size: 13px; }
        
        input, select { 
            width: 100%; 
            padding: 14px 16px; 
            background: rgba(0, 0, 0, 0.2); 
            border: 1px solid var(--glass-border); 
            border-radius: 12px; 
            box-sizing: border-box; 
            font-size: 14px; 
            color: var(--text-main);
            font-family: 'Outfit', sans-serif;
            transition: 0.3s;
        }
        select option { background: #1a1a2e; color: var(--text-main); }
        
        input:focus, select:focus {
            outline: none;
            border-color: var(--primary);
            background: rgba(0, 0, 0, 0.4);
            box-shadow: 0 0 0 4px rgba(249, 115, 22, 0.1);
        }

        .search-btn {
            background: var(--primary); 
            color: white; 
            border: none; 
            border-radius: 12px; 
            padding: 0 20px; 
            cursor: pointer;
            transition: 0.3s;
        }
        .search-btn:hover { background: var(--primary-hover); }

        .row { display: flex; gap: 15px; }
        .row .form-group { flex: 1; }
        
        .btn-submit { 
            width: 100%; 
            padding: 16px; 
            background: var(--primary); 
            color: white; 
            border: none; 
            border-radius: 12px; 
            font-weight: 700; 
            font-size: 16px; 
            cursor: pointer; 
            margin-top: 15px; 
            transition: 0.3s; 
            font-family: 'Outfit', sans-serif;
        }
        .btn-submit:hover { 
            background: var(--primary-hover); 
            transform: translateY(-2px);
            box-shadow: 0 10px 25px -5px rgba(249, 115, 22, 0.4);
        }
        .btn-submit:disabled {
            background: rgba(255, 255, 255, 0.1);
            color: var(--text-muted);
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        .error { color: #fca5a5; background: rgba(239, 68, 68, 0.1); padding: 12px; border-radius: 8px; margin-bottom: 20px; text-align: center; font-size: 14px; border: 1px solid rgba(239, 68, 68, 0.3); }
        
        .fare-box { 
            background: rgba(0, 0, 0, 0.2); 
            padding: 20px; 
            border-radius: 16px; 
            margin-top: 25px; 
            border: 1px solid var(--glass-border); 
            text-align: center;
        }
        .fare-amount { font-size: 28px; font-weight: 800; color: var(--primary); display: block; margin: 5px 0; }
        .distance-info { font-size: 14px; color: var(--text-muted); font-weight: 600; }
        
        .map-instructions { 
            position: absolute; 
            top: 20px; 
            left: 50%; 
            transform: translateX(-50%); 
            z-index: 1000; 
            background: rgba(20, 20, 25, 0.85); 
            backdrop-filter: blur(10px);
            padding: 10px 20px; 
            border-radius: 30px; 
            font-size: 13px; 
            font-weight: 600; 
            pointer-events: none; 
            border: 1px solid var(--glass-border); 
            color: white;
            box-shadow: 0 4px 15px rgba(0,0,0,0.3);
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 900px) {
            .main-container { flex-direction: column; }
            .map-container { height: 400px; }
            .booking-card { min-width: 100%; }
        }
    </style>
    <script>
        (function(){
            var t = localStorage.getItem('kc-theme') || 'dark';
            document.documentElement.setAttribute('data-theme', t);
        })();
        function toggleTheme(){
            var html = document.documentElement;
            var next = html.getAttribute('data-theme') === 'dark' ? 'light' : 'dark';
            html.setAttribute('data-theme', next);
            localStorage.setItem('kc-theme', next);
            var btn = document.getElementById('theme-toggle');
            btn.innerHTML = next === 'dark' ? '&#9790; Dark' : '&#9788; Light';
        }
        window.onload = function() {
            var t = localStorage.getItem('kc-theme') || 'dark';
            var btn = document.getElementById('theme-toggle');
            if(btn) btn.innerHTML = t === 'dark' ? '&#9790; Dark' : '&#9788; Light';
        }
    </script>
</head>
<body>
    <button id="theme-toggle" onclick="toggleTheme()">&#9790; Dark</button>


    <!-- Dynamic Backgrounds -->
    <div class="bg-night">
        <img src="${pageContext.request.contextPath}/images/bg-dark.png" alt="" style="width:100%;height:100%;object-fit:cover;">
        <div style="position:absolute;inset:0;background:linear-gradient(rgba(8,8,10,0.4),rgba(8,8,10,0.4));"></div>
    </div>
    <div class="bg-light">
        <img src="${pageContext.request.contextPath}/images/bg-light.png" alt="" style="width:100%;height:100%;object-fit:cover;">
        <div style="position:absolute;inset:0;background:linear-gradient(rgba(255,255,255,0.2),rgba(255,255,255,0.2));"></div>
    </div>
    <!-- ============ END BACKGROUND ============ -->

    <div class="orb orb-1"></div>
    <div class="orb orb-2"></div>

    <div class="top-nav">
        <a href="${pageContext.request.contextPath}/home">Ã°Å¸Å¡â€¢ Zip<span>SL</span></a>
        <a href="${pageContext.request.contextPath}/home" class="back-link">Ã¢â€ Â Back to Dashboard</a>
    </div>

    <div class="main-container">
        <!-- Booking Form -->
        <div class="booking-card">
            <h2>Trip Details</h2>

            <div id="companyAlert" style="display:none; background: rgba(239, 68, 68, 0.1); color: #fca5a5; border: 1px solid rgba(239, 68, 68, 0.3); padding: 12px; border-radius: 8px; margin-bottom: 20px; text-align: center; font-weight: bold;">
                Ã°Å¸Å¡Â« Sorry, all vehicles in this company are currently occupied.
            </div>

            <c:if test="${param.error == 'same_location'}">
                <div class="error">Pickup and Destination cannot be the same!</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/create-booking" method="post">
                <div class="form-group">
                    <label>Pickup Location</label>
                    <div style="display: flex; gap: 8px;">
                        <input type="text" id="pickupLocation" name="pickupLocation" placeholder="Type address and press Enter or Search..." required>
                        <button type="button" class="search-btn" onclick="searchLocation(document.getElementById('pickupLocation').value, 'pickup')">Ã°Å¸â€Â</button>
                    </div>
                </div>

                <div class="form-group">
                    <label>Drop Location</label>
                    <div style="display: flex; gap: 8px;">
                        <input type="text" id="dropLocation" name="dropLocation" placeholder="Type address and press Enter or Search..." required>
                        <button type="button" class="search-btn" onclick="searchLocation(document.getElementById('dropLocation').value, 'drop')">Ã°Å¸â€Â</button>
                    </div>
                </div>

                <div class="form-group">
                    <label>Preferred Company (Optional)</label>
                    <select name="cooperation" id="companySelect" onchange="checkCompanyAvailability()">
                        <option value="none">Any Available Driver (Normal)</option>
                        <c:forEach var="c" items="${companies}">
                            <option value="${c.id}">${c.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="row">
                    <div class="form-group">
                        <label>Vehicle Type</label>
                        <select name="vehicleType" id="vType">
                            <option value="Tuk">Three-Wheelers (Tuk-tuk)</option>
                            <option value="Moto">Motorbikes (Moto)</option>
                            <option value="Mini">Small Cars (Budget)</option>
                            <option value="Sedan">Standard Cars (Sedan)</option>
                            <option value="Premium">Premium Cars</option>
                            <option value="Van">Large Vehicles (Vans/SUVs)</option>
                            <option value="Luxury">Luxury Cars</option>
                        </select>
                        <div id="availabilityInfo" style="font-size: 11px; margin-top: 6px; color: var(--text-muted);">
                            Availability: Ready to check...
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="form-group">
                        <label>Schedule</label>
                        <select name="bookingType" id="bookingTypeSelect" onchange="toggleTimeInput()">
                            <option value="Instant">Ride Now</option>
                            <option value="Scheduled">Schedule for Later</option>
                        </select>
                    </div>
                    <div class="form-group" id="timeInputGroup" style="display: none;">
                        <label>Time</label>
                        <input type="time" name="scheduledTime">
                    </div>
                </div>

                <div class="form-group">
                    <label>Payment Method</label>
                    <select name="paymentMethod" id="paymentMethod" onchange="checkPaymentMethod()">
                        <option value="Cash">Ã°Å¸â€™Âµ Cash to Driver</option>
                        <c:choose>
                            <c:when test="${loggedInUser.cardNumber != 'Not Set'}">
                                <option value="Card">Ã°Å¸â€™Â³ Pay by Card (Ends in ${loggedInUser.cardNumber.substring(loggedInUser.cardNumber.length() - 4)})</option>
                            </c:when>
                            <c:otherwise>
                                <option value="Card" disabled>Ã°Å¸â€™Â³ Pay by Card (No Card Configured)</option>
                            </c:otherwise>
                        </c:choose>
                    </select>
                    <c:if test="${loggedInUser.cardNumber == 'Not Set'}">
                        <p style="font-size: 12px; color: #fca5a5; margin-top: 6px;">
                            <a href="${pageContext.request.contextPath}/profile" style="color: var(--primary); text-decoration: none; font-weight: bold;">Click here</a> to add your card details.
                        </p>
                    </c:if>
                </div>

                <div class="fare-box">
                    <span class="distance-info" id="distLabel">DISTANCE: 0.0 km</span>
                    <span class="fare-amount" id="displayFare">LKR 0.00</span>
                    <span style="font-size: 11px; color: var(--text-muted);">*Base fare LKR 100 + Per KM charge</span>
                </div>

                <!-- Hidden inputs -->
                <input type="hidden" name="distance" id="distanceInput" value="0.0">
                <input type="hidden" name="fare" id="fareInput" value="0.0">

                <button type="submit" id="submitBtn" class="btn-submit">Confirm Ride Request</button>
            </form>
        </div>

        <!-- Map Container -->
        <div class="map-container">
            <div class="map-instructions">Ã°Å¸â€œÂ Click map or type address and press Enter</div>
            <div id="map"></div>
        </div>
    </div>

    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <script>
        // Sri Lanka Bounds
        const slBounds = L.latLngBounds([5.9, 79.5], [9.9, 82.0]);

        // Initialize Map (Center on Colombo, Sri Lanka)
        var map = L.map('map', {
            center: [7.8731, 80.7718], // Center of SL
            zoom: 7,
            maxBounds: slBounds,
            maxBoundsViscosity: 1.0,
            minZoom: 7
        });

        // Use a darker map tile layer if possible, else standard OSM
        L.tileLayer('https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png', {
            attribution: 'Ã‚Â© OpenStreetMap contributors Ã‚Â© CARTO'
        }).addTo(map);

        var pickupMarker = null;
        var dropMarker = null;
        var routeLine = null;

        // Function to search location by text (Geocoding)
        async function searchLocation(query, type) {
            if (!query || query.length < 3) return;
            
            // Show loading state
            const input = document.getElementById(type + 'Location');
            const originalVal = input.value;
            input.value = "Searching...";
            
            try {
                // Strict Sri Lanka search
                const response = await fetch('https://nominatim.openstreetmap.org/search?format=json&q=' + encodeURIComponent(query) + '&countrycodes=lk&limit=1');
                const data = await response.json();
                
                if (data && data.length > 0) {
                    const latlng = { lat: parseFloat(data[0].lat), lng: parseFloat(data[0].lon) };
                    const displayName = data[0].display_name.split(',')[0] + ", " + data[0].display_name.split(',')[1];
                    
                    if (type === 'pickup') {
                        setPickup(latlng, displayName);
                    } else {
                        setDrop(latlng, displayName);
                    }
                    map.setView(latlng, 15);
                } else {
                    input.value = originalVal;
                    alert("Location not found in Sri Lanka. Please try a different name.");
                }
            } catch (err) {
                console.error("Geocoding error:", err);
                input.value = originalVal;
            }
        }

        function setPickup(latlng, name) {
            if (pickupMarker) map.removeLayer(pickupMarker);
            pickupMarker = L.marker(latlng, {draggable: true, title: "Pickup"}).addTo(map);
            pickupMarker.bindPopup("<b style='color:black;'>Pickup:</b><br><span style='color:black;'>" + (name || "Selected Point") + "</span>").openPopup();
            
            document.getElementById('pickupLocation').value = name || (latlng.lat.toFixed(4) + ", " + latlng.lng.toFixed(4));
            
            pickupMarker.on('dragend', function() {
                let pos = this.getLatLng();
                document.getElementById('pickupLocation').value = pos.lat.toFixed(4) + ", " + pos.lng.toFixed(4);
                calculateTrip();
            });
            calculateTrip();
        }

        function setDrop(latlng, name) {
            if (dropMarker) map.removeLayer(dropMarker);
            dropMarker = L.marker(latlng, {draggable: true, title: "Drop"}).addTo(map);
            dropMarker.bindPopup("<b style='color:black;'>Drop-off:</b><br><span style='color:black;'>" + (name || "Selected Point") + "</span>").openPopup();
            
            document.getElementById('dropLocation').value = name || (latlng.lat.toFixed(4) + ", " + latlng.lng.toFixed(4));
            
            dropMarker.on('dragend', function() {
                let pos = this.getLatLng();
                document.getElementById('dropLocation').value = pos.lat.toFixed(4) + ", " + pos.lng.toFixed(4);
                calculateTrip();
            });
            calculateTrip();
        }

        map.on('click', function(e) {
            if (!pickupMarker) {
                setPickup(e.latlng);
            } else if (!dropMarker) {
                setDrop(e.latlng);
            } else {
                // Reset
                map.removeLayer(pickupMarker);
                map.removeLayer(dropMarker);
                if(routeLine) map.removeLayer(routeLine);
                pickupMarker = null;
                dropMarker = null;
                routeLine = null;
                document.getElementById('pickupLocation').value = "";
                document.getElementById('dropLocation').value = "";
                calculateTrip();
            }
        });

        // Event listeners for typing
        document.getElementById('pickupLocation').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                searchLocation(this.value, 'pickup');
            }
        });
        document.getElementById('pickupLocation').addEventListener('blur', function() {
            if (this.value && this.value !== "Searching..." && !this.value.includes(",")) {
                searchLocation(this.value, 'pickup');
            }
        });

        document.getElementById('dropLocation').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                searchLocation(this.value, 'drop');
            }
        });
        document.getElementById('dropLocation').addEventListener('blur', function() {
            if (this.value && this.value !== "Searching..." && !this.value.includes(",")) {
                searchLocation(this.value, 'drop');
            }
        });

        function calculateTrip() {
            if (pickupMarker && dropMarker) {
                var pLatlng = pickupMarker.getLatLng();
                var dLatlng = dropMarker.getLatLng();
                
                // Draw line
                if (routeLine) map.removeLayer(routeLine);
                routeLine = L.polyline([pLatlng, dLatlng], {color: '#f97316', weight: 4, opacity: 0.8, dashArray: '10, 10'}).addTo(map);
                
                // Calculate Distance
                var distance = (pLatlng.distanceTo(dLatlng) / 1000).toFixed(2);
                document.getElementById('distanceInput').value = distance;
                document.getElementById('distLabel').innerText = "DISTANCE: " + distance + " km";

                updateFareDisplay(distance);
            } else {
                document.getElementById('distLabel').innerText = "DISTANCE: 0.0 km";
                document.getElementById('displayFare').innerText = "LKR 0.00";
            }
        }

        function updateFareDisplay(distance) {
            let vType = document.getElementById("vType").value;
            let baseFare = 100;
            let pricePerKm = 80;

            switch(vType.toLowerCase()) {
                case 'tuk': pricePerKm = 50; break;
                case 'moto': pricePerKm = 40; break;
                case 'mini': pricePerKm = 80; break;
                case 'sedan': pricePerKm = 120; break;
                case 'premium': pricePerKm = 180; break;
                case 'van': pricePerKm = 150; break;
                case 'luxury': pricePerKm = 300; break;
            }

            let totalFare = baseFare + (distance * pricePerKm);
            document.getElementById('displayFare').innerText = "LKR " + totalFare.toFixed(2);
            document.getElementById('fareInput').value = totalFare.toFixed(2);
        }

        document.getElementById("vType").addEventListener('change', function() {
            var dist = document.getElementById('distanceInput').value;
            if (dist > 0) updateFareDisplay(dist);
        });

        async function checkCompanyAvailability() {
            const companyId = document.getElementById('companySelect').value;
            const submitBtn = document.getElementById('submitBtn');
            const alertBox = document.getElementById('companyAlert');
            const infoBox = document.getElementById('availabilityInfo');
            const vTypeSelect = document.getElementById('vType');

            try {
                const response = await fetch('${pageContext.request.contextPath}/api/check-availability?companyId=' + companyId);
                const data = await response.json();

                if (!data.anyAvailable && companyId !== 'none') {
                    submitBtn.disabled = true;
                    submitBtn.innerText = 'Company Busy';
                    alertBox.style.display = 'block';
                } else {
                    submitBtn.disabled = false;
                    submitBtn.innerText = 'Confirm Ride Request';
                    alertBox.style.display = 'none';
                }

                // Update individual type availability indicators
                let availText = "Availability: ";
                const types = ['Tuk', 'Moto', 'Mini', 'Sedan', 'Premium', 'Van', 'Luxury'];
                types.forEach(t => {
                    const isAvail = data.availability[t];
                    availText += t + ": " + (isAvail ? 'Ã¢Å“â€¦' : 'Ã¢ÂÅ’') + " ";
                    
                    // Disable specific options in dropdown if busy
                    const option = vTypeSelect.querySelector('option[value="' + t + '"]');
                    if (option) {
                        option.disabled = !isAvail;
                        if (!isAvail && vTypeSelect.value === t) {
                            // If selected one is now disabled, pick another
                            vTypeSelect.selectedIndex = -1;
                        }
                    }
                });
                infoBox.innerHTML = availText;

            } catch (err) {
                console.error("Availability check error:", err);
            }
        }

        function toggleTimeInput() {
            var type = document.getElementById('bookingTypeSelect').value;
            var timeGroup = document.getElementById('timeInputGroup');
            if (type === 'Scheduled') {
                timeGroup.style.display = 'block';
            } else {
                timeGroup.style.display = 'none';
            }
        }

        window.onload = function() {
            checkCompanyAvailability();
            toggleTimeInput();
        };
    </script>
</body>
</html>
