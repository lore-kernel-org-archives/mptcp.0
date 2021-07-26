Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167AC17F
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 10:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627296945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yl19+9MJUhCu9cFyCMeNv6/nRd069zzDdyz3zrlAwpY=;
	b=XHLpvtUDSGUHiYS8YEX2/cIH8YR0p6AswU5K/Q7XRXPXyPPV/DYUwVtqnWe4JWgZLhilAL
	IxNqy2veUviwjf0quAhpYCPf5EuHyjNcP3YLzOjl3orEdUVg5qmsoKRF8cSsJr+imPjBox
	N2qPvgIXuDPeVDacItKiuhr6QkhPRpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-ELJYyl7hP8ay4-5MVL_0Bg-1; Mon, 26 Jul 2021 06:55:43 -0400
X-MC-Unique: ELJYyl7hP8ay4-5MVL_0Bg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE7801936B61;
	Mon, 26 Jul 2021 10:55:42 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-113-71.ams2.redhat.com [10.36.113.71])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 09CFA19D9F;
	Mon, 26 Jul 2021 10:55:41 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v3 mptcp-next 2/3] mptcp: optimize out option generation
Date: Mon, 26 Jul 2021 12:55:28 +0200
Message-Id: <31938eaa6cd1d45c22d184c1df7970f904785500.1627296764.git.pabeni@redhat.com>
In-Reply-To: <cover.1627296764.git.pabeni@redhat.com>
References: <cover.1627296764.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Currently we have several protocol contraint on MPTCP option
generation (e.g. MPC and MPJ subopt are mutually exclusive)
and some additionall ones required by our implementation
(e.g. almost all ADD_ADDR variant are mutually exclusive with
everything else).

We can leverage the above to optimize the out option generation:
we check DSS/MPC/MPJ presencence in a mutually exclusive way,
avoiding many unneeded conditionals in the common case.

Additionally extend the existing constraint on ADD_ADDR opt on
all subvariant, so that it become fully mutually exclusive with
the above and we can skip another conditional statement the common
case.

This change is also need by the next patch.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
--
v1 -> v2:
 - moved the pm.c chunk into the previous patch
 - avoid changing 'len' type - Geliang
 - add a comment describing why we need to clear ahmac field
 - don't clear ext_copy fields anymore in mptcp_pm_add_addr_signal()
   not needed and confusing

side node: we could probably optimize the conditionals in
mptcp_established_options()
---
 net/mptcp/options.c  | 227 +++++++++++++++++++++++--------------------
 net/mptcp/protocol.h |   1 +
 2 files changed, 120 insertions(+), 108 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index eafdb9408f3a..c14314268b36 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -592,6 +592,7 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 		dss_size = map_size;
 		if (skb && snd_data_fin_enable)
 			mptcp_write_data_fin(subflow, skb, &opts->ext_copy);
+		opts->suboptions = OPTION_MPTCP_DSS;
 		ret = true;
 	}
 
@@ -615,6 +616,7 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 		opts->ext_copy.ack64 = 0;
 	}
 	opts->ext_copy.use_ack = 1;
+	opts->suboptions = OPTION_MPTCP_DSS;
 	WRITE_ONCE(msk->old_wspace, __mptcp_space((struct sock *)msk));
 
 	/* Add kind/length/subtype/flag overhead if mapping is not populated */
@@ -682,8 +684,13 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	if (drop_other_suboptions) {
 		pr_debug("drop other suboptions");
 		opts->suboptions = 0;
-		opts->ext_copy.use_ack = 0;
-		opts->ext_copy.use_map = 0;
+
+		/* note that e.g. DSS could have written into the memory
+		 * aliased by ahmac, we must reset the field here
+		 * to avoid appending the hmac even for ADD_ADDR echo
+		 * options
+		 */
+		opts->ahmac = 0;
 		*size -= opt_size;
 	}
 	opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
@@ -735,7 +742,12 @@ static bool mptcp_established_options_mp_prio(struct sock *sk,
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 
-	if (!subflow->send_mp_prio)
+	/* can't send MP_PRIO with MPC, as they share the same option space:
+	 * 'backup'. Also it makes no sense at all
+	 */
+	if (!subflow->send_mp_prio ||
+	     ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
+	       OPTION_MPTCP_MPC_ACK) & opts->suboptions))
 		return false;
 
 	/* account for the trailing 'nop' option */
