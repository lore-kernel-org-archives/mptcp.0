Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEAE2209B
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588538; cv=none; b=mU07lo0aZUpD9YPH3BeDyhatPKWWP7YvoT59fzCoPSFZi9HX8gA9tsFw37tqlHoWHVpiEnH/p7vwKiWHWwKdnjMqpb29E1GIx3+BBnipGNewwFxeTGRP2upKtwhs6G9iBdnrq0CgcyrjU2Mp97+uz/4YeugSxvWSIxTOCDfj7Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588538; c=relaxed/simple;
	bh=3isXOFt/eH5lr6Gi6Z1hk9HgJqIdeKaAbETb72lSuqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIyZOmSBGr+EZxgkG65KDOsVqnF1aK4V7rTX5xSr8QsD4ko2YidErJz6LOwvP5A5u0Tln/XBp+JnP4v9J3zqRiorVXG576vC0PfcMLtrZEDXtJME6tTOjl5rNQ9/DLJhsdzv69cBpbqRS7gdpq6kbKmExWaHl+IAP4NT/HOHblw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dctezfr5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dctezfr5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CC8C4CEC3;
	Tue, 22 Oct 2024 09:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588538;
	bh=3isXOFt/eH5lr6Gi6Z1hk9HgJqIdeKaAbETb72lSuqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dctezfr5m4qNJocGMtyJl0VmixASzhFLgKMsw4vJat8Jd+yL0MJ0Tca3tqsv+xGcU
	 6AFWRjbGevdCQjQI1E34UBcrPX0UGBQkqRfd9LQNyNLQE5btgghDQsGB9YGewsRv46
	 7qIkx6nOXu98B/aIMwciyBpaNa2SEZgzEs/3oxzCtKEO5XAGJeWVvEdTb5kgx+Ck0A
	 l7aFpp3OnLtifmCaagmQ62B25PVX1UNp79SQt1gQCBpi8niDSLxOKlqoREifhaFIQd
	 s6x3o2y3BGpUCMZRE5Pf8c560FL6lcbgsgciockBzHOGMDw/nD8l4Beg42//7WW8lh
	 wZLYYXK2b9c0g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 28/36] mptcp: drop free_list for deleting entries
Date: Tue, 22 Oct 2024 17:14:36 +0800
Message-ID: <9aeee6d70b0b4071765029bc2ac3dd9c2033a85c.1729588019.git.tanggeliang@kylinos.cn>
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

With the help of mptcp_pm_remove_addr_entry(), it's no longer necessary to
move the entry to be deleted to free_list and then traverse the list to
delete the entry, which is not allowed in BPF. The entry can be directly
deleted through list_del_rcu() and sock_kfree_s() now.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 21b2a3b02cfe..e5dfa1a6db31 100644
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
2.45.2

