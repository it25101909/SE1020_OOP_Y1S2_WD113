<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Zip SL - All Bookings</title>
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #f5f5f5; padding: 40px; margin: 0; }
        .container { background: white; padding: 30px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); max-width: 1200px; margin: auto; }

        h2 { color: #1a2a4a; margin-bottom: 25px; display: flex; align-items: center; gap: 10px; }

        table { width: 100%; border-collapse: collapse; margin-top: 10px; background: white; }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; font-size: 14px; }
        th { background-color: #4a6da7; color: white; text-transform: uppercase; letter-spacing: 0.5px; }
        tr:hover { background-color: #fafafa; }

        /* Status Pills */
        .status-pill { padding: 5px 12px; border-radius: 20px; font-size: 11px; font-weight: bold; text-transform: uppercase; display: inline-block; }
        .pending { background: #ffeaa7; color: #d6a316; }
        .confirmed { background: #d4edda; color: #155724; }
        .completed { background: #cce5ff; color: #004085; }

        /* Action Buttons */
        .btn-action { border: none; padding: 6px 10px; border-radius: 4px; cursor: pointer; color: white; font-size: 14px; transition: 0.2s; }
        .btn-confirm { background-color: #2ecc71; }
        .btn-confirm:hover { background-color: #27ae60; }
        .btn-delete { background-color: #e74c3c; }
        .btn-delete:hover { background-color: #c0392b; }

        .back-link { display: inline-block; margin-top: 20px; color: #4a6da7; text-decoration: none; font-weight: bold; }
        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>

    <div class="container">
        <h2>Ã°Å¸â€œâ€¹ Ride Booking Records</h2>
        <div style="margin-bottom: 20px; display: flex; justify-content: flex-end;">
            <form action="/searchBookings" method="get" style="display: flex; gap: 10px;">
                <input type="text" name="query" placeholder="Search by Booking ID..."
                       value="${searchQuery}"
                       style="padding: 8px; border: 1px solid #ddd; border-radius: 4px; width: 250px;">
                <button type="submit" style="background: #4a6da7; color: white; border: none; padding: 8px 15px; border-radius: 4px; cursor: pointer;">
                    Search
                </button>
                <a href="/viewBookings" style="padding: 8px; text-decoration: none; color: #666; font-size: 13px;">Clear</a>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>User ID</th>
                    <th>Driver</th>
                    <th>Route (From - To)</th>
                    <th>Type</th>
                    <th>Scheduled</th>
                    <th>Status</th>
                    <th>Fare (LKR)</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${allBookings}" var="b">
                    <tr>
                        <td><strong>${b.bookingId}</strong></td>
                        <td>${b.userId}</td>
                        <td>${b.driverId}</td>
                        <td>${b.pickupLocation} Ã¢â€ â€™ ${b.dropLocation}</td>
                        <td>${b.bookingType}</td>
                        <td>${b.scheduledTime}</td>
                        <td>
                            <span class="status-pill ${b.status.toLowerCase()}">${b.status}</span>
                        </td>
                        <td>${b.fare}</td>
                        <td>
                            <div style="display: flex; gap: 8px;">
                                <c:if test="${b.status != 'Confirmed'}">
                                    <form action="/updateBookingStatus" method="post">
                                        <input type="hidden" name="bookingId" value="${b.bookingId}">
                                        <input type="hidden" name="status" value="Confirmed">
                                        <button type="submit" class="btn-action btn-confirm" title="Confirm Booking">Ã¢Å“â€</button>
                                    </form>
                                </c:if>

                                <form action="/deleteBooking" method="post" onsubmit="return confirm('Are you sure you want to cancel this booking?');">
                                    <input type="hidden" name="bookingId" value="${b.bookingId}">
                                    <button type="submit" class="btn-action btn-delete" title="Cancel Booking">Ã¢Å“Ëœ</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <a href="/home" class="back-link">Ã¢â€ Â Return to Dashboard</a>
    </div>

</body>
</html>
