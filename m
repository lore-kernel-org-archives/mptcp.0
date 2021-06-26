Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F442FB2
	for <mptcp@lists.linux.dev>; Sat, 26 Jun 2021 09:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=cKTxBtsgUU1di8gPok
	9Kk4B2N8Z4kUdJZNF3O4xVGeM=; b=UhmNdHNVSFiPsZozQv1GmhRGKtA9PXZ/bH
	smvT3ruYC2HDw+dsag4LUDMe4A0IO6rU0JCebv4CO7np4SowgpJ4s8d4Vhw6lmLw
	i5bVCaB+JZyb94Va+2TlNkbC4wKb+GOcFqI4NuYYEFBMnq/0YmL4vdehjlVoCegO
	53aras5ws=
Received: from localhost.localdomain (unknown [36.111.140.26])
	by smtp14 (Coremail) with SMTP id EsCowAD3_dV38NZgettArg--.471S6;
	Sat, 26 Jun 2021 17:16:44 +0800 (CST)
From: wujianguo106@163.com
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com
Subject: [PATCH mptcp-net v8 4/5] mptcp: avoid processing packet if a subflow reset
Date: Sat, 26 Jun 2021 17:16:37 +0800
Message-Id: <1624698998-9029-5-git-send-email-wujianguo106@163.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1624698998-9029-1-git-send-email-wujianguo106@163.com>
References: <1624698998-9029-1-git-send-email-wujianguo106@163.com>
X-CM-TRANSID:EsCowAD3_dV38NZgettArg--.471S6
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ar45CFyrXF43tr47ZFWrKrg_yoW7Xr1kpF
	1DGw43Jr4kWFWfXr4xAFW8Zr1F93yFyFZ8G3yDKw45Arn8Jw4I9Fy8t3Wakr43GFWv9a43
	JrZ2vFy5uF17AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07js6pPUUUUU=
X-Originating-IP: [36.111.140.26]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiJx29kF5u+2-JYwAAsZ
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

From: Jianguo Wu <wujianguo@chinatelecom.cn>

If check_fully_established() causes a subflow reset, it should not
continue to process the packet in tcp_data_queue().
Add a return value to mptcp_incoming_options(), and return false if a
subflow has been reset, else return true. Then drop the packet in
tcp_data_queue()/tcp_rcv_state_process() if mptcp_incoming_options()
return false.

Fixes: d582484726c4 ("mptcp: fix fallback for MP_JOIN subflows")
Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
---
 include/net/mptcp.h  |  5 +++--
 net/ipv4/tcp_input.c | 19 +++++++++++++++----
 net/mptcp/options.c  | 19 +++++++++++++------
 3 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index cb580b0..8b5af68 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -105,7 +105,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
 			       struct mptcp_out_options *opts);
-void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
+bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
 
 void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			 struct mptcp_out_options *opts);
@@ -227,9 +227,10 @@ static inline bool mptcp_established_options(struct sock *sk,
 	return false;
 }
 
-static inline void mptcp_incoming_options(struct sock *sk,
+static inline bool mptcp_incoming_options(struct sock *sk,
 					  struct sk_buff *skb)
 {
+	return true;
 }
 
 static inline void mptcp_skb_ext_move(struct sk_buff *to,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7d5e59f..4bacd7d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4247,6 +4247,9 @@ void tcp_reset(struct sock *sk, struct sk_buff *skb)
 {
 	trace_tcp_receive_reset(sk);
 
+	/* mptcp can't tell us to ignore reset pkts,
+	 * so just ignore the return value of mptcp_incoming_options().
+	 */
 	if (sk_is_mptcp(sk))
 		mptcp_incoming_options(sk, skb);
 
@@ -4941,8 +4944,13 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 	bool fragstolen;
 	int eaten;
 
-	if (sk_is_mptcp(sk))
-		mptcp_incoming_options(sk, skb);
+	/* If a subflow has been reset, the packet should not continue
+	 * to be processed, drop the packet.
+	 */
+	if (sk_is_mptcp(sk) && !mptcp_incoming_options(sk, skb)) {
+		__kfree_skb(skb);
+		return;
+	}
 
 	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq) {
 		__kfree_skb(skb);
@@ -6523,8 +6531,11 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 	case TCP_CLOSING:
 	case TCP_LAST_ACK:
 		if (!before(TCP_SKB_CB(skb)->seq, tp->rcv_nxt)) {
-			if (sk_is_mptcp(sk))
-				mptcp_incoming_options(sk, skb);
+			/* If a subflow has been reset, the packet should not
+			 * continue to be processed, drop the packet.
+			 */
+			if (sk_is_mptcp(sk) && !mptcp_incoming_options(sk, skb))
+				goto discard;
 			break;
 		}
 		fallthrough;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b5850af..4452455 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1035,7 +1035,8 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 	return hmac == mp_opt->ahmac;
 }
 
-void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
+/* Return false if a subflow has been reset, else return true */
+bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
@@ -1053,12 +1054,16 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 			__mptcp_check_push(subflow->conn, sk);
 		__mptcp_data_acked(subflow->conn);
 		mptcp_data_unlock(subflow->conn);
-		return;
+		return true;
 	}
 
 	mptcp_get_options(sk, skb, &mp_opt);
+
+	/* The subflow can be in close state only if check_fully_established()
+	 * just sent a reset. If so, tell the caller to ignore the current packet.
+	 */
 	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
-		return;
+		return sk->sk_state != TCP_CLOSE;
 
 	if (mp_opt.fastclose &&
 	    msk->local_key == mp_opt.rcvr_key) {
@@ -1100,7 +1105,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	}
 
 	if (!mp_opt.dss)
-		return;
+		return true;
 
 	/* we can't wait for recvmsg() to update the ack_seq, otherwise
 	 * monodirectional flows will stuck
@@ -1119,12 +1124,12 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		    schedule_work(&msk->work))
 			sock_hold(subflow->conn);
 
-		return;
+		return true;
 	}
 
 	mpext = skb_ext_add(skb, SKB_EXT_MPTCP);
 	if (!mpext)
-		return;
+		return true;
 
 	memset(mpext, 0, sizeof(*mpext));
 
@@ -1153,6 +1158,8 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		if (mpext->csum_reqd)
 			mpext->csum = mp_opt.csum;
 	}
+
+	return true;
 }
 
 static void mptcp_set_rwin(const struct tcp_sock *tp)
-- 
1.8.3.1


