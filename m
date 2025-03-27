Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6C6C8EB
	for <mptcp@lists.linux.dev>; Thu, 27 Mar 2025 06:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743055483; cv=none; b=DHr9UsLfdubwgS1iiI44NCR3B1kcZwZrmK8rEWqJVlzcsCxgNjylwhsjPW8DHBukI3Y3FTo5aEkt4oBP9VIRPdlmS5pZwBXwdOZM1rytm1ZYruxB8U1i89WroZD7sTZeyaT27T6DKnw0iYKCI59giHKIw+TVjU8HM1dLHho9i0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743055483; c=relaxed/simple;
	bh=flxUMCaDQvsIeqU3OiohAQzS2lNpiMGYLE4TLlJZLaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPPnISexrmR9IVBul/EYA1maqV3fa384YVfudmukBQnQ5Z9GaRHb2vj9UxZ4B1F9EbVhglioAOlJ9yuIcAjbZZV2dQGBcuEjmoxnbN6BiBmKTTpSJg34qijX9YP5KsAuNFxKnyzc0BC4xLZ8Z4iRiVhbE19T46RYQDSIjIdaHeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7wl/Dzq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7wl/Dzq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6A1C4CEDD;
	Thu, 27 Mar 2025 06:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743055481;
	bh=flxUMCaDQvsIeqU3OiohAQzS2lNpiMGYLE4TLlJZLaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l7wl/DzqPH7sduQh6DnFNus1YsaW65yUreYxDh9RISQzOpvWzV5VJV9oTQHwTUXkK
	 FFAQFIC2Feia5TizjQsDTF32WJRRk8hqA7qElfymArNADLnO0kuUJSm05gKzGRobYR
	 nOX2Qr6jz2jX8H+rxgQJvFann61MYMVl0IuJQUqNran3ogC66N0+Btsv+2B1s+IANB
	 nAszqI8b2vhr2/p2X8GXP9GBiu81bLMO2Dnr03mcykxLFbu47pC+QJlWzli+L3GE0T
	 noQi0zzpbq30eCALA45dTQe21OSxJM8AraxucFGaCZWeBm5hY2UCDs+YDwGBVTEoJR
	 0ADNxyyv49dEQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 7/7] mptcp: pm: drop is_userspace in subflow_check_next
Date: Thu, 27 Mar 2025 14:04:17 +0800
Message-ID: <50605945cc7a54b820b1a934b454b4a5fef031e1.1743054942.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1743054942.git.tanggeliang@kylinos.cn>
References: <cover.1743054942.git.tanggeliang@kylinos.cn>
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
index 39842f7786db..9904fb71d596 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -551,22 +551,14 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
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

