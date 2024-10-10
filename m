Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1F9178372
	for <mptcp@lists.linux.dev>; Thu, 10 Oct 2024 05:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728539311; cv=none; b=Kj0SermptLAss7Yhlkj8DHH2Cant2cjTDTYqMgIe/kGTH9yVjHcsJ1lCfEfLXnJ88YM6ZY0rBsaOLdx4XLWaHq/8UzJRqYI/jh2zzCqWUMZ1bBiizSk4nutXRGTRdWiDIm0lTUjjFFTtFbcfUebUWScLpmb4WCq5jkOoB+pYG+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728539311; c=relaxed/simple;
	bh=zRrDYSrsKOnxGUDLUv6SHHsyzHqehx5WeHxuztEZX9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrceZPAF/hZzCueGSX+bJq/18mZw9uFP39evhGjzAVBzMcdg2yaXQL5N7/Z50/WETpN2TW3fFuQkcuU9n1tKulglrSCmicjr4n2IO7EpX2q1e+fPwF5uwRpTP/op6wvYJW2UcwlJjhOng4yK9QoT6oG3RL5BIYJmZGHjAAwDifs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXLaPpdM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXLaPpdM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5333BC4CEC6;
	Thu, 10 Oct 2024 05:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728539310;
	bh=zRrDYSrsKOnxGUDLUv6SHHsyzHqehx5WeHxuztEZX9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aXLaPpdMlmRaJ1SVE7BG2xhoeBvHFPfDsyjKIVDdT168PGQk+UaPazcamx+eyIu/P
	 ytk8291UyuIY+99ZMO55Zxe/qsdHa4y8FhVyho92C08JoF3wbLA4Lxc4ekBzG11l0Y
	 qAIG0dNXCG8IWiTJO7Lxx20kkuCXGPsPNmvxKpHdy6PwsM0PRPZmEjmM4pX2zmTQ+P
	 KHcQJvXPTLbUBwmBkFhAPWg5DvraPoHv9/QsreuN/lS9gZSbreWquEPz5da8o9z7uq
	 inAB8l+p0YMdIEf7CE4KJxwV2rKnbD7ddeQa04/hvhgalBtXIG4K4JgldESFCUOKs/
	 p24NzZtzFJwLg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 13/15] mptcp: drop free_list for deleting entries
Date: Thu, 10 Oct 2024 13:47:58 +0800
Message-ID: <65f5108cce91f79a93915d84047ec03c10655623.1728538976.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728538975.git.tanggeliang@kylinos.cn>
References: <cover.1728538975.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

With the help of mptcp_pm_remove_addr_entry(), it's no longer necessary to
move the entry to be deleted to free_list and then traverse the list to
delete the entry, which is not allowed in BPF. The entry can be directly
deleted through list_del_rcu() and sock_kfree_s() now.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 9477c36d3284..4b2c3d0f685e 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -283,9 +283,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
 	struct mptcp_pm_addr_entry *match;
-	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
-	LIST_HEAD(free_list);
 	int err = -EINVAL;
 	struct sock *sk;
 	u8 id_val;
@@ -312,23 +310,21 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	spin_lock_bh(&msk->pm.lock);
 	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
+	spin_unlock_bh(&msk->pm.lock);
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
-		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
 		goto out;
 	}
 
-	list_move(&match->list, &free_list);
-	spin_unlock_bh(&msk->pm.lock);
-
 	mptcp_pm_remove_addr_entry(msk, match);
 
 	release_sock(sk);
 
-	list_for_each_entry_safe(match, entry, &free_list, list) {
-		sock_kfree_s(sk, match, sizeof(*match));
-	}
+	spin_lock_bh(&msk->pm.lock);
+	list_del_rcu(&match->list);
+	sock_kfree_s(sk, match, sizeof(*match));
+	spin_unlock_bh(&msk->pm.lock);
 
 	err = 0;
 out:
-- 
2.43.0

