Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793307946;
	b=wocR1plvgVwEeegPfC+x6Wmhp841wrGSvwaH6a1D65QtkWsjcSt4NcbIFtQHAIjU76wz
	 CZXX0qHd5WObw7PptSY1kX/aXm8U8MDh6i6x/gzXCM2c+7rwWkqp7R7UltGelMkmblWo5
	 ZIUJ5xU9Bqt8k4KJkINGImT9sNevsSdf9iaymuyYJAemNpBOHhQN6skS2Y4/pXXhgrxct
	 QAnAQEN9TN7BffBGCheXNTqvPM4tGE/JfVsG4Ze/r9tBEQfo9Ghs5KpLUcYqcCrCJWUnb
	 Yeuujsv1yNEDZxN4aFQT0fi1j4r5XosvmrJywkdt6+VLqj/PP+1b44NUylIT7Yb9idA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307946;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=c8KAglxNr6wFa/vsZ2lJ1rJT5FGyWu1APEsAAdrXAw4=;
	b=i8ScrbA8r8OEbbLdIcKuavaOQdl+VcUq0Vd31wFj/v0leEYYJ29F+HJ5APLuvJm7Oxut
	 no1WjHCKQjSTBaufGdnrdYmJ7KhuWm3Op8S1/Q0QqRovMDjKU9Ka2sWcN29LPKUwog4sm
	 ZspmxMS+4xtsByuXJbisZIvTPNOSEDpPQaYAJHy36e4BR+an/EqntsyVGqVaqOi5VcfAO
	 dMSs5z2qRFxuUqY2jIeqP/b9igOitfLYjEi8iGnZwZfrEvkhejmCdwALv8Vhbo0Xv9GhY
	 UgSY5chMebVg/SRl8d41DsFcd1wBFBUin3wquefmwP7whCT0pTilIOG8ORvpeujP51g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P2PWgELA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54026606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P2PWgELA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8831F01824;
	Thu, 29 Oct 2026 21:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793307946;
	bh=c8KAglxNr6wFa/vsZ2lJ1rJT5FGyWu1APEsAAdrXAw4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=P2PWgELA+e03xmUPfMxGL1fODpz6CveOuwjP7uKjxnO+c48BsxSbvMuccLQbmZR8Q
	 QOpcEtek85vdzJX759fFJMVG+ycPHuPKBNm9uQmmQ3xlgNXVku1U3w4FtezlZSMlAj
	 Z2Yo+TI+6zUOGrte4zfsdzQUSy6BSib5/MHoiTuhxMGNhjbNR0Joo+a0lDmGLWxEBD
	 8p+qkPE0cj439tW2TGIjIRSO55hF2WZgKBnLN1EGyM65/VTvqqbquEnlH5zL0t6yl9
	 dHRGuHn+uT8c7S7hY0IMHVaHluwC3riJKRSVs30UzIowrWrSHVLwPSUp+GmIkSDJJD
	 4XWtPS5t4N6+w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 29 Oct 2026 22:05:31 +0100
Subject: [PATCH mptcp-next v3 1/3] mptcp: options: use a dedicated bit for
 csum reqd
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
Message-Id: <20261029-mptcp-mib-inval-opt-v3-1-428f42a35674@kernel.org>
References: <20261029-mptcp-mib-inval-opt-v3-0-428f42a35674@kernel.org>
In-Reply-To: <20261029-mptcp-mib-inval-opt-v3-0-428f42a35674@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6351; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6bP5gSVTTO54VUmV3639fbDRT0ZR8SXDJMd0KpmyRa8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIeb1X1XPxI5KKjV4P1mbQnM6LnXzNXlVi7d03NyY3WB
 a+2iuzZ1VHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCReymMDHdlfOONv55b1uMv
 137F2z7rkcSdpwu4sjhV7Np3pa+2mMPwT8Fgkct60+eelrNFdcXnqRw4PzN8YsHps+rd6rvOn4t
 cyw0A
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
 net/mptcp/options.c  | 25 ++++++++++++-------------
 net/mptcp/protocol.c |  2 +-
 net/mptcp/protocol.h |  6 ++----
 net/mptcp/subflow.c  |  2 +-
 4 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index adbf8e0773db..cbc105199073 100644
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
@@ -251,22 +250,22 @@ static void mptcp_parse_option(const struct sk_buff *skb,
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
-				 (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD) ? mp_opt->csum : 0);
+				 mp_opt->data_len, mp_opt->csum_reqd,
+				 mp_opt->csum_reqd ? mp_opt->csum : 0);
 		}
 
 		break;
 
 	case MPTCPOPT_ADD_ADDR:
 		/* Can be used with a restricted number of other options */
