Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EDA3218
	for <mptcp@lists.linux.dev>; Mon,  2 May 2022 20:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651524769; x=1683060769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9ZNXtLvhcp5bF7tlcfkg+UESgvpjmFh340RfFxsO+X8=;
  b=IajvVgYPZlNlXb28hl/VqmEpiVuv2bqEfyFNaaLS3nirUczTo7mCKggQ
   Xy7uwTnZ2OfTehuBQUr9GGjqmN9o33NqpWrDGwcF0Td2/jbETHEcoOQME
   HqBwLN7nxFZHY6iWDjiVfHSioNAMoySZfeoX1BOFz/mKBrkyrq0AKfczS
   HEHvlKn6vY1wsfJkWvxgXATo/C+kxXxwrbp7kqV6U8EhBEDigurbLKTOu
   X3mdoYWoW0Lv3efY2pBv53fguuZcodihBdtItFkx0+xOwubr6KlxO4n2j
   KVP2ls4yKccNW27Zv2MXzSNtUNFRIHVyMrSS+yUBON3QPGzRUEJwqWj4h
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="247875194"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="247875194"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 13:52:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="733619592"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.141.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 13:52:44 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Kishen Maloor <kishen.maloor@intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 7/7] mptcp: allow ADD_ADDR reissuance by userspace PMs
Date: Mon,  2 May 2022 13:52:37 -0700
Message-Id: <20220502205237.129297-8-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220502205237.129297-1-mathew.j.martineau@linux.intel.com>
References: <20220502205237.129297-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kishen Maloor <kishen.maloor@intel.com>

This change allows userspace PM implementations to reissue ADD_ADDR
announcements (if necessary) based on their chosen policy.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
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
2.36.0

