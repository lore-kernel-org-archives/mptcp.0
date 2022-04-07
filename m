Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D1A17F2
	for <mptcp@lists.linux.dev>; Thu,  7 Apr 2022 02:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649299368; x=1680835368;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=sKHGYS4wSoiHYtJWAVjOUe7mFJkoa0zCDSkyK1QyfBM=;
  b=LF4L6ZJjnKSNoKkwtKFJ/42w/T4wyzrVVPKdU5MofElJtvowKkvro57u
   PI9RCNrwVJ2fyecbDSDmv5L820RKWhfLNoEIlWa6+a60x+AyF1LRpwkER
   lskVeE33IPXs2fXku6gfybETZFY+R5jwx4IJ7pgfdp/5G/u/jHubQ3jWi
   49/4wfZTLQ05O/UF7LYbqnNlAQTqnr9n7ugxxK+xqV5QgkSRQiCMdXy8E
   fH6PfdNm05Truk4EKkIbXy5YOktvMACJnMJfdzIeOTYnM7i2AmUwAz3Pa
   Ih69cSDvRMumzNSBsgd95c4D8B/WXh2FQbHK5CECyTsqS71oNE2Po/rLA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="286189740"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="286189740"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 19:42:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="658882184"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 19:42:46 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v7 01/14] mptcp: allow ADD_ADDR reissuance by userspace PMs
Date: Wed,  6 Apr 2022 22:42:28 -0400
Message-Id: <20220407024241.1757334-2-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220407024241.1757334-1-kishen.maloor@intel.com>
References: <20220407024241.1757334-1-kishen.maloor@intel.com>
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

