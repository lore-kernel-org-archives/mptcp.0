Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C661854
	for <mptcp@lists.linux.dev>; Tue, 17 May 2022 18:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652810541; x=1684346541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NPyjrYQpM53zicvELSUePCB3rJhTOtiZ364J8gH2kPU=;
  b=hfCKfQUcb+8adg4blFtWp2b4I1oJVPmuZ5hhb8UpSyzjR6QS9Y3Dc1cg
   iZbRA3a8754oZtrO2hwm+MFd9rKa7L8PNgPdl1IjxM9Oz92C4CycbB33x
   2Hda1GzArCyH5EJsmmi73fyrF/mKarkeNskCbE6QOLgSk33uvm6Ac9Pmf
   EjX0FEiE2YZWfER0oWcYv8QCaKE9bI1QuZgKIMyIlyxqAaG8MvjNqxBaV
   M52i3/H6hRHWEwrGPdwo0bNgwTWGVH0jp+l3RZSPn4xw6owWF79LRZO/E
   KeR7E5T0LCMHUwSPp2Dd3khyqX190bj1sbZqNzKJ+vhr0ALhdv6ZvmzYv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="331887958"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="331887958"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 11:02:19 -0700
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="523080352"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.6.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 11:02:17 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 1/2] mptcp: fix checksum byte order
Date: Tue, 17 May 2022 11:02:11 -0700
Message-Id: <20220517180212.92597-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220517180212.92597-1-mathew.j.martineau@linux.intel.com>
References: <20220517180212.92597-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

The MPTCP code typecasts the checksum value to u16 and
then converts it to big endian while storing the value into
the MPTCP option.

As a result, the wire encoding for little endian host is
wrong, and that causes interoperabilty interoperability
issues with other implementation or host with different endianness.

Address the issue writing in the packet the unmodified __sum16 value.

MPTCP checksum is disabled by default, interoperating with systems
with bad mptcp-level csum encoding should cause fallback to TCP.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/275
Fixes: c5b39e26d003 ("mptcp: send out checksum for DSS")
Fixes: 390b95a5fb84 ("mptcp: receive checksum for DSS")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/options.c  | 36 ++++++++++++++++++++++++------------
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  |  2 +-
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 325383646f5c..b548cec86c9d 100644
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
 
@@ -1240,7 +1240,7 @@ static void mptcp_set_rwin(const struct tcp_sock *tp)
 		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
 }
 
-u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
+__sum16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
 {
 	struct csum_pseudo_header header;
 	__wsum csum;
@@ -1256,15 +1256,25 @@ u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
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
 void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			 struct mptcp_out_options *opts)
 {
@@ -1340,8 +1350,9 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			put_unaligned_be32(mpext->subflow_seq, ptr);
 			ptr += 1;
 			if (opts->csum_reqd) {
-				put_unaligned_be32(mpext->data_len << 16 |
-						   mptcp_make_csum(mpext), ptr);
+				put_len_csum(mpext->data_len,
+					     mptcp_make_csum(mpext),
+					     ptr);
 			} else {
 				put_unaligned_be32(mpext->data_len << 16 |
 						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
@@ -1392,11 +1403,12 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
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
index f4ce28bb0fdc..fb40dd676a26 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -723,7 +723,7 @@ void mptcp_token_destroy(struct mptcp_sock *msk);
 void mptcp_crypto_key_sha(u64 key, u32 *token, u64 *idsn);
 
 void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg, int len, void *hmac);
-u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum);
+__sum16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum);
 
 void __init mptcp_pm_init(void);
 void mptcp_pm_data_init(struct mptcp_sock *msk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8c37087f0d84..e90fe7eec43a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -888,7 +888,7 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	u32 offset, seq, delta;
-	u16 csum;
+	__sum16 csum;
 	int len;
 
 	if (!csum_reqd)
-- 
2.36.1

