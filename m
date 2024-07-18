Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DEF4D8B7
	for <mptcp@lists.linux.dev>; Thu, 18 Jul 2024 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318050; cv=none; b=Nole6mCBMeemuSMHDwFZd4qvvHOziLR6xUl/7x+IvHXXRAAh/BxhviqjSy2VDud0xWNisTUjkCDmkyUBi/+x2T+Pg3QrTIJi6YQDxhOyjshVqiRs1OPUD9fpYL85mObZDlWscop7dwc8jC8YsU4FmPuPsbxlDjuwaS8PEkLQ2YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318050; c=relaxed/simple;
	bh=ZDZ8Zs9+UnNJsK4rttUm4nEmmnD7uvT6+ABRxskRfWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hgmVjHQpM2G1Ko+EN5eHFK/PUdfgkkEKM9ri9+QeXHZVN0ZF94Cvwgx7LLI/Ys8eflM51O+llDuDQu8IIFfYcwWFWLaObrNqH1hGpPhFoy3FG6/lcE6debi8J32K8ZsN+Vot8PwA4QDaDu1Q2swVQwXcVr2ztj22FXGMW/+Ju98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vpkw39SM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vpkw39SM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC83C116B1;
	Thu, 18 Jul 2024 15:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721318050;
	bh=ZDZ8Zs9+UnNJsK4rttUm4nEmmnD7uvT6+ABRxskRfWI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vpkw39SMLE+MR30Sa5kdgnaxDa6sHDwFoIVd9+Vu3OFSmJrFmJO9DiLQg5sL2MFtK
	 l7LIRHpWIZ0adNzL+/bHqSLeHHiKVB238bSYLrHJaF6ivL36WevMpy6gSZFVDtV2xe
	 rJTXEg/8veON/lCdLr0vmm2jVcFVcIoq2lmO/9p8p4cfKNnJ8NFJLPVJPMaoZrB7hn
	 MgDWCqU3eKwhXavRJPzfxz/3JHHDLfko8Qo7D1ICTdQzEliF8NgbV/x6mU6oDe6EIv
	 ihuBSGSAMDbc4HcTQ96t5swgvZzprokr701bWXeqpTDCjt32HR97VT1EVxUspHwTef
	 ohbTVX3EonoAw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Jul 2024 17:54:03 +0200
Subject: [PATCH mptcp-net v3 6/9] mptcp: pm: fix backup support in signal
 endpoints
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-mptcp-backup-mpj-v3-6-1f6cd9b89ee4@kernel.org>
References: <20240718-mptcp-backup-mpj-v3-0-1f6cd9b89ee4@kernel.org>
In-Reply-To: <20240718-mptcp-backup-mpj-v3-0-1f6cd9b89ee4@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5681; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ZDZ8Zs9+UnNJsK4rttUm4nEmmnD7uvT6+ABRxskRfWI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmTqbx6VfHXPV16uDzRUlRVp+CQqbeqYsSDQA8
 +E+yPTyDiaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpk6mwAKCRD2t4JPQmmg
 c179D/0fpVIbVG3kiducXs/Y54kDxU/nYh432JrRHvnXQtRvOP1InfoNRoEySCP36m27EHoxS5x
 oElJ76t9iB04VI9mjsCpqx1MRBse7JHkmVwyte6JOLVLi1Gqx6xzcr3YVpwNtZOttPf9OhLtRPj
 bg2VHWThxREkgT6eZmkkLQALTIeLCUrvNdpaR5sTNPhjiuhE0pdAHkKIyfxcOh5/nQkJpV66z7A
 EF+sQtRoAxH3dOE1+dRY4K0v+LbWP+qUzwr43WLyPVtatkfPZQjpS+mSL8z7r4TTxZ20QDRrPqB
 JbeYAg7rHbNb7If9q7jiVkJ4KEkB1XMXqdQ1uMijEVPTY3d6dHyrWPZua8t59QQQw+Y6aA+OFKj
 xlqVL5Wlvp5oBlYeeIJVw3XjIuUPnzr/2wHETeNZ0dkzqqnWtJkDAN0usfCZ/79C2O7pksQjmxC
 OZqPIJ4soOcN/FeiwVBScBSeGHjeEcFlck/BYvIruRlVxyYBErXdVx3cKNhSZBdfd5v0DjVVqDx
 DhFiiRkyGYEAw9GAsaSu8qZ+BVMVnnPn8AXlxQmzkY7mOB4XNXo3vfoQatRHRoSUFvQSX8D6pRg
 jTqhaL9rNf9IyT9umO8VDi1RuwhDAN9mQ/k3vxQ9+wnfO3l6swmwBMCZdk/OJ8KlB+WBzQK67dU
 dKNegT7QEniwjog==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

