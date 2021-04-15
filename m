Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F5E6D32
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 01:59:44 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.48:54452.1147090965
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9?logid-a24984fa52b0421db8890352ca924471 (unknown [172.18.0.48])
	by chinatelecom.cn (HERMES) with SMTP id 104412800EC;
	Thu, 15 Apr 2021 09:59:45 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([172.18.0.48])
	by app0024 with ESMTP id a24984fa52b0421db8890352ca924471 for mptcp@lists.linux.dev;
	Thu Apr 15 09:59:42 2021
X-Transaction-ID: a24984fa52b0421db8890352ca924471
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: Yonglong Li <liyonglong@chinatelecom.cn>
To: mptcp@lists.linux.dev,
	liyonglong@chinatelecom.cn
Subject: [PATCH v2 1/2] mptcp: add MSG_PEEK support
Date: Thu, 15 Apr 2021 09:58:54 +0800
Message-Id: <1618451935-78322-1-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

This patch adds support for MSG_PEEK flag. Packets are not removed
from the receive_queue if MSG_PEEK set in recv() system call.

Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
---
 net/mptcp/protocol.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2d895c3..93367ff 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1710,12 +1710,12 @@ static void mptcp_wait_data(struct sock *sk, long *timeo)
 
 static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 				struct msghdr *msg,
-				size_t len)
+				size_t len, int flags)
 {
-	struct sk_buff *skb;
+	struct sk_buff *skb, *tmp;
 	int copied = 0;
 
-	while ((skb = skb_peek(&msk->receive_queue)) != NULL) {
+	skb_queue_walk_safe(&msk->receive_queue, skb, tmp) {
 		u32 offset = MPTCP_SKB_CB(skb)->offset;
 		u32 data_len = skb->len - offset;
 		u32 count = min_t(size_t, len - copied, data_len);
@@ -1731,15 +1731,18 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 		copied += count;
 
 		if (count < data_len) {
-			MPTCP_SKB_CB(skb)->offset += count;
+			if (!(flags & MSG_PEEK))
+				MPTCP_SKB_CB(skb)->offset += count;
 			break;
 		}
 
-		/* we will bulk release the skb memory later */
-		skb->destructor = NULL;
-		msk->rmem_released += skb->truesize;
-		__skb_unlink(skb, &msk->receive_queue);
-		__kfree_skb(skb);
+		if (!(flags & MSG_PEEK)) {
+			/* we will bulk release the skb memory later */
+			skb->destructor = NULL;
+			msk->rmem_released += skb->truesize;
+			__skb_unlink(skb, &msk->receive_queue);
+			__kfree_skb(skb);
+		}
 
 		if (copied >= len)
 			break;
@@ -1916,7 +1919,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	int target;
 	long timeo;
 
-	if (msg->msg_flags & ~(MSG_WAITALL | MSG_DONTWAIT))
+	if (flags & ~(MSG_PEEK | MSG_WAITALL | MSG_DONTWAIT))
 		return -EOPNOTSUPP;
 
 	mptcp_lock_sock(sk, __mptcp_splice_receive_queue(sk));
@@ -1933,7 +1936,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	while (copied < len) {
 		int bytes_read;
 
-		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied);
+		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied, flags);
 		if (unlikely(bytes_read < 0)) {
 			if (!copied)
 				copied = bytes_read;
@@ -2017,7 +2020,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	pr_debug("msk=%p data_ready=%d rx queue empty=%d copied=%d",
 		 msk, test_bit(MPTCP_DATA_READY, &msk->flags),
 		 skb_queue_empty_lockless(&sk->sk_receive_queue), copied);
-	mptcp_rcv_space_adjust(msk, copied);
+	if (!(flags & MSG_PEEK))
+		mptcp_rcv_space_adjust(msk, copied);
 
 	release_sock(sk);
 	return copied;
-- 
1.8.3.1

