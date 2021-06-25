Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3F72FB2
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 03:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=OxTDbxMw+Kwm2XGPyh
	3EBHHnkXSpOsBLMVK213nv/P0=; b=Y+V4CSyaD+exmTFhMa88h3s/mbf2OK3IXk
	4jzgECHgevM7HdkVUH8WiQ/SVDuUsWUW8HDrCwS7/y0xqMfxoWSH8MS+E2P1at22
	OeN7Po0ua2tRlYzKRGL7BQ1aVQQvWyzRAAqxzqVeMjWe8LvRQkr2OvYH/GbAJh+2
	6pI5TF0o0=
Received: from localhost.localdomain (unknown [36.111.140.26])
	by smtp13 (Coremail) with SMTP id EcCowACntjoSRNVg6_a69Q--.41874S6;
	Fri, 25 Jun 2021 10:48:55 +0800 (CST)
From: wujianguo106@163.com
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com
Subject: [PATCH mptcp-net v6 4/5] mptcp: avoid processing packet if a subflow reset
Date: Fri, 25 Jun 2021 10:48:49 +0800
Message-Id: <1624589330-2579-5-git-send-email-wujianguo106@163.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1624589330-2579-1-git-send-email-wujianguo106@163.com>
References: <1624589330-2579-1-git-send-email-wujianguo106@163.com>
X-CM-TRANSID:EcCowACntjoSRNVg6_a69Q--.41874S6
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ar45CFyrJw43Gr4rAFWfGrg_yoW7Zr1xpF
	1DG343Jr4kWFWfWr4IyF4kZr1S93yFkFZ8G3yUKw45Arn8Gw4IkFy5tF1a9rW3GFZF9asx
	JrZ2qFy5uF17AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ja6wZUUUUU=
X-Originating-IP: [36.111.140.26]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbB9wi8kF2MZX4mlgAAsp
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

From: Jianguo Wu <wujianguo@chinatelecom.cn>

If check_fully_established() causes a subflow reset, it should not
continue to process the packet in tcp_data_queue().
Add a return value to mptcp_incoming_options(), and return 0 if a
subflow has been reset, else return 1. Then drop the packet in
tcp_data_queue()/tcp_rcv_state_process() if mptcp_incoming_options()
return 0.

Fixes: d582484726c4 ("mptcp: fix fallback for MP_JOIN subflows")
Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
---
 include/net/mptcp.h  |  2 +-
 net/ipv4/tcp_input.c | 19 +++++++++++++++----
 net/mptcp/options.c  | 22 ++++++++++++++--------
 3 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index d61bbbf11979..b32333f95738 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -104,7 +104,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
 			       struct mptcp_out_options *opts);
-void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
+int mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
 
 void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			 struct mptcp_out_options *opts);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7d5e59f688de..4bacd7d2abd7 100644
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
index 1aec01686c1a..8a386556a23c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -847,7 +847,8 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 				    struct mptcp_subflow_context *subflow,
 				    struct sk_buff *skb,
-				    struct mptcp_options_received *mp_opt)
+				    struct mptcp_options_received *mp_opt,
+				    bool *subflow_is_rst)
 {
 	/* here we can process OoO, in-window pkts, only in-sequence 4th ack
 	 * will make the subflow fully established
@@ -926,6 +927,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	return true;
 
 reset:
+	*subflow_is_rst = true;
 	mptcp_subflow_reset(ssk);
 	return false;
 }
@@ -1022,12 +1024,14 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 	return hmac == mp_opt->ahmac;
 }
 
-void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
+/* Return 0 if a subflow has been reset, else return 1 */
+int mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	struct mptcp_options_received mp_opt;
 	struct mptcp_ext *mpext;
+	bool subflow_is_rst = false;
 
 	if (__mptcp_check_fallback(msk)) {
 		/* Keep it simple and unconditionally trigger send data cleanup and
@@ -1040,12 +1044,12 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 			__mptcp_check_push(subflow->conn, sk);
 		__mptcp_data_acked(subflow->conn);
 		mptcp_data_unlock(subflow->conn);
-		return;
+		return 1;
 	}
 
 	mptcp_get_options(sk, skb, &mp_opt);
-	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
-		return;
+	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt, &subflow_is_rst))
+		return subflow_is_rst ? 0 : 1;
 
 	if (mp_opt.fastclose &&
 	    msk->local_key == mp_opt.rcvr_key) {
@@ -1087,7 +1091,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	}
 
 	if (!mp_opt.dss)
-		return;
+		return 1;
 
 	/* we can't wait for recvmsg() to update the ack_seq, otherwise
 	 * monodirectional flows will stuck
@@ -1106,12 +1110,12 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		    schedule_work(&msk->work))
 			sock_hold(subflow->conn);
 
-		return;
+		return 1;
 	}
 
 	mpext = skb_ext_add(skb, SKB_EXT_MPTCP);
 	if (!mpext)
-		return;
+		return 1;
 
 	memset(mpext, 0, sizeof(*mpext));
 
@@ -1140,6 +1144,8 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		if (mpext->csum_reqd)
 			mpext->csum = mp_opt.csum;
 	}
+
+	return 1;
 }
 
 static void mptcp_set_rwin(const struct tcp_sock *tp)
-- 
1.8.3.1


