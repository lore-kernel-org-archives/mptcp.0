Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F1B2568
	for <mptcp@lists.linux.dev>; Thu,  5 May 2022 15:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1651763364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LKfDDaS1asHf6nm0qWTLvUDVXIdGDUXCu+exSEI2iI4=;
	b=RCzKJsdQvpOnJh5i/HI1yL66kdSoCkxuEc0WIfYN71LgIVmmWNRmo1W627Y0NBMddEbnaM
	4MD8PNFsfEMv3Ckay+ftDNQ1TDm0rMbZHPETg1d1u7oAeNaTbB+vA5WjDIqfXT4CD+NSuJ
	WSS8vikYziiAO5tdPIqdqaLBbtmULFg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-PdL8xQHWMA-DJoFt0txXvg-1; Thu, 05 May 2022 11:09:23 -0400
X-MC-Unique: PdL8xQHWMA-DJoFt0txXvg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA065185A7BA
	for <mptcp@lists.linux.dev>; Thu,  5 May 2022 15:09:22 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.241])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5569714C3B5A
	for <mptcp@lists.linux.dev>; Thu,  5 May 2022 15:09:22 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH MPTCP-next] mptcp: fix checksum byte order
Date: Thu,  5 May 2022 17:09:12 +0200
Message-Id: <1a8201582e7fd63db7b5c9c4077af1ab1953c57e.1651763323.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The MPTCP code typecasts the checksum value to u16 and
then convert it to big endian while storing the value into
the MPTCP option.

As a result, the wire encoding for little endian host is
wrong, and that causes interoperabilty interoperability
issues with other implementation or host with different endianess.

Address the issue writing in the packet the unmodified __sum16 value.

The change is not backward compatible, but I can't see any
other option. MPTCP checksum is disabled by default, and there are
no backward issues with csum disabled.

Fixes: c5b39e26d003 ("mptcp: send out checksum for DSS")
Fixes: 390b95a5fb84 ("mptcp: receive checksum for DSS")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ac3b7b8a02f6..5b5849d9fe60 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -107,7 +107,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			ptr += 2;
 		}
 		if (opsize == TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM) {
-			mp_opt->csum = (__force __sum16)get_unaligned_be16(ptr);
+			mp_opt->csum = get_unaligned((__force __sum16 *)ptr);
 			mp_opt->suboptions |= OPTION_MPTCP_CSUMREQD;
 			ptr += 2;
 		}
@@ -221,7 +221,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 
 			if (opsize == expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM) {
 				mp_opt->suboptions |= OPTION_MPTCP_CSUMREQD;
-				mp_opt->csum = (__force __sum16)get_unaligned_be16(ptr);
+				mp_opt->csum = get_unaligned((__force __sum16 *)ptr);
 				ptr += 2;
 			}
 
@@ -1282,7 +1282,7 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 	}
 }
 
-u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
+__sum16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
 {
 	struct csum_pseudo_header header;
 	__wsum csum;
@@ -1298,15 +1298,23 @@ u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
 	header.csum = 0;
 
 	csum = csum_partial(&header, sizeof(header), sum);
-	return (__force u16)csum_fold(csum);
+	return csum_fold(csum);
 }
 
-static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
+static __sum16 mptcp_make_csum(const struct mptcp_ext *mpext)
 {
 	return __mptcp_make_csum(mpext->data_seq, mpext->subflow_seq, mpext->data_len,
 				 ~csum_unfold(mpext->csum));
 }
 
+static void put_len_csum(u16 len, __sum16 csum, __be16 *ptr)
+{
+	put_unaligned_be16(len, ptr);
+
+	ptr += 1;
+	put_unaligned(csum, ptr);
+}
+
 void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 			 struct mptcp_out_options *opts)
 {
@@ -1385,9 +1393,9 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 				/* data_len == 0 is reserved for the infinite mapping,
 				 * the checksum will also be set to 0.
 				 */
-				put_unaligned_be32(mpext->data_len << 16 |
-						   (mpext->data_len ? mptcp_make_csum(mpext) : 0),
-						   ptr);
+				put_len_csum(mpext->data_len,
+					     mpext->data_len ? mptcp_make_csum(mpext) : 0,
+					     (__force __be16 *)ptr);
 			} else {
 				put_unaligned_be32(mpext->data_len << 16 |
 						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
@@ -1438,11 +1446,12 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 			goto mp_capable_done;
 
 		if (opts->csum_reqd) {
-			put_unaligned_be32(opts->data_len << 16 |
-					   __mptcp_make_csum(opts->data_seq,
-							     opts->subflow_seq,
-							     opts->data_len,
-							     ~csum_unfold(opts->csum)), ptr);
+			put_len_csum(opts->data_len,
+				     __mptcp_make_csum(opts->data_seq,
+						       opts->subflow_seq,
+						       opts->data_len,
+						       ~csum_unfold(opts->csum)),
+				     (__force __be16 *)ptr);
 		} else {
 			put_unaligned_be32(opts->data_len << 16 |
 					   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
-- 
2.35.1

