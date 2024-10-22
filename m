Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AE1152166
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588521; cv=none; b=GC4dVWRcz9NDXE2zWLS4quJbui+Xrt64S88hic3XtTjyjji4V95bSr5k45UfU8oDUPiynOoDcuOMA4eueOC9s4rNorPYN2sqY1oouPzwubx8jepHGBeO3AOzw7Fk6BhfvfcUJFvB4OtPf6737PBIAQsJ/slz82zCTGaujXchgHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588521; c=relaxed/simple;
	bh=ZjREbHxhOIy+A7ttd4+oVrbw067GkUlxYaXjFcOshvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zdp1yWft7RgVury09wUyi5U67CLJKynRdl4AbgnnGz3c3FS+s9xcPFxN5JouvET1YC5qsX28fhLrigyChy6S/kmusN1jxcUKc2KNu4ZWi43rB62XCmAk9A9xovT6dgfejQ0PSV3mynbgobLJbFn/2LBEOMhMv8jl26Eh/x8H/fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8/Jz/sh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8/Jz/sh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D8DC4CEE3;
	Tue, 22 Oct 2024 09:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588520;
	bh=ZjREbHxhOIy+A7ttd4+oVrbw067GkUlxYaXjFcOshvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b8/Jz/shvwjudcLn/olY6jVj52v55zE7rAL+uLkyujTlaWoYPWNU5mSnvWyssmwiD
	 RK4F4TvZmEu5Hxv9b3K8nECe+rw4jz5GX0fMigXyP4iyhBnmEKIanc2GgyroWGqWfQ
	 Hl2twbfA1JL2LaMGYVhwA0AG5Er2zga4YPo4+veTdh5ZYY4u+RoE6EeqS5vLJwH9zg
	 3nkMsUvhWJHHI5T+k8KpdObtsXopxX0gZcrCYOYWsUXySfip7WyWYw6XsYESuUj/OW
	 4HO/KzUdYyly7yC3ZlUt7dOtLv6U2UKX3iz7F0qlm2hXcUB75l8XQA1GVw9GdgPgj3
	 18+c8ElchnEKQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 17/36] mptcp: update local address flags when setting it
Date: Tue, 22 Oct 2024 17:14:25 +0800
Message-ID: <7ab7696f338aa9ac73d65439350b38412c2e613d.1729588019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729588019.git.tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Just like in-kernel pm, when userspace pm does set_flags, it needs to send
out MP_PRIO signal, and also modify the flags of the corresponding address
entry in the local address list. This patch implements the missing logic.

Fixes: 892f396c8e68 ("mptcp: netlink: issue MP_PRIO signals from userspace PMs")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index d815bfa57532..ec2ac0f9c8f5 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -543,6 +543,7 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_pm_addr_entry rem = { .addr = { .family = AF_UNSPEC }, };
 	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
@@ -574,6 +575,16 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (loc.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
 
+	spin_lock_bh(&msk->pm.lock);
+	entry = mptcp_userspace_pm_lookup_addr(msk, &loc.addr);
+	if (entry) {
+		if (bkup)
+			entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
+		else
+			entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
+	}
+	spin_unlock_bh(&msk->pm.lock);
+
 	lock_sock(sk);
 	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem.addr, bkup);
 	release_sock(sk);
-- 
2.45.2

