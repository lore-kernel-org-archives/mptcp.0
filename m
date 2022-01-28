Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3684A2CAE
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 00:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643330324; x=1674866324;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=mnR7vfPK4ZYgF4Wcirh0yNyrgesX9MuVyrdIUYpbiLI=;
  b=IcRIh2GMWUruITrtOF6PMXyd6DJPZEAGEu/JM4K6rcrERUwNRNU/+YHx
   YyJOW9Oqi5DqWnFpeWJg1V4dAAfI6mowf5LgBn/YoenAaCU0nlxa9Ykaw
   so5THHOET2YxY9+RUi5T1Fs1KkVeH43WFRXQF/Y7NwWRvEKQiD7o9YEW0
   I+r1NXnCh1jLvt/sdwxl3mPHkrYefY/6qBXE/nztv5iOp/4TvuDVz/kGi
   cWdzxA5jRfiNJM5RtlBoBNxccTjVezzR8SlxA0D8sW7maZgQWWIJaqGMQ
   WC3s94LOLj4b6vTgiroW25XQpbjwt3c20YgVvr3qEOp2j7UBM6bH3tLBL
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="333358331"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="333358331"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="480527108"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:41 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v3 02/14] mptcp: allow ADD_ADDR reissuance by userspace PMs
Date: Thu, 27 Jan 2022 19:38:24 -0500
Message-Id: <20220128003836.2732694-3-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220128003836.2732694-1-kishen.maloor@intel.com>
References: <20220128003836.2732694-1-kishen.maloor@intel.com>
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
index 882988e43d76..726dc0a56fca 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -479,8 +479,16 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	if (mptcp_lookup_anno_list_by_saddr(msk, &entry->addr))
-		return false;
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, &entry->addr);
+
+	if (add_entry) {
+		if (READ_ONCE(msk->pm.pm_type) == MPTCP_PM_TYPE_KERNEL)
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

