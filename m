Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCBD456E12
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788434720; cv=none; b=F7LS0Y9qADSfAT6vbiWP7H2/rH98jwFNOPC/c6Wng9ruvCzYkKHBqNYgFogkIOn+Dluq91ZKlnLJdkPnoLVvNCrefRIrLXbFA9D1NhieA4LyfAAK2wXmAW6+NFdRYWhTKzOOVK6FQxsdS8TPRYIQG1Eg6n67OVDH8Q3Y0xWKrVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788434720; c=relaxed/simple;
	bh=qQOSM8dvXGPMjLM2qWRjFKGbCmlcWGVfV3F77lw6gpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JlmW4uO5hZfUR9/2uUtMSjnaCNSFdyHcZxbaD+SzT5fzjN+SgokiQFuSJBweLDOPzgPjxPpiInBHNqtGkYrLdrTgTBiLjYfyCwIpADxOXD1qOBlcpYHPGMtzxsuGXsj/o6yKJExxJtS2OdeOB33BNd8Z6Kx/vpewTdUD+KEMUL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/pCeEu7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/pCeEu7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565111F00A3D;
	Thu,  3 Sep 2026 11:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788434714;
	bh=7myiKEy0D4UKHgenVh1S2Zrg6ZN3z/J9zfHpyFbWl/Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=D/pCeEu7OVCn0+Er8UQ4F8V10pY/EV9b/ebXFKXeNRl22AJVVvCXDJXqKFO5zp5mi
	 pvdOACKiTBuUiWUUVo/qV3s27DSp4qCLbMWuDo5GlBP9LDOJ9oIj+jMqOv61u8h0O3
	 QTNAzrhVLOoKnQUDfQQrjQc/A1dpWRGIV/rWS5qV72n8f3bT9x4Ks+8hoBSrBSL889
	 EYLqwGiAIPvCQuBaMq/blqSIQPmyzhy6tmqmh3EX7hMqqPHe4wybc56sui5ampy9zX
	 xXVWRYO3/74+EEcmzbDHkt8oZK09SXLIdmu+jxnYZoaARWaStL0vdwujhhs/+FaFbH
	 3ToOebo7vfiEw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 03 Sep 2026 13:24:54 +0200
Subject: [PATCH mptcp-next 1/3] mptcp: options: use a dedicated bit for
 csum reqd
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-mptcp-mib-inval-opt-v1-1-84a553c552b6@kernel.org>
References: <20260903-mptcp-mib-inval-opt-v1-0-84a553c552b6@kernel.org>
In-Reply-To: <20260903-mptcp-mib-inval-opt-v1-0-84a553c552b6@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6244; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qQOSM8dvXGPMjLM2qWRjFKGbCmlcWGVfV3F77lw6gpE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJmRor5ShySm+k64223vPOaS4/3WouwSO1av//micUJ0
 kncuxZYdZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExkExvDb5YrM2Mfi29kXekg
 c/djGPtV7b9vri15s6f7WLPmW9nfG/YxMtx6eObR3SVq00JYwv/uW7uzcunE3TLibUsFV9X9WP7
 VspwdAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Instead of mixing that with suboptions: that's the only non-suboptions
that is present in the 'suboptions' field.

This even cause a workaround with OPTIONS_MPTCP_DSS to exclude this
non-suboptions when checking which other ones are set.

Move it to a dedicated free bit, and adapt the corresponding code.

This is clearer like that.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  | 23 +++++++++++------------
 net/mptcp/protocol.c |  2 +-
 net/mptcp/protocol.h |  6 ++----
 net/mptcp/subflow.c  |  2 +-
 4 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index f87707110c75..afda3f2ca935 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -93,9 +93,8 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		 * In other words, the only way for checksums not to be used
 		 * is if both hosts in their SYNs set A=0."
 		 */
-		if ((flags & MPTCP_CAP_CHECKSUM_REQD) &&
-		    opsize < TCPOLEN_MPTCP_MPC_ACK_DATA)
-			mp_opt->suboptions |= OPTION_MPTCP_CSUMREQD;
+		mp_opt->csum_reqd = (flags & MPTCP_CAP_CHECKSUM_REQD) &&
+				    opsize < TCPOLEN_MPTCP_MPC_ACK_DATA;
 
 		mp_opt->deny_join_id0 = !!(flags & MPTCP_CAP_DENY_JOIN_ID0);
 
@@ -122,7 +121,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		}
 		if (opsize == TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM) {
 			mp_opt->csum = get_unaligned((__force __sum16 *)ptr);
-			mp_opt->suboptions |= OPTION_MPTCP_CSUMREQD;
+			mp_opt->csum_reqd = 1;
 			ptr += 2;
 		}
 		pr_debug("MP_CAPABLE version=%x, flags=%x, optlen=%d sndr=%llu, rcvr=%llu len=%d csum=%u\n",
@@ -248,14 +247,14 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			ptr += 2;
 
 			if (opsize == expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM) {
-				mp_opt->suboptions |= OPTION_MPTCP_CSUMREQD;
 				mp_opt->csum = get_unaligned((__force __sum16 *)ptr);
+				mp_opt->csum_reqd = 1;
 				ptr += 2;
 			}
 
 			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u csum=%d:%u\n",
 				 mp_opt->data_seq, mp_opt->subflow_seq,
-				 mp_opt->data_len, !!(mp_opt->suboptions & OPTION_MPTCP_CSUMREQD),
+				 mp_opt->data_len, mp_opt->csum_reqd,
 				 mp_opt->csum);
 		}
 
