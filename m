Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7841A71
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 09:49:31 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1lhURl-0006tQ-T8; Fri, 14 May 2021 11:49:29 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH v3 mptcp-next 6/7] mptcp: receive path cmsg support
Date: Fri, 14 May 2021 11:48:56 +0200
Message-Id: <20210514094857.10663-7-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210514094857.10663-1-fw@strlen.de>
References: <20210514094857.10663-1-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for SO_TIMESTAMP(NS).  Timestamps are passed to
userspace in the same way as for plain tcp sockets.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/protocol.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 652e55a0c6e8..a157872c3164 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -39,10 +39,15 @@ struct mptcp_skb_cb {
 	u64 map_seq;
 	u64 end_seq;
 	u32 offset;
+	u8  has_rxtstamp:1;
 };
 
 #define MPTCP_SKB_CB(__skb)	((struct mptcp_skb_cb *)&((__skb)->cb[0]))
 
+enum {
+	MPTCP_CMSG_TS = BIT(0),
+};
+
 static struct percpu_counter mptcp_sockets_allocated;
 
 static void __mptcp_destroy_sock(struct sock *sk);
@@ -272,6 +277,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = (struct sock *)msk;
 	struct sk_buff *tail;
+	bool has_rxtstamp;
 
 	__skb_unlink(skb, &ssk->sk_receive_queue);
 
@@ -287,6 +293,8 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 			goto drop;
 	}
 
+	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
+
 	/* the skb map_seq accounts for the skb offset:
 	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
 	 * value
@@ -294,6 +302,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
 	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;
 	MPTCP_SKB_CB(skb)->offset = offset;
+	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
@@ -1767,7 +1776,9 @@ static void mptcp_wait_data(struct sock *sk, long *timeo)
 
 static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 				struct msghdr *msg,
-				size_t len, int flags)
+				size_t len, int flags,
+				struct scm_timestamping_internal *tss,
+				int *cmsg_flags)
 {
 	struct sk_buff *skb, *tmp;
 	int copied = 0;
@@ -1787,6 +1798,11 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 			}
 		}
 
+		if (MPTCP_SKB_CB(skb)->has_rxtstamp) {
+			tcp_update_recv_tstamps(skb, tss);
+			*cmsg_flags |= MPTCP_CMSG_TS;
+		}
+
 		copied += count;
 
 		if (count < data_len) {
@@ -1974,7 +1990,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			 int nonblock, int flags, int *addr_len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	int copied = 0;
+	struct scm_timestamping_internal tss;
+	int copied = 0, cmsg_flags = 0;
 	int target;
 	long timeo;
 
@@ -1996,7 +2013,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	while (copied < len) {
 		int bytes_read;
 
-		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied, flags);
+		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied, flags, &tss, &cmsg_flags);
 		if (unlikely(bytes_read < 0)) {
 			if (!copied)
 				copied = bytes_read;
@@ -2077,6 +2094,11 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		set_bit(MPTCP_DATA_READY, &msk->flags);
 	}
 out_err:
+	if (cmsg_flags && copied >= 0) {
+		if (cmsg_flags & MPTCP_CMSG_TS)
+			tcp_recv_timestamp(msg, sk, &tss);
+	}
+
 	pr_debug("msk=%p data_ready=%d rx queue empty=%d copied=%d",
 		 msk, test_bit(MPTCP_DATA_READY, &msk->flags),
 		 skb_queue_empty_lockless(&sk->sk_receive_queue), copied);
-- 
2.26.3

