Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087AB3FE0
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 23:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652313103; x=1683849103;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T6ohq70PvrfHIJo9AdvzzGDp3GeVOaFclkR+cZp5Puk=;
  b=AZxVyn9K1zp97PbuogPzcgvqutlUNn+DBVg2d4SeWMqkz0bt305u25Ou
   wakgtiLLvYm7zFp7KCYutynKv8uthAT82VlfZSYLo0OsAHKgwaCao+KTz
   +rEirPCqRo813Xf0+pKxITN+1IXs14JOq5v6BGCZxgTWXmT9hXV1h3EqV
   Fd/dGuGCpg8IX40Wp+/3u/O0CRZpHpy5LEBs1OJS0MfOkHQviZyjG0poj
   DFjPxL+U/1azDPwaOGY8lCGL8EMNtVjd4XEbmYS5H6jt7zW3nJ5s6B9Vd
   /xOpLLiIrclyWGnTA4GlfgYpxib/e7Ppzl3OlvL43AI1KB3NBrYjj7sJ1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="267427995"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="267427995"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 16:51:42 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="895560682"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.225.213])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 16:51:42 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-net v2] mptcp: Do TCP fallback on early DSS checksum failure
Date: Wed, 11 May 2022 16:51:37 -0700
Message-Id: <20220511235137.431538-1-mathew.j.martineau@linux.intel.com>
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

v2: add a helper function for checking whether a subflow is
fallback-capable.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Fixes: dd8bcd1768ff ("mptcp: validate the data checksum")
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  | 21 ++++++++++++++++++---
 2 files changed, 20 insertions(+), 4 deletions(-)

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
index 8c37087f0d84..dac38b6a8c53 100644
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
 
@@ -1141,6 +1144,18 @@ static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ss
 	}
 }
 
+static bool subflow_can_fallback(struct mptcp_subflow_context *subflow)
+{
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+
+	if (subflow->mp_join)
+		return false;
+	else if (READ_ONCE(msk->csum_enabled))
+		return !subflow->valid_csum_seen;
+	else
+		return !subflow->fully_established;
+}
+
 static bool subflow_check_data_avail(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
@@ -1218,7 +1233,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		return true;
 	}
 
-	if (subflow->mp_join || subflow->fully_established) {
+	if (!subflow_can_fallback(subflow)) {
 		/* fatal protocol error, close the socket.
 		 * subflow_error_report() will introduce the appropriate barriers
 		 */
-- 
2.36.1