@@ -263,7 +262,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 
 	case MPTCPOPT_ADD_ADDR:
 		/* Can be used with a restricted number of other options */
-		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_DSS |
+		if ((mp_opt->suboptions & ~(OPTION_MPTCP_DSS |
 					    OPTION_MPTCP_RM_ADDR |
 					    OPTION_MPTCP_PRIO)) != 0)
 			break;
@@ -330,7 +329,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		/* Can be used with a restricted number of other options */
 		if ((mp_opt->suboptions & ~(OPTION_MPTCP_MPC_ACK |
 					    OPTIONS_MPTCP_MPJ |
-					    OPTIONS_MPTCP_DSS |
+					    OPTION_MPTCP_DSS |
 					    OPTION_MPTCP_ADD_ADDR |
 					    OPTION_MPTCP_PRIO)) != 0)
 			break;
@@ -351,7 +350,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 	case MPTCPOPT_MP_PRIO:
 		/* Can be used with a restricted number of other options */
 		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_MPJ |
-					    OPTIONS_MPTCP_DSS |
+					    OPTION_MPTCP_DSS |
 					    OPTION_MPTCP_ADD_ADDR |
 					    OPTION_MPTCP_RM_ADDR)) != 0)
 			break;
@@ -366,7 +365,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 
 	case MPTCPOPT_MP_FASTCLOSE:
 		/* Can be used with a restricted number of other options */
-		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_DSS |
+		if ((mp_opt->suboptions & ~(OPTION_MPTCP_DSS |
 					    OPTION_MPTCP_RST)) != 0)
 			break;
 
@@ -402,7 +401,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 
 	case MPTCPOPT_MP_FAIL:
 		/* Can be used with a restricted number of other options */
-		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_DSS |
+		if ((mp_opt->suboptions & ~(OPTION_MPTCP_DSS |
 					    OPTION_MPTCP_RST)) != 0)
 			break;
 
@@ -1349,7 +1348,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		}
 		mpext->data_len = mp_opt.data_len;
 		mpext->use_map = 1;
-		mpext->csum_reqd = !!(mp_opt.suboptions & OPTION_MPTCP_CSUMREQD);
+		mpext->csum_reqd = mp_opt.csum_reqd;
 
 		if (mpext->csum_reqd)
 			mpext->csum = mp_opt.csum;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0b24e0afedfb..0e4616054955 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3771,7 +3771,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	WRITE_ONCE(msk->token, subflow_req->token);
 	msk->in_accept_queue = 1;
 	WRITE_ONCE(msk->fully_established, false);
-	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
+	if (mp_opt->csum_reqd)
 		WRITE_ONCE(msk->csum_enabled, true);
 
 	WRITE_ONCE(msk->write_seq, subflow_req->idsn + 1);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b3121c8c766b..c8d413e14064 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -31,13 +31,10 @@
 #define OPTION_MPTCP_DSS	BIT(11)
 #define OPTION_MPTCP_FAIL	BIT(12)
 
-#define OPTION_MPTCP_CSUMREQD	BIT(13)
-
 #define OPTIONS_MPTCP_MPC	(OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK | \
 				 OPTION_MPTCP_MPC_ACK)
 #define OPTIONS_MPTCP_MPJ	(OPTION_MPTCP_MPJ_SYN | OPTION_MPTCP_MPJ_SYNACK | \
 				 OPTION_MPTCP_MPJ_ACK)
-#define OPTIONS_MPTCP_DSS	(OPTION_MPTCP_DSS | OPTION_MPTCP_CSUMREQD)
 
 /* MPTCP option subtypes */
 #define MPTCPOPT_MP_CAPABLE	0
@@ -165,7 +162,8 @@ struct mptcp_options_received {
 		    echo:1,
 		    backup:1,
 		    deny_join_id0:1,
-		    __unused:2;
+		    csum_reqd:1,
+		    __unused:1;
 	);
 	u8	join_id;
 	u32	token;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2d7ccb01d234..df1d18a4e906 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -553,7 +553,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 			goto fallback;
 		}
 
-		if (mp_opt.suboptions & OPTION_MPTCP_CSUMREQD)
+		if (mp_opt.csum_reqd)
 			WRITE_ONCE(msk->csum_enabled, true);
 		if (mp_opt.deny_join_id0)
 			WRITE_ONCE(msk->pm.remote_deny_join_id0, true);

-- 
2.55.0

