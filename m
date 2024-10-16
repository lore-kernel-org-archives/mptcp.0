Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47120205E00
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069996; cv=none; b=MLFsuw6xx2WzqfAchIxrpF275TtxjgqBc6k1EzZ5MDhQIV6XL5SsyoahcygJEwqdOI6IKtEeQ+zQiPfzRSSgUvnazA/otvv4qiD4C7PDHkIc+Ww5DYpxMQaj1ynrXEqvr/rqFgNuV5GdYURIGnXVcfou9je87VFW+e/fO6CX+K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069996; c=relaxed/simple;
	bh=Q338E+VwlIkdV2vjVcsMJnGwflObkj/6tW2uxwTY3cE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0polZp7Acaoc+VV6Ybbu2AH35+7vBIQQo1Ke1/PjRKt1TjheKqy3M6M6FQgQQ/TeVz/mJZ/qs+uLKIbe5bDqhTToBtUgbo8TQv7CFz3QIzSkM4bo6hEc0qZtezuQUMfDgBqtWT4Bg7oTtHVV1/BTCMTzxbo8l2dcC0drTHsMLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKUQctGT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKUQctGT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84D7C4CEC5;
	Wed, 16 Oct 2024 09:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729069996;
	bh=Q338E+VwlIkdV2vjVcsMJnGwflObkj/6tW2uxwTY3cE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XKUQctGTk1ft+S9bSgr/JvhzpymfkePgzymxp6NAexGed+nMOqqXEm4PLpAiB7xav
	 VyDnVSR0WlGoirqPxpzUyRQTMhpbTzMAsaPnBDnEEiWF/89ofnB+fNkTvLloGjTqyv
	 5WawLxvEz9Gj65m7t4lL3Ljksb5KVH/Tu79PJHdNEbu0G08oFHaXa0FoBw7ccIlWId
	 sPDz32MH5RRzP7r0XUdSAkWIeKijIigh8WnXSQJaJ9tiBBK9h1clZoYjN8MZtPUqwO
	 4G7slnY95Mov/SBwZ3ytUculGL2DFAUTcAz6nQ5/fIk/dPsJ3rl0ID+zTGsNOSDQry
	 9eD7+7l88aR9Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 17/33] mptcp: update local address flags when setting it
Date: Wed, 16 Oct 2024 17:12:21 +0800
Message-ID: <c3e79ab7489e604d45e24de5b1019a1b9c2b52f1.1729069854.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729069853.git.tanggeliang@kylinos.cn>
References: <cover.1729069853.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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
2.43.0

