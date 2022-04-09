Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F93622
	for <mptcp@lists.linux.dev>; Sat,  9 Apr 2022 01:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649468316; x=1681004316;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=sKHGYS4wSoiHYtJWAVjOUe7mFJkoa0zCDSkyK1QyfBM=;
  b=khK+tYpXbb7sGbbV4szmR4OcUCycroK3IE6RLDkVVMjAUrr0YeZ3umpR
   /XwRfmO+DIgxQw+G9uqEe9dU6zL4dsgcvhfU3HxWmwjyeGe67u32pjPxh
   9h/hdwucricPvJ0D7TLUqanHFhRPi6UOpHxkaAQ2+jlfakllxi+MB36bV
   hHXgSu6g0qc8W2Xwn3C/8JAutcIOWuF3DDHHY9BobEkY2PrGiJl9QpW2w
   52RvO9dnt4Qf0lkW+9eqjunlORxRC0jICq29Q7BdR3/FsO239A1XZlGU2
   LayWXSQQ2yS2T4yyQqTA1BT/cI1Wo4xOj1CBnshwkRZlerFUh6+eGmfCx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="261921143"
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="261921143"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 18:38:29 -0700
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="698436067"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 18:38:29 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v9 01/14] mptcp: allow ADD_ADDR reissuance by userspace PMs
Date: Fri,  8 Apr 2022 21:38:12 -0400
Message-Id: <20220409013825.1877395-2-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220409013825.1877395-1-kishen.maloor@intel.com>
References: <20220409013825.1877395-1-kishen.maloor@intel.com>
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

