Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA18633D8
	for <mptcp@lists.linux.dev>; Wed,  8 Jun 2022 19:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654715971; x=1686251971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ypaTwO0pQdtrccJnIA7clYfA5CtbDAy0cfvBFehY6Fg=;
  b=KM40fXGASuVtDUWM59kCGlMlTYP085EgWmS7r5Yr2p7VOoZoGp0qUJan
   yLb/RfO/97byHtvNFM6hFRGETYX69QiQYC1f034u4WPW2eAoL1+UvVbYm
   L/Nu2AhXZt7iMW6SMOz9XStb9OKO0OSF0liUuQIsvdREwnPgXMAE+I2WQ
   0/PUfR8hGYURngrLzXv6PJWhOSMhW8nwSWQ48gg8DV/UdP1P41at6b1UV
   y/PBOE+y/zU50Il8jY7xsIZHzmX93HHcvccE1sGpNJdaQaSoroi5+dxDX
   cuDvHzxvr77hnwTSdhysrWA7Yns40UnwfRIp1hB9gHAQ9LBmeOL2RVcXi
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="278178196"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="278178196"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 12:19:29 -0700
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="580206810"
Received: from pperi-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.252.138.161])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 12:19:29 -0700
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
Subject: [PATCH net-next 2/2] mptcp: move MPTCPOPT_HMAC_LEN to net/mptcp.h
Date: Wed,  8 Jun 2022 12:19:19 -0700
Message-Id: <20220608191919.327705-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220608191919.327705-1-mathew.j.martineau@linux.intel.com>
References: <20220608191919.327705-1-mathew.j.martineau@linux.intel.com>
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
index 200f89f6d62f..8f03775a2f22 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -83,7 +83,6 @@
 
 /* MPTCP MP_JOIN flags */
 #define MPTCPOPT_BACKUP		BIT(0)
-#define MPTCPOPT_HMAC_LEN	20
 #define MPTCPOPT_THMAC_LEN	8
 
 /* MPTCP MP_CAPABLE flags */
-- 
2.36.1

