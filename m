Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D592C7081A
	for <mptcp@lists.linux.dev>; Fri, 14 Mar 2025 02:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741920364; cv=none; b=Ougq9PKQ3+EBMxcadSVVD5wLav4RxKTTxs84uTxHYTNIrkWJaQDDYD1AIPBA+aX7HvhZpm/mplCa756OqGWJVvR1SfsgId3YYXWq8Om8ZCGUUe1fOJ0XtbA2Su8M1atwvMl2zMn6pRQAol+t48JgXUqI32g3CZEruuYztjls/LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741920364; c=relaxed/simple;
	bh=dQEnEuQeD5gGnnYHi82ZoZfB7qorisjBt0SwIahvlVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNJ+Nzp//rK+8ClFPK04c69Sm6hxEGXSyeCMK802aHcsQGOxZGhdfp/avbQImwKkEvM7ufoGHUMZf5DEnHjpiLXInic1WMFNYchBneYQnuD9Mb7aE8RsqWjL4welYqsA2b/QMFnODsYw/UpJZJnOIUXS42D4jBuy8xVXL+16Ygk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWcVIDi8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWcVIDi8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041E6C4CEE9;
	Fri, 14 Mar 2025 02:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741920364;
	bh=dQEnEuQeD5gGnnYHi82ZoZfB7qorisjBt0SwIahvlVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HWcVIDi8oDSaHFWeqDB6v49m0n4FaPafWtyAuOfSOhz6yOSlTDlPErImWGuOV/HZ+
	 xssXE7Y96+MXvskQl+DXrx59xWK++SGhnIwztxV8TDTgmZLymiC1gn0pHQ/UWliTyW
	 L0s1OwDuvvOmp395G1n4K/CVm+FiYih+ptKGiyBWHPzuRLhbiZUXjwapn89v34NvJo
	 JlHP7D67WwuK1xUHCkJrAdXLa+EpZ48b2mpVcY+FWZ/GdSSE7EA9842Gd5cZJs7f2L
	 Vs10JaQS7lp13WkY5HvvuaSVcYwCnsLcpHinK+aHBwzKeXmZtHvaAS5IG4nmtXJAl1
	 s9g9RNc2qWcYA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 10/10] mptcp: pm: drop is_userspace in subflow_check_next
Date: Fri, 14 Mar 2025 10:45:31 +0800
Message-ID: <eedf03832d4bfbd9580c7ec21fb5994c2de3884d.1741919893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1741919893.git.tanggeliang@kylinos.cn>
References: <cover.1741919893.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In mptcp_pm_subflow_check_next(), instead of reducing "pm->subflows"
for the in-kernel PM in __mptcp_pm_close_subflow(), this patch moves
"pm->subflows--;" forward to let it be used by both the userspace PM
and the in-kernel PM. Then mptcp_pm_is_userspace() here can be dropped.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 70611946dfbf..d504f9b31893 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -531,13 +531,10 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 	bool update_subflows;
 
 	update_subflows = subflow->request_join || subflow->mp_join;
-	if (mptcp_pm_is_userspace(msk)) {
-		if (update_subflows) {
-			spin_lock_bh(&pm->lock);
-			pm->subflows--;
-			spin_unlock_bh(&pm->lock);
-		}
-		return;
+	if (update_subflows) {
+		spin_lock_bh(&pm->lock);
+		pm->subflows--;
+		spin_unlock_bh(&pm->lock);
 	}
 
 	if (!pm->ops->subflow_established)
@@ -547,8 +544,8 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 		return;
 
 	spin_lock_bh(&pm->lock);
-	if (update_subflows)
-		__mptcp_pm_close_subflow(msk);
+	if (update_subflows && msk->pm.subflows < mptcp_pm_get_subflows_max(msk))
+		WRITE_ONCE(msk->pm.accept_subflow, true);
 
 	/* Even if this subflow is not really established, tell the PM to try
 	 * to pick the next ones, if possible.
-- 
2.45.2

