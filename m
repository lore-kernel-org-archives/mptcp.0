Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C0D68
	for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 14:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1634827892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XPNJzWMu1H6JfAZbvCA8aIWGa6w6Bxy18gm08/QGtMY=;
	b=RQ1AX9B300X9+ZgBHodtabmMQKwhEh2bQG0UeGCk6S4QGvc8sGMdzTPDyVBlptYqp5vMLt
	DOjhmX4n3ZwY4WIYnKAd1dhXOlU9pwSMaV6JNCKc2aIYlIhkNOt0+AzXzOAFd+xYfmQyVi
	Qo+4OZ5EijBns45dCfvfoToAZBArbFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-FCcU5M7mM4-zt-AjX3PwqQ-1; Thu, 21 Oct 2021 10:51:28 -0400
X-MC-Unique: FCcU5M7mM4-zt-AjX3PwqQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E78411922960;
	Thu, 21 Oct 2021 14:51:26 +0000 (UTC)
Received: from dcaratti.station (unknown [10.40.192.250])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 57F79101E5AE;
	Thu, 21 Oct 2021 14:51:25 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev,
	psonparo@redhat.com
Subject: [PATCH mptcp-net] mptcp: fix corrupt receiver key in MPC + data + checksum
Date: Thu, 21 Oct 2021 16:51:15 +0200
Message-Id: <1207c7d44dd4d1a630afc8b7018cf4185fe4a489.1634827708.git.dcaratti@redhat.com>
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
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/233
Reported-by: Poorva Sonparote <psonparo@redhat.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 include/net/mptcp.h |  4 ++++
 net/mptcp/options.c | 38 +++++++++++++++++++++++---------------
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index f83fa48408b3..a925349b4b89 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -71,6 +71,10 @@ struct mptcp_out_options {
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
index 422f4acfb3e6..ce27a4afc64a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -489,7 +489,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
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
@@ -1223,25 +1223,30 @@ static void mptcp_set_rwin(const struct tcp_sock *tp)
 		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
 }
 
-static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
+static u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __sum16 csum)
 {
 	struct csum_pseudo_header header;
-	__wsum csum;
 
 	/* cfr RFC 8684 3.3.1.:
 	 * the data sequence number used in the pseudo-header is
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
+	csum = csum_partial(&header, sizeof(header), ~csum_unfold(csum));
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
@@ -1332,7 +1337,7 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			len = TCPOLEN_MPTCP_MPC_SYN;
 		} else if (OPTION_MPTCP_MPC_SYNACK & opts->suboptions) {
 			len = TCPOLEN_MPTCP_MPC_SYNACK;
-		} else if (opts->ext_copy.data_len) {
+		} else if (opts->data_len) {
 			len = TCPOLEN_MPTCP_MPC_ACK_DATA;
 			if (opts->csum_reqd)
 				len += TCPOLEN_MPTCP_DSS_CHECKSUM;
@@ -1361,14 +1366,17 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 
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

