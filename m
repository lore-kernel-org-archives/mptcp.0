Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8E61FCD0B
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072589; cv=none; b=QzuXEwVtq/WKgTWRiQWZMGi496bAA4Ts52rvSy/qKd76rZLwoagKrpE8IDudLGTcokpr2wQoG9z/0Fw9FJn8aePs6Nba15m4NNN99xSYLx40BN4CFFP2+CxgFjR7ryEw54LlyTJtnUhh7Nr1bfqIiZH34nZ3zus/ZuO0W1SjugU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072589; c=relaxed/simple;
	bh=TDW9QKyXUIkWBx5kgnb5kR50lq3izZWsmoF+n6hArnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fp9ZxHaC+AFhg4dKNZbLQ1HrxqaSN0rNAI6H/YKDyb6W/nAoIVlnntllF6qlrJk0Jry8pkgQpEW/EaeeNDhYaQrSeQtKYFF8kRAiz2oQYTiHU3LNoiZNJTL3nyYeiQuLGHcyYr8iQGqY9eLoES6Z1uGPx6fXC6bXUzYJ5XR+X3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYLMFQr3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYLMFQr3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1544AC4CEE5;
	Tue,  4 Mar 2025 07:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741072589;
	bh=TDW9QKyXUIkWBx5kgnb5kR50lq3izZWsmoF+n6hArnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CYLMFQr3oaEzBVjFWiQqbEvE+dAlyZVqO+pdN1beIhuIAMse5/SClcln4mXU3P7Z7
	 5Jr5VyyCYcSv1QozMRAQWFXB3JmB+wPptfazVi1U5eIomfm/XYduRmJHCoM+JkWG72
	 goSpANW1qZ+lqb8IvRf3fTPO8EbwYaPSLb2dF95RGH3LoRGFC1+1DONRM67Xe686iA
	 kEI96l148qXPRq7eoUJdhgD4FJdLxjJTAhIuchUChdgdE+X35GauTw64UIO6SsmbxI
	 tLTEWw1j3BDO4YknweHTgVrFg+Qh0Kh9zjFzeytnkFwUCyFqJSAbysk3xcsMcWIAT7
	 Nng9s2PkweF2g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 2/2] mptcp: pm: use pm variable instead of msk->pm
Date: Tue,  4 Mar 2025 15:16:17 +0800
Message-ID: <b3fc56c8fefef00d42c064da81ce13b138d43103.1741072099.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741072099.git.tanggeliang@kylinos.cn>
References: <cover.1741072099.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The variable "pm" has been defined in mptcp_pm_fully_established()
and mptcp_pm_data_reset() as "sk->pm", so use "pm" directly instead
of using "sk->pm".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 8e6a325a3898..04a156395aad 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -511,13 +511,13 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk)
 	 * be sure to serve this event only once.
 	 */
 	if (READ_ONCE(pm->work_pending) &&
-	    !(msk->pm.status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)))
+	    !(pm->status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_ESTABLISHED);
 
-	if ((msk->pm.status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)) == 0)
+	if ((pm->status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)) == 0)
 		announce = true;
 
-	msk->pm.status |= BIT(MPTCP_PM_ALREADY_ESTABLISHED);
+	pm->status |= BIT(MPTCP_PM_ALREADY_ESTABLISHED);
 	spin_unlock_bh(&pm->lock);
 
 	if (announce)
@@ -1009,7 +1009,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	WRITE_ONCE(pm->addr_signal, 0);
 	WRITE_ONCE(pm->remote_deny_join_id0, false);
 	pm->status = 0;
-	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	bitmap_fill(pm->id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 }
 
 void mptcp_pm_data_init(struct mptcp_sock *msk)
-- 
2.43.0