@@ -1198,7 +1210,73 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
 void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			 struct mptcp_out_options *opts)
 {
-	if ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
+	/* RST is mutually exclusive with everything else */
+	if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
+		*ptr++ = mptcp_option(MPTCPOPT_RST,
+				      TCPOLEN_MPTCP_RST,
+				      opts->reset_transient,
+				      opts->reset_reason);
+		return;
+	}
+
+	/* DSS, MPC, MPJ and ADD_ADDR are mutually exclusive, see
+	 * mptcp_established_options*()
+	 */
+	if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
+		struct mptcp_ext *mpext = &opts->ext_copy;
+		u8 len = TCPOLEN_MPTCP_DSS_BASE;
+		u8 flags = 0;
+
+		if (mpext->use_ack) {
+			flags = MPTCP_DSS_HAS_ACK;
+			if (mpext->ack64) {
+				len += TCPOLEN_MPTCP_DSS_ACK64;
+				flags |= MPTCP_DSS_ACK64;
+			} else {
+				len += TCPOLEN_MPTCP_DSS_ACK32;
+			}
+		}
+
+		if (mpext->use_map) {
+			len += TCPOLEN_MPTCP_DSS_MAP64;
+
+			/* Use only 64-bit mapping flags for now, add
+			 * support for optional 32-bit mappings later.
+			 */
+			flags |= MPTCP_DSS_HAS_MAP | MPTCP_DSS_DSN64;
+			if (mpext->data_fin)
+				flags |= MPTCP_DSS_DATA_FIN;
+
+			if (opts->csum_reqd)
+				len += TCPOLEN_MPTCP_DSS_CHECKSUM;
+		}
+
+		*ptr++ = mptcp_option(MPTCPOPT_DSS, len, 0, flags);
+
+		if (mpext->use_ack) {
+			if (mpext->ack64) {
+				put_unaligned_be64(mpext->data_ack, ptr);
+				ptr += 2;
+			} else {
+				put_unaligned_be32(mpext->data_ack32, ptr);
+				ptr += 1;
+			}
+		}
+
+		if (mpext->use_map) {
+			put_unaligned_be64(mpext->data_seq, ptr);
+			ptr += 2;
+			put_unaligned_be32(mpext->subflow_seq, ptr);
+			ptr += 1;
+			if (opts->csum_reqd) {
+				put_unaligned_be32(mpext->data_len << 16 |
+						   mptcp_make_csum(mpext), ptr);
+			} else {
+				put_unaligned_be32(mpext->data_len << 16 |
+						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
+			}
+		}
+	} else if ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
 	     OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
 		u8 len, flag = MPTCP_CAP_HMAC_SHA256;
 
@@ -1246,10 +1324,31 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 					   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
 		}
 		ptr += 1;
-	}
 
-mp_capable_done:
-	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
+		/* MPC is additionally mutually exclusive with MP_PRIO */
+		goto mp_capable_done;
+	} else if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
+		*ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
+				      TCPOLEN_MPTCP_MPJ_SYN,
+				      opts->backup, opts->join_id);
+		put_unaligned_be32(opts->token, ptr);
+		ptr += 1;
+		put_unaligned_be32(opts->nonce, ptr);
+		ptr += 1;
+	} else if (OPTION_MPTCP_MPJ_SYNACK & opts->suboptions) {
+		*ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
+				      TCPOLEN_MPTCP_MPJ_SYNACK,
+				      opts->backup, opts->join_id);
+		put_unaligned_be64(opts->thmac, ptr);
+		ptr += 2;
+		put_unaligned_be32(opts->nonce, ptr);
+		ptr += 1;
+	} else if (OPTION_MPTCP_MPJ_ACK & opts->suboptions) {
+		*ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
+				      TCPOLEN_MPTCP_MPJ_ACK, 0, 0);
+		memcpy(ptr, opts->hmac, MPTCPOPT_HMAC_LEN);
+		ptr += 5;
+	} else if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
 		struct mptcp_addr_info *addr = &opts->addr;
 		u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
 		u8 echo = MPTCP_ADDR_ECHO;
@@ -1308,6 +1407,19 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 		}
 	}
 
+	if (OPTION_MPTCP_PRIO & opts->suboptions) {
+		const struct sock *ssk = (const struct sock *)tp;
+		struct mptcp_subflow_context *subflow;
+
+		subflow = mptcp_subflow_ctx(ssk);
+		subflow->send_mp_prio = 0;
+
+		*ptr++ = mptcp_option(MPTCPOPT_MP_PRIO,
+				      TCPOLEN_MPTCP_PRIO,
+				      opts->backup, TCPOPT_NOP);
+	}
+
+mp_capable_done:
 	if (OPTION_MPTCP_RM_ADDR & opts->suboptions) {
 		u8 i = 1;
 
@@ -1328,107 +1440,6 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 		}
 	}
 
