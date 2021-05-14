Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05A271
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 09:49:22 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1lhURd-0006sh-Fq; Fri, 14 May 2021 11:49:21 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH v3 mptcp-next 4/7] mptcp: setsockopt: handle SOL_SOCKET in one place only
Date: Fri, 14 May 2021 11:48:54 +0200
Message-Id: <20210514094857.10663-5-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210514094857.10663-1-fw@strlen.de>
References: <20210514094857.10663-1-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the pre-check to the function that handles all SOL_SOCKET values.

At this point there is complete coverage for all values that were
accepted by the pre-check.

BUSYPOLL functions are accepted but will not have any functionality
yet until its clear how the expected mptcp behaviour should look like.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/sockopt.c | 99 +++++++++++++--------------------------------
 1 file changed, 29 insertions(+), 70 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 3168ad4a9298..092d1f635d27 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -304,6 +304,14 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 		return mptcp_setsockopt_sol_socket_int(msk, optname, optval, optlen);
 	case SO_LINGER:
 		return mptcp_setsockopt_sol_socket_linger(msk, optval, optlen);
+	case SO_RCVLOWAT:
+	case SO_RCVTIMEO_OLD:
+	case SO_RCVTIMEO_NEW:
+	case SO_BUSY_POLL:
+	case SO_PREFER_BUSY_POLL:
+	case SO_BUSY_POLL_BUDGET:
+		/* No need to copy: only relevant for msk */
+		return sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname, optval, optlen);
 	case SO_NO_CHECK:
 	case SO_DONTROUTE:
 	case SO_BROADCAST:
@@ -317,7 +325,24 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
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
@@ -349,72 +374,6 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 
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
-
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
@@ -624,12 +583,12 @@ int mptcp_setsockopt(struct sock *sk, int level, int optname,
 
 	pr_debug("msk=%p", msk);
 
-	if (!mptcp_supported_sockopt(level, optname))
-		return -ENOPROTOOPT;
-
 	if (level == SOL_SOCKET)
 		return mptcp_setsockopt_sol_socket(msk, optname, optval, optlen);
 
+	if (!mptcp_supported_sockopt(level, optname))
+		return -ENOPROTOOPT;
+
 	/* @@ the meaning of setsockopt() when the socket is connected and
 	 * there are multiple subflows is not yet defined. It is up to the
 	 * MPTCP-level socket to configure the subflows until the subflow
-- 
2.26.3

