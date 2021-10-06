Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5259A2C93
	for <mptcp@lists.linux.dev>; Thu,  7 Oct 2021 00:00:08 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="226439239"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="226439239"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 16:59:59 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="560351289"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.0.106])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 16:59:59 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	kishen.maloor@intel.com
Subject: [RFC PATCH 5/6] DO-NOT-MERGE: debug: mptcp: Warn on use of in-kernel PM functions
Date: Wed,  6 Oct 2021 16:59:52 -0700
Message-Id: <20211006235953.212243-6-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006235953.212243-1-mathew.j.martineau@linux.intel.com>
References: <20211006235953.212243-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Double-check that all relevant call sites are filtered when sockets are
managed by userspace.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 434049836707..affa84099bdd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -468,6 +468,8 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
 
+	WARN_ON_ONCE(READ_ONCE(msk->pm.userspace));
+
 	pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
 
 	add_addr_signal_max = mptcp_pm_get_add_addr_signal_max(msk);
@@ -700,6 +702,8 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 
 	msk_owned_by_me(msk);
 
+	WARN_ON_ONCE(READ_ONCE(msk->pm.userspace));
+
 	if (!rm_list->nr)
 		return;
 
@@ -1244,6 +1248,8 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	struct mptcp_rm_list list = { .nr = 0 };
 	bool ret;
 
+	WARN_ON_ONCE(READ_ONCE(msk->pm.userspace));
+
 	list.ids[list.nr++] = addr->id;
 
 	ret = remove_anno_list_by_saddr(msk, addr);
-- 
2.33.0

