Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6689A70
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 10:23:14 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1lebA0-0001Pg-Tc; Thu, 06 May 2021 12:23:13 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next 5/8] mptcp: setsockopt: handle SOL_SOCKET in one place only
Date: Thu,  6 May 2021 12:22:40 +0200
Message-Id: <20210506102243.2390-6-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210506102243.2390-1-fw@strlen.de>
References: <20210506102243.2390-1-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the pre-check to the function that handles all SOL_SOCKET
values.

At this point there is complete coverage for all values that have
been accepted previously.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/sockopt.c | 89 +++++++++++----------------------------------
 1 file changed, 22 insertions(+), 67 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 7b47204ecb9a..a83c0e4669d7 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -311,7 +311,8 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	case SO_PREFER_BUSY_POLL:
 	case SO_BUSY_POLL_BUDGET:
 		/* No need to copy: only relevant for msk */
-		break;
+		return sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname, optval, optlen);
+
 	case SO_NO_CHECK:
 	case SO_DONTROUTE:
 	case SO_BROADCAST:
@@ -325,7 +326,24 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 		return 0;
 	}
 
-	return sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname, optval, optlen);
+	/* SO_OOBINLINE is not supported, let's avoid the related mess
+	 * SO_ATTACH_FILTER, SO_ATTACH_BPF, SO_ATTACH_REUSEPORT_CBPF,
+	 * SO_DETACH_REUSEPORT_BPF, SO_DETACH_FILTER, SO_LOCK_FILTER,
+	 * we must be careful with subflows
+	 *
+	 * SO_ATTACH_REUSEPORT_EBPF is not supported, at it checks
+	 * explicitly the sk_protocol field
+	 *
+	 * SO_PEEK_OFF is unsupported, as it is for plain TCP
+	 * SO_MAX_PACING_RATE is unsupported, we must be careful with subflows
+	 * SO_CNX_ADVICE is currently unsupported, could possibly be relevant,
+	 * but likely needs careful design
+	 *
+	 * SO_ZEROCOPY is currently unsupported, TODO in sndmsg
+	 * SO_TXTIME is currently unsupported
+	 */
+
+	return -EOPNOTSUPP;
 }
 
 static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
@@ -357,72 +375,9 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 
 static bool mptcp_supported_sockopt(int level, int optname)
 {
-	if (level == SOL_SOCKET) {
-		switch (optname) {
-		case SO_DEBUG:
-		case SO_REUSEPORT:
-		case SO_REUSEADDR:
-
-		/* the following ones need a better implementation,
-		 * but are quite common we want to preserve them
-		 */
-		case SO_BINDTODEVICE:
-		case SO_SNDBUF:
-		case SO_SNDBUFFORCE:
-		case SO_RCVBUF:
-		case SO_RCVBUFFORCE:
-		case SO_KEEPALIVE:
-		case SO_PRIORITY:
-		case SO_LINGER:
-		case SO_TIMESTAMP_OLD:
-		case SO_TIMESTAMP_NEW:
-		case SO_TIMESTAMPNS_OLD:
-		case SO_TIMESTAMPNS_NEW:
-		case SO_TIMESTAMPING_OLD:
-		case SO_TIMESTAMPING_NEW:
-		case SO_RCVLOWAT:
-		case SO_RCVTIMEO_OLD:
-		case SO_RCVTIMEO_NEW:
-		case SO_SNDTIMEO_OLD:
-		case SO_SNDTIMEO_NEW:
-		case SO_MARK:
-		case SO_INCOMING_CPU:
-		case SO_BINDTOIFINDEX:
-		case SO_BUSY_POLL:
-		case SO_PREFER_BUSY_POLL:
-		case SO_BUSY_POLL_BUDGET:
-
-		/* next ones are no-op for plain TCP */
-		case SO_NO_CHECK:
-		case SO_DONTROUTE:
-		case SO_BROADCAST:
-		case SO_BSDCOMPAT:
-		case SO_PASSCRED:
-		case SO_PASSSEC:
-		case SO_RXQ_OVFL:
-		case SO_WIFI_STATUS:
-		case SO_NOFCS:
-		case SO_SELECT_ERR_QUEUE:
-			return true;
-		}
+	if (level == SOL_SOCKET)
+		return true; /* mptcp_setsockopt_sol_socket handles this */
 
-		/* SO_OOBINLINE is not supported, let's avoid the related mess */
-		/* SO_ATTACH_FILTER, SO_ATTACH_BPF, SO_ATTACH_REUSEPORT_CBPF,
-		 * SO_DETACH_REUSEPORT_BPF, SO_DETACH_FILTER, SO_LOCK_FILTER,
-		 * we must be careful with subflows
-		 */
-		/* SO_ATTACH_REUSEPORT_EBPF is not supported, at it checks
-		 * explicitly the sk_protocol field
-		 */
-		/* SO_PEEK_OFF is unsupported, as it is for plain TCP */
-		/* SO_MAX_PACING_RATE is unsupported, we must be careful with subflows */
-		/* SO_CNX_ADVICE is currently unsupported, could possibly be relevant,
-		 * but likely needs careful design
-		 */
-		/* SO_ZEROCOPY is currently unsupported, TODO in sndmsg */
-		/* SO_TXTIME is currently unsupported */
-		return false;
-	}
 	if (level == SOL_IP) {
 		switch (optname) {
 		/* should work fine */
-- 
2.26.3

