Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DAE6D0D
	for <mptcp@lists.linux.dev>; Thu, 27 May 2021 23:31:48 +0000 (UTC)
IronPort-SDR: hrP70nwFpeyg/W1j/yFDUObcf0DgA7WpWaNFKoppwt4VDniSnhcsHnE0VLA0xD3/I952rW13RO
 Fv1oR8RXJhHA==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="202623689"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="202623689"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 16:31:45 -0700
IronPort-SDR: 8zDKVubE6zpPBf1AA5nZQwLzQ0ATBhUAfJOkJWfVIgQtxKMpNhJz5PPPFDvkHEEHkg8su4WZCy
 YwkBmvqDulQg==
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="477700332"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.84.136])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 16:31:45 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 2/4] mptcp: always parse mptcp options for MPC reqsk
Date: Thu, 27 May 2021 16:31:38 -0700
Message-Id: <20210527233140.182728-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527233140.182728-1-mathew.j.martineau@linux.intel.com>
References: <20210527233140.182728-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

In subflow_syn_recv_sock() we currently skip options parsing
for OoO packet, given that such packets may not carry the relevant
MPC option.

If the peer generates an MPC+data TSO packet and some of the early
segments are lost or get reorder, we server will ignore the peer key,
causing transient, unexpected fallback to TCP.

The solution is always parsing the incoming MPTCP options, and
do the fallback only for in-order packets. This actually cleans
the existing code a bit.

Fixes: d22f4988ffec ("mptcp: process MP_CAPABLE data option")
Reported-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/subflow.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index bde6be77ea73..c6ee81149829 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -630,21 +630,20 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 	/* if the sk is MP_CAPABLE, we try to fetch the client key */
 	if (subflow_req->mp_capable) {
-		if (TCP_SKB_CB(skb)->seq != subflow_req->ssn_offset + 1) {
-			/* here we can receive and accept an in-window,
-			 * out-of-order pkt, which will not carry the MP_CAPABLE
-			 * opt even on mptcp enabled paths
-			 */
-			goto create_msk;
-		}
-
+		/* we can receive and accept an in-window, out-of-order pkt,
+		 * which may not carry the MP_CAPABLE opt even on mptcp enabled
+		 * paths: always try to extract the peer key, and fallback
+		 * for packets missing it.
+		 * Even OoO DSS packets coming legitly after dropped or
+		 * reordered MPC will cause fallback, but we don't have other
+		 * options.
+		 */
 		mptcp_get_options(skb, &mp_opt);
 		if (!mp_opt.mp_capable) {
 			fallback = true;
 			goto create_child;
 		}
 
-create_msk:
 		new_msk = mptcp_sk_clone(listener->conn, &mp_opt, req);
 		if (!new_msk)
 			fallback = true;
-- 
2.31.1

