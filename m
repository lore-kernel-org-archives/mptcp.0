Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AC53B38
	for <mptcp@lists.linux.dev>; Wed, 16 Mar 2022 19:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647457701; x=1678993701;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=pKmhSmSgsGDyEXccKYgjKKGFzm/tsUwQ4w+2dOStpKg=;
  b=ZCcSHDbk8GuRVOpKD4/NPJIfFD5rCOkmWdNYdJWNlDXVtnuxsOU7RTGz
   QpVfWgVz9KDQYRQ0ZmxlNnfZYBgfHN1TK0FAj5+6A3luHMbO05TrrQrR9
   OGXrmCoV8iUhoqop44ycQtHvF0NFSHy87bCnXlecdqRSGQwmdH8MSWE5t
   qHiO0DxwpyN/f6htyYO4KlpvlNfYH6zg3ciHNzRf2HiKiDAxBVx9u6NvR
   NjEMhypB9/N7fiJrq/yA6P43cd5HeXPQfwh8qC4Cm28dvDW6oFog74/S9
   x3xhA7sPTNq/ggjTwHwBWwyxHZSdgywJog66Ezx4P+fpBHb2+jrlU6Ge7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256880338"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="256880338"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 12:08:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="557595356"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 12:08:18 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 01/14] mptcp: allow ADD_ADDR reissuance by userspace PMs
Date: Wed, 16 Mar 2022 15:08:00 -0400
Message-Id: <20220316190813.634423-2-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220316190813.634423-1-kishen.maloor@intel.com>
References: <20220316190813.634423-1-kishen.maloor@intel.com>
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
index 6fb84f9c377f..98e59576415b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -362,8 +362,16 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
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

