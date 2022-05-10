Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C76028E9
	for <mptcp@lists.linux.dev>; Tue, 10 May 2022 16:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1652200018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cNuvkdX6MXM75ZrE+5MOP6awkzYReQS4/O3lIQP0qrc=;
	b=WeteaC06c0iaPuGpJvsSE6PiRJDEoe/f95SRDMb01F5E/wlkvynmj7G10XxLCoTOoIqZ6T
	VfhlXJ1gCfTAfMxI/X5lJTc/EiTSlwIDyV4OYgj8ZdMHHwmda+sOBDHoqn5dPG9umOar0m
	wbT0VnNitS5HTesnOEsyHBufkbYjTKE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-qd9JZ8JPO-aBsNv16SMIVg-1; Tue, 10 May 2022 12:26:54 -0400
X-MC-Unique: qd9JZ8JPO-aBsNv16SMIVg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 846C31801393
	for <mptcp@lists.linux.dev>; Tue, 10 May 2022 16:25:39 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.162])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1738F2166B4E
	for <mptcp@lists.linux.dev>; Tue, 10 May 2022 16:25:38 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2] mptcp: fix checksum byte order
Date: Tue, 10 May 2022 18:25:35 +0200
Message-Id: <595f104803a212df58db6d20f84947325b33a9d6.1652196378.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
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

MPTCP checksum is disabled by default, interoperating with systems
with bad mptcp-level csum encodying should cause fallback to TCP.

Fixes: c5b39e26d003 ("mptcp: send out checksum for DSS")
Fixes: 390b95a5fb84 ("mptcp: receive checksum for DSS")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - move the typecast inside put_len_csum (Mat)
 - updated the commit message (Mat)
 - fix a few sparse issues
---
 net/mptcp/options.c  | 37 ++++++++++++++++++++++++-------------
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  |  2 +-
 3 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ac3b7b8a02f6..6c90c78b52d1 100644
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
@@ -1298,15 +1298,25 @@ u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
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
 
+static void put_len_csum(u16 len, __sum16 csum, void *data)
+{
+	__sum16 *sumptr = data + 2;
+	__be16 *ptr = data;
+
+	put_unaligned_be16(len, ptr);
+
+	put_unaligned(csum, sumptr);
+}
+
 void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 			 struct mptcp_out_options *opts)
 {
@@ -1385,9 +1395,9 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 				/* data_len == 0 is reserved for the infinite mapping,
 				 * the checksum will also be set to 0.
 				 */
-				put_unaligned_be32(mpext->data_len << 16 |
-						   (mpext->data_len ? mptcp_make_csum(mpext) : 0),
-						   ptr);
+				put_len_csum(mpext->data_len,
+					     mpext->data_len ? mptcp_make_csum(mpext) : 0,
+					     ptr);
 			} else {
 				put_unaligned_be32(mpext->data_len << 16 |
 						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
@@ -1438,11 +1448,12 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
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
+				     ptr);
 		} else {
 			put_unaligned_be32(opts->data_len << 16 |
 					   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 59a23838782f..f98c27300e60 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -763,7 +763,7 @@ void mptcp_token_destroy(struct mptcp_sock *msk);
 void mptcp_crypto_key_sha(u64 key, u32 *token, u64 *idsn);
 
 void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg, int len, void *hmac);
-u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum);
+__sum16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum);
 
 void __init mptcp_pm_init(void);
 void mptcp_pm_data_init(struct mptcp_sock *msk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9842dab09c8b..b38a02db924b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -891,7 +891,7 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	u32 offset, seq, delta;
-	u16 csum;
+	__sum16 csum;
 	int len;
 
 	if (!csum_reqd)
-- 
2.35.3

