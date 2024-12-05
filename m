Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0C7653
	for <mptcp@lists.linux.dev>; Thu,  5 Dec 2024 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382922; cv=none; b=CkuEKK44pxFa7d/a03Cqs8fCQ2dV3Cs4sdjFZOWsIJZsBNAdfAdsPllZFuhY0JuV6tlNroIkXWwbpZG39HlxFHBIGHNRxtzjOdhwoyXqz/SC9glG+JyvjugJQY0NQ7vbS8E2WtqI9A+hN+mdCJG9HkQAI+5QMA1HZlkXnBq2PYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382922; c=relaxed/simple;
	bh=bMsOP7bqSA9DUccHz7v6v8BVuLTwcmSYXGyZaxT1AJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+NexxhtX7O68TY3soxzUkxM/Q9rEUinVmkNh4xUZO1YYkN903oW8u0UOLpr4wt822QJcy+6+nVGO0bfWXbczWh0hI5tlcB4zqnzxZ5d+i4xOw7LsTqSt6tRZ05pxsgPZi+vYMKw2rhVqY0AEKWlwE3m4hxUl2aQy+KUy/HckB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4NbNN61; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4NbNN61"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0FBC4CED1;
	Thu,  5 Dec 2024 07:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733382921;
	bh=bMsOP7bqSA9DUccHz7v6v8BVuLTwcmSYXGyZaxT1AJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q4NbNN61ODtgTWnm7uxl7MCxqZnsqWZRbZfOwIGdcjpWfIHt5ASuEC0l5iOugBpNG
	 P2RUZqjfSqBChWB3As7uvD4dN+l4TdG0UjiPhlQhMSwslD0DgOW00jOO2qebHo6hu0
	 F9qY/75o3cLCt5Ttp5HtB5M5Yi9AP7MDbciwPdenmdxXdI/OLTLm5mp4QvT8a8U8u/
	 dplce2p5xFWpQgT1sMv5XChdmYuyylzshArVla1J4//D3Zz+p5srYS+omWhNsRQYjp
	 0CDRCmD3RfcWQOHPmbf2HS6AgVxG5yEk7nNJNUWLnHkvQ37w2cR6fUwa/8qHP3saI0
	 v4Z8geOM9F1wA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 7/7] mptcp: drop useless "err = 0" in subflow_destroy
Date: Thu,  5 Dec 2024 15:14:59 +0800
Message-ID: <5e7c6ebc914c22053389526d1a29b2e5d89be4de.1733382223.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733382222.git.tanggeliang@kylinos.cn>
References: <cover.1733382222.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Upon successful return, mptcp_pm_parse_addr() returns 0. There is no need
to set "err = 0" after this. So after mptcp_nl_find_ssk() returns, just
need to set "err = -ESRCH", then release and free msk socket if it returns
NULL.

Also, no need to define the veriable "subflow" in subflow_destroy(), use
mptcp_subflow_ctx(ssk) directly.

This patch doesn't change the behaviour of the code, just refactoring.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index f6ac4cd3b6c3..2bb5c0ded22c 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -537,19 +537,18 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 
 	lock_sock(sk);
 	ssk = mptcp_nl_find_ssk(msk, &addr_l.addr, &addr_r);
-	if (ssk) {
-		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-
-		spin_lock_bh(&msk->pm.lock);
-		mptcp_userspace_pm_delete_local_addr(msk, &addr_l);
-		spin_unlock_bh(&msk->pm.lock);
-		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
-		mptcp_close_ssk(sk, ssk, subflow);
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
-		err = 0;
-	} else {
+	if (!ssk) {
 		err = -ESRCH;
+		goto release_sock;
 	}
+
+	spin_lock_bh(&msk->pm.lock);
+	mptcp_userspace_pm_delete_local_addr(msk, &addr_l);
+	spin_unlock_bh(&msk->pm.lock);
+	mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
+	mptcp_close_ssk(sk, ssk, mptcp_subflow_ctx(ssk));
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
+release_sock:
 	release_sock(sk);
 
 destroy_err:
-- 
2.45.2

