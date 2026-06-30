Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2F92F261C
	for <mptcp@lists.linux.dev>; Tue, 30 Jun 2026 06:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782799928; cv=none; b=OfwqqX5MP8XhasiBC6KmQB4DTz1rAxfXfkKlDLfiGl86NyS/SS1f8V+ZjIpE48Xqh9H8WbCwyOuTH64IXwDY8LxyLkuaJeOS4hc3sdLJCbeyoF9U70slN+lbsBmRerJirkOExeRap8cLtNwNHmvGgWg9yu+xU/+hBYT6DTMBLLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782799928; c=relaxed/simple;
	bh=4xxgDIh2HncHlfe6ocUDoPS4sVaCzIiAZ7F47QCqhwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EcjbVjcT9ulsrurTwDX9iRnidro4J3kHvEq8VDaDq1ljZLtwCLXX/lXY0NetLGgxGshVC+CXCxSK8QTFKyyFAX5fgjSY/XvwLoJZzENYcfa6cf6GALYto7nXzgBN77MVPJSwTCCEPf22CRCRxHk/lQoYS/jZM53qV0g9kHyvk9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bp92eF2Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bp92eF2Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F91F1F000E9;
	Tue, 30 Jun 2026 06:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782799926;
	bh=QCzr/B9wVAr1lm9vqm6zHAlQjIyn2Sq1oJCwYk5xvAM=;
	h=From:To:Cc:Subject:Date;
	b=bp92eF2ZuVzgozMbdLmMDPupBjJ6CpVLnlhzddF8/ctELLPjHPNL8LAXTynOLMOTi
	 a+Wmp52+WDSugFxuOtlp60g3uac1eUEeQSZiOVph/ve4xrNnmkNgxlHpPNec6GRVNS
	 RrliC8auXcUz9k5E3G1kT19Oeq9fGSfl5/25fBRtJVH8n5vNjujAlN/dlobePHPrvp
	 y75gLbzUUpOJF4bVAmJcKM+vHUcW3s/npuku6U/zbwbNLkjwbBN1x8BCcdwe10eSL9
	 Fy/mXwIeB4Dmtgp/vWfJE8F7lNbm53RgrlUWoZCB+T+ysZB6H/xbzQABquSbGeqSHG
	 HCUGMLZx2xgLg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net] mptcp: pm: userspace: fix use-after-free in get_local_id
Date: Tue, 30 Jun 2026 14:11:56 +0800
Message-ID: <4e50adfde3b80f433e13b86919596be229045edc.1782799876.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In mptcp_pm_userspace_get_local_id(), the address entry is looked up under
spinlock, but its id is read after dropping the lock. A concurrent deletion
can free the entry between the unlock and the read, leading to UAF.

Fix by copying the id into a local variable while still holding the lock,
and use -1 as a "not found" sentinel.

Fixes: f012d796a6de ("mptcp: check addrs list in userspace_pm_get_local_id")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ad6ba658e5a5..8a5cf5ed8f7b 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -132,12 +132,14 @@ static int mptcp_pm_userspace_get_local_id(struct mptcp_sock *msk,
 	__be16 msk_sport =  ((struct inet_sock *)
 			     inet_sk((struct sock *)msk))->inet_sport;
 	struct mptcp_pm_addr_entry *entry;
+	int id;
 
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_userspace_pm_lookup_addr(msk, &skc->addr);
+	id = entry ? entry->addr.id : -1;
 	spin_unlock_bh(&msk->pm.lock);
-	if (entry)
-		return entry->addr.id;
+	if (id != -1)
+		return id;
 
 	if (skc->addr.port == msk_sport)
 		skc->addr.port = 0;
-- 
2.53.0

