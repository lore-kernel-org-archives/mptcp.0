Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793307947;
	b=DSKnbnH9G6W+E1jl/6SQST6meO4aisqg1UNrOWcODZ/T4Jd+As6b62LDiYKUeYGWhikM
	 UoQufbfhTnpE2yP8tJHK+tE8DGwgweKca8p1k4VuXnCIAC8e2RmXW/81n+l2xCQuOj43I
	 GXl1ewyHVgJ2MC8eqJp4OueAGmjR9jlT9e9gigzYWJdvH86cD8wvGqerAFBS3zxgeiVdv
	 NvvcFCRARIUlj9Y+ungrgwC1a3OjayEVnOItgc0eg5TH+7D0npLhO/M1baIb0lnQMetND
	 KLrwicfGQmcMPmwUg32j0TnBIpt4Lw3igUozuWk8zlS0jjZcBZ+su7J2UsaUd0koC6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307947;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=yXC+PauuNiU9Tu34HXqQyJPBCSGC8KgkNgwtWAShS3M=;
	b=fzrwdFN4oawbwPNwPKuxvnyG4IXd+9ty0HcB8dKHZf8lHKVPgIbVpOyL77lX9UsEQK5+
	 NJeGzXF4FWSCeMD3MOcUW2aquhdTbvDPc6cfCTH88a7ag1aTqXn339ToveHV+dmKSQQQV
	 XlTV/qTCYyCYYQ9AZyyj7tRmBrgCKWQqCfLvB44BbbJZYxhKVb/EN6M3R4g3p+zlHYsVH
	 xFM6xRf36LBlPftfZGwl6f11lIen56vSHJdGaS7HPFT9WCYZVa67gNs4EbKvhEyntnfUs
	 anpydjUm+JCx+RYZ+/9cjlDhBHoEGPfJP55cn4Qlm555PL6dxjF84SJbOJvPJMaMx2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C1+vRjXy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1EA606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C1+vRjXy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E36F1F01825;
	Thu, 29 Oct 2026 21:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793307947;
	bh=yXC+PauuNiU9Tu34HXqQyJPBCSGC8KgkNgwtWAShS3M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=C1+vRjXyn9zFT1H8J7u6UiL9p8p5IGWpogIXKRWYOymWHbh8JdiWv4bTg7dmpw7RJ
	 LY9Zn68meIzuZUr5PRbVh4PXZkodTZsWEocAXbYAvFJIAhiNHIKFupYdyuQDSJ4H7m
	 p5e/yT5B4s9bnU2vgxK3vH/kV+SG0UdqwymOFjzLToOhULWRFERZpEz0KwlINH7jjm
	 dk9YqJK8WZlyAbWNgj3lUljLccYyXPDyQLgYjaSCjRcBKPbKiruQW8mpjYpjZEUFzL
	 ACV1gTCUgbaMZXDSM2dxNp1cToBPBE+KWVAo6v46uJyYXqQ5iUv5z96QCRiqMlb2Ch
	 sos9fw7SWYBZA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 29 Oct 2026 22:05:32 +0100
Subject: [PATCH mptcp-next v3 2/3] mptcp: options: track invalid suboptions
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-mptcp-mib-inval-opt-v3-2-428f42a35674@kernel.org>
References: <20261029-mptcp-mib-inval-opt-v3-0-428f42a35674@kernel.org>
In-Reply-To: <20261029-mptcp-mib-inval-opt-v3-0-428f42a35674@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10433; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MRe5jjFzByt4nM9V87TkJsCChSV2bUSeD28Fc/iHT0Q=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIeb1U3PnbxPQeXyvZWq+dtcitNzzdc+lxsxDD158qwV
 KsrhTMVO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYi85eR4YZffcfEAEX3Opm0
 S40ekx1qw3qF3golTv/1fcq831fv+DP8M3b8sLv40KkwjqVXvN3bcibdvzYtifVfs2MJI1d52o/
 pLAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Any unexpected suboptions combinations or use of invalid sizes are
suspicious: either it is coming from a buggy host, or an attacker.

Better to track that with a new MIB counter.

Note that receiving unsupported versions or extensions can happen, so
this part shouldn't be considered as invalid.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/mib.c      |  1 +
 net/mptcp/mib.h      |  1 +
 net/mptcp/options.c  | 55 ++++++++++++++++++++++++++++++----------------------
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  | 10 +++++-----
 5 files changed, 40 insertions(+), 29 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 608cb568897c..c54a20f19cf9 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -95,6 +95,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 	SNMP_MIB_ITEM("OFOPruned", MPTCP_MIB_OFOPRUNED),
+	SNMP_MIB_ITEM("OptInvalid", MPTCP_MIB_OPTINVALID),
 };
 
 /* mptcp_mib_alloc - allocate percpu mib counters
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 1ebdb55e9534..d1ce731cb5b7 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -98,6 +98,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
 	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constraints */
 	MPTCP_MIB_OFOPRUNED,		/* MPTCP-level OoO queue pruned */
