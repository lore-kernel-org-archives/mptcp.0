Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F31194A5B
	for <mptcp@lists.linux.dev>; Tue, 13 Aug 2024 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555856; cv=none; b=daKoutG52lo8s4j7sdNOiq+H1vX8sVcEJGJK0Od//MWkWi7FG0luXzIAdp8vtbQBsQkPTkN96piGRo8NEp2td/PH6KJqtPn9slhUOObV5TpEAzU1dTiZzaMo1sk31ecGP3d/W2lCt+I2C6Np3P8eT3D2zOYjU0L8rJxWeTSXFv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555856; c=relaxed/simple;
	bh=+FwCgdpwWBPLOOHuMUyBqhyYA1L9tT2CU2ZXG7zC1fM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NKp8Mu5ummo5BXMsZ9k+cmFof8VSGe67vMLOmD7VLJwIc5VRJ2sCme2ENVD7it/ZeRNH0RBuntZLkplQeq1yA7zRDB9pvvVB7uNTAn/vE53QwPY/4ZldXu50RBQ4/LbLwvOiJgOI6fOaoj1LagfIGhG8Qoscrs74U3u9GmdxOHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzerquIs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzerquIs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBDAC4AF0B;
	Tue, 13 Aug 2024 13:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723555856;
	bh=+FwCgdpwWBPLOOHuMUyBqhyYA1L9tT2CU2ZXG7zC1fM=;
	h=From:Date:Subject:To:Cc:From;
	b=MzerquIsX4l9dn5ihvSs3IRWVLrwDqfOzdVaZKSgN1twqIgnwsNuRMOWg7Gf1JP1u
	 BnEaNo73QQI8NRSBbVEKscNAZo4xmXNW5HRqXJWtrwp2pqoi5q9P85f+P4SpKhnml+
	 BZHsf0HEmHUzwaNQqEZ0nL+oqUUvC+4sEv8Z3vCNODBA4uZ/i1APAOowhKi3UaUAtw
	 skdCIZbLNAnOc63OSgY1/v44V6dwBLfHo55690Nvza8j8I+N1aJFzcCPHsPGkPA11v
	 83LwJI0+JtFr2nT7fl8vW1xhXx5f3a7p+Y3SjyB0LYBbuOtQ8eujRJToX0/wjM3q7f
	 4aZmjuoaP0vhw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 13 Aug 2024 15:30:50 +0200
Subject: [PATCH mptcp-net] mptcp: pr_debug: add missing \n at the end
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-mptcp-pr_debug_n-v1-1-ab706c0cbe60@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAlgu2YC/yWMWwqAIBAArxL7naC9sK4SEZVr7UcmahGEd0/qc
 2BmHvDoCD102QMOL/J0mAQiz2DZJrMiI5UYCl5UXIqS7TYsllk3KpzPdTRMNLWSUqLQrYaUWYe
 a7m/Zw28bDDDE+AKmXy86bQAAAA==
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=38447; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+FwCgdpwWBPLOOHuMUyBqhyYA1L9tT2CU2ZXG7zC1fM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmu2AOXncIAeEOT4OwWovqGZo+X7Of6tQ7enV2e
 tKBKseExn6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrtgDgAKCRD2t4JPQmmg
 c3z4EAC/dDt0iS5t5bvujsouEl1ZItMSyfjCmd4Hj2lRTINCtvQsiQY2/yyohlFamo+mHEl4+L9
 kGnSHxOmhcsc2adcLwlYz8l3urrUloRQWK+Hh2TfLJzRUhjqcFZOqTCK6DIDZ9xZPisAzqqYVhs
 3l5AOfzz4T4Nw5LqjfdBDV3V91L4h8gjze6C9I+YneKJb/Di/Ei/189YwXMdu0QizIeM39VZcTg
 9Ds2tk1tYPwqMoMvojv0QSc3O/9zCAGK61emC99oE63D7Sj0SmIfW5DhNDbkZA0hotkQQrwq9MA
 jX7qaZY/roAMkDcfo7WXF65+VRUOIXh63SERNGS/CfWMdayS5TaXZ5n4KgzqgH4KAPYZdsb3+FR
 ShUkzuWWYYPu3CCt4AlSyAtSOsxDR6ywLeVrSkPMNSBtblpJ6cNjicw3qtokilcx897Gb6eL0Mc
 yBSwaY0IwURzvO5iJBEvC4MPVmE3x8wgd827JBgONLpun6yza2A1ixIVHHmK4msOEjVTK1HOAry
 A43APdEVnyH2ONWyoxn8lqM3WTm9qCFYjO7jH68UlAlEFhi5V+hKC4mCjJdsl4fwDwzLCthZJx4
 iVEecgX0h9L0h8pWLOW2qEjyCMOib+4AGbLWUHs4MGTzVw+dyy8PlE0WmVC6vox7eP5fp9IJ115
 2P1Y2zdXdzf3rQg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

pr_debug() have been added in various places in MPTCP code to help
developers to debug some situations. With the dynamic debug feature, it
is easy to enable all or some of them, and asks users to reproduce
issues with extra debug.

Many of these pr_debug() don't end with a new line, which causes the
messages to be printed with a delay, when something else needs to be
printed. That's fine when many messages need to be printed, but not when
only specific ones are expected.

The 'Fixes' tag here below points to the first pr_debug() used without
'\n' in net/mptcp. This patch could be split in many small ones, with
different Fixes tag, but it doesn't seem worth it, because it is easy to
re-generate this patch with this simple 'sed' command:

  git grep -l pr_debug -- net/mptcp | \
    xargs sed -i "s/\(pr_debug(\".*[^n]\)\",/\1\\\n\",/g"

So in case of conflicts, simply drop the modifications, and launch this
command.

