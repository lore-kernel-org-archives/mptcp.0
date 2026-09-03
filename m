Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1CE4562B3
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788434720; cv=none; b=HUbRNv9DUSK8QDD5Gni6g4r12pU6UNMEasHk4l2cMrE8je39Va57QHJD8pWCYkjnQRSpKrYfH66lcgJBLWhFbmhNp5WJxCgmqtC9ZLzZJWABp5FtCbMF5cLlS1PAzV1SGRe66gKMxrPpLcS+3PB1XmlhXtaAFJ1NbfHDiTrtQAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788434720; c=relaxed/simple;
	bh=KKzKMsjYyjaxWRelc4j/x7eK4DZtJO+YlZE0tuHmLVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G6vTbM2qpSRWrp4IOki1v7IfWvwZdclDQQZTHSWqmBcbvm4SOpvbFX/3VT1xDXd0aCl+F+ZdJyahDYIMeRH4W4vBJ11voMvPFuAghq/hvl53Z6/m2pyiHrhUDnrYF/NTvZUpV+orK1n1NklkeXNh5Xju6w7tZ4Kpx+YmWO3dhjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUtZrho9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUtZrho9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298CE1F00A3E;
	Thu,  3 Sep 2026 11:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788434715;
	bh=qYOE/UKVXKX+6JOPLz+IAWs0ozHAqvoTIse44beEmNg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MUtZrho9Egq/uw3jThUfuITD0+4SktgwuNMnqfXkp5E6KCcvSjO4xx1FPqBIrJI1x
	 zky3ePi+Wh/rk9dV0uBdIKT4tqFZc9tFs0uzqaUFDo6QrXh7Y3F1GIdrmBY+3yJP21
	 QBGbrvC88R+HmYmmVw4wZzF6T+uRe1wfsQhsEN7JJ2pe6z6BO6bz2UsLySMd0XPIjh
	 HpGiEvmDWUbeFsq7OxxJo6SCGX0nnt4cq86tkXI1lMDlye6LKoEG6KBKeROyb6jEZC
	 aOSjVjlEpbfsulpdg+oOrlQqMVp52ychKalQEHc1Es53kFA829JzB4xFDGGQw2C1CB
	 fuFCFaG33qGdQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 03 Sep 2026 13:24:55 +0200
Subject: [PATCH mptcp-next 2/3] mptcp: options: track invalid suboptions
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-mptcp-mib-inval-opt-v1-2-84a553c552b6@kernel.org>
References: <20260903-mptcp-mib-inval-opt-v1-0-84a553c552b6@kernel.org>
In-Reply-To: <20260903-mptcp-mib-inval-opt-v1-0-84a553c552b6@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10430; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=KKzKMsjYyjaxWRelc4j/x7eK4DZtJO+YlZE0tuHmLVs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJmRooH8/opRad+j1BbNN+6OTRdO98hYMJL2QrTrit3N
 /57y/ulo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCLzrjH8d/oorNebr5zmtvGL
 w9x5/+7PU0m75bvc+M2Vt9c++Z//68nIcG9a8OHXDxvW/K1VtTzaXCmg1r0hvOdZbW8Eq0iB5Ox
 f/AA=
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
index afda3f2ca935..aaaabcab0f8f 100644
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
@@ -133,7 +133,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		/* Can be used with a restricted number of other options */
 		if ((mp_opt->suboptions & ~(OPTION_MPTCP_RM_ADDR |
 					    OPTION_MPTCP_PRIO)) != 0)
-			break;
+			goto invalid;
 
 		if (opsize == TCPOLEN_MPTCP_MPJ_SYN) {
 			mp_opt->suboptions |= OPTION_MPTCP_MPJ_SYN;
@@ -162,6 +162,8 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			ptr += 2;
 			memcpy(mp_opt->hmac, ptr, MPTCPOPT_HMAC_LEN);
 			pr_debug("MP_JOIN hmac\n");
+		} else {
+			goto invalid;
 		}
 		break;
 
@@ -172,7 +174,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 					    OPTION_MPTCP_PRIO |
 					    OPTION_MPTCP_FASTCLOSE |
 					    OPTION_MPTCP_FAIL)) != 0)
-			break;
+			goto invalid;
 
 		pr_debug("DSS\n");
 		ptr++;
@@ -215,7 +217,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->ack64 = 0;
 			mp_opt->use_ack = 0;
 			mp_opt->data_fin = 0;
-			break;
+			goto invalid;
 		}
 
 		mp_opt->suboptions |= OPTION_MPTCP_DSS;
