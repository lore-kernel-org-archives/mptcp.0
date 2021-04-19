Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.228])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FE02F83
	for <mptcp@lists.linux.dev>; Mon, 19 Apr 2021 02:54:40 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.48:34752.612161389
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9?logid-d782fd9c13ed41ba930a2c60b4a12aac (unknown [172.18.0.48])
	by chinatelecom.cn (HERMES) with SMTP id F1D7E28011E;
	Mon, 19 Apr 2021 10:54:27 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([172.18.0.48])
	by app0024 with ESMTP id d782fd9c13ed41ba930a2c60b4a12aac for mptcp@lists.linux.dev;
	Mon Apr 19 10:54:31 2021
X-Transaction-ID: d782fd9c13ed41ba930a2c60b4a12aac
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: Yonglong Li <liyonglong@chinatelecom.cn>
To: mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net,
	fw@strlen.de,
	pabeni@redhat.com,
	geliangtang@gmail.com,
	qitiepeng@chinatelecom.cn,
	Yonglong Li <liyonglong@chinatelecom.cn>
Subject: [PATCH v4 1/2] mptcp: add MSG_PEEK support
Date: Mon, 19 Apr 2021 10:53:55 +0800
Message-Id: <1618800836-76736-1-git-send-email-liyonglong@chinatelecom.cn>
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
index 16d73ec..75f4420 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1739,12 +1739,12 @@ static void mptcp_wait_data(struct sock *sk, long *timeo)
 
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
@@ -1760,15 +1760,18 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
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
@@ -1945,7 +1948,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	int target;
 	long timeo;
 
-	if (msg->msg_flags & ~(MSG_WAITALL | MSG_DONTWAIT))
+	if (flags & ~(MSG_PEEK | MSG_WAITALL | MSG_DONTWAIT))
 		return -EOPNOTSUPP;
 
 	mptcp_lock_sock(sk, __mptcp_splice_receive_queue(sk));
@@ -1962,7 +1965,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	while (copied < len) {
 		int bytes_read;
 
-		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied);
+		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied, flags);
 		if (unlikely(bytes_read < 0)) {
 			if (!copied)
 				copied = bytes_read;
@@ -2046,7 +2049,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
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

