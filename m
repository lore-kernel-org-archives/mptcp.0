Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B132FB0
	for <mptcp@lists.linux.dev>; Fri, 23 Jul 2021 17:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627059977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WtO5PIaQkcTLhMilNrM++XFFaOj30u54oMQ08/9oHn0=;
	b=T6doZtAD6iBTqpbFeyHQLBc9vRd3RP7BaLMXcagYnazps1qc1i4OvkWkLACrq/cXq6b6kz
	jmiQVHh/eENsluvrKoYQExtL7hjqbxXlt1+BOJSnShrAtegrhq38OlqZ8FCLZEEYiRTeaW
	Cea0TtvsuuuwhuRVm63BAKZFOMTl8aY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-NQxCtCxtPmGZ6gZiGkkQNA-1; Fri, 23 Jul 2021 13:06:15 -0400
X-MC-Unique: NQxCtCxtPmGZ6gZiGkkQNA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7D9D1005D4F
	for <mptcp@lists.linux.dev>; Fri, 23 Jul 2021 17:06:14 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-112-240.ams2.redhat.com [10.36.112.240])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F3B0F1007604
	for <mptcp@lists.linux.dev>; Fri, 23 Jul 2021 17:06:13 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 1/2] mptcp: optimize out option generation
Date: Fri, 23 Jul 2021 19:06:05 +0200
Message-Id: <b886e46981b5f02c726f92655fabd054f4dc9217.1627059686.git.pabeni@redhat.com>
In-Reply-To: <cover.1627059686.git.pabeni@redhat.com>
References: <cover.1627059686.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
side node: we could probably optimize the conditionals in
mptcp_established_options()
---
 net/mptcp/options.c  | 225 ++++++++++++++++++++++---------------------
 net/mptcp/pm.c       |   9 +-
 net/mptcp/protocol.h |   1 +
 3 files changed, 122 insertions(+), 113 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index eafdb9408f3a..38f324667761 100644
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
@@ -663,9 +665,9 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	bool drop_other_suboptions = false;
 	unsigned int opt_size = *size;
+	unsigned int len;
 	bool echo;
 	bool port;
-	int len;
 
 	if (!mptcp_pm_should_add_signal(msk) ||
 	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, opts,
@@ -687,11 +689,12 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 		*size -= opt_size;
 	}
 	opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
-	if (!echo) {
+	if (!echo)
 		opts->ahmac = add_addr_generate_hmac(msk->local_key,
 						     msk->remote_key,
 						     &opts->addr);
-	}
+	else
+		opts->ahmac = 0;
 	pr_debug("addr_id=%d, addr_port=%d, ahmac=%llu, echo=%d",
 		 opts->addr.id, ntohs(opts->addr.port), opts->ahmac, echo);
 
@@ -735,7 +738,12 @@ static bool mptcp_established_options_mp_prio(struct sock *sk,
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
@@ -1198,7 +1206,73 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
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
 
@@ -1246,10 +1320,31 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
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
@@ -1308,6 +1403,19 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
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
 
@@ -1328,107 +1436,6 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
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
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4d1828fd2482..baf2d6e524bd 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -266,10 +266,11 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 	if (!mptcp_pm_should_add_signal(msk))
 		goto out_unlock;
 
-	if (((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)) ||
-	     ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL)) &&
-	      (msk->pm.local.family == AF_INET6 || msk->pm.local.port))) &&
-	    skb && skb_is_tcp_pure_ack(skb)) {
+	/* always drop every other options for pure ack ADD_ADDR; this is
+	 * plain dup-ack from TCP perspective. The other MPTCP-relevant info,
+	 * if any, will be carried by the other pure ack
+	 */
+	if (skb && skb_is_tcp_pure_ack(skb)) {
 		remaining += opt_size;
 		*drop_other_suboptions = true;
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

