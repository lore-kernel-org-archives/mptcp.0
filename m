Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8AE20E6
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 02:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648520050; x=1680056050;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=RJJAoZH769xw3Gm9uQPRUtnnIFyaZSVqSI6EX+533dU=;
  b=UB1AkJzxr7p/JmwrK8swkJ73Lv1vEUJpQ181gB1t6FNnAWAYvIb7eQ2M
   pHzW9T2RyURMmLQn6790Vmdeh4RcIKxrjBly8h8R0GE84zrnqDaF28wUv
   MoDxyoVl02JLxpxUQmXdHsC8Hsn8SGfg/5x4Txmka7xT8Hjamuva7w8ju
   ebp3jDM+9/M65+Zf5Lj+QC9EFxw+JfnF/OJchVvEW8C6axHcxjTYzRubz
   So/wRtjwoIjv7+ddybvDbNk3pjmaJvPww2MPLEDzrrh17wJwelDP/oWGb
   ndNXzfIJnum6kK+pbjMpX/e8/bv7O9YXG8jckEibFa3lp9ipfxTNCAahJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="345578742"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="345578742"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 19:14:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="564202539"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 19:14:07 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v9 1/6] Squash-to: mptcp: Bypass kernel PM when userspace PM is enabled
Date: Mon, 28 Mar 2022 22:13:56 -0400
Message-Id: <20220329021401.1196466-2-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220329021401.1196466-1-kishen.maloor@intel.com>
References: <20220329021401.1196466-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 net/mptcp/protocol.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fd82fd113113..54d2b3b2d100 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -806,9 +806,9 @@ static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
 	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL);
 }
 
-static inline bool mptcp_pm_is_userspace(struct mptcp_sock *msk)
+static inline bool mptcp_pm_is_userspace(const struct mptcp_sock *msk)
 {
-	return READ_ONCE(msk->pm.pm_type) != MPTCP_PM_TYPE_KERNEL;
+	return READ_ONCE(msk->pm.pm_type) == MPTCP_PM_TYPE_USERSPACE;
 }
 
 static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
-- 
2.31.1

