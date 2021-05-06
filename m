Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828A770
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 10:23:02 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1leb9i-0001O3-NE; Thu, 06 May 2021 12:22:54 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next 1/8] mptcp: enable busypoll from mptcp receive path
Date: Thu,  6 May 2021 12:22:36 +0200
Message-Id: <20210506102243.2390-2-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210506102243.2390-1-fw@strlen.de>
References: <20210506102243.2390-1-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The setting is only relevant for the msk socket.
While at it, also handle rcvlowat/rcvtimeo this way.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/protocol.c | 7 +++++++
 net/mptcp/sockopt.c  | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index aec8e77b18e4..e51070883064 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -12,6 +12,7 @@
 #include <linux/sched/signal.h>
 #include <linux/atomic.h>
 #include <net/sock.h>
+#include <net/busy_poll.h>
 #include <net/inet_common.h>
 #include <net/inet_hashtables.h>
 #include <net/protocol.h>
@@ -1966,6 +1967,12 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len, addr_len);
 
+	if (sk_can_busy_loop(sk) &&
+	    skb_queue_empty_lockless(&msk->receive_queue) &&
+	    skb_queue_empty_lockless(&sk->sk_receive_queue) &&
+	     inet_sk_state_load(sk) == TCP_ESTABLISHED)
+		sk_busy_loop(sk, nonblock);
+
 	mptcp_lock_sock(sk, __mptcp_splice_receive_queue(sk));
 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
 		copied = -ENOTCONN;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 00d941b66c1e..c98e4e116992 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -254,6 +254,14 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
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
+		break;
 	case SO_NO_CHECK:
 	case SO_DONTROUTE:
 	case SO_BROADCAST:
-- 
2.26.3

