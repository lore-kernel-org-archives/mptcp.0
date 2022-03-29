Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F6B20E7
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 02:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648520083; x=1680056083;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=pfIbsRZdaSpVaXdXppcuHSBgVel+aYE60+iBdj9Cbog=;
  b=TN8G01/zKn3uyJl0xK0slTNgITSDchdcm64VZsGerjOkoQDe/yiZExVH
   7BY1X0jYtVokKfvPvNm/1hNFlW/XA/InZRpZ7SWB4R++FkoXzdNuSB8wf
   sX6uoyi6GfUuz9UkUBHlWz8Fqld6mk+zpMF17/Ig2zC8bGwaDrYNlJEdM
   MIGLIl4T8q7QZNkla4QNd/C+Tf/51r22MhGL5DZXJkeDTFJ11RTseZYbe
   eX7CMVqxYfvsxtKQl3flYmjHl+cgO7M1lXFutKxYEOOFCEoUsWOtLX5mI
   8l9vKUSHir/LlNx8TBNwNdV5zF7wH4H2T2IpW2K5/9Vc+62ncKd1YkdcY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="284037574"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="284037574"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 19:14:42 -0700
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="564202876"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 19:14:41 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v6 01/14] mptcp: allow ADD_ADDR reissuance by userspace PMs
Date: Mon, 28 Mar 2022 22:14:24 -0400
Message-Id: <20220329021437.1196552-2-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220329021437.1196552-1-kishen.maloor@intel.com>
References: <20220329021437.1196552-1-kishen.maloor@intel.com>
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
index 7c92af2ad900..8d04c8d8a8df 100644
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

