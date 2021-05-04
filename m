Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ED970
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620164557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TfumiE1l1jplV3JjLWBpasdZpys2o/OWWJNudLyhbto=;
	b=T7tEYCl10pj8bqsrXM3JwN7ID2lu8HdVDRRw5dQC13lTXwSQmjjB58PQeC1uhqXJW+Z6p6
	p9Dadvfe+efcU6M0+ldAktM1WxV0Cghlm+HzyRrAyqPIvIejB1TDCg1lgcLYvuFZwWAOL5
	W7d1M9YobXkj43nBp4vc9PdFrOwHQNk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-WMuQ7b94Os--395JKR8TTA-1; Tue, 04 May 2021 17:42:35 -0400
X-MC-Unique: WMuQ7b94Os--395JKR8TTA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D55865235
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:34 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-126.ams2.redhat.com [10.36.114.126])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9D2995C22A
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:33 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v6 mptcp-next 06/22] Squash-to: "mptcp: send out checksum for MP_CAPABLE with data"
Date: Tue,  4 May 2021 23:41:54 +0200
Message-Id: <8850fb3700c38e61a548c65424c678df38ce380d.1620163861.git.pabeni@redhat.com>
In-Reply-To: <cover.1620163861.git.pabeni@redhat.com>
References: <cover.1620163861.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Finalize the csum value including the pseudo header and copy the
checksum into the opts only after computing it.

This is necessary after:
Squash-to: "mptcp: generate the data checksum"

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v4 -> v5:$
 - finalize csum in mptcp_write_options() this is necessary due to$
   the incremental csum update in v5 revision$
---
 net/mptcp/options.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 175635214ce6..d18a686aab7d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -440,7 +440,6 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	struct mptcp_ext *mpext;
 	unsigned int data_len;
-	__sum16 csum;
 	u8 len;
 
 	/* When skb is not available, we better over-estimate the emitted
@@ -461,7 +460,6 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 	if (subflow->mp_capable) {
 		mpext = mptcp_get_ext(skb);
 		data_len = mpext ? mpext->data_len : 0;
-		csum = mpext ? mpext->csum : 0;
 
 		/* we will check ext_copy.data_len in mptcp_write_options() to
 		 * discriminate between TCPOLEN_MPTCP_MPC_ACK_DATA and
@@ -472,8 +470,6 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		opts->sndr_key = subflow->local_key;
 		opts->rcvr_key = subflow->remote_key;
 		opts->csum_reqd = READ_ONCE(msk->csum_enabled);
-		if (opts->csum_reqd)
-			opts->ext_copy.csum = csum;
 
 		/* Section 3.1.
 		 * The MP_CAPABLE option is carried on the SYN, SYN/ACK, and ACK
@@ -482,8 +478,10 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		 */
 		if (data_len > 0) {
 			len = TCPOLEN_MPTCP_MPC_ACK_DATA;
-			if (opts->csum_reqd)
+			if (opts->csum_reqd) {
+				opts->ext_copy.csum = mpext->csum;
 				len += TCPOLEN_MPTCP_DSS_CHECKSUM;
+			}
 			*size = ALIGN(len, 4);
 		} else {
 			*size = TCPOLEN_MPTCP_MPC_ACK;
@@ -1135,6 +1133,25 @@ static void mptcp_set_rwin(const struct tcp_sock *tp)
 		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
 }
 
+static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
+{
+	struct csum_pseudo_header header;
+	__wsum csum;
+
+	/* cfr RFC 8684 3.3.1.:
+	 * the data sequence number used in the pseudo-header is
+	 * always the 64-bit value, irrespective of what length is used in the
+	 * DSS option itself.
+	 */
+	header.data_seq = cpu_to_be64(mpext->data_seq);
+	header.subflow_seq = htonl(mpext->subflow_seq);
+	header.data_len = htons(mpext->data_len);
+	header.csum = 0;
+
+	csum = csum_partial(&header, sizeof(header), ~csum_unfold(mpext->csum));
+	return (__force u16)csum_fold(csum);
+}
+
 void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			 struct mptcp_out_options *opts)
 {
@@ -1177,7 +1194,7 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 
 		if (opts->csum_reqd) {
 			put_unaligned_be32(opts->ext_copy.data_len << 16 |
-					   (__force u16)opts->ext_copy.csum, ptr);
+					   mptcp_make_csum(&opts->ext_copy), ptr);
 		} else {
 			put_unaligned_be32(opts->ext_copy.data_len << 16 |
 					   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
-- 
2.26.2

