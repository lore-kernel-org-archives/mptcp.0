Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8113A70
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 14:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619189430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jxtwOVUgkA3oMK6cE1fEKftzjA0k6oX+7SKbyJ9DpLI=;
	b=OymWH4Kpg1MTIqOS/bJCvZM2IIEOPN7yjj2hhnaLN/WozGsWNnXMNL/aIXQy0wRRWNWIzK
	wbBprGjX2ORMF/gYspL6MJdLBEyWyNemZQv+KcYDko5zZMYjLw/e4Q53xj9PQAILWH4mS9
	QrLERzwq1DlRmtG6LR8crZtrt3yilRk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-oK2b48VLMZKEgwF2abjknA-1; Fri, 23 Apr 2021 10:50:28 -0400
X-MC-Unique: oK2b48VLMZKEgwF2abjknA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6550E1008060;
	Fri, 23 Apr 2021 14:50:27 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-60.ams2.redhat.com [10.36.115.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9A4E71992D;
	Fri, 23 Apr 2021 14:50:26 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v4 mptcp-next 11/22] mptcp: receive checksum for MP_CAPABLE with data
Date: Fri, 23 Apr 2021 16:49:50 +0200
Message-Id: <b2717e05d0a33c8a8cb80d0523c76b09b725a260.1619189145.git.pabeni@redhat.com>
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

From: Geliang Tang <geliangtang@gmail.com>

This patch added a new member named csum in struct mptcp_options_received.

When parsing the MP_CAPABLE with data, if the checksum is enabled,
adjust the expected_opsize. If the receiving option length matches the
length with the data checksum, get the checksum value and save it in
mp_opt->csum. And in mptcp_incoming_options, pass it to mpext->csum.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c  | 21 ++++++++++++++++-----
 net/mptcp/protocol.h |  1 +
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 2d6b0158e19b..cd205ad09c00 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -37,10 +37,13 @@ static void mptcp_parse_option(const struct sock *sk,
 	case MPTCPOPT_MP_CAPABLE:
 		/* strict size checking */
 		if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)) {
-			if (skb->len > tcp_hdr(skb)->doff << 2)
+			if (skb->len > tcp_hdr(skb)->doff << 2) {
 				expected_opsize = TCPOLEN_MPTCP_MPC_ACK_DATA;
-			else
+				if (READ_ONCE(msk->csum_enabled))
+					expected_opsize += TCPOLEN_MPTCP_DSS_CHECKSUM;
+			} else {
 				expected_opsize = TCPOLEN_MPTCP_MPC_ACK;
+			}
 		} else {
 			if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK)
 				expected_opsize = TCPOLEN_MPTCP_MPC_SYNACK;
@@ -88,7 +91,7 @@ static void mptcp_parse_option(const struct sock *sk,
 			mp_opt->rcvr_key = get_unaligned_be64(ptr);
 			ptr += 8;
 		}
-		if (opsize == TCPOLEN_MPTCP_MPC_ACK_DATA) {
+		if (opsize >= TCPOLEN_MPTCP_MPC_ACK_DATA) {
 			/* Section 3.1.:
 			 * "the data parameters in a MP_CAPABLE are semantically
 			 * equivalent to those in a DSS option and can be used
@@ -100,9 +103,13 @@ static void mptcp_parse_option(const struct sock *sk,
 			mp_opt->data_len = get_unaligned_be16(ptr);
 			ptr += 2;
 		}
-		pr_debug("MP_CAPABLE version=%x, flags=%x, optlen=%d sndr=%llu, rcvr=%llu len=%d",
+		if (opsize == TCPOLEN_MPTCP_MPC_ACK_DATA + TCPOLEN_MPTCP_DSS_CHECKSUM) {
+			mp_opt->csum = (__force __sum16)get_unaligned_be16(ptr);
+			ptr += 2;
+		}
+		pr_debug("MP_CAPABLE version=%x, flags=%x, optlen=%d sndr=%llu, rcvr=%llu len=%d csum=%u",
 			 version, flags, opsize, mp_opt->sndr_key,
-			 mp_opt->rcvr_key, mp_opt->data_len);
+			 mp_opt->rcvr_key, mp_opt->data_len, mp_opt->csum);
 		break;
 
 	case MPTCPOPT_MP_JOIN:
@@ -346,6 +353,7 @@ void mptcp_get_options(const struct sock *sk,
 	mp_opt->mp_prio = 0;
 	mp_opt->reset = 0;
 	mp_opt->csum_reqd = 0;
+	mp_opt->csum = 0;
 
 	length = (th->doff * 4) - sizeof(struct tcphdr);
 	ptr = (const unsigned char *)(th + 1);
@@ -1121,6 +1129,9 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		}
 		mpext->data_len = mp_opt.data_len;
 		mpext->use_map = 1;
+
+		if (READ_ONCE(msk->csum_enabled))
+			mpext->csum = mp_opt.csum;
 	}
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 51f4bbe1703a..d2b00f8c4040 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -124,6 +124,7 @@ struct mptcp_options_received {
 	u64	data_seq;
 	u32	subflow_seq;
 	u16	data_len;
+	__sum16	csum;
 	u16	mp_capable : 1,
 		mp_join : 1,
 		fastclose : 1,
-- 
2.26.2