@@ -265,7 +267,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		if ((mp_opt->suboptions & ~(OPTION_MPTCP_DSS |
 					    OPTION_MPTCP_RM_ADDR |
 					    OPTION_MPTCP_PRIO)) != 0)
-			break;
+			goto invalid;
 
 		mp_opt->echo = (*ptr++) & MPTCP_ADDR_ECHO;
 		if (!mp_opt->echo) {
@@ -278,7 +280,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 				mp_opt->addr.family = AF_INET6;
 #endif
 			else
-				break;
+				goto invalid;
 		} else {
 			if (opsize == TCPOLEN_MPTCP_ADD_ADDR_BASE ||
 			    opsize == TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT)
@@ -289,7 +291,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 				mp_opt->addr.family = AF_INET6;
 #endif
 			else
-				break;
+				goto invalid;
 		}
 
 		mp_opt->suboptions |= OPTION_MPTCP_ADD_ADDR;
@@ -332,11 +334,11 @@ static void mptcp_parse_option(const struct sk_buff *skb,
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
 
@@ -353,10 +355,10 @@ static void mptcp_parse_option(const struct sk_buff *skb,
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
@@ -367,10 +369,10 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		/* Can be used with a restricted number of other options */
 		if ((mp_opt->suboptions & ~(OPTION_MPTCP_DSS |
 					    OPTION_MPTCP_RST)) != 0)
-			break;
+			goto invalid;
 
 		if (opsize != TCPOLEN_MPTCP_FASTCLOSE)
-			break;
+			goto invalid;
 
 		ptr += 2;
 		mp_opt->rcvr_key = get_unaligned_be64(ptr);
@@ -383,10 +385,10 @@ static void mptcp_parse_option(const struct sk_buff *skb,
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
@@ -403,10 +405,10 @@ static void mptcp_parse_option(const struct sk_buff *skb,
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
@@ -415,11 +417,17 @@ static void mptcp_parse_option(const struct sk_buff *skb,
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
@@ -454,7 +462,8 @@ void mptcp_get_options(const struct sk_buff *skb,
 			if (opsize > length)
 				return;	/* don't parse partial options */
 			if (opcode == TCPOPT_MPTCP)
-				mptcp_parse_option(skb, ptr, opsize, mp_opt);
+				mptcp_parse_option(sk, skb, ptr, opsize,
+						   mp_opt);
 			ptr += opsize - 2;
 			length -= opsize;
 		}
@@ -1248,7 +1257,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		return !mptcp_over_limit(subflow->conn, sk, skb);
 	}
 
-	mptcp_get_options(skb, &mp_opt);
+	mptcp_get_options(sk, skb, &mp_opt);
 
 	/* The subflow can be in close state only if check_fully_established()
 	 * just sent a reset. If so, tell the caller to ignore the current packet.
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c8d413e14064..739f9006c1e1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -925,7 +925,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 				 const struct mptcp_options_received *mp_opt,
 				 struct sock *ssk,
 				 struct request_sock *req);
-void mptcp_get_options(const struct sk_buff *skb,
+void mptcp_get_options(const struct sock *sk, const struct sk_buff *skb,
 		       struct mptcp_options_received *mp_opt);
 
 void mptcp_finish_connect(struct sock *sk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index df1d18a4e906..2b4b2179fe03 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -167,7 +167,7 @@ static int subflow_check_req(struct request_sock *req,
 	}
 #endif
 
-	mptcp_get_options(skb, &mp_opt);
+	mptcp_get_options(sk_listener, skb, &mp_opt);
 
 	opt_mp_capable = !!(mp_opt.suboptions & OPTION_MPTCP_MPC_SYN);
 	opt_mp_join = !!(mp_opt.suboptions & OPTION_MPTCP_MPJ_SYN);
@@ -273,7 +273,7 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
 	int err;
 
 	subflow_init_req(req, sk_listener);
-	mptcp_get_options(skb, &mp_opt);
+	mptcp_get_options(sk_listener, skb, &mp_opt);
 
 	opt_mp_capable = !!(mp_opt.suboptions & OPTION_MPTCP_MPC_ACK);
 	opt_mp_join = !!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK);
@@ -540,7 +540,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	subflow->ssn_offset = TCP_SKB_CB(skb)->seq;
 	pr_debug("subflow=%p synack seq=%x\n", subflow, subflow->ssn_offset);
 
-	mptcp_get_options(skb, &mp_opt);
+	mptcp_get_options(sk, skb, &mp_opt);
 	if (subflow->request_mptcp) {
 		if (!(mp_opt.suboptions & OPTION_MPTCP_MPC_SYNACK)) {
 			if (!mptcp_try_fallback(sk,
@@ -842,13 +842,13 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
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