There was a support for signal endpoints, but only when the endpoint's
flag was changed during a connection. If an endpoint with the signal and
backup was already present, the MP_JOIN reply was not containing the
backup flag as expected.

That's confusing to have this inconsistent behaviour. On the other hand,
the infrastructure to set the backup flag in the SYN + ACK + MP_JOIN was
already there, it was just never set before. Now when requesting the
local ID from the path-manager, the backup status is also requested.

Note that when the userspace PM is used, the backup flag can be set if
the local address was already used before with a backup flag, e.g. if
the address was announced with the 'backup' flag, or a subflow was
created with the 'backup' flag.

Fixes: 4596a2c1b7f5 ("mptcp: allow creating non-backup subflows")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/507
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - v2:
   - Only set *backup on success (Mat).
   - Support MPJ to/from ID0 with backup.
   - Split the tests in a new dedicated commit to ease the backports.
 - v3:
   - Use a new dedicated helper instead of re-using
     mptcp_pm_get_local_id() (Geliang).
---
 net/mptcp/pm.c           | 12 ++++++++++++
 net/mptcp/pm_netlink.c   | 18 ++++++++++++++++++
 net/mptcp/pm_userspace.c | 18 ++++++++++++++++++
 net/mptcp/protocol.h     |  3 +++
 net/mptcp/subflow.c      |  3 +++
 5 files changed, 54 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 55406720c607..23bb89c94e90 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -426,6 +426,18 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_get_local_id(msk, &skc_local);
 }
 
+bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
+{
+	struct mptcp_addr_info skc_local;
+
+	mptcp_local_address((struct sock_common *)skc, &skc_local);
+
+	if (mptcp_pm_is_userspace(msk))
+		return mptcp_userspace_pm_is_backup(msk, &skc_local);
+
+	return mptcp_pm_nl_is_backup(msk, &skc_local);
+}
+
 int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
 					 u8 *flags, int *ifindex)
 {
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7635fac91539..37954a0b087d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1101,6 +1101,24 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	return ret;
 }
 
+bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+	struct mptcp_pm_addr_entry *entry;
+	bool backup = false;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port)) {
+			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return backup;
+}
+
 #define MPTCP_PM_CMD_GRP_OFFSET       0
 #define MPTCP_PM_EV_GRP_OFFSET        1
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index f0a4590506c6..8eaa9fbe3e34 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -165,6 +165,24 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry, true);
 }
 
+bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
+				  struct mptcp_addr_info *skc)
+{
+	struct mptcp_pm_addr_entry *entry;
+	bool backup = false;
+
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, skc, false)) {
+			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+			break;
+		}
+	}
+	spin_unlock_bh(&msk->pm.lock);
+
+	return backup;
+}
+
 int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6b6b76152db5..23dd0ecd5fbc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1114,6 +1114,9 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
+bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb);
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index be406197b1c4..0e4b5bfbeaa1 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -100,6 +100,7 @@ static struct mptcp_sock *subflow_token_join_request(struct request_sock *req)
 		return NULL;
 	}
 	subflow_req->local_id = local_id;
+	subflow_req->request_bkup = mptcp_pm_is_backup(msk, (struct sock_common *)req);
 
 	return msk;
 }
@@ -620,6 +621,8 @@ static int subflow_chk_local_id(struct sock *sk)
 		return err;
 
 	subflow_set_local_id(subflow, err);
+	subflow->request_bkup = mptcp_pm_is_backup(msk, (struct sock_common *)sk);
+
 	return 0;
 }
 

-- 
2.45.2

