Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759EE7B
	for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 22:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656542157; x=1688078157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qmRi+cGXcerluFw1EN+/UhOf5UoZko7/g8T3OUWG1vU=;
  b=lbvw0fsckcoIw/pRMmPvjQvRrr9/Jk5ev3/32k8zMMybOZ4dTXAsUct3
   5KQ2Xj4SgXImSIscDKU65/LE7y9o5G41szNRwnQqzQmiNNPbxCwss6jYA
   cWZUh3bRiFZ5O/g5yyEt5qGsMNXdCQCwlTjvLRNcP4BMg0/CZeadeAwaL
   l46bZ0XvFjiriufIY6ErVzCN9ygaZA0UQUz//hsDjKVayOJxvWvSc+rxx
   bZT6Nj7fOYGy8TGCSIaeTBvlchtaBWM54X49yPAz/s//RwZGoDC/7w/l3
   RX+dchh0YBfvTZRf93ZH4TgbPOX09CpdgGId+GEYLbqkqPBnMFkthvHiu
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="282214125"
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="282214125"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 15:35:54 -0700
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="718005996"
Received: from divyamar-mobl2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.13.211])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 15:35:54 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev,
	pabeni@redhat.com
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-net v2 1/2] mptcp: Avoid acquiring PM lock for subflow priority changes
Date: Wed, 29 Jun 2022 15:35:49 -0700
Message-Id: <20220629223550.655928-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220629223550.655928-1-mathew.j.martineau@linux.intel.com>
References: <20220629223550.655928-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The in-kernel path manager code for changing subflow flags acquired both
the msk socket lock and the PM lock when possibly changing the "backup"
and "fullmesh" flags. mptcp_pm_nl_mp_prio_send_ack() does not access
anything protected by the PM lock, and it must release and reacquire
the PM lock.

By pushing the PM lock to where it is needed in mptcp_pm_nl_fullmesh(),
the lock is only acquired when the fullmesh flag is changed and the
backup flag code no longer has to release and reacquire the PM lock. The
change in locking context requires the MIB update to be modified - move
that to a better location instead.

This change also makes it possible to call
mptcp_pm_nl_mp_prio_send_ack() for the userspace PM commands without
manipulating the in-kernel PM lock.

v2: Move MIB call to handle change in atomic context.

Fixes: 0f9f696a502e ("mptcp: add set_flags command in PM netlink")
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/options.c    | 2 ++
 net/mptcp/pm_netlink.c | 7 ++-----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index aead331866a0..d5e58d2ce153 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1584,6 +1584,8 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 		*ptr++ = mptcp_option(MPTCPOPT_MP_PRIO,
 				      TCPOLEN_MPTCP_PRIO,
 				      opts->backup, TCPOPT_NOP);
+
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIOTX);
 	}
 
 mp_capable_done:
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e099f2a12504..936d72359c46 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -739,12 +739,9 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		subflow->backup = bkup;
 		subflow->send_mp_prio = 1;
 		subflow->request_bkup = bkup;
-		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIOTX);
 
-		spin_unlock_bh(&msk->pm.lock);
 		pr_debug("send ack for mp_prio");
 		mptcp_subflow_send_ack(ssk);
-		spin_lock_bh(&msk->pm.lock);
 
 		return 0;
 	}
@@ -1816,8 +1813,10 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 
 	list.ids[list.nr++] = addr->id;
 
+	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_nl_rm_subflow_received(msk, &list);
 	mptcp_pm_create_subflow_or_signal_addr(msk);
+	spin_unlock_bh(&msk->pm.lock);
 }
 
 static int mptcp_nl_set_flags(struct net *net,
@@ -1835,12 +1834,10 @@ static int mptcp_nl_set_flags(struct net *net,
 			goto next;
 
 		lock_sock(sk);
-		spin_lock_bh(&msk->pm.lock);
 		if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
 			ret = mptcp_pm_nl_mp_prio_send_ack(msk, addr, bkup);
 		if (changed & MPTCP_PM_ADDR_FLAG_FULLMESH)
 			mptcp_pm_nl_fullmesh(msk, addr);
-		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
 
 next:
-- 
2.36.1

