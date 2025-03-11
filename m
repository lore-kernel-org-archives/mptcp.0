Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D55C53363
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 06:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741674246; cv=none; b=aG1iIGhMYVUPeidczWYG/wOmhKLaZlXo22zyx1szJAG+8r931/7SJHkFhjdgl5JBYB4PcdpViE6VjwmZXYObbhkBuRPei4jPOKI/lh9q2bSAKUgAzqrjYyiL/IokA7aMaHx4U7kXd4iMKVxlRPFKWy4ApL/kfHyrbIZ8vtOUetk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741674246; c=relaxed/simple;
	bh=6xXcL+r3z4agqisrZFHoWuf6TafXWf/LUxOxUbooNAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISTF5LwfcVzLQF5vmgOmlg8MUq6pZ5CKAslfbQPnAU+3w82OSYBgadVmQVEKVbb+9LUisPmudxO3HEmuvYOHV5iPHe/bmAHcT4ZxhwSjQxNB+x7qTNM/6cklwd10QhQcTqYM3/eC1HrdWL+pAE0Pe3Wmh6PWftOU647WzDA+hSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7mnJmg5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7mnJmg5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAC9C4CEE9;
	Tue, 11 Mar 2025 06:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741674246;
	bh=6xXcL+r3z4agqisrZFHoWuf6TafXWf/LUxOxUbooNAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X7mnJmg5YAby9f/7INDwJXmDw00WKL2FGo+ys4lvrp6G5ipYmoZIL96fP1EXk6GHq
	 /aIIx+q90KUmqBrPqOn5FSsJ5yJkn6tWyo9U3WINZKWsiGLpVBJmXQ/HF44pFwgtiA
	 h/3ETrXKyT7IIA8Cpb28FxsHYO7AbPDzIxu20pdv6jFdKg5o2EflAKt8PfEtmjBN+1
	 v7zPv7jaHQ317rdaKMawW6agUPz3cd2d7ONMRuQdP9MVZ/QpNoY4+kidiqQa53+Isg
	 a2Racw1+fz9y2pLlzMNh9B8qFjCoqePG5h3wewFqgw82bphmeAH//nn0DgZxWvEyxY
	 +IgLcM6Oa6iEw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v2 2/2] mptcp: pm: add struct_group in mptcp_pm_data
Date: Tue, 11 Mar 2025 14:23:55 +0800
Message-ID: <1744ec29cbe7f97f0be41322efa6d782404013ca.1741674102.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741674101.git.tanggeliang@kylinos.cn>
References: <cover.1741674101.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a "struct_group(reset, ...)" in struct mptcp_pm_data to
simplify the reset, and make sure we don't miss any.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c       | 13 +------------
 net/mptcp/protocol.h |  5 +++++
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index af009661477b..85ee999729a1 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -978,10 +978,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	u8 pm_type = mptcp_get_pm_type(sock_net((struct sock *)msk));
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pm->add_addr_signaled = 0;
-	pm->add_addr_accepted = 0;
-	pm->local_addr_used = 0;
-	pm->subflows = 0;
+	memset(&pm->reset, 0, sizeof(pm->reset));
 	pm->rm_list_tx.nr = 0;
 	pm->rm_list_rx.nr = 0;
 	WRITE_ONCE(pm->pm_type, pm_type);
@@ -1002,15 +999,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 		WRITE_ONCE(pm->accept_subflow, subflows_allowed);
 
 		bitmap_fill(pm->id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-	} else {
-		WRITE_ONCE(pm->work_pending, 0);
-		WRITE_ONCE(pm->accept_addr, 0);
-		WRITE_ONCE(pm->accept_subflow, 0);
 	}
-
-	WRITE_ONCE(pm->addr_signal, 0);
-	WRITE_ONCE(pm->remote_deny_join_id0, false);
-	pm->status = 0;
 }
 
 void mptcp_pm_data_init(struct mptcp_sock *msk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3492b256ecba..b5c945064baf 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -223,6 +223,8 @@ struct mptcp_pm_data {
 
 	spinlock_t	lock;		/*protects the whole PM data */
 
+	struct_group(reset,
+
 	u8		addr_signal;
 	bool		server_side;
 	bool		work_pending;
@@ -235,6 +237,9 @@ struct mptcp_pm_data {
 	u8		pm_type;
 	u8		subflows;
 	u8		status;
+
+	);
+
 	DECLARE_BITMAP(id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	struct mptcp_rm_list rm_list_tx;
 	struct mptcp_rm_list rm_list_rx;
-- 
2.43.0

