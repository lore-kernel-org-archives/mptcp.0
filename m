Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29CC2C81
	for <mptcp@lists.linux.dev>; Tue, 26 Oct 2021 14:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635258542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pV3hjagxhvTO/jY8KxafZdsOS71mEN4q53KquOaYJVY=;
	b=S8KV0i9VZ43u8FilBTlNEuqyFUkJLrmmLmn1eYAIBZIChfnBzKvEFb3SQnbEhIJvbbmsUV
	g5mx5gj7Rmcv7PH2L7bQ/+JuQFeRIrvmP16oRze+7R8lFPxmwpIbN0JYT2TPi1LYMsyNKC
	RTwo8hUrv1Nl+pUfeuQn8um1KwrMCIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-OXNAvaENMIuodDCofHrKzA-1; Tue, 26 Oct 2021 10:28:56 -0400
X-MC-Unique: OXNAvaENMIuodDCofHrKzA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 662DD9126B;
	Tue, 26 Oct 2021 14:28:55 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.40.194.195])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C64B1100EBAD;
	Tue, 26 Oct 2021 14:28:53 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Paolo Abeni <pabeni@redhat.com>,
	mptcp@lists.linux.dev
Cc: psonparo@redhat.com
Subject: [PATCH mptcp-net v2] mptcp: fix corrupt receiver key in MPC + data + checksum
Date: Tue, 26 Oct 2021 16:27:35 +0200
Message-Id: <0ad4620ed5034e9267e579f71c060b312b3e2eee.1635258393.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dcaratti@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

using packetdrill it's possible to observe that the receiver key contains
random values when clients transmit MP_CAPABLE with data and checksum (as
specified in RFC8684 §3.1). Fix the layout of mptcp_out_options, to avoid
using the skb extension copy when writing the MP_CAPABLE sub-option.

Fixes: d7b269083786 ("mptcp: shrink mptcp_out_options struct")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/233
Reported-by: Poorva Sonparote <psonparo@redhat.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---

Notes:
    v1:
     - fix metadata in the commit message (Mat Martineau)
     - adjust comment in mptcp_established_options_mp() (Mat Martineau)
     - fix sparse warning in __mptcp_make_csum() (Mat Martineau / patchew CI)

 include/net/mptcp.h |  4 ++++
 net/mptcp/options.c | 39 ++++++++++++++++++++++++---------------
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 6026bbefbffd..3214848402ec 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -69,6 +69,10 @@ struct mptcp_out_options {
 		struct {
 			u64 sndr_key;
 			u64 rcvr_key;
+			u64 data_seq;
+			u32 subflow_seq;
+			u16 data_len;
+			__sum16 csum;
 		};
 		struct {
 			struct mptcp_addr_info addr;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c41273cefc51..f0f22eb4fd5f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -485,11 +485,11 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		mpext = mptcp_get_ext(skb);
 		data_len = mpext ? mpext->data_len : 0;
 
-		/* we will check ext_copy.data_len in mptcp_write_options() to
+		/* we will check ops->data_len in mptcp_write_options() to
 		 * discriminate between TCPOLEN_MPTCP_MPC_ACK_DATA and
 		 * TCPOLEN_MPTCP_MPC_ACK
 		 */
-		opts->ext_copy.data_len = data_len;
+		opts->data_len = data_len;
 		opts->suboptions = OPTION_MPTCP_MPC_ACK;
 		opts->sndr_key = subflow->local_key;
 		opts->rcvr_key = subflow->remote_key;
@@ -505,9 +505,9 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 			len = TCPOLEN_MPTCP_MPC_ACK_DATA;
 			if (opts->csum_reqd) {
 				/* we need to propagate more info to csum the pseudo hdr */
-				opts->ext_copy.data_seq = mpext->data_seq;
-				opts->ext_copy.subflow_seq = mpext->subflow_seq;
-				opts->ext_copy.csum = mpext->csum;
+				opts->data_seq = mpext->data_seq;
+				opts->subflow_seq = mpext->subflow_seq;
+				opts->csum = mpext->csum;
 				len += TCPOLEN_MPTCP_DSS_CHECKSUM;
 			}
 			*size = ALIGN(len, 4);
@@ -1227,7 +1227,7 @@ static void mptcp_set_rwin(const struct tcp_sock *tp)
 		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
 }
 
-static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
+static u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __sum16 sum)
 {
 	struct csum_pseudo_header header;
 	__wsum csum;
@@ -1237,15 +1237,21 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
 	 * always the 64-bit value, irrespective of what length is used in the
 	 * DSS option itself.
 	 */
-	header.data_seq = cpu_to_be64(mpext->data_seq);
-	header.subflow_seq = htonl(mpext->subflow_seq);
-	header.data_len = htons(mpext->data_len);
+	header.data_seq = cpu_to_be64(data_seq);
+	header.subflow_seq = htonl(subflow_seq);
+	header.data_len = htons(data_len);
 	header.csum = 0;
 
-	csum = csum_partial(&header, sizeof(header), ~csum_unfold(mpext->csum));
+	csum = csum_partial(&header, sizeof(header), ~csum_unfold(sum));
 	return (__force u16)csum_fold(csum);
 }
 
+static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
+{
+	return __mptcp_make_csum(mpext->data_seq, mpext->subflow_seq, mpext->data_len,
+				 mpext->csum);
+}
+
 void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			 struct mptcp_out_options *opts)
 {
@@ -1337,7 +1343,7 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			len = TCPOLEN_MPTCP_MPC_SYN;
 		} else if (OPTION_MPTCP_MPC_SYNACK & opts->suboptions) {
 			len = TCPOLEN_MPTCP_MPC_SYNACK;
-		} else if (opts->ext_copy.data_len) {
+		} else if (opts->data_len) {
 			len = TCPOLEN_MPTCP_MPC_ACK_DATA;
 			if (opts->csum_reqd)
 				len += TCPOLEN_MPTCP_DSS_CHECKSUM;
@@ -1366,14 +1372,17 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 
 		put_unaligned_be64(opts->rcvr_key, ptr);
 		ptr += 2;
-		if (!opts->ext_copy.data_len)
+		if (!opts->data_len)
 			goto mp_capable_done;
 
 		if (opts->csum_reqd) {
-			put_unaligned_be32(opts->ext_copy.data_len << 16 |
-					   mptcp_make_csum(&opts->ext_copy), ptr);
+			put_unaligned_be32(opts->data_len << 16 |
+					   __mptcp_make_csum(opts->data_seq,
+							     opts->subflow_seq,
+							     opts->data_len,
+							     opts->csum), ptr);
 		} else {
-			put_unaligned_be32(opts->ext_copy.data_len << 16 |
+			put_unaligned_be32(opts->data_len << 16 |
 					   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
 		}
 		ptr += 1;
-- 
2.31.1

