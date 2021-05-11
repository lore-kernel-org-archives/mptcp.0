Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC26970
	for <mptcp@lists.linux.dev>; Tue, 11 May 2021 13:37:09 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1lgSZQ-0000TI-Cw; Tue, 11 May 2021 15:37:08 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH v2 mptcp-next 1/8] mptcp: enable busypoll from mptcp receive path
Date: Tue, 11 May 2021 15:36:52 +0200
Message-Id: <20210511133659.29982-2-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210511133659.29982-1-fw@strlen.de>
References: <20210511133659.29982-1-fw@strlen.de>
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
index 652e55a0c6e8..86e599eb4403 100644
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
@@ -1982,6 +1983,12 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len, addr_len);
 
+	if (sk_can_busy_loop(sk) &&
+	    skb_queue_empty_lockless(&msk->receive_queue) &&
+	    skb_queue_empty_lockless(&sk->sk_receive_queue) &&
+	    inet_sk_state_load(sk) == TCP_ESTABLISHED)
+		sk_busy_loop(sk, nonblock);
+
 	mptcp_lock_sock(sk, __mptcp_splice_receive_queue(sk));
 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
 		copied = -ENOTCONN;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index a79798189599..ee55e4145d7e 100644
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

