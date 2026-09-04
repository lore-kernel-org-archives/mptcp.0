Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE26D4229A6
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512934; cv=none; b=CF7TbeVCqdCw7pbOenfnmNSCEd/hiV6WRCuScefEglkbsdKb1DlhxqW2pQeDRLZKeWHFpiMFeDLjdHVj5oIRiuugUdOrOXLqRwMFv7e/cKBWZl4oyDQdN8VTC5cODlIU8zRqbgVaae8DUWXvXElb09Vhr6AXDQnEhNX6lP0oXSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512934; c=relaxed/simple;
	bh=KKzKMsjYyjaxWRelc4j/x7eK4DZtJO+YlZE0tuHmLVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=scritzha+XS59IEvX5XARDffdN1VTGr5boQzv6i9ajYH7PM5sNKhgCy9R1uF+UweaCLgQNQU/CYog1jfumAWA/E7e42I9WKxxeB8eVOHhJur+3i0PIvyjpFtW7Y8ONPm1s/Y7zF+b722p3LY6pDVo1OvdwMWh6dOTUzj4eRSte8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fI+v2cWv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fI+v2cWv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F671F00A3F;
	Fri,  4 Sep 2026 09:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788512932;
	bh=qYOE/UKVXKX+6JOPLz+IAWs0ozHAqvoTIse44beEmNg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fI+v2cWvxFA0n045sshb+Of3WPpF0wi9j/9eg3uUL7qGp157GHWB4AzSP3zPwCSFF
	 ZbfmDUSS/obVgp+ocOj1aqo5sa8Mdr5ngHxM1Pdpfz+PNsHHePlVftuQjrzsGyvzd3
	 lpWueGtnuOs9TuxnUxudAITy2Df4JtgbIxEJeMQ43a7k3wSEQ8UKe8I0Ykv188E9IR
	 aRNd+QfKlXON+0MmIypyeegLFoLVOu/NpDpV0rLaVZC0zKjRiRNsrsQKWocSeRCfZh
	 BbzlstklALXd3hSK+Pys5o/hY0voSjw/GXpT8wNnnhKK/FDwPgKjrtobv9CB6tws9O
	 6t/lEjk8lSl2Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 04 Sep 2026 11:08:40 +0200
Subject: [PATCH mptcp-next v2 2/3] mptcp: options: track invalid suboptions
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-mptcp-mib-inval-opt-v2-2-a72003dc4425@kernel.org>
References: <20260904-mptcp-mib-inval-opt-v2-0-a72003dc4425@kernel.org>
In-Reply-To: <20260904-mptcp-mib-inval-opt-v2-0-a72003dc4425@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10430; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=KKzKMsjYyjaxWRelc4j/x7eK4DZtJO+YlZE0tuHmLVs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJmdS2MeXDMWmyZ0oQ/W+NEuDxvhT9f3bD+AOufVFeW8
 53Tph2/3FHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRyV4M/1NzmmreLn1w13xe
 B8ssf4cre/n87b6k2N7gWXjw2yW2yMkM/3Nkasx6rjyQP+Wok3/n85H1Qa99NMxWvZMQnWt8MmC
 JAT8A
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

