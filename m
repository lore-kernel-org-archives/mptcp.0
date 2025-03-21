Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5139D15820C
	for <mptcp@lists.linux.dev>; Fri, 21 Mar 2025 01:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742521556; cv=none; b=PjyBVl0VfG63JnrjQnOCCrYrnvF7sdsZmgRwLINE8b6Ts8yzIanXa8J9zlARr0vajxSPJyINSAANTu8XdIY9fQ3vLJiUb6ueCnbszxOQYCBUt2pBN+bDVNzzU++CBbON7H6Zj89cEg3i+y7dZP6hEHiEFQdnqwUmIcRO4dm0tAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742521556; c=relaxed/simple;
	bh=JOHxu32s2gWzOzGtnauf1ccVRaAoXi9BmLr/LYQ7R68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcUi/8c3+9EFxTeqfrZ/MGgOKj1l5skBYYG7iX1vtb/1+n9tIVmlWr0s58bWKznJC7N5oOCjyK6NPkz9q22hwn7OAo2KMIi4JI5yxfI7Rv6RukMsq4JlvFEiQ2EBlNELyw8wr65YachogDQs0U5VbyVgQN4kBXNEfKU6FxzJoqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYJ0oPyX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYJ0oPyX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D4FC4CEDD;
	Fri, 21 Mar 2025 01:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742521556;
	bh=JOHxu32s2gWzOzGtnauf1ccVRaAoXi9BmLr/LYQ7R68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SYJ0oPyXz0W+mrEDb1sw0Tox0vYxjHexvfVlDqm5H9wKrU/uGROduZgyyO2cZJxjR
	 jp7CUoQWbQUT1Ulj/3wOO2nkbD973FC77eMZDW6dBct3KBVyizmBIZt7a14BQt9gYc
	 mv3/Tos4ae3LJhGke99GoRDLjcKYwkTizRRDO9jCqOEOVxVWmBC+WExB1Dt8+8lJHd
	 ttMwDTLTWQcIBhZOTbqHnF8U+5inY+HWo9RJOrlkUOHJTgH7CmtDCT7KIJZVj9XGba
	 MQ0mTX9gxCfhhXVWRw1fgG6QJPYq1Alf1MKTb/5FzuYx0m3bou+b/+yctMLXdsDrTd
	 wHn3BSEIPbqiQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 10/10] mptcp: pm: drop is_userspace in subflow_check_next
Date: Fri, 21 Mar 2025 09:45:04 +0800
Message-ID: <7d236597235768dcf1885f317acb767840cb9e42.1742521397.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742521397.git.tanggeliang@kylinos.cn>
References: <cover.1742521397.git.tanggeliang@kylinos.cn>
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
index bb456e203665..a3fcb335c717 100644
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
2.43.0