-	if (OPTION_MPTCP_PRIO & opts->suboptions) {
-		const struct sock *ssk = (const struct sock *)tp;
-		struct mptcp_subflow_context *subflow;
-
-		subflow = mptcp_subflow_ctx(ssk);
-		subflow->send_mp_prio = 0;
-
-		*ptr++ = mptcp_option(MPTCPOPT_MP_PRIO,
-				      TCPOLEN_MPTCP_PRIO,
-				      opts->backup, TCPOPT_NOP);
-	}
-
-	if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
-		*ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
-				      TCPOLEN_MPTCP_MPJ_SYN,
-				      opts->backup, opts->join_id);
-		put_unaligned_be32(opts->token, ptr);
-		ptr += 1;
-		put_unaligned_be32(opts->nonce, ptr);
-		ptr += 1;
-	}
-
-	if (OPTION_MPTCP_MPJ_SYNACK & opts->suboptions) {
-		*ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
-				      TCPOLEN_MPTCP_MPJ_SYNACK,
-				      opts->backup, opts->join_id);
-		put_unaligned_be64(opts->thmac, ptr);
-		ptr += 2;
-		put_unaligned_be32(opts->nonce, ptr);
-		ptr += 1;
-	}
-
-	if (OPTION_MPTCP_MPJ_ACK & opts->suboptions) {
-		*ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
-				      TCPOLEN_MPTCP_MPJ_ACK, 0, 0);
-		memcpy(ptr, opts->hmac, MPTCPOPT_HMAC_LEN);
-		ptr += 5;
-	}
-
-	if (OPTION_MPTCP_RST & opts->suboptions)
-		*ptr++ = mptcp_option(MPTCPOPT_RST,
-				      TCPOLEN_MPTCP_RST,
-				      opts->reset_transient,
-				      opts->reset_reason);
-
-	if (opts->ext_copy.use_ack || opts->ext_copy.use_map) {
-		struct mptcp_ext *mpext = &opts->ext_copy;
-		u8 len = TCPOLEN_MPTCP_DSS_BASE;
-		u8 flags = 0;
-
-		if (mpext->use_ack) {
-			flags = MPTCP_DSS_HAS_ACK;
-			if (mpext->ack64) {
-				len += TCPOLEN_MPTCP_DSS_ACK64;
-				flags |= MPTCP_DSS_ACK64;
-			} else {
-				len += TCPOLEN_MPTCP_DSS_ACK32;
-			}
-		}
-
-		if (mpext->use_map) {
-			len += TCPOLEN_MPTCP_DSS_MAP64;
-
-			/* Use only 64-bit mapping flags for now, add
-			 * support for optional 32-bit mappings later.
-			 */
-			flags |= MPTCP_DSS_HAS_MAP | MPTCP_DSS_DSN64;
-			if (mpext->data_fin)
-				flags |= MPTCP_DSS_DATA_FIN;
-
-			if (opts->csum_reqd)
-				len += TCPOLEN_MPTCP_DSS_CHECKSUM;
-		}
-
-		*ptr++ = mptcp_option(MPTCPOPT_DSS, len, 0, flags);
-
-		if (mpext->use_ack) {
-			if (mpext->ack64) {
-				put_unaligned_be64(mpext->data_ack, ptr);
-				ptr += 2;
-			} else {
-				put_unaligned_be32(mpext->data_ack32, ptr);
-				ptr += 1;
-			}
-		}
-
-		if (mpext->use_map) {
-			put_unaligned_be64(mpext->data_seq, ptr);
-			ptr += 2;
-			put_unaligned_be32(mpext->subflow_seq, ptr);
-			ptr += 1;
-			if (opts->csum_reqd) {
-				put_unaligned_be32(mpext->data_len << 16 |
-						   mptcp_make_csum(mpext), ptr);
-			} else {
-				put_unaligned_be32(mpext->data_len << 16 |
-						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
-			}
-		}
-	}
-
 	if (tp)
 		mptcp_set_rwin(tp);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 34ad1c4bc29f..d960d8b8a8ce 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -26,6 +26,7 @@
 #define OPTION_MPTCP_FASTCLOSE	BIT(8)
 #define OPTION_MPTCP_PRIO	BIT(9)
 #define OPTION_MPTCP_RST	BIT(10)
+#define OPTION_MPTCP_DSS	BIT(11)
 
 /* MPTCP option subtypes */
 #define MPTCPOPT_MP_CAPABLE	0
-- 
2.26.3

