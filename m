Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1843D6B
	for <mptcp@lists.linux.dev>; Wed, 16 Mar 2022 23:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647472604; x=1679008604;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=pKmhSmSgsGDyEXccKYgjKKGFzm/tsUwQ4w+2dOStpKg=;
  b=behTHmYEVeM8ooOJPxrN2liaBBmXfSBfWlghp7eiMzbb32jKsTeCd35n
   ONMFy0R3vwb45a24jgrFC2zwOp8USC1ZkUzZiLA/MPyUxtvMyTTgMkf7W
   1K0tJBFUZeReIJRIBd9Ej1uVTCcBH0s0euTuFry7p4M2QNsdMxdLgUt+C
   zlPJaIh2xAwZhZBYlPPvm9iqDGl17p0hNVPhCsBF8bGMHHwmxnsd8dskK
   DrM5ZdV8xumVEiR6BUyR/gpgUT+MRsqOgVvcjZpAg7nrGZiPbf/w87Oya
   tZSNax0d+ZhgQYgnrI5a6yZcsbZcB55YnmnzEnqVqf1at6NAQ+sHyin1C
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="317453505"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="317453505"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 16:16:42 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="613813294"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 16:16:42 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v5 01/14] mptcp: allow ADD_ADDR reissuance by userspace PMs
Date: Wed, 16 Mar 2022 19:16:23 -0400
Message-Id: <20220316231636.645625-2-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220316231636.645625-1-kishen.maloor@intel.com>
References: <20220316231636.645625-1-kishen.maloor@intel.com>
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

