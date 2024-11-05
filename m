Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971011CEAA0
	for <mptcp@lists.linux.dev>; Tue,  5 Nov 2024 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799670; cv=none; b=AvUGn8jWUqyctakWi4eHfOV8vfl8d7Za5qeiNP1v2qYwnInBMlAJ6u8ItRpJAPBHy222t0XMDpuDTRSNwy2fAlkU/vWWLU2QVLXfCmBVumCp5c61UGp2Id8wpf8LNnIGGlzgnR7YDQ9Rfl5Sig2n0sKZU2XlH7bU/i5cqgmoHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799670; c=relaxed/simple;
	bh=KPtlrGtxYJONQVEUACfPSIQJ7R6y/qNOjZKwIW4cMgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIJmHyjL+uZl1wQGiqB/GABXLF3MfaYdIpVmrjcMVAyy2LVhIGOIe6PX+vQ/oayNDTASMDktYm4jyroZZEoeVt33YqpTi6EwEdYL6LWdZbRA9LqbJRKwGTnCDH3HEbDlw7aCsVjEi/T/YN0+fE3eWw/FUjhkSAtINQS3RTG0+qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSj4Hz/2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSj4Hz/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46611C4CECF;
	Tue,  5 Nov 2024 09:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730799670;
	bh=KPtlrGtxYJONQVEUACfPSIQJ7R6y/qNOjZKwIW4cMgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kSj4Hz/25Kog65n9XpkY8fPge2eDnewDcTudNfwWS+hM/pzxpivyakFTCfP8aTBkv
	 Id3whAYeS1l00Fqk/EwxGslG4uLfggmUOfGOXK8HY/eIqBNZzzlFA3nMOlMFlUz7Zv
	 AFMB0m3ULZB6NxSYJJEiseOKVGAy6xmowLVDUpWxWcqQYQLSCCai5eCxAwp3/WJMeE
	 QHLJIMaUXFWODpATOLKN87WnAZmyiUbyaf858Yfg5ZOJ3BA6bPv+U11gZYUJ2aiVc1
	 q8nLwabtmEuAEAjwOHVZJnySPe7cVx7hqLX+m44cJC7cvlFmsNuoTXGe1P/ClGTpl2
	 wRPLHId20eKdw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net 2/3] mptcp: update local address flags when setting it
Date: Tue,  5 Nov 2024 17:40:59 +0800
Message-ID: <72998c181b94560b3d1e1e5843250ee2815869ac.1730799589.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1730799589.git.tanggeliang@kylinos.cn>
References: <cover.1730799589.git.tanggeliang@kylinos.cn>
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

Use mptcp_userspace_pm_lookup_addr() helper to find the address entry on
userspace_pm_local_addr_list, if bkup is true, set the flags of the address
entry with FLAG_BACKUP, otherwise, clear FLAG_BACKUP.

Fixes: 892f396c8e68 ("mptcp: netlink: issue MP_PRIO signals from userspace PMs")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 9c622b0e3e6e..0c0f6f65accb 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -562,6 +562,7 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct net *net = sock_net(skb->sk);
+	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
@@ -603,6 +604,16 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
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

