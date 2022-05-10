Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7658115A1
	for <mptcp@lists.linux.dev>; Tue, 10 May 2022 00:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652141006; x=1683677006;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tOtliI8OrQthezRVmlHwBBFLoFvVz2GWTJi7qZTYoeE=;
  b=mmLwxErnEsqGafOv8uJMK2oK0E8OBz2SoJLWeCxqbqJ6fnB6paZjH2SC
   pqyyHBzOljlRSYkjeMNtIIcNYa3wJmIUBq5U5VT2Swl+r+TZqRDkNJUhS
   f2v7ng3HQkoY1jrbD0YhocaKcY0x+MNzs6v5WV6oqg2s/tUwwoSr8exNT
   9k7OnSM82M4MPsIMcnBnZeeLm6aws3zg2SiArToGNePwJxOxFwz6RDli3
   cW//IRx6NkEapu0+2/+CNjAUYasUY1VL4q2lSjbjhLQFp8MUpj32wic98
   GmGs7PZ7pm7VVwB3IkGt2Kaf82ZMiKMqdetklJEQm9/gJoltpvmSST4if
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="355632487"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="355632487"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 17:03:25 -0700
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="738424869"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.61.132])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 17:03:25 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-net] mptcp: Do TCP fallback on early DSS checksum failure
Date: Mon,  9 May 2022 17:03:20 -0700
Message-Id: <20220510000320.82652-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC 8684 section 3.7 describes several opportunities for a MPTCP
connection to "fall back" to regular TCP early in the connection
process, before it has been confirmed that MPTCP options can be
successfully propagated on all SYN, SYN/ACK, and data packets. If a peer
acknowledges the first received data packet with a regular TCP header
(no MPTCP options), fallback is allowed.

If the recipient of that first data packet finds a MPTCP DSS checksum
error, this provides an opportunity to fail gracefully with a TCP
fallback rather than resetting the connection (as might happen if a
checksum failure were detected later).

This commit modifies the checksum failure code to attempt fallback on
the initial subflow of a MPTCP connection, only if it's a failure in the
first data mapping. In cases where the peer initiates the connection,
requests checksums, is the first to send data, and the peer is sending
incorrect checksums (see
https://github.com/multipath-tcp/mptcp_net-next/issues/275), this allows
the connection to proceed as TCP rather than reset.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---

I tested this on the export-net branch along with Paolo's proposed
checksum fix ("mptcp: fix checksum byte order"). Testing between the
patched export-net kernel and 5.17.5-200.fc35.x86_64 (Fedora) showed the
fallback succeeding if checksums are enabled on one side, export-net was
the listener, and 5.17.5 initiated the connection and sent the first
data. Without this patch, if one side has the fixed checksum byte order
then all connections would reset after a checksum failure.

---
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f4ce28bb0fdc..6c7e78ec88e8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -443,7 +443,8 @@ struct mptcp_subflow_context {
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1,	    /* ctx can be free at ulp release time */
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
-		local_id_valid : 1; /* local_id is correctly initialized */
+		local_id_valid : 1, /* local_id is correctly initialized */
+		valid_csum_seen : 1;        /* at least one csum validated */
 	enum mptcp_data_avail data_avail;
 	u32	remote_nonce;
 	u64	thmac;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8c37087f0d84..3a7b02a92239 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -955,11 +955,14 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
 				 subflow->map_data_csum);
 	if (unlikely(csum)) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
-		subflow->send_mp_fail = 1;
-		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPFAILTX);
+		if (subflow->mp_join || subflow->valid_csum_seen) {
+			subflow->send_mp_fail = 1;
+			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPFAILTX);
+		}
 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
 	}
 
+	subflow->valid_csum_seen = 1;
 	return MAPPING_OK;
 }
 
@@ -1145,6 +1148,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	enum mapping_status status;
+	bool fallback_impossible;
 	struct mptcp_sock *msk;
 	struct sk_buff *skb;
 
@@ -1218,7 +1222,12 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		return true;
 	}
 
-	if (subflow->mp_join || subflow->fully_established) {
+	if (READ_ONCE(msk->csum_enabled))
+		fallback_impossible = subflow->valid_csum_seen;
+	else
+		fallback_impossible = subflow->fully_established;
+
+	if (subflow->mp_join || fallback_impossible) {
 		/* fatal protocol error, close the socket.
 		 * subflow_error_report() will introduce the appropriate barriers
 		 */
-- 
2.36.1

