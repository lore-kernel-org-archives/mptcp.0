Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BFB2C85
	for <mptcp@lists.linux.dev>; Mon,  8 Nov 2021 11:23:42 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1mk2L7-0006Xg-J9; Mon, 08 Nov 2021 11:57:25 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next 1/3] mptcp: add TCP_INQ cmsg support
Date: Mon,  8 Nov 2021 11:57:09 +0100
Message-Id: <20211108105711.16200-2-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211108105711.16200-1-fw@strlen.de>
References: <20211108105711.16200-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support the TCP_INQ setsockopt.
This is a boolean that tells recvmsg path to include the remaining
in-sequence bytes into a cmsg data.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/224
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/protocol.c | 33 +++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  1 +
 net/mptcp/sockopt.c  | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b0bfe20d6bb0..b4263bf821ac 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -46,6 +46,7 @@ struct mptcp_skb_cb {
 
 enum {
 	MPTCP_CMSG_TS = BIT(0),
+	MPTCP_CMSG_INQ = BIT(1),
 };
 
 static struct percpu_counter mptcp_sockets_allocated;
@@ -2006,6 +2007,29 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 	return !skb_queue_empty(&msk->receive_queue);
 }
 
+static unsigned int mptcp_inq_hint(const struct sock *sk)
+{
+	const struct mptcp_sock *msk = mptcp_sk(sk);
+	const struct sk_buff *skb;
+	u64 acked = msk->ack_seq;
+	u64 hint_val = 0;
+
+	skb = skb_peek(&msk->receive_queue);
+	if (skb) {
+		u64 map_seq = MPTCP_SKB_CB(skb)->map_seq + MPTCP_SKB_CB(skb)->offset;
+
+		hint_val = acked - map_seq;
+
+		if (hint_val >= INT_MAX)
+			hint_val = INT_MAX - 1;
+	}
+
+	if (hint_val == 0 && sock_flag(sk, SOCK_DONE))
+		hint_val = 1;
+
+	return (unsigned int)hint_val;
+}
+
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			 int nonblock, int flags, int *addr_len)
 {
@@ -2030,6 +2054,9 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	len = min_t(size_t, len, INT_MAX);
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
 
+	if (unlikely(msk->recvmsg_inq))
+		cmsg_flags = MPTCP_CMSG_INQ;
+
 	while (copied < len) {
 		int bytes_read;
 
@@ -2103,6 +2130,12 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	if (cmsg_flags && copied >= 0) {
 		if (cmsg_flags & MPTCP_CMSG_TS)
 			tcp_recv_timestamp(msg, sk, &tss);
+
+		if (cmsg_flags & MPTCP_CMSG_INQ) {
+			unsigned int inq = mptcp_inq_hint(sk);
+
+			put_cmsg(msg, SOL_TCP, TCP_CM_INQ, sizeof(inq), &inq);
+		}
 	}
 
 	pr_debug("msk=%p rx queue empty=%d:%d copied=%d",
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 906509c6cde5..e77de7662df0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -250,6 +250,7 @@ struct mptcp_sock {
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	bool		csum_enabled;
 	bool		allow_infinite_fallback;
+	u8		recvmsg_inq:1;
 	spinlock_t	join_list_lock;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index b818e91f2e09..7405152691e0 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -557,6 +557,7 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		case TCP_TIMESTAMP:
 		case TCP_NOTSENT_LOWAT:
 		case TCP_TX_DELAY:
+		case TCP_INQ:
 			return true;
 		}
 
@@ -698,7 +699,21 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    sockptr_t optval, unsigned int optlen)
 {
+	struct sock *sk = (void *)msk;
+	int ret, val;
+
 	switch (optname) {
+	case TCP_INQ:
+		ret = mptcp_get_int_option(msk, optval, optlen, &val);
+		if (ret)
+			return ret;
+		if (val < 0 || val > 1)
+			return -EINVAL;
+
+		lock_sock(sk);
+		msk->recvmsg_inq = !!val;
+		release_sock(sk);
+		return 0;
 	case TCP_ULP:
 		return -EOPNOTSUPP;
 	case TCP_CONGESTION:
@@ -1032,6 +1047,26 @@ static int mptcp_getsockopt_subflow_addrs(struct mptcp_sock *msk, char __user *o
 	return 0;
 }
 
+static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
+				int __user *optlen, int val)
+{
+	int len;
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+
+	len = min_t(unsigned int, len, sizeof(int));
+	if (len < 0)
+		return -EINVAL;
+
+	if (put_user(len, optlen))
+		return -EFAULT;
+	if (copy_to_user(optval, &val, len))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    char __user *optval, int __user *optlen)
 {
@@ -1042,6 +1077,8 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_CC_INFO:
 		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
 						      optval, optlen);
+	case TCP_INQ:
+		return mptcp_put_int_option(msk, optval, optlen, msk->recvmsg_inq);
 	}
 	return -EOPNOTSUPP;
 }
-- 
2.32.0

