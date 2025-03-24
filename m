Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88911459F6
	for <mptcp@lists.linux.dev>; Mon, 24 Mar 2025 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742804396; cv=none; b=Vy/5mJgoXseYAJHqrowZ7G0CvqUBZuxmsPidkQ7tQ44vBqDrMAJ6OdBMm8l/CPYKjzdyykvD3gmpKUp+SGNuHLeIy2QCLX4LR5vEPOScE0Vx5N2ph6YozcTuzUeGQChL2mmN6tOdYvBwEIhyyFOKMalfP2urq2w+GQO7JZej96Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742804396; c=relaxed/simple;
	bh=61vKMIrzXW1Lgy7L8zqTyNvGT8sisXMs1/mG5P/149Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyg7gqBvGw5+DmxPFtShNEJj0OzL/1Jz2hIwG6//Dgs4562lKeeFi05idPLXVbMDzl/izadsgRLP8wsOud9k2QFafkG0GiXcFC19HXmXdj8LTGm44LOu0aTZfqoYCdK2hSL3e3y+jSFS6OKlTbBUhiVN8JJeuZx0Ni7KpNwUkVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnveZXkx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnveZXkx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC71EC4CEED;
	Mon, 24 Mar 2025 08:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742804396;
	bh=61vKMIrzXW1Lgy7L8zqTyNvGT8sisXMs1/mG5P/149Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EnveZXkxbqwi0LFotG72ITFke6vR/yXALAc5/kmWk/6iyz6Z0ZT046rv9eO0clfgz
	 HjDtZvyoc7Sw61Z7QrBWiBRvOZhXpqvIft0khzbFRuMIrI3ue6vO0X5V6cxElKUfzT
	 5gSFteHVYKeDgE51xmMwX1AD/OLMlsLD7UNU2+Y73xAb+gwNc82SzhmJcvqN/TQhhc
	 dwtGak0cpNakU/z8UaEFmrbwOZEK3CFDIE1Xm6NfO4Ss/DvnZN5VDEsh031nnPyArD
	 ASlxcjq0h9GKqqWWDcQz5m1LeSssqTcGgm6/iqtMVyRw4psqR0JSiQzk/zjalQkZbx
	 lwaN0tVgaQFhw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 3/9] mptcp: pm: drop is_userspace in subflow_check_next
Date: Mon, 24 Mar 2025 16:19:37 +0800
Message-ID: <c7f5b4fe1579c47eae9d34ac8b5570bccf277f13.1742804266.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742804266.git.tanggeliang@kylinos.cn>
References: <cover.1742804266.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch moves mptcp_pm_close_subflow() forward to let it be used by both
the userspace PM and the in-kernel PM in mptcp_pm_subflow_check_next().Then
mptcp_pm_is_userspace() here can be dropped.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index e2b2c874a9f8..906c558aef0b 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -562,22 +562,14 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
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
 	    (!READ_ONCE(pm->work_pending) && !update_subflows))
 		return;
 
 	spin_lock_bh(&pm->lock);
-	if (update_subflows)
-		__mptcp_pm_close_subflow(msk);
 
 	/* Even if this subflow is not really established, tell the PM to try
 	 * to pick the next ones, if possible.
-- 
2.43.0

