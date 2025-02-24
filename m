Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD91C134AB
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 08:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384832; cv=none; b=pLUHAE8bZnqle3Q8BbVNA6p0oiiSMjrHm0pc0vTTPwPYkjXuP3aCKgSaQBHqiy7SNer4/JDNBkAuAtYX6aqbtBqJpQRqM+ZuFmRw2GWSbwvaqEeTKnUDFFZ5ZlbYZsktSGLid9YTkRDymk2iTcW2IPQjIhaCOQykk5Wc6Fz6qmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384832; c=relaxed/simple;
	bh=cGtY4t6sdylYcA+LRDIqPy8T3u2YwXrzz1tLoyScfEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHNcvBjb1oOueiA0ZSVC37Iej4+7ZP845lfolHJx+iqUfYsfub3Xwl8nJD80Uz1A69ExVTKVCcTOYHOVU53HtOgVMavIRyYlz3P7sCCjS5AFcvUooKkTvJG08NbJ6fT7K08aZcvWY34ymUBMn7EmyQxhYzu3XFfVtGda1ALVcdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7AL2W55; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7AL2W55"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7D5C4CED6;
	Mon, 24 Feb 2025 08:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740384832;
	bh=cGtY4t6sdylYcA+LRDIqPy8T3u2YwXrzz1tLoyScfEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C7AL2W55tLXJkYgZQj0O/9kNFJA4vw8DmAgvMFWwzLeLdydpo6KRlkz5ByLduaMlN
	 Ijkc9npOO1qQdzgoby9h493tPkpfvMv6V6s6E1ziGMQfOV0nqBxcI1uusQS2vX3pko
	 ingJbA7QWCzNE0bXnZxUxJYzDio27P+rtjqwIJ04ZlcKYU3/wTkj2/XhIM6gatW9WF
	 OG+Yut61gvUSVGmaTOoh0SdO0yk3Iko5u7og5lEAHqawIQsX5U49KWOekPM8lSuY87
	 m4+CAERD6FMBp5l2+wDIIX8fAQfdOhz02ZI2+emiISe6eBIBeJGsUheVANpMkavfII
	 jN1+Dd/rgJqUQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 2/6] mptcp: pm: in-kernel: reduce parameters of set_flags
Date: Mon, 24 Feb 2025 16:13:34 +0800
Message-ID: <cdd7312a8ea7fccc72af9af50349c096168de68b.1740384564.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740384564.git.tanggeliang@kylinos.cn>
References: <cover.1740384564.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The number of parameters in mptcp_nl_set_flags() can be reduced.
Only need to pass a "local" parameter to it instead of "local->addr"
and "local->flags".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index fb83eba041f1..4bebc4963c42 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1907,11 +1907,12 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 	spin_unlock_bh(&msk->pm.lock);
 }
 
-static void mptcp_nl_set_flags(struct net *net, struct mptcp_addr_info *addr,
-			       u8 flags, u8 changed)
+static void mptcp_nl_set_flags(struct net *net,
+			       struct mptcp_pm_addr_entry *local,
+			       u8 changed)
 {
-	u8 is_subflow = !!(flags & MPTCP_PM_ADDR_FLAG_SUBFLOW);
-	u8 bkup = !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+	u8 is_subflow = !!(local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW);
+	u8 bkup = !!(local->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 	long s_slot = 0, s_num = 0;
 	struct mptcp_sock *msk;
 
@@ -1926,10 +1927,10 @@ static void mptcp_nl_set_flags(struct net *net, struct mptcp_addr_info *addr,
 
 		lock_sock(sk);
 		if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
-			mptcp_pm_nl_mp_prio_send_ack(msk, addr, NULL, bkup);
+			mptcp_pm_nl_mp_prio_send_ack(msk, &local->addr, NULL, bkup);
 		/* Subflows will only be recreated if the SUBFLOW flag is set */
 		if (is_subflow && (changed & MPTCP_PM_ADDR_FLAG_FULLMESH))
-			mptcp_pm_nl_fullmesh(msk, addr);
+			mptcp_pm_nl_fullmesh(msk, &local->addr);
 		release_sock(sk);
 
 next:
@@ -1983,7 +1984,7 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
 	*local = *entry;
 	spin_unlock_bh(&pernet->lock);
 
-	mptcp_nl_set_flags(net, &local->addr, local->flags, changed);
+	mptcp_nl_set_flags(net, local, changed);
 	return 0;
 }
 
-- 
2.43.0

