Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B702B2FA3
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 14:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619189430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fC+MmkL5PFju1ATdXhJy5kUhf1SByY/gbBCK4bGiW5I=;
	b=JvhI7rhXOHQpIJSKC+sJLK7/Ldscw1TvCf1GdBv9lTTysTlq8rRhFmOIwKX+g/7Ah6/jzC
	v29YerfjxRR4iXaQKsS4KL0AcHC4j2zr/Mh2kuKLIiT/4V+4sOi9F9j13qUdTKs+Z+HxbQ
	nQ8PrJONBXrEEVhSnbPfsEH1OSNZHLo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-bxfWbgsbP5WXUq1G0tnBcw-1; Fri, 23 Apr 2021 10:50:29 -0400
X-MC-Unique: bxfWbgsbP5WXUq1G0tnBcw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CBEE18397AA;
	Fri, 23 Apr 2021 14:50:28 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-60.ams2.redhat.com [10.36.115.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C085E19D9B;
	Fri, 23 Apr 2021 14:50:27 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v4 mptcp-next 12/22] Squash-to: "mptcp: receive checksum for MP_CAPABLE with data"
Date: Fri, 23 Apr 2021 16:49:51 +0200
Message-Id: <9a9851d76be0250658af3030e9d60afa51be8c95.1619189145.git.pabeni@redhat.com>
In-Reply-To: <cover.1619189145.git.pabeni@redhat.com>
References: <cover.1619189145.git.pabeni@redhat.com>
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

always parse any csum/nocsum combination and delay the
presence check to later code, to allow reset if missing.

Additionally, in the TX path, use the newly introduce ext
field to avoid MPTCP csum recomputation on tcp retransmission
and unneeded csum update on when setting the data fin_flag.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/mptcp.h  |  3 ++-
 net/mptcp/options.c  | 32 ++++++++++++++++++++------------
 net/mptcp/protocol.h |  2 ++
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 8f86c05ddbfd..bd272c34b53c 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -32,7 +32,8 @@ struct mptcp_ext {
 			mpc_map:1,
 			frozen:1,
 			reset_transient:1;
-	u8		reset_reason:4;
+	u8		reset_reason:4,
+			csum_reqd:1;
 };
 
 #define MPTCP_RM_IDS_MAX	8
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index cd205ad09c00..83a981684bbf 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -39,8 +39,6 @@ static void mptcp_parse_option(const struct sock *sk,
 		if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)) {
 			if (skb->len > tcp_hdr(skb)->doff << 2) {
 				expected_opsize = TCPOLEN_MPTCP_MPC_ACK_DATA;
-				if (READ_ONCE(msk->csum_enabled))
-					expected_opsize += TCPOLEN_MPTCP_DSS_CHECKSUM;
 			} else {
 				expected_opsize = TCPOLEN_MPTCP_MPC_ACK;
 			}
@@ -50,7 +48,20 @@ static void mptcp_parse_option(const struct sock *sk,
 			else
 				expected_opsize = TCPOLEN_MPTCP_MPC_SYN;
 		}
-		if (opsize != expected_opsize)
+
+		/* Cfr RFC 8684 Section 3.3.0:
+		 * If a checksum is present but its use had
+		 * not been negotiated in the MP_CAPABLE handshake, the receiver MUST
+		 * close the subflow with a RST, as it is not behaving as negotiated.
+		 * If a checksum is not present when its use has been negotiated, the
+		 * receiver MUST close the subflow with a RST, as it is considered
+		 * broken
+		 * We parse even option with mismatching csum presence, so that
+		 * later in subflow_data_ready we can trigger the reset.
+		 */
+		if ((opsize != expected_opsize) &&
+		    (expected_opsize != TCPOLEN_MPTCP_MPC_ACK_DATA ||
+		     opsize != TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM))
 			break;
 
 		/* try to be gentle vs future versions on the initial syn */
@@ -72,11 +83,6 @@ static void mptcp_parse_option(const struct sock *sk,
 		 * host requires the use of checksums, checksums MUST be used.
 		 * In other words, the only way for checksums not to be used
 		 * is if both hosts in their SYNs set A=0."
-		 *
-		 * Section 3.3.0:
-		 * "If a checksum is not present when its use has been
-		 * negotiated, the receiver MUST close the subflow with a RST as
-		 * it is considered broken."
 		 */
 		mp_opt->csum_reqd = READ_ONCE(msk->csum_enabled);
 		if (flags & MPTCP_CAP_CHECKSUM_REQD)
@@ -103,8 +109,9 @@ static void mptcp_parse_option(const struct sock *sk,
 			mp_opt->data_len = get_unaligned_be16(ptr);
 			ptr += 2;
 		}
-		if (opsize == TCPOLEN_MPTCP_MPC_ACK_DATA + TCPOLEN_MPTCP_DSS_CHECKSUM) {
+		if (opsize == TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM) {
 			mp_opt->csum = (__force __sum16)get_unaligned_be16(ptr);
+			mp_opt->csum_reqd = 1;
 			ptr += 2;
 		}
 		pr_debug("MP_CAPABLE version=%x, flags=%x, optlen=%d sndr=%llu, rcvr=%llu len=%d csum=%u",
@@ -353,7 +360,6 @@ void mptcp_get_options(const struct sock *sk,
 	mp_opt->mp_prio = 0;
 	mp_opt->reset = 0;
 	mp_opt->csum_reqd = 0;
-	mp_opt->csum = 0;
 
 	length = (th->doff * 4) - sizeof(struct tcphdr);
 	ptr = (const unsigned char *)(th + 1);
@@ -543,7 +549,8 @@ static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
 		ext->data_len++;
 
 		/* the pseudo header has changed, update the csum accordingly */
-		csum_replace2(&ext->csum, ext->data_len - 1, ext->data_len);
+		if (ext->csum_reqd)
+			csum_replace2(&ext->csum, ext->data_len - 1, ext->data_len);
 	}
 }
 
@@ -1129,8 +1136,9 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		}
 		mpext->data_len = mp_opt.data_len;
 		mpext->use_map = 1;
+		mpext->csum_reqd = mp_opt.csum_reqd;
 
-		if (READ_ONCE(msk->csum_enabled))
+		if (mpext->csum_reqd)
 			mpext->csum = mp_opt.csum;
 	}
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d2b00f8c4040..3ac61b8178fd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -68,6 +68,8 @@
 #define TCPOLEN_MPTCP_FASTCLOSE		12
 #define TCPOLEN_MPTCP_RST		4
 
+#define TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM	(TCPOLEN_MPTCP_DSS_CHECKSUM + TCPOLEN_MPTCP_MPC_ACK_DATA)
+
 /* MPTCP MP_JOIN flags */
 #define MPTCPOPT_BACKUP		BIT(0)
 #define MPTCPOPT_HMAC_LEN	20
-- 
2.26.2