-		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_DSS |
+		if ((mp_opt->suboptions & ~(OPTION_MPTCP_DSS |
 					    OPTION_MPTCP_RM_ADDR |
 					    OPTION_MPTCP_PRIO)) != 0)
 			break;
@@ -333,7 +332,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		/* Can be used with a restricted number of other options */
 		if ((mp_opt->suboptions & ~(OPTION_MPTCP_MPC_ACK |
 					    OPTIONS_MPTCP_MPJ |
-					    OPTIONS_MPTCP_DSS |
+					    OPTION_MPTCP_DSS |
 					    OPTION_MPTCP_ADD_ADDR |
 					    OPTION_MPTCP_PRIO)) != 0)
 			break;
@@ -354,7 +353,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 	case MPTCPOPT_MP_PRIO:
 		/* Can be used with a restricted number of other options */
 		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_MPJ |
-					    OPTIONS_MPTCP_DSS |
+					    OPTION_MPTCP_DSS |
 					    OPTION_MPTCP_ADD_ADDR |
 					    OPTION_MPTCP_RM_ADDR)) != 0)
 			break;
@@ -369,7 +368,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 
 	case MPTCPOPT_MP_FASTCLOSE:
 		/* Can be used with a restricted number of other options */
-		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_DSS |
+		if ((mp_opt->suboptions & ~(OPTION_MPTCP_DSS |
 					    OPTION_MPTCP_RST)) != 0)
 			break;
 
@@ -405,7 +404,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 
 	case MPTCPOPT_MP_FAIL:
 		/* Can be used with a restricted number of other options */
-		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_DSS |
+		if ((mp_opt->suboptions & ~(OPTION_MPTCP_DSS |
 					    OPTION_MPTCP_RST)) != 0)
 			break;
 
@@ -1352,7 +1351,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		}
 		mpext->data_len = mp_opt.data_len;
 		mpext->use_map = 1;
-		mpext->csum_reqd = !!(mp_opt.suboptions & OPTION_MPTCP_CSUMREQD);
+		mpext->csum_reqd = mp_opt.csum_reqd;
 
 		if (mpext->csum_reqd)
 			mpext->csum = mp_opt.csum;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 02a4f479d9d8..c85401952bf1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3798,7 +3798,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	WRITE_ONCE(msk->token, subflow_req->token);
 	msk->in_accept_queue = 1;
 	WRITE_ONCE(msk->fully_established, false);
-	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
+	if (mp_opt->csum_reqd)
 		WRITE_ONCE(msk->csum_enabled, true);
 
 	WRITE_ONCE(msk->write_seq, subflow_req->idsn + 1);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3be60da12924..cb1862ca5cb3 100644
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
 	struct mptcp_rm_list rm_list;
 	/* Options below are mutually exclusive, see mptcp_parse_option() */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 78e886b20258..b1aa772a2519 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -592,7 +592,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 			goto fallback;
 		}
 
-		if (mp_opt.suboptions & OPTION_MPTCP_CSUMREQD)
+		if (mp_opt.csum_reqd)
 			WRITE_ONCE(msk->csum_enabled, true);
 		if (mp_opt.deny_join_id0)
 			WRITE_ONCE(msk->pm.remote_deny_join_id0, true);

-- 
2.55.0

