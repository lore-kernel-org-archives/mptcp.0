Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9847C193
	for <mptcp@lists.linux.dev>; Mon,  9 Sep 2024 03:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725853567; cv=none; b=QBV1Rv3r7Hz6E65bqXs9kgWAyq1F4jzcK5bg9BLOAyTw/oXGG9lpSeFwcSNrWNFZT71yS5iBx2yjyEtsRVyH4i9ZB2BtyL/Rgon79qczGAfXagQUKSccf+CHf3yGCf8dBrfu6hjrEK4TuAXvEd5o8PRZQG+ga8JXulw2Xvfab9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725853567; c=relaxed/simple;
	bh=YNj9H09pZ8af6W51VC2jImFXex8KHQ3uU2eQrRE+X64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svqk8Fb5RFtUu6AORqMlGQWBFMFu4HuDybHMciYUX4HW8pIXF2FEBVeQJw7GML3yvRP+FSlpD0qrrGNGrsBZFoGTEMTvnczGnvQlJgSiiSfo0jAxT3GCEd8F3SHvdFca1+8Dzw0cu/OZ1NGlEIT1L8t0xbh2THkeSP0Sb0RdIJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNlinHl1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNlinHl1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACA8C4CEC5;
	Mon,  9 Sep 2024 03:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725853567;
	bh=YNj9H09pZ8af6W51VC2jImFXex8KHQ3uU2eQrRE+X64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XNlinHl1lBLUItF3eCH7P4s+ovoWAXcxJ6PvxolUctfW/WZEa3UZ72jSIxFIJwuWf
	 7gJMnXZ7Pp9t2yu1gFoC/hIOEAZ+F32fQezwaO3B5gmuGMUIsmmNIw0lUvKPfyQoHk
	 LpnKKWovbWjkB1JkPh2LT9mx2e/tiLzzhzX2Du7P6iJIDBfU1vySx+pjLwflUjYIvo
	 jd16RA4YgDE4pgNe+uN1vqFab20sgDmigki50RykWjOL2Tl7+R1Zpq50+wfloP6pqp
	 lhhcaxiXDvCDfbQNaYth7O5onapcc5f0kw67fGtyS76U6vHZjbQEYZ8QCGeVCrYvNw
	 kPOZuR1k1Jzxg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/2] mptcp: add back mptcp_pm_subflow_closed
Date: Mon,  9 Sep 2024 11:45:57 +0800
Message-ID: <eaf475e7335131061c3a0cea0e6320e956657084.1725853370.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725853370.git.tanggeliang@kylinos.cn>
References: <cover.1725853370.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The MPTCP path manager event handler mptcp_pm_subflow_closed interface
is added in the commit "mptcp: Add path manager interface", but removed
in the commit "mptcp: do not block subflows creation on errors".

This patch adds it back and changes its 2nd parameter from "u8 id" to
"struct sock *ssk". Invoke mptcp_event with the MPTCP_EVENT_SUB_CLOSED
event type in it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c       | 7 +++++++
 net/mptcp/protocol.c | 2 +-
 net/mptcp/protocol.h | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 16c336c51940..23f73f07a9e7 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -176,6 +176,13 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk)
 	spin_unlock_bh(&pm->lock);
 }
 
+void mptcp_pm_subflow_closed(struct mptcp_sock *msk, struct sock *ssk)
+{
+	pr_debug("msk=%p", msk);
+
+	mptcp_event(MPTCP_EVENT_SUB_CLOSED, msk, ssk, GFP_KERNEL);
+}
+
 void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 				 const struct mptcp_subflow_context *subflow)
 {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a12149d8f718..69859eb2d891 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2515,7 +2515,7 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	subflow->close_event_done = true;
 
 	if (sk->sk_state == TCP_ESTABLISHED)
-		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
+		mptcp_pm_subflow_closed(mptcp_sk(sk), ssk);
 
 	/* subflow aborted before reaching the fully_established status
 	 * attempt the creation of the next subflow
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d25d2dac88a5..0c8ab6071a3f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -996,6 +996,7 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk);
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
 void mptcp_pm_connection_closed(struct mptcp_sock *msk);
 void mptcp_pm_subflow_established(struct mptcp_sock *msk);
+void mptcp_pm_subflow_closed(struct mptcp_sock *msk, struct sock *ssk);
 bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk);
 void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 				 const struct mptcp_subflow_context *subflow);
-- 
2.43.0