+	MPTCP_MIB_OPTINVALID,		/* Invalid MPTCP option */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index cbc105199073..10a150e2ad69 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -20,7 +20,7 @@ static bool mptcp_cap_flag_sha256(u8 flags)
 	return (flags & MPTCP_CAP_FLAG_MASK) == MPTCP_CAP_HMAC_SHA256;
 }
 
-static void mptcp_parse_option(const struct sk_buff *skb,
+static void mptcp_parse_option(const struct sock *sk, const struct sk_buff *skb,
 			       const unsigned char *ptr, int opsize,
 			       struct mptcp_options_received *mp_opt)
 {
@@ -53,9 +53,9 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		/* Only the MPC + ACK can be used with a RM_ADDR */
 		if (subopt == OPTION_MPTCP_MPC_ACK) {
 			if ((mp_opt->suboptions & ~OPTION_MPTCP_RM_ADDR) != 0)
-				break;
+				goto invalid;
 		} else if (mp_opt->suboptions != 0) {
-			break;
+			goto invalid;
 		}
 
 		/* Cfr RFC 8684 Section 3.3.0:
@@ -71,7 +71,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		if (opsize != expected_opsize &&
 		    (expected_opsize != TCPOLEN_MPTCP_MPC_ACK_DATA ||
 		     opsize != TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM))
-			break;
+			goto invalid;
 
 		/* try to be gentle vs future versions on the initial syn */
 		version = *ptr++ & MPTCP_VERSION_MASK;
@@ -136,7 +136,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		/* Can be used with a restricted number of other options */
 		if ((mp_opt->suboptions & ~(OPTION_MPTCP_RM_ADDR |
 					    OPTION_MPTCP_PRIO)) != 0)
-			break;
+			goto invalid;
 
 		if (opsize == TCPOLEN_MPTCP_MPJ_SYN) {
 			mp_opt->suboptions |= OPTION_MPTCP_MPJ_SYN;
@@ -165,6 +165,8 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			ptr += 2;
 			memcpy(mp_opt->hmac, ptr, MPTCPOPT_HMAC_LEN);
 			pr_debug("MP_JOIN hmac\n");
+		} else {
+			goto invalid;
 		}
 		break;
 
@@ -175,7 +177,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 					    OPTION_MPTCP_PRIO |
 					    OPTION_MPTCP_FASTCLOSE |
 					    OPTION_MPTCP_FAIL)) != 0)
-			break;
+			goto invalid;
 
 		pr_debug("DSS\n");
 		ptr++;
@@ -218,7 +220,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->ack64 = 0;
 			mp_opt->use_ack = 0;
 			mp_opt->data_fin = 0;
-			break;
+			goto invalid;
 		}
 
 		mp_opt->suboptions |= OPTION_MPTCP_DSS;
@@ -268,7 +270,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		if ((mp_opt->suboptions & ~(OPTION_MPTCP_DSS |
 					    OPTION_MPTCP_RM_ADDR |
 					    OPTION_MPTCP_PRIO)) != 0)
-			break;
+			goto invalid;
 
 		mp_opt->echo = (*ptr++) & MPTCP_ADDR_ECHO;
 		if (!mp_opt->echo) {
@@ -281,7 +283,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 				mp_opt->addr.family = AF_INET6;
 #endif
 			else
-				break;
+				goto invalid;
 		} else {
 			if (opsize == TCPOLEN_MPTCP_ADD_ADDR_BASE ||
 			    opsize == TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT)
@@ -292,7 +294,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 				mp_opt->addr.family = AF_INET6;
 #endif
 			else
-				break;
+				goto invalid;
 		}
 
 		mp_opt->suboptions |= OPTION_MPTCP_ADD_ADDR;
@@ -335,11 +337,11 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 					    OPTION_MPTCP_DSS |
 					    OPTION_MPTCP_ADD_ADDR |
 					    OPTION_MPTCP_PRIO)) != 0)
-			break;
+			goto invalid;
 
 		if (opsize < TCPOLEN_MPTCP_RM_ADDR_BASE + 1 ||
 		    opsize > TCPOLEN_MPTCP_RM_ADDR_BASE + MPTCP_RM_IDS_MAX)
-			break;
+			goto invalid;
 
 		ptr++;
 
@@ -356,10 +358,10 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 					    OPTION_MPTCP_DSS |
 					    OPTION_MPTCP_ADD_ADDR |
 					    OPTION_MPTCP_RM_ADDR)) != 0)
-			break;
+			goto invalid;
 
 		if (opsize != TCPOLEN_MPTCP_PRIO)
-			break;
+			goto invalid;
 
 		mp_opt->suboptions |= OPTION_MPTCP_PRIO;
 		mp_opt->backup = *ptr++ & MPTCP_PRIO_BKUP;
@@ -370,10 +372,10 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		/* Can be used with a restricted number of other options */
 		if ((mp_opt->suboptions & ~(OPTION_MPTCP_DSS |
 					    OPTION_MPTCP_RST)) != 0)
