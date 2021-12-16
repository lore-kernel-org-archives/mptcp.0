Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9059A2CBF
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 22:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639693457; x=1671229457;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=U42LR8NHdNAF6mxUIwJ8FQ3rN7WLYItwAMPPCPoAaGg=;
  b=eOZW+kObMnCOLTnCOaRRYkadwIvunujnshYzQepVRU/FaaMteKzUrDrN
   y2h2636xpq6d2KfPLSWcAlsljsczsgNNC/Oz09PqUCxsQRYWLRfn8YIIQ
   YsgtXvqE/KyBn/aEf87tbkEMF2y6C5+58vWwMOrjRRKdP4HyWhDjiB6Jl
   3SykdKKP1eqsqz2VA5IdE+x8JKeHtCwLmC7qPoIf++aER4nGN80q/BCFz
   e5AS8ij1TtlIlbo18hH9KmizBB5XupU4EUXocH8Te/vSrI0LYdlhcSrye
   6rae+tAmzti5C+hT7Z4lhgducEpudV7Ctez/UwTeIt+wIFb53OCdB8/2t
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="300393165"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="300393165"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 14:24:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="519461250"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 14:24:10 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 09/21] mptcp: allow ADD_ADDR reissuance by userspace PMs
Date: Thu, 16 Dec 2021 17:23:02 -0500
Message-Id: <20211216222314.1244708-10-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216222314.1244708-1-kishen.maloor@intel.com>
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
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
index d57e2f825728..1adaf5d14f87 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -452,8 +452,16 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
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

