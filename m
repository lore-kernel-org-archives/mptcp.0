Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810736D13
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 23:45:09 +0000 (UTC)
IronPort-SDR: KLBEX5CRWC4jMPYLrpv/8MLbvAl6BrymGrMGcpk/xQN+n+6+cr1Clpukf/lkG1ZFOw6wQ0PdID
 w22HcXkS5bQg==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="258923270"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="258923270"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:45:07 -0700
IronPort-SDR: g82DuLSt65Mcvx6G1dH2lYc2wkySD9Hbw2hn94CyITyRuNRJSeFiuGV6vRQnNNUineBUDncdJc
 Sc5ceQnTq7HA==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="461793353"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.243.150])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:45:07 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	mptcp@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 01/13] mptcp: revert "mptcp: forbit mcast-related sockopt on MPTCP sockets"
Date: Thu, 15 Apr 2021 16:44:50 -0700
Message-Id: <20210415234502.224225-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415234502.224225-1-mathew.j.martineau@linux.intel.com>
References: <20210415234502.224225-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts <matthieu.baerts@tessares.net>

This change reverts commit 86581852d771 ("mptcp: forbit mcast-related sockopt on MPTCP sockets").

As announced in the cover letter of the mentioned patch above, the
following commits introduce a larger MPTCP sockopt implementation
refactor.

This time, we switch from a blocklist to an allowlist. This is safer for
the future where new sockoptions could be added while not being fully
supported with MPTCP sockets and thus causing unstabilities.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 45 --------------------------------------------
 1 file changed, 45 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8009b3f8e4c1..2fcdc611c122 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2869,48 +2869,6 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 	return ret;
 }
 
-static bool mptcp_unsupported(int level, int optname)
-{
-	if (level == SOL_IP) {
-		switch (optname) {
-		case IP_ADD_MEMBERSHIP:
-		case IP_ADD_SOURCE_MEMBERSHIP:
-		case IP_DROP_MEMBERSHIP:
-		case IP_DROP_SOURCE_MEMBERSHIP:
-		case IP_BLOCK_SOURCE:
-		case IP_UNBLOCK_SOURCE:
-		case MCAST_JOIN_GROUP:
-		case MCAST_LEAVE_GROUP:
-		case MCAST_JOIN_SOURCE_GROUP:
-		case MCAST_LEAVE_SOURCE_GROUP:
-		case MCAST_BLOCK_SOURCE:
-		case MCAST_UNBLOCK_SOURCE:
-		case MCAST_MSFILTER:
-			return true;
-		}
-		return false;
-	}
-	if (level == SOL_IPV6) {
-		switch (optname) {
-		case IPV6_ADDRFORM:
-		case IPV6_ADD_MEMBERSHIP:
-		case IPV6_DROP_MEMBERSHIP:
-		case IPV6_JOIN_ANYCAST:
-		case IPV6_LEAVE_ANYCAST:
-		case MCAST_JOIN_GROUP:
-		case MCAST_LEAVE_GROUP:
-		case MCAST_JOIN_SOURCE_GROUP:
-		case MCAST_LEAVE_SOURCE_GROUP:
-		case MCAST_BLOCK_SOURCE:
-		case MCAST_UNBLOCK_SOURCE:
-		case MCAST_MSFILTER:
-			return true;
-		}
-		return false;
-	}
-	return false;
-}
-
 static int mptcp_setsockopt(struct sock *sk, int level, int optname,
 			    sockptr_t optval, unsigned int optlen)
 {
@@ -2919,9 +2877,6 @@ static int mptcp_setsockopt(struct sock *sk, int level, int optname,
 
 	pr_debug("msk=%p", msk);
 
-	if (mptcp_unsupported(level, optname))
-		return -ENOPROTOOPT;
-
 	if (level == SOL_SOCKET)
 		return mptcp_setsockopt_sol_socket(msk, optname, optval, optlen);
 
-- 
2.31.1

