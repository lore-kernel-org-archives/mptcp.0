Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070552CA1
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 22:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642025773; x=1673561773;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Z5n23T2UVI+k7SO8+HolS8Wh5rW2dyUaMxqQnnY3ixw=;
  b=I3Nk/H5akzaKUX8E5ZuM82qBnosTEFEoE9s953JJCo4wuyZFdkJwleiY
   RhsEXBuP/w7G4c1mBLLwJeF3gHGi8eqhP+UTf8o1Yf2MTNPpqq9uzyE47
   9szrGATG56Z+3Bn5TE+EyKpxbmHYpL9mr5Usn7zTYfuD4qhuvNsNG6xmj
   gbDxG21tRgMfKoAXJ4fbO8IQTCqcNJGWrEJFWGqw5lOnQ0UAhM38GX7sP
   jA3oRlSlKkeBm3AGdbh0D+WbaXQf05D92FpQPT+DN2/3nPDUVkATN/vIr
   b1uPiwm8N/wWJMkhXwy0fcrb16h60K1APWFGdkme3JJ/GUnoM3S3zEh9E
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="307213937"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="307213937"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:16:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="490907355"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:16:07 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 09/21] mptcp: allow ADD_ADDR reissuance by userspace PMs
Date: Wed, 12 Jan 2022 17:15:11 -0500
Message-Id: <20220112221523.1829397-10-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220112221523.1829397-1-kishen.maloor@intel.com>
References: <20220112221523.1829397-1-kishen.maloor@intel.com>
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
index e2211f3b8c8c..a8c9a89ee1c5 100644
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

