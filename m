Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1657A190468
	for <mptcp@lists.linux.dev>; Wed,  6 Nov 2024 03:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730864616; cv=none; b=q/iuOK0vhW3GAkY/f3y6beXKKfg62zcvmH9guT+n3MRE7UDS/sSKR3O/X8jkGo8l/KJK0bnxS3AwBCZzhqMc3vh2um996TN46cFZifhGs9XMmEs7fj3VQW9Bn6YaysLadPFi+vEZ3A08PGCPEepIZv+CJTgcZO9GRpf5FtnxTRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730864616; c=relaxed/simple;
	bh=N0iQVGFr0n6Y2eeewebKd55V3PtFdIiYX974tyQcrPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvEguj6JzDKZqtDko+4veSJ9FjKvdTZtlXkGcNfu71PBxUR8A9efqO7V8hVsgcvLZVYhUtJpz7V9NWdhiTgXUHnL0t2asizXGXbieAEHhiUWaiLMgMlbUhjvtYdpD1gcGq78p9U+tSAQ4mguwyW9KgqrlUryAs7j2mN8/Wz6I3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RccLxNxq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RccLxNxq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7B0C4CED3;
	Wed,  6 Nov 2024 03:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730864615;
	bh=N0iQVGFr0n6Y2eeewebKd55V3PtFdIiYX974tyQcrPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RccLxNxqrDJsI0O1/zofgJIKlnw01b+YmeQU9wp6XfmurPnNAavSkKoS92i8d54Mc
	 j+J7KnHjdkxMRzg0Q5nvKueh0Exh63GuwsDbxXq+4WlrMwYZE5osfP+8PVhAUURgSz
	 vPOJZoTnE02NcZoVLy7809frachoV6AJ1yJHwjmqEeigUp+q2pJytgxiieaGagEw9z
	 axu0XT4VrUz/ch55QmJkkyuCahcBW/mDb+REPr9Cwxc49OBSXTVTXhMovfgSKY6KH5
	 tSYSQEF5SmXUr2s2fR5TvevCEf8EBpT/KpK/U7tDrfLuIXxy9EB/lxKBxunwgKcbNv
	 Zla01DBHSLaKw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v2 1/2] mptcp: update local address flags when setting it
Date: Wed,  6 Nov 2024 11:43:23 +0800
Message-ID: <7ffab520bd47404b5c79518efe07463db3da3448.1730864444.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1730864444.git.tanggeliang@kylinos.cn>
References: <cover.1730864444.git.tanggeliang@kylinos.cn>
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

Traverse all address entries on userspace_pm_local_addr_list to find the
local address entry, if bkup is true, set the flags of this entry with
FLAG_BACKUP, otherwise, clear FLAG_BACKUP.

Fixes: 892f396c8e68 ("mptcp: netlink: issue MP_PRIO signals from userspace PMs")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 56dfea9862b7..3f888bfe1462 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -560,6 +560,7 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct net *net = sock_net(skb->sk);
+	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
@@ -601,6 +602,17 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (loc.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
 
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, &loc.addr, false)) {
+			if (bkup)
+				entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
+			else
+				entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
+		}
+	}
+	spin_unlock_bh(&msk->pm.lock);
+
 	lock_sock(sk);
 	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem.addr, bkup);
 	release_sock(sk);
-- 
2.45.2