Fixes: f870fa0b5768 ("mptcp: Add MPTCP socket stubs")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/fastopen.c   |  4 ++--
 net/mptcp/options.c    | 44 ++++++++++++++++++++++----------------------
 net/mptcp/pm.c         | 24 ++++++++++++------------
 net/mptcp/pm_netlink.c | 20 ++++++++++----------
 net/mptcp/protocol.c   | 48 ++++++++++++++++++++++++------------------------
 net/mptcp/protocol.h   |  4 ++--
 net/mptcp/sched.c      |  4 ++--
 net/mptcp/sockopt.c    |  4 ++--
 net/mptcp/subflow.c    | 46 +++++++++++++++++++++++-----------------------
 9 files changed, 99 insertions(+), 99 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index ad28da655f8b..a29ff901df75 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -68,12 +68,12 @@ void __mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflo
 	skb = skb_peek_tail(&sk->sk_receive_queue);
 	if (skb) {
 		WARN_ON_ONCE(MPTCP_SKB_CB(skb)->end_seq);
-		pr_debug("msk %p moving seq %llx -> %llx end_seq %llx -> %llx", sk,
+		pr_debug("msk %p moving seq %llx -> %llx end_seq %llx -> %llx\n", sk,
 			 MPTCP_SKB_CB(skb)->map_seq, MPTCP_SKB_CB(skb)->map_seq + msk->ack_seq,
 			 MPTCP_SKB_CB(skb)->end_seq, MPTCP_SKB_CB(skb)->end_seq + msk->ack_seq);
 		MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq;
 		MPTCP_SKB_CB(skb)->end_seq += msk->ack_seq;
 	}
 
-	pr_debug("msk=%p ack_seq=%llx", msk, msk->ack_seq);
+	pr_debug("msk=%p ack_seq=%llx\n", msk, msk->ack_seq);
 }
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 07d215e30693..79bb726d8f52 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -117,7 +117,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->suboptions |= OPTION_MPTCP_CSUMREQD;
 			ptr += 2;
 		}
-		pr_debug("MP_CAPABLE version=%x, flags=%x, optlen=%d sndr=%llu, rcvr=%llu len=%d csum=%u",
+		pr_debug("MP_CAPABLE version=%x, flags=%x, optlen=%d sndr=%llu, rcvr=%llu len=%d csum=%u\n",
 			 version, flags, opsize, mp_opt->sndr_key,
 			 mp_opt->rcvr_key, mp_opt->data_len, mp_opt->csum);
 		break;
@@ -131,7 +131,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			ptr += 4;
 			mp_opt->nonce = get_unaligned_be32(ptr);
 			ptr += 4;
-			pr_debug("MP_JOIN bkup=%u, id=%u, token=%u, nonce=%u",
+			pr_debug("MP_JOIN bkup=%u, id=%u, token=%u, nonce=%u\n",
 				 mp_opt->backup, mp_opt->join_id,
 				 mp_opt->token, mp_opt->nonce);
 		} else if (opsize == TCPOLEN_MPTCP_MPJ_SYNACK) {
@@ -142,7 +142,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			ptr += 8;
 			mp_opt->nonce = get_unaligned_be32(ptr);
 			ptr += 4;
-			pr_debug("MP_JOIN bkup=%u, id=%u, thmac=%llu, nonce=%u",
+			pr_debug("MP_JOIN bkup=%u, id=%u, thmac=%llu, nonce=%u\n",
 				 mp_opt->backup, mp_opt->join_id,
 				 mp_opt->thmac, mp_opt->nonce);
 		} else if (opsize == TCPOLEN_MPTCP_MPJ_ACK) {
@@ -169,7 +169,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		mp_opt->ack64 = (flags & MPTCP_DSS_ACK64) != 0;
 		mp_opt->use_ack = (flags & MPTCP_DSS_HAS_ACK);
 
-		pr_debug("data_fin=%d dsn64=%d use_map=%d ack64=%d use_ack=%d",
+		pr_debug("data_fin=%d dsn64=%d use_map=%d ack64=%d use_ack=%d\n",
 			 mp_opt->data_fin, mp_opt->dsn64,
 			 mp_opt->use_map, mp_opt->ack64,
 			 mp_opt->use_ack);
@@ -207,7 +207,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 				ptr += 4;
 			}
 
-			pr_debug("data_ack=%llu", mp_opt->data_ack);
+			pr_debug("data_ack=%llu\n", mp_opt->data_ack);
 		}
 
 		if (mp_opt->use_map) {
@@ -231,7 +231,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 				ptr += 2;
 			}
 
-			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u csum=%d:%u",
+			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u csum=%d:%u\n",
 				 mp_opt->data_seq, mp_opt->subflow_seq,
 				 mp_opt->data_len, !!(mp_opt->suboptions & OPTION_MPTCP_CSUMREQD),
 				 mp_opt->csum);
@@ -293,7 +293,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->ahmac = get_unaligned_be64(ptr);
 			ptr += 8;
 		}
