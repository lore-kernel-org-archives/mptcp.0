Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEF43229
	for <mptcp@lists.linux.dev>; Thu, 14 Apr 2022 21:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649971166; x=1681507166;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=sKHGYS4wSoiHYtJWAVjOUe7mFJkoa0zCDSkyK1QyfBM=;
  b=DOfWWvc2rivoX2f4MSfebJuUSq7zMp56TqW0bf7rbXMfDDv82SAZZSYh
   HKKp3t26fnZTeMbx3W0yJhVHIp3Vmfq4l7ZpboLDGJGkdE57j+0zULpwk
   cHJHJLxXtGWislmCm2soxHRsm8ib891WASuMLRG4TVg1gzGp4XidnInz9
   SVCJeadxNQezf/ozPfXOK0Jw5FCq3rHSyHroBsAxp2f6xDO1nras131yS
   iXP+DmRfjOsoWoR4YIL3M2zyYKHt/0K9c7Me+sqwxbrQpAAYnSJBPao2j
   pVKp8WDBMgO+36iCG+8NNPDJHxsxpkHL9PxNqob7jAJk19PcPndxvtOKo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="349467250"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="349467250"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 14:19:25 -0700
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="573998116"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 14:19:24 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v10 01/14] mptcp: allow ADD_ADDR reissuance by userspace PMs
Date: Thu, 14 Apr 2022 17:19:07 -0400
Message-Id: <20220414211920.1987961-2-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220414211920.1987961-1-kishen.maloor@intel.com>
References: <20220414211920.1987961-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change allows userspace PM implementations to reissue ADD_ADDR
announcements (if necessary) based on their chosen policy.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 net/mptcp/pm_netlink.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a4430c576ce9..98b205c2c101 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -369,8 +369,16 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	if (mptcp_lookup_anno_list_by_saddr(msk, &entry->addr))
-		return false;
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, &entry->addr);
+
+	if (add_entry) {
+		if (mptcp_pm_is_kernel(msk))
+			return false;
+
+		sk_reset_timer(sk, &add_entry->add_timer,
+			       jiffies + mptcp_get_add_addr_timeout(net));
+		return true;
+	}
 
 	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);
 	if (!add_entry)
-- 
2.31.1

