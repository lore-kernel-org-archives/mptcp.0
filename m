Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCD772
	for <mptcp@lists.linux.dev>; Tue, 24 Aug 2021 01:05:51 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="197456287"
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="197456287"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 18:05:50 -0700
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="515224408"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.11.16])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 18:05:50 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Yonglong Li <liyonglong@chinatelecom.cn>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Geliang Tang <geliangtang@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 4/6] mptcp: build ADD_ADDR/echo-ADD_ADDR option according pm.add_signal
Date: Mon, 23 Aug 2021 18:05:42 -0700
Message-Id: <20210824010544.68600-5-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210824010544.68600-1-mathew.j.martineau@linux.intel.com>
References: <20210824010544.68600-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yonglong Li <liyonglong@chinatelecom.cn>

According to the MPTCP_ADD_ADDR_SIGNAL or MPTCP_ADD_ADDR_ECHO flag, build
the ADD_ADDR/ADD_ADDR_ECHO option.

In mptcp_pm_add_addr_signal(), use opts->addr to save the announced
ADD_ADDR or ADD_ADDR_ECHO address.

Co-developed-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Co-developed-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm.c       | 14 +++++++++-----
 net/mptcp/protocol.h |  2 +-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index bc03c08eeee5..f1b520df228a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -257,11 +257,12 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
-			      struct mptcp_addr_info *saddr, bool *echo,
+			      struct mptcp_addr_info *addr, bool *echo,
 			      bool *port, bool *drop_other_suboptions)
 {
 	int ret = false;
 	u8 add_addr;
+	u8 family;
 
 	spin_lock_bh(&msk->pm.lock);
 
@@ -281,14 +282,17 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 	*echo = mptcp_pm_should_add_signal_echo(msk);
 	*port = mptcp_pm_should_add_signal_port(msk);
 
-	if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo, *port))
+	family = *echo ? msk->pm.remote.family : msk->pm.local.family;
+	if (remaining < mptcp_add_addr_len(family, *echo, *port))
 		goto out_unlock;
 
-	*saddr = msk->pm.local;
-	if (*echo)
+	if (*echo) {
+		*addr = msk->pm.remote;
 		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO);
-	else
+	} else {
+		*addr = msk->pm.local;
 		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGNAL);
+	}
 	WRITE_ONCE(msk->pm.addr_signal, add_addr);
 	ret = true;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3c388c1a9de4..27afacb6fde2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -802,7 +802,7 @@ static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
 
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
-			      struct mptcp_addr_info *saddr, bool *echo,
+			      struct mptcp_addr_info *addr, bool *echo,
 			      bool *port, bool *drop_other_suboptions);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
-- 
2.33.0

