Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E45E3229
	for <mptcp@lists.linux.dev>; Fri,  8 Jul 2022 17:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657300460; x=1688836460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wvwoov0ZtEtx5i1pjqAsOc7JoLHCC2rk2TZrjCa1l7A=;
  b=gp2Nvm3C3nfRRGmvFlmsTVqMT6RUf3fyQ4nHTjqEXq3M8vAE7CgwZKLn
   GxRJ95rx5ksBNddYlWOtPQfUzuB6V5nm40TpyqEJH2L4zZsMbC4g90rDL
   VGnaKKy9fOhtLes/Vj8gA8hN28N3m6D/T3pGd9O+HCFPZUttFC15jVPby
   PJY0Bc8Rrdj4lLKTzZ1/tXuwHXlPcQ6eMVhNJVnOi5FrSTwllCEYM1iZv
   Jl38rVXCQFFedidLhE4eSwA04zp+YMsWoJjtne3+Umff8PkfzecaoOuhW
   1S4WbfHsFmlCn0e2WzhCnxfNqabFuzUI7PGK2lIAcr3VyDFZSizOfXz1p
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="285069092"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="285069092"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 10:14:18 -0700
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="651641497"
Received: from aroras-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.1.203])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 10:14:17 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 1/6] mptcp: move MPTCPOPT_HMAC_LEN to net/mptcp.h
Date: Fri,  8 Jul 2022 10:14:08 -0700
Message-Id: <20220708171413.327112-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220708171413.327112-1-mathew.j.martineau@linux.intel.com>
References: <20220708171413.327112-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

Move macro MPTCPOPT_HMAC_LEN definition from net/mptcp/protocol.h to
include/net/mptcp.h.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 include/net/mptcp.h  | 3 ++-
 net/mptcp/protocol.h | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4d761ad530c9..ac9cf7271d46 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -39,6 +39,7 @@ struct mptcp_ext {
 			infinite_map:1;
 };
 
+#define MPTCPOPT_HMAC_LEN	20
 #define MPTCP_RM_IDS_MAX	8
 
 struct mptcp_rm_list {
@@ -89,7 +90,7 @@ struct mptcp_out_options {
 			u32 nonce;
 			u32 token;
 			u64 thmac;
-			u8 hmac[20];
+			u8 hmac[MPTCPOPT_HMAC_LEN];
 		};
 	};
 #endif
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 480c5320b86e..07871e10e510 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -83,7 +83,6 @@
 
 /* MPTCP MP_JOIN flags */
 #define MPTCPOPT_BACKUP		BIT(0)
-#define MPTCPOPT_HMAC_LEN	20
 #define MPTCPOPT_THMAC_LEN	8
 
 /* MPTCP MP_CAPABLE flags */
-- 
2.37.0