-		pr_debug("ADD_ADDR%s: id=%d, ahmac=%llu, echo=%d, port=%d",
+		pr_debug("ADD_ADDR%s: id=%d, ahmac=%llu, echo=%d, port=%d\n",
 			 (mp_opt->addr.family == AF_INET6) ? "6" : "",
 			 mp_opt->addr.id, mp_opt->ahmac, mp_opt->echo, ntohs(mp_opt->addr.port));
 		break;
@@ -309,7 +309,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		mp_opt->rm_list.nr = opsize - TCPOLEN_MPTCP_RM_ADDR_BASE;
 		for (i = 0; i < mp_opt->rm_list.nr; i++)
 			mp_opt->rm_list.ids[i] = *ptr++;
-		pr_debug("RM_ADDR: rm_list_nr=%d", mp_opt->rm_list.nr);
+		pr_debug("RM_ADDR: rm_list_nr=%d\n", mp_opt->rm_list.nr);
 		break;
 
 	case MPTCPOPT_MP_PRIO:
@@ -318,7 +318,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 
 		mp_opt->suboptions |= OPTION_MPTCP_PRIO;
 		mp_opt->backup = *ptr++ & MPTCP_PRIO_BKUP;
-		pr_debug("MP_PRIO: prio=%d", mp_opt->backup);
+		pr_debug("MP_PRIO: prio=%d\n", mp_opt->backup);
 		break;
 
 	case MPTCPOPT_MP_FASTCLOSE:
@@ -329,7 +329,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		mp_opt->rcvr_key = get_unaligned_be64(ptr);
 		ptr += 8;
 		mp_opt->suboptions |= OPTION_MPTCP_FASTCLOSE;
-		pr_debug("MP_FASTCLOSE: recv_key=%llu", mp_opt->rcvr_key);
+		pr_debug("MP_FASTCLOSE: recv_key=%llu\n", mp_opt->rcvr_key);
 		break;
 
 	case MPTCPOPT_RST:
@@ -343,7 +343,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		flags = *ptr++;
 		mp_opt->reset_transient = flags & MPTCP_RST_TRANSIENT;
 		mp_opt->reset_reason = *ptr;
-		pr_debug("MP_RST: transient=%u reason=%u",
+		pr_debug("MP_RST: transient=%u reason=%u\n",
 			 mp_opt->reset_transient, mp_opt->reset_reason);
 		break;
 
@@ -354,7 +354,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		ptr += 2;
 		mp_opt->suboptions |= OPTION_MPTCP_FAIL;
 		mp_opt->fail_seq = get_unaligned_be64(ptr);
-		pr_debug("MP_FAIL: data_seq=%llu", mp_opt->fail_seq);
+		pr_debug("MP_FAIL: data_seq=%llu\n", mp_opt->fail_seq);
 		break;
 
 	default:
@@ -417,7 +417,7 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 		*size = TCPOLEN_MPTCP_MPC_SYN;
 		return true;
 	} else if (subflow->request_join) {
-		pr_debug("remote_token=%u, nonce=%u", subflow->remote_token,
+		pr_debug("remote_token=%u, nonce=%u\n", subflow->remote_token,
 			 subflow->local_nonce);
 		opts->suboptions = OPTION_MPTCP_MPJ_SYN;
 		opts->join_id = subflow->local_id;
@@ -500,7 +500,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 			*size = TCPOLEN_MPTCP_MPC_ACK;
 		}
 
-		pr_debug("subflow=%p, local_key=%llu, remote_key=%llu map_len=%d",
+		pr_debug("subflow=%p, local_key=%llu, remote_key=%llu map_len=%d\n",
 			 subflow, subflow->local_key, subflow->remote_key,
 			 data_len);
 
@@ -509,7 +509,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		opts->suboptions = OPTION_MPTCP_MPJ_ACK;
 		memcpy(opts->hmac, subflow->hmac, MPTCPOPT_HMAC_LEN);
 		*size = TCPOLEN_MPTCP_MPJ_ACK;
-		pr_debug("subflow=%p", subflow);
+		pr_debug("subflow=%p\n", subflow);
 
 		/* we can use the full delegate action helper only from BH context
 		 * If we are in process context - sk is flushing the backlog at
@@ -695,7 +695,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	} else {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADDTX);
 	}
-	pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d",
+	pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d\n",
 		 opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port));
 
 	return true;
@@ -726,7 +726,7 @@ static bool mptcp_established_options_rm_addr(struct sock *sk,
 	opts->rm_list = rm_list;
 
 	for (i = 0; i < opts->rm_list.nr; i++)
-		pr_debug("rm_list_ids[%d]=%d", i, opts->rm_list.ids[i]);
+		pr_debug("rm_list_ids[%d]=%d\n", i, opts->rm_list.ids[i]);
 	MPTCP_ADD_STATS(sock_net(sk), MPTCP_MIB_RMADDRTX, opts->rm_list.nr);
 	return true;
 }
@@ -752,7 +752,7 @@ static bool mptcp_established_options_mp_prio(struct sock *sk,
 	opts->suboptions |= OPTION_MPTCP_PRIO;
 	opts->backup = subflow->request_bkup;
 
-	pr_debug("prio=%d", opts->backup);
+	pr_debug("prio=%d\n", opts->backup);
 
 	return true;
 }
@@ -794,7 +794,7 @@ static bool mptcp_established_options_fastclose(struct sock *sk,
 	opts->suboptions |= OPTION_MPTCP_FASTCLOSE;
 	opts->rcvr_key = READ_ONCE(msk->remote_key);
 
-	pr_debug("FASTCLOSE key=%llu", opts->rcvr_key);
+	pr_debug("FASTCLOSE key=%llu\n", opts->rcvr_key);
 	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFASTCLOSETX);
 	return true;
 }
@@ -816,7 +816,7 @@ static bool mptcp_established_options_mp_fail(struct sock *sk,
 	opts->suboptions |= OPTION_MPTCP_FAIL;
 	opts->fail_seq = subflow->map_seq;
 
-	pr_debug("MP_FAIL fail_seq=%llu", opts->fail_seq);
+	pr_debug("MP_FAIL fail_seq=%llu\n", opts->fail_seq);
 	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
 
 	return true;
@@ -904,7 +904,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 		opts->csum_reqd = subflow_req->csum_reqd;
 		opts->allow_join_id0 = subflow_req->allow_join_id0;
 		*size = TCPOLEN_MPTCP_MPC_SYNACK;
-		pr_debug("subflow_req=%p, local_key=%llu",
+		pr_debug("subflow_req=%p, local_key=%llu\n",
 			 subflow_req, subflow_req->local_key);
 		return true;
 	} else if (subflow_req->mp_join) {
@@ -913,7 +913,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 		opts->join_id = subflow_req->local_id;
 		opts->thmac = subflow_req->thmac;
 		opts->nonce = subflow_req->local_nonce;
-		pr_debug("req=%p, bkup=%u, id=%u, thmac=%llu, nonce=%u",
+		pr_debug("req=%p, bkup=%u, id=%u, thmac=%llu, nonce=%u\n",
 			 subflow_req, opts->backup, opts->join_id,
 			 opts->thmac, opts->nonce);
 		*size = TCPOLEN_MPTCP_MPJ_SYNACK;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 56c0a318e5df..c425eae196cd 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -19,7 +19,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 {
 	u8 add_addr = READ_ONCE(msk->pm.addr_signal);
 
-	pr_debug("msk=%p, local_id=%d, echo=%d", msk, addr->id, echo);
+	pr_debug("msk=%p, local_id=%d, echo=%d\n", msk, addr->id, echo);
 
 	lockdep_assert_held(&msk->pm.lock);
 
@@ -45,7 +45,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 {
 	u8 rm_addr = READ_ONCE(msk->pm.addr_signal);
 
-	pr_debug("msk=%p, rm_list_nr=%d", msk, rm_list->nr);
+	pr_debug("msk=%p, rm_list_nr=%d\n", msk, rm_list->nr);
 
 	if (rm_addr) {
 		MPTCP_ADD_STATS(sock_net((struct sock *)msk),
@@ -66,7 +66,7 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pr_debug("msk=%p, token=%u side=%d", msk, READ_ONCE(msk->token), server_side);
+	pr_debug("msk=%p, token=%u side=%d\n", msk, READ_ONCE(msk->token), server_side);
 
 	WRITE_ONCE(pm->server_side, server_side);
 	mptcp_event(MPTCP_EVENT_CREATED, msk, ssk, GFP_ATOMIC);
@@ -90,7 +90,7 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
-	pr_debug("msk=%p subflows=%d max=%d allow=%d", msk, pm->subflows,
+	pr_debug("msk=%p subflows=%d max=%d allow=%d\n", msk, pm->subflows,
 		 subflows_max, READ_ONCE(pm->accept_subflow));
 
 	/* try to avoid acquiring the lock below */
@@ -114,7 +114,7 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 static bool mptcp_pm_schedule_work(struct mptcp_sock *msk,
 				   enum mptcp_pm_status new_status)
 {
-	pr_debug("msk=%p status=%x new=%lx", msk, msk->pm.status,
+	pr_debug("msk=%p status=%x new=%lx\n", msk, msk->pm.status,
 		 BIT(new_status));
 	if (msk->pm.status & BIT(new_status))
 		return false;
@@ -129,7 +129,7 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk)
 	struct mptcp_pm_data *pm = &msk->pm;
 	bool announce = false;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	spin_lock_bh(&pm->lock);
 
@@ -153,14 +153,14 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk)
 
 void mptcp_pm_connection_closed(struct mptcp_sock *msk)
 {
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 }
 
 void mptcp_pm_subflow_established(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	if (!READ_ONCE(pm->work_pending))
 		return;
@@ -212,7 +212,7 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pr_debug("msk=%p remote_id=%d accept=%d", msk, addr->id,
+	pr_debug("msk=%p remote_id=%d accept=%d\n", msk, addr->id,
 		 READ_ONCE(pm->accept_addr));
 
 	mptcp_event_addr_announced(ssk, addr);
@@ -243,7 +243,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	spin_lock_bh(&pm->lock);
 
@@ -267,7 +267,7 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 	struct mptcp_pm_data *pm = &msk->pm;
 	u8 i;
 
-	pr_debug("msk=%p remote_ids_nr=%d", msk, rm_list->nr);
+	pr_debug("msk=%p remote_ids_nr=%d\n", msk, rm_list->nr);
 
 	for (i = 0; i < rm_list->nr; i++)
 		mptcp_event_addr_removed(msk, rm_list->ids[i]);
@@ -299,7 +299,7 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 
-	pr_debug("fail_seq=%llu", fail_seq);
+	pr_debug("fail_seq=%llu\n", fail_seq);
 
 	if (!READ_ONCE(msk->allow_infinite_fallback))
 		return;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d3b1b459e6f3..fc5d848a129e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -294,7 +294,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	if (!msk)
 		return;
@@ -313,7 +313,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (!mptcp_pm_should_add_signal_addr(msk)) {
-		pr_debug("retransmit ADD_ADDR id=%d", entry->addr.id);
+		pr_debug("retransmit ADD_ADDR id=%d\n", entry->addr.id);
 		mptcp_pm_announce_addr(msk, &entry->addr, false);
 		mptcp_pm_add_addr_send_ack(msk);
 		entry->retrans_times++;
@@ -394,7 +394,7 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	struct sock *sk = (struct sock *)msk;
 	LIST_HEAD(free_list);
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	spin_lock_bh(&msk->pm.lock);
 	list_splice_init(&msk->pm.anno_list, &free_list);
@@ -480,7 +480,7 @@ static void __mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_con
 	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 	bool slow;
 
-	pr_debug("send ack for %s",
+	pr_debug("send ack for %s\n",
 		 prio ? "mp_prio" : (mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr"));
 
 	slow = lock_sock_fast(ssk);
@@ -724,7 +724,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
-	pr_debug("accepted %d:%d remote family %d",
+	pr_debug("accepted %d:%d remote family %d\n",
 		 msk->pm.add_addr_accepted, add_addr_accept_max,
 		 msk->pm.remote.family);
 
@@ -786,7 +786,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 {
 	struct mptcp_subflow_context *subflow;
 
-	pr_debug("bkup=%d", bkup);
+	pr_debug("bkup=%d\n", bkup);
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
@@ -817,7 +817,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 	struct sock *sk = (struct sock *)msk;
 	u8 i;
 
-	pr_debug("%s rm_list_nr %d",
+	pr_debug("%s rm_list_nr %d\n",
 		 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow", rm_list->nr);
 
 	msk_owned_by_me(msk);
@@ -846,7 +846,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			if (rm_type == MPTCP_MIB_RMSUBFLOW && id != rm_id)
 				continue;
 
-			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u mpc_id=%u",
+			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u mpc_id=%u\n",
 				 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow",
 				 i, rm_id, id, remote_id, msk->mpc_endpoint_id);
 			spin_unlock_bh(&msk->pm.lock);
@@ -903,7 +903,7 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk)
 
 	spin_lock_bh(&msk->pm.lock);
 
-	pr_debug("msk=%p status=%x", msk, pm->status);
+	pr_debug("msk=%p status=%x\n", msk, pm->status);
 	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED)) {
 		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
 		mptcp_pm_nl_add_addr_received(msk);
@@ -1479,7 +1479,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 	long s_slot = 0, s_num = 0;
 	struct mptcp_sock *msk;
 
-	pr_debug("remove_id=%d", addr->id);
+	pr_debug("remove_id=%d\n", addr->id);
 
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 13777c35496c..bab0155bdc2e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -139,7 +139,7 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	    !skb_try_coalesce(to, from, &fragstolen, &delta))
 		return false;
 
-	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx",
+	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx\n",
 		 MPTCP_SKB_CB(from)->map_seq, MPTCP_SKB_CB(to)->map_seq,
 		 to->len, MPTCP_SKB_CB(from)->end_seq);
 	MPTCP_SKB_CB(to)->end_seq = MPTCP_SKB_CB(from)->end_seq;
@@ -217,7 +217,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	end_seq = MPTCP_SKB_CB(skb)->end_seq;
 	max_seq = atomic64_read(&msk->rcv_wnd_sent);
 
-	pr_debug("msk=%p seq=%llx limit=%llx empty=%d", msk, seq, max_seq,
+	pr_debug("msk=%p seq=%llx limit=%llx empty=%d\n", msk, seq, max_seq,
 		 RB_EMPTY_ROOT(&msk->out_of_order_queue));
 	if (after64(end_seq, max_seq)) {
 		/* out of window */
@@ -643,7 +643,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		}
 	}
 
-	pr_debug("msk=%p ssk=%p", msk, ssk);
+	pr_debug("msk=%p ssk=%p\n", msk, ssk);
 	tp = tcp_sk(ssk);
 	do {
 		u32 map_remaining, offset;
@@ -724,7 +724,7 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 	u64 end_seq;
 
 	p = rb_first(&msk->out_of_order_queue);
-	pr_debug("msk=%p empty=%d", msk, RB_EMPTY_ROOT(&msk->out_of_order_queue));
+	pr_debug("msk=%p empty=%d\n", msk, RB_EMPTY_ROOT(&msk->out_of_order_queue));
 	while (p) {
 		skb = rb_to_skb(p);
 		if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq))
@@ -746,7 +746,7 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 			int delta = msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
 
 			/* skip overlapping data, if any */
-			pr_debug("uncoalesced seq=%llx ack seq=%llx delta=%d",
+			pr_debug("uncoalesced seq=%llx ack seq=%llx delta=%d\n",
 				 MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq,
 				 delta);
 			MPTCP_SKB_CB(skb)->offset += delta;
@@ -1240,7 +1240,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	size_t copy;
 	int i;
 
-	pr_debug("msk=%p ssk=%p sending dfrag at seq=%llu len=%u already sent=%u",
+	pr_debug("msk=%p ssk=%p sending dfrag at seq=%llu len=%u already sent=%u\n",
 		 msk, ssk, dfrag->data_seq, dfrag->data_len, info->sent);
 
 	if (WARN_ON_ONCE(info->sent > info->limit ||
@@ -1341,7 +1341,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	mpext->use_map = 1;
 	mpext->dsn64 = 1;
 
-	pr_debug("data_seq=%llu subflow_seq=%u data_len=%u dsn64=%d",
+	pr_debug("data_seq=%llu subflow_seq=%u data_len=%u dsn64=%d\n",
 		 mpext->data_seq, mpext->subflow_seq, mpext->data_len,
 		 mpext->dsn64);
 
@@ -1892,7 +1892,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			if (!msk->first_pending)
 				WRITE_ONCE(msk->first_pending, dfrag);
 		}
-		pr_debug("msk=%p dfrag at seq=%llu len=%u sent=%u new=%d", msk,
+		pr_debug("msk=%p dfrag at seq=%llu len=%u sent=%u new=%d\n", msk,
 			 dfrag->data_seq, dfrag->data_len, dfrag->already_sent,
 			 !dfrag_collapsed);
 
@@ -2248,7 +2248,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			}
 		}
 
-		pr_debug("block timeout %ld", timeo);
+		pr_debug("block timeout %ld\n", timeo);
 		sk_wait_data(sk, &timeo, NULL);
 	}
 
@@ -2264,7 +2264,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		}
 	}
 
-	pr_debug("msk=%p rx queue empty=%d:%d copied=%d",
+	pr_debug("msk=%p rx queue empty=%d:%d copied=%d\n",
 		 msk, skb_queue_empty_lockless(&sk->sk_receive_queue),
 		 skb_queue_empty(&msk->receive_queue), copied);
 	if (!(flags & MSG_PEEK))
@@ -2898,7 +2898,7 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 			WRITE_ONCE(mptcp_sk(sk)->snd_una, mptcp_sk(sk)->snd_nxt);
 			mptcp_schedule_work(sk);
 		} else {
-			pr_debug("Sending DATA_FIN on subflow %p", ssk);
+			pr_debug("Sending DATA_FIN on subflow %p\n", ssk);
 			tcp_send_ack(ssk);
 			if (!mptcp_rtx_timer_pending(sk))
 				mptcp_reset_rtx_timer(sk);
@@ -2964,7 +2964,7 @@ static void mptcp_check_send_data_fin(struct sock *sk)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	pr_debug("msk=%p snd_data_fin_enable=%d pending=%d snd_nxt=%llu write_seq=%llu",
+	pr_debug("msk=%p snd_data_fin_enable=%d pending=%d snd_nxt=%llu write_seq=%llu\n",
 		 msk, msk->snd_data_fin_enable, !!mptcp_send_head(sk),
 		 msk->snd_nxt, msk->write_seq);
 
@@ -2988,7 +2988,7 @@ static void __mptcp_wr_shutdown(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	pr_debug("msk=%p snd_data_fin_enable=%d shutdown=%x state=%d pending=%d",
+	pr_debug("msk=%p snd_data_fin_enable=%d shutdown=%x state=%d pending=%d\n",
 		 msk, msk->snd_data_fin_enable, sk->sk_shutdown, sk->sk_state,
 		 !!mptcp_send_head(sk));
 
@@ -3003,7 +3003,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	might_sleep();
 
@@ -3111,7 +3111,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		mptcp_set_state(sk, TCP_CLOSE);
 
 	sock_hold(sk);
-	pr_debug("msk=%p state=%d", sk, sk->sk_state);
+	pr_debug("msk=%p state=%d\n", sk, sk->sk_state);
 	if (msk->token)
 		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
 
@@ -3543,7 +3543,7 @@ static int mptcp_get_port(struct sock *sk, unsigned short snum)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	pr_debug("msk=%p, ssk=%p", msk, msk->first);
+	pr_debug("msk=%p, ssk=%p\n", msk, msk->first);
 	if (WARN_ON_ONCE(!msk->first))
 		return -EINVAL;
 
@@ -3560,7 +3560,7 @@ void mptcp_finish_connect(struct sock *ssk)
 	sk = subflow->conn;
 	msk = mptcp_sk(sk);
 
-	pr_debug("msk=%p, token=%u", sk, subflow->token);
+	pr_debug("msk=%p, token=%u\n", sk, subflow->token);
 
 	subflow->map_seq = subflow->iasn;
 	subflow->map_subflow_seq = 1;
@@ -3589,7 +3589,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	struct sock *parent = (void *)msk;
 	bool ret = true;
 
-	pr_debug("msk=%p, subflow=%p", msk, subflow);
+	pr_debug("msk=%p, subflow=%p\n", msk, subflow);
 
 	/* mptcp socket already closing? */
 	if (!mptcp_is_fully_established(parent)) {
@@ -3635,7 +3635,7 @@ bool mptcp_finish_join(struct sock *ssk)
 
 static void mptcp_shutdown(struct sock *sk, int how)
 {
-	pr_debug("sk=%p, how=%d", sk, how);
+	pr_debug("sk=%p, how=%d\n", sk, how);
 
 	if ((how & SEND_SHUTDOWN) && mptcp_close_state(sk))
 		__mptcp_wr_shutdown(sk);
@@ -3856,7 +3856,7 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	struct sock *ssk;
 	int err;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	lock_sock(sk);
 
@@ -3895,7 +3895,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
 	struct sock *ssk, *newsk;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	/* Buggy applications can call accept on socket states other then LISTEN
 	 * but no need to allocate the first subflow just to error out.
@@ -3904,12 +3904,12 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 	if (!ssk)
 		return -EINVAL;
 
-	pr_debug("ssk=%p, listener=%p", ssk, mptcp_subflow_ctx(ssk));
+	pr_debug("ssk=%p, listener=%p\n", ssk, mptcp_subflow_ctx(ssk));
 	newsk = inet_csk_accept(ssk, arg);
 	if (!newsk)
 		return arg->err;
 
-	pr_debug("newsk=%p, subflow is mptcp=%d", newsk, sk_is_mptcp(newsk));
+	pr_debug("newsk=%p, subflow is mptcp=%d\n", newsk, sk_is_mptcp(newsk));
 	if (sk_is_mptcp(newsk)) {
 		struct mptcp_subflow_context *subflow;
 		struct sock *new_mptcp_sock;
@@ -4002,7 +4002,7 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	sock_poll_wait(file, sock, wait);
 
 	state = inet_sk_state_load(sk);
-	pr_debug("msk=%p state=%d flags=%lx", msk, state, msk->flags);
+	pr_debug("msk=%p state=%d flags=%lx\n", msk, state, msk->flags);
 	if (state == TCP_LISTEN) {
 		struct sock *ssk = READ_ONCE(msk->first);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 22b7eff311f5..cbdfe17eca9a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1180,7 +1180,7 @@ static inline bool mptcp_check_fallback(const struct sock *sk)
 static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 {
 	if (__mptcp_check_fallback(msk)) {
-		pr_debug("TCP fallback already done (msk=%p)", msk);
+		pr_debug("TCP fallback already done (msk=%p)\n", msk);
 		return;
 	}
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
@@ -1216,7 +1216,7 @@ static inline void mptcp_do_fallback(struct sock *ssk)
 	}
 }
 
-#define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)", __func__, a)
+#define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)\n", __func__, a)
 
 static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 8def10abd60e..5257bc6c8cd6 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -86,7 +86,7 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
 	list_add_tail_rcu(&sched->list, &mptcp_sched_list);
 	spin_unlock(&mptcp_sched_list_lock);
 
-	pr_debug("%s registered", sched->name);
+	pr_debug("%s registered\n", sched->name);
 	return 0;
 }
 
@@ -118,7 +118,7 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 	if (msk->sched->init)
 		msk->sched->init(msk);
 
-	pr_debug("sched=%s", msk->sched->name);
+	pr_debug("sched=%s\n", msk->sched->name);
 
 	return 0;
 }
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 2026a9a36f80..505445a9598f 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -873,7 +873,7 @@ int mptcp_setsockopt(struct sock *sk, int level, int optname,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sock *ssk;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	if (level == SOL_SOCKET)
 		return mptcp_setsockopt_sol_socket(msk, optname, optval, optlen);
@@ -1453,7 +1453,7 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sock *ssk;
 
-	pr_debug("msk=%p", msk);
+	pr_debug("msk=%p\n", msk);
 
 	/* @@ the meaning of setsockopt() when the socket is connected and
 	 * there are multiple subflows is not yet defined. It is up to the
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6cd71061ef3e..423e674df90f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -39,7 +39,7 @@ static void subflow_req_destructor(struct request_sock *req)
 {
 	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
 
-	pr_debug("subflow_req=%p", subflow_req);
+	pr_debug("subflow_req=%p\n", subflow_req);
 
 	if (subflow_req->msk)
 		sock_put((struct sock *)subflow_req->msk);
@@ -146,7 +146,7 @@ static int subflow_check_req(struct request_sock *req,
 	struct mptcp_options_received mp_opt;
 	bool opt_mp_capable, opt_mp_join;
 
-	pr_debug("subflow_req=%p, listener=%p", subflow_req, listener);
+	pr_debug("subflow_req=%p, listener=%p\n", subflow_req, listener);
 
 #ifdef CONFIG_TCP_MD5SIG
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
@@ -221,7 +221,7 @@ static int subflow_check_req(struct request_sock *req,
 		}
 
 		if (subflow_use_different_sport(subflow_req->msk, sk_listener)) {
-			pr_debug("syn inet_sport=%d %d",
+			pr_debug("syn inet_sport=%d %d\n",
 				 ntohs(inet_sk(sk_listener)->inet_sport),
 				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
 			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
@@ -243,7 +243,7 @@ static int subflow_check_req(struct request_sock *req,
 			subflow_init_req_cookie_join_save(subflow_req, skb);
 		}
 
-		pr_debug("token=%u, remote_nonce=%u msk=%p", subflow_req->token,
+		pr_debug("token=%u, remote_nonce=%u msk=%p\n", subflow_req->token,
 			 subflow_req->remote_nonce, subflow_req->msk);
 	}
 
@@ -527,7 +527,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	subflow->rel_write_seq = 1;
 	subflow->conn_finished = 1;
 	subflow->ssn_offset = TCP_SKB_CB(skb)->seq;
-	pr_debug("subflow=%p synack seq=%x", subflow, subflow->ssn_offset);
+	pr_debug("subflow=%p synack seq=%x\n", subflow, subflow->ssn_offset);
 
 	mptcp_get_options(skb, &mp_opt);
 	if (subflow->request_mptcp) {
@@ -559,7 +559,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		subflow->thmac = mp_opt.thmac;
 		subflow->remote_nonce = mp_opt.nonce;
 		WRITE_ONCE(subflow->remote_id, mp_opt.join_id);
-		pr_debug("subflow=%p, thmac=%llu, remote_nonce=%u backup=%d",
+		pr_debug("subflow=%p, thmac=%llu, remote_nonce=%u backup=%d\n",
 			 subflow, subflow->thmac, subflow->remote_nonce,
 			 subflow->backup);
 
@@ -585,7 +585,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKBACKUPRX);
 
 		if (subflow_use_different_dport(msk, sk)) {
-			pr_debug("synack inet_dport=%d %d",
+			pr_debug("synack inet_dport=%d %d\n",
 				 ntohs(inet_sk(sk)->inet_dport),
 				 ntohs(inet_sk(parent)->inet_dport));
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINPORTSYNACKRX);
@@ -655,7 +655,7 @@ static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 
-	pr_debug("subflow=%p", subflow);
+	pr_debug("subflow=%p\n", subflow);
 
 	/* Never answer to SYNs sent to broadcast or multicast */
 	if (skb_rtable(skb)->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
@@ -686,7 +686,7 @@ static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 
-	pr_debug("subflow=%p", subflow);
+	pr_debug("subflow=%p\n", subflow);
 
 	if (skb->protocol == htons(ETH_P_IP))
 		return subflow_v4_conn_request(sk, skb);
@@ -807,7 +807,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	struct mptcp_sock *owner;
 	struct sock *child;
 
-	pr_debug("listener=%p, req=%p, conn=%p", listener, req, listener->conn);
+	pr_debug("listener=%p, req=%p, conn=%p\n", listener, req, listener->conn);
 
 	/* After child creation we must look for MPC even when options
 	 * are not parsed
@@ -898,7 +898,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			ctx->conn = (struct sock *)owner;
 
 			if (subflow_use_different_sport(owner, sk)) {
-				pr_debug("ack inet_sport=%d %d",
+				pr_debug("ack inet_sport=%d %d\n",
 					 ntohs(inet_sk(sk)->inet_sport),
 					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
 				if (!mptcp_pm_sport_in_anno_list(owner, sk)) {
@@ -961,7 +961,7 @@ enum mapping_status {
 
 static void dbg_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
 {
-	pr_debug("Bad mapping: ssn=%d map_seq=%d map_data_len=%d",
+	pr_debug("Bad mapping: ssn=%d map_seq=%d map_data_len=%d\n",
 		 ssn, subflow->map_subflow_seq, subflow->map_data_len);
 }
 
@@ -1133,7 +1133,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 		if (data_len == 1) {
 			bool updated = mptcp_update_rcv_data_fin(msk, mpext->data_seq,
 								 mpext->dsn64);
-			pr_debug("DATA_FIN with no payload seq=%llu", mpext->data_seq);
+			pr_debug("DATA_FIN with no payload seq=%llu\n", mpext->data_seq);
 			if (subflow->map_valid) {
 				/* A DATA_FIN might arrive in a DSS
 				 * option before the previous mapping
@@ -1159,7 +1159,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 			data_fin_seq &= GENMASK_ULL(31, 0);
 
 		mptcp_update_rcv_data_fin(msk, data_fin_seq, mpext->dsn64);
-		pr_debug("DATA_FIN with mapping seq=%llu dsn64=%d",
+		pr_debug("DATA_FIN with mapping seq=%llu dsn64=%d\n",
 			 data_fin_seq, mpext->dsn64);
 
 		/* Adjust for DATA_FIN using 1 byte of sequence space */
@@ -1205,7 +1205,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 	if (unlikely(subflow->map_csum_reqd != csum_reqd))
 		return MAPPING_INVALID;
 
-	pr_debug("new map seq=%llu subflow_seq=%u data_len=%u csum=%d:%u",
+	pr_debug("new map seq=%llu subflow_seq=%u data_len=%u csum=%d:%u\n",
 		 subflow->map_seq, subflow->map_subflow_seq,
 		 subflow->map_data_len, subflow->map_csum_reqd,
 		 subflow->map_data_csum);
@@ -1240,7 +1240,7 @@ static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *skb,
 	avail_len = skb->len - offset;
 	incr = limit >= avail_len ? avail_len + fin : limit;
 
-	pr_debug("discarding=%d len=%d offset=%d seq=%d", incr, skb->len,
+	pr_debug("discarding=%d len=%d offset=%d seq=%d\n", incr, skb->len,
 		 offset, subflow->map_subflow_seq);
 	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DUPDATA);
 	tcp_sk(ssk)->copied_seq += incr;
@@ -1337,7 +1337,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 
 		old_ack = READ_ONCE(msk->ack_seq);
 		ack_seq = mptcp_subflow_get_mapped_dsn(subflow);
-		pr_debug("msk ack_seq=%llx subflow ack_seq=%llx", old_ack,
+		pr_debug("msk ack_seq=%llx subflow ack_seq=%llx\n", old_ack,
 			 ack_seq);
 		if (unlikely(before64(ack_seq, old_ack))) {
 			mptcp_subflow_discard_data(ssk, skb, old_ack - ack_seq);
@@ -1409,7 +1409,7 @@ bool mptcp_subflow_data_available(struct sock *sk)
 		subflow->map_valid = 0;
 		WRITE_ONCE(subflow->data_avail, false);
 
-		pr_debug("Done with mapping: seq=%u data_len=%u",
+		pr_debug("Done with mapping: seq=%u data_len=%u\n",
 			 subflow->map_subflow_seq,
 			 subflow->map_data_len);
 	}
@@ -1519,7 +1519,7 @@ void mptcpv6_handle_mapped(struct sock *sk, bool mapped)
 
 	target = mapped ? &subflow_v6m_specific : subflow_default_af_ops(sk);
 
-	pr_debug("subflow=%p family=%d ops=%p target=%p mapped=%d",
+	pr_debug("subflow=%p family=%d ops=%p target=%p mapped=%d\n",
 		 subflow, sk->sk_family, icsk->icsk_af_ops, target, mapped);
 
 	if (likely(icsk->icsk_af_ops == target))
@@ -1628,7 +1628,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 	}
 
 	mptcp_crypto_key_sha(subflow->remote_key, &remote_token, NULL);
-	pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d", msk,
+	pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d\n", msk,
 		 remote_token, local_id, remote_id);
 	subflow->remote_token = remote_token;
 	WRITE_ONCE(subflow->remote_id, remote_id);
@@ -1769,7 +1769,7 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	SOCK_INODE(sf)->i_gid = SOCK_INODE(sk->sk_socket)->i_gid;
 
 	subflow = mptcp_subflow_ctx(sf->sk);
-	pr_debug("subflow=%p", subflow);
+	pr_debug("subflow=%p\n", subflow);
 
 	*new_sock = sf;
 	sock_hold(sk);
@@ -1798,7 +1798,7 @@ static struct mptcp_subflow_context *subflow_create_ctx(struct sock *sk,
 	INIT_LIST_HEAD(&ctx->node);
 	INIT_LIST_HEAD(&ctx->delegated_node);
 
-	pr_debug("subflow=%p", ctx);
+	pr_debug("subflow=%p\n", ctx);
 
 	ctx->tcp_sock = sk;
 	WRITE_ONCE(ctx->local_id, -1);
@@ -1949,7 +1949,7 @@ static int subflow_ulp_init(struct sock *sk)
 		goto out;
 	}
 
-	pr_debug("subflow=%p, family=%d", ctx, sk->sk_family);
+	pr_debug("subflow=%p, family=%d\n", ctx, sk->sk_family);
 
 	tp->is_mptcp = 1;
 	ctx->icsk_af_ops = icsk->icsk_af_ops;

---
base-commit: 45fdbcbbb825fc76fe75116f57f698ba74700d89
change-id: 20240813-mptcp-pr_debug_n-165d888e1f9f

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