-			break;
+			goto invalid;
 
 		if (opsize != TCPOLEN_MPTCP_FASTCLOSE)
-			break;
+			goto invalid;
 
 		ptr += 2;
 		mp_opt->fc_recv_key = get_unaligned_be64(ptr);
@@ -386,10 +388,10 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		/* Can be used with a restricted number of other options */
 		if ((mp_opt->suboptions & ~(OPTION_MPTCP_FAIL |
 					    OPTION_MPTCP_FASTCLOSE)) != 0)
-			break;
+			goto invalid;
 
 		if (opsize != TCPOLEN_MPTCP_RST)
-			break;
+			goto invalid;
 
 		if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST))
 			break;
@@ -406,10 +408,10 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		/* Can be used with a restricted number of other options */
 		if ((mp_opt->suboptions & ~(OPTION_MPTCP_DSS |
 					    OPTION_MPTCP_RST)) != 0)
-			break;
+			goto invalid;
 
 		if (opsize != TCPOLEN_MPTCP_FAIL)
-			break;
+			goto invalid;
 
 		ptr += 2;
 		mp_opt->suboptions |= OPTION_MPTCP_FAIL;
@@ -418,11 +420,17 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	default:
+		/* Not invalid: maybe used for experimentations */
 		break;
 	}
+
+	return;
+
+invalid:
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OPTINVALID);
 }
 
-void mptcp_get_options(const struct sk_buff *skb,
+void mptcp_get_options(const struct sock *sk, const struct sk_buff *skb,
 		       struct mptcp_options_received *mp_opt)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
@@ -457,7 +465,8 @@ void mptcp_get_options(const struct sk_buff *skb,
 			if (opsize > length)
 				return;	/* don't parse partial options */
 			if (opcode == TCPOPT_MPTCP)
-				mptcp_parse_option(skb, ptr, opsize, mp_opt);
+				mptcp_parse_option(sk, skb, ptr, opsize,
+						   mp_opt);
 			ptr += opsize - 2;
 			length -= opsize;
 		}
@@ -1251,7 +1260,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		return !mptcp_over_limit(subflow->conn, sk, skb);
 	}
 
-	mptcp_get_options(skb, &mp_opt);
+	mptcp_get_options(sk, skb, &mp_opt);
 
 	/* The subflow can be in close state only if check_fully_established()
 	 * just sent a reset. If so, tell the caller to ignore the current packet.
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index cb1862ca5cb3..8f8b4173a566 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -944,7 +944,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 				 const struct mptcp_options_received *mp_opt,
 				 struct sock *ssk,
 				 struct request_sock *req);
-void mptcp_get_options(const struct sk_buff *skb,
+void mptcp_get_options(const struct sock *sk, const struct sk_buff *skb,
 		       struct mptcp_options_received *mp_opt);
 
 void mptcp_finish_connect(struct sock *sk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b1aa772a2519..d0ff0fb83b29 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -202,7 +202,7 @@ static int subflow_check_req(struct request_sock *req,
 	}
 #endif
 
-	mptcp_get_options(skb, &mp_opt);
+	mptcp_get_options(sk_listener, skb, &mp_opt);
 
 	opt_mp_capable = !!(mp_opt.suboptions & OPTION_MPTCP_MPC_SYN);
 	opt_mp_join = !!(mp_opt.suboptions & OPTION_MPTCP_MPJ_SYN);
@@ -308,7 +308,7 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
 	int err;
 
 	subflow_init_req(req, sk_listener);
-	mptcp_get_options(skb, &mp_opt);
+	mptcp_get_options(sk_listener, skb, &mp_opt);
 
 	opt_mp_capable = !!(mp_opt.suboptions & OPTION_MPTCP_MPC_ACK);
 	opt_mp_join = !!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK);
@@ -579,7 +579,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	subflow->ssn_offset = TCP_SKB_CB(skb)->seq;
 	pr_debug("subflow=%p synack seq=%x\n", subflow, subflow->ssn_offset);
 
-	mptcp_get_options(skb, &mp_opt);
+	mptcp_get_options(sk, skb, &mp_opt);
 	if (subflow->request_mptcp) {
 		if (!(mp_opt.suboptions & OPTION_MPTCP_MPC_SYNACK)) {
 			if (!mptcp_try_fallback(sk,
@@ -881,13 +881,13 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		 * reordered MPC will cause fallback, but we don't have other
 		 * options.
 		 */
-		mptcp_get_options(skb, &mp_opt);
+		mptcp_get_options(sk, skb, &mp_opt);
 		if (!(mp_opt.suboptions &
 		      (OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_ACK)))
 			fallback = true;
 
 	} else if (subflow_req->mp_join) {
-		mptcp_get_options(skb, &mp_opt);
+		mptcp_get_options(sk, skb, &mp_opt);
 		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK))
 			fallback = true;
 	}

-- 
2.55.0

