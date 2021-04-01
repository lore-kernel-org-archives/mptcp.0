Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACA26D0D
	for <mptcp@lists.linux.dev>; Thu,  1 Apr 2021 23:19:54 +0000 (UTC)
IronPort-SDR: zrpzrky93CnhGYtmN3Ty7hOS/WvwkNkw48mBCixTIijVzy46a2uUZzyneFSue4ipTZFXBUEjDB
 /nS8Z/MGjvbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="277537235"
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="277537235"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 16:19:53 -0700
IronPort-SDR: DXN6dwrGaOqhNBgjaIECa0VeQkB1sHgL1L/fA+wkk68G+Dgpbr8gkRinkjkYM9D3joK4jwzxOW
 YlH0KHiY1Hdg==
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="446269194"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.252.128.105])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 16:19:53 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 3/7] mptcp: remove unneeded check on first subflow
Date: Thu,  1 Apr 2021 16:19:43 -0700
Message-Id: <20210401231947.162836-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210401231947.162836-1-mathew.j.martineau@linux.intel.com>
References: <20210401231947.162836-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

Currently we explicitly check for the first subflow being
NULL in a couple of places, even if we don't need any
special actions in such scenario.

Just drop the unneeded checks, to avoid confusion.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/options.c  | 2 +-
 net/mptcp/protocol.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 69cafaacc31b..68361d28dc67 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -952,7 +952,7 @@ bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool us
 	 * should match. If they mismatch, the peer is misbehaving and
 	 * we will prefer the most recent information.
 	 */
-	if (READ_ONCE(msk->rcv_data_fin) || !READ_ONCE(msk->first))
+	if (READ_ONCE(msk->rcv_data_fin))
 		return false;
 
 	WRITE_ONCE(msk->rcv_data_fin_seq,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0c916d48cad8..531ee24aa827 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -493,7 +493,7 @@ static bool mptcp_check_data_fin(struct sock *sk)
 	u64 rcv_data_fin_seq;
 	bool ret = false;
 
-	if (__mptcp_check_fallback(msk) || !msk->first)
+	if (__mptcp_check_fallback(msk))
 		return ret;
 
 	/* Need to ack a DATA_FIN received from a peer while this side
-- 
2.31.1

