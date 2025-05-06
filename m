Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37582262804
	for <mptcp@lists.linux.dev>; Tue,  6 May 2025 08:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746521741; cv=none; b=WYsUBJbP2keuSvNnlPl+PLnjn5pQCeTzRCGFz7SOMjZfhjx68Mcr7ZXh/Zjcdm3a0mJwKtESo0uwt5m4lMSZT6gHQBjCJVm52d8f0oToLxutqjatdvsAQ9Vtkv/gIj4ehki88pFd3Jr1qVmmsEfUmvUZZIE4iyrFioeDaAgw3H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746521741; c=relaxed/simple;
	bh=IvC5k2k5C9gQfi4qxCchZ9B9XPj5fojm71qXmKfkc3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEkg0BptN/I/qZv9FsUcitqjdoIygiNkzf7Ytgj6QuU94kQtnZfzup+teS3WDfRdeIILpDXqH87wkwDzOCbGerrzWqhaot4j5zkcrJxLB4D/1wd67+Mf17OR1pDUKmgG5XRYmH0zarH/JAHoB49UwWG1nxjw2ZJ4xkhchWME/zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7T+S7UB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7T+S7UB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A68C4CEF1;
	Tue,  6 May 2025 08:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746521740;
	bh=IvC5k2k5C9gQfi4qxCchZ9B9XPj5fojm71qXmKfkc3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P7T+S7UBj4kR0XGU79X2hYobz3keuGVumbXHiQnt6uW6VHz74zls0Kh6Tzl5B7T44
	 /nTbgAJGFmMi+pDiUGJFA0pEUwtnOj52znR4whvwqFPWZdCLlzDe58SKtUpgLly4mC
	 /9XvMHNIo2A9vuuV+WDHeBykxNzY44e7QqETfowY5Y3t4JOj3vGllQzW+jxy3SLQBu
	 VHDVmTN0pdMmeXcXTUAG4s4DNLvV0FfadIlpfmtMysS056OxHJNx2Ef6E6x/w8F3i6
	 cBXJ7z6533+rFeyP1zOxqWeNhxHKZrRalYGS19MAtpmrGOOnc6tW/bFoBkj1ZJnsBA
	 rfj8oQWHJHSfw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 5/5] mptcp: pm: drop is_userspace in subflow_check_next
Date: Tue,  6 May 2025 16:55:26 +0800
Message-ID: <cac4c60723e0a504593e012ec32f2416f6cb9f8e.1746521233.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746521233.git.tanggeliang@kylinos.cn>
References: <cover.1746521233.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch moves mptcp_pm_close_subflow() forward to let it be used by both
the userspace PM and the in-kernel PM in mptcp_pm_subflow_check_next().
Then mptcp_pm_is_userspace() here can be dropped.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 7d67789fd09d..cfa1e0ebc87f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -552,22 +552,14 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 	bool update_subflows;
 
 	update_subflows = subflow->request_join || subflow->mp_join;
-	if (mptcp_pm_is_userspace(msk)) {
-		if (update_subflows) {
-			spin_lock_bh(&pm->lock);
-			pm->subflows--;
-			spin_unlock_bh(&pm->lock);
-		}
-		return;
-	}
+	if (update_subflows)
+		mptcp_pm_close_subflow(msk);
 
 	if (!pm->ops->subflow_established ||
-	    (!READ_ONCE(pm->work_pending) && !update_subflows))
+	    !READ_ONCE(pm->work_pending))
 		return;
 
 	spin_lock_bh(&pm->lock);
-	if (update_subflows)
-		__mptcp_pm_close_subflow(msk);
 
 	/* Even if this subflow is not really established, tell the PM to try
 	 * to pick the next ones, if possible.
-- 
2.43.0

