Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421162F25
	for <mptcp@lists.linux.dev>; Sat,  5 Feb 2022 01:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644022968; x=1675558968;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xkyVW7E/+O7tWkj/9uNn3xGmnPUBci6DZeRuJO3bhE0=;
  b=gbHhW/Lv3C60J+MGR1i0BvFH/2bPgtJF3AhjLTWuTox+R4i0n3WcznDR
   GCSdRTg9Mo24BFj1SY3d+Yv/QM2wZ9yWDpHT8dxlu8QnboQdPUadPLXXg
   6erwEZ9woK9CXx87xwzOKKr32gxCyr/e6v/YyzkFeadrvOL30Obm91sZb
   EbG3G+VDRNx6hk6PnhZ6d07HJOIPCjUa744IkYbgBAKPy2kIvOaXE750u
   dbnACOLfhLNRdm1UF81tAXs/qhctWO4NXGrg20LsV9dmD5G4ZHOMUiLH9
   OGDwISMBcuaCiscXYq/mQxI8U8Jtub3dHRn5OoExoaoOSQPSc/n9knhkE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="272977435"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="272977435"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 17:02:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="535690177"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.231.200])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 17:02:36 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: stable@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	mptcp@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] mptcp: fix msk traversal in mptcp_nl_cmd_set_flags()
Date: Fri,  4 Feb 2022 17:02:31 -0800
Message-Id: <20220205010231.189151-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 8e9eacad7ec7a9cbf262649ebf1fa6e6f6cc7d82 upstream.

The upstream commit had to handle a lookup_by_id variable that is only
present in 5.17. This version of the patch removes that variable, so the
__lookup_addr() function only handles the lookup as it is implemented in
5.15 and 5.16. It also removes one 'const' keyword to prevent a warning
due to differing const-ness in the 5.17 version of addresses_equal().

The MPTCP endpoint list is under RCU protection, guarded by the
pernet spinlock. mptcp_nl_cmd_set_flags() traverses the list
without acquiring the spin-lock nor under the RCU critical section.

This change addresses the issue performing the lookup and the endpoint
update under the pernet spinlock.

Cc: <stable@vger.kernel.org> # 5.15.x
Cc: <stable@vger.kernel.org> # 5.16.x
Fixes: 0f9f696a502e ("mptcp: add set_flags command in PM netlink")
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 65764c8171b3..5d305fafd0e9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -459,6 +459,18 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
 	return i;
 }
 
+static struct mptcp_pm_addr_entry *
+__lookup_addr(struct pm_nl_pernet *pernet, struct mptcp_addr_info *info)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &pernet->local_addr_list, list) {
+		if (addresses_equal(&entry->addr, info, true))
+			return entry;
+	}
+	return NULL;
+}
+
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
@@ -1725,17 +1737,21 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
 
-	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if (addresses_equal(&entry->addr, &addr.addr, true)) {
-			mptcp_nl_addr_backup(net, &entry->addr, bkup);
-
-			if (bkup)
-				entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
-			else
-				entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
-		}
+	spin_lock_bh(&pernet->lock);
+	entry = __lookup_addr(pernet, &addr.addr);
+	if (!entry) {
+		spin_unlock_bh(&pernet->lock);
+		return -EINVAL;
 	}
 
+	if (bkup)
+		entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
+	else
+		entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
+	addr = *entry;
+	spin_unlock_bh(&pernet->lock);
+
+	mptcp_nl_addr_backup(net, &addr.addr, bkup);
 	return 0;
 }
 
-- 
2.35.1

