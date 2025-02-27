Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7F715B102
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 06:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740638658; cv=none; b=TzksbPAHiD9HrPdza+S/PuC+4uTwA5KN+ui6eiAXHz+i1VuecYhM5vjcamqsMhwmGOeL8KvHUf14jGTcEMesghqhq29Kx4WCZ0S4+Qmz0lvYsLxL/s1zyopjupGI4QocSwzmRnyDEMqjfrgI5byn8ktD1LKg5tvsxEwWpZo8ZFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740638658; c=relaxed/simple;
	bh=tqW2pLqpby6Lsmk545cvuFQ9KEh3v1bRWjP08sfAgzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PusG+Fo4qaiylNqHnMS5ispYaasd7FCKB8+kViawc86RoikRRUjlexlDHmiGg4/GcsINuhEuFn7Q1HOjKZmZ5xRGG3yGL/hYKt3htE8Rzk6klWDeYmIDS4J4lsSoCdqw5FzHATxrSWwrW2XBhd1q9jEPd1aipauEISEb+zb6Rfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hmonc6pu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hmonc6pu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F0EC4CEE4;
	Thu, 27 Feb 2025 06:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740638657;
	bh=tqW2pLqpby6Lsmk545cvuFQ9KEh3v1bRWjP08sfAgzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hmonc6puCJp67ljIQZAA+Rj7UgpRiOltQ9z94SbVMFgnkuZM4Fk75cTB23zWgfSYG
	 SNpAdO3u72W2bf+EQirTlvFIa8XuHqSlW5+uAafPD+vzQLfZCdWpMOSd+6vlQGavVI
	 TAqkiCGvsTQ2WPxCUvuJN8Uu9dw01Smma6K1RE6QN7wEWVTlCckFEw11yO1jmwrPg8
	 gRq1+9mFpymVb2puFyei3W8u/xSR6XM+1RkxLXi58qCCddeUvppOOMTDIBtp86QmPk
	 T+MXj1osm62Zgqu3ruFzgzb+SBcBZbZkv8kbk4dhcGAFwVgu6fUO6tz606xvlPfpLn
	 IU9TUFZowe/mQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 1/6] mptcp: pm: use pm variable instead of msk->pm
Date: Thu, 27 Feb 2025 14:43:52 +0800
Message-ID: <98c518824741870f215f7e388ae9ee40655ec9b0.1740638334.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740638334.git.tanggeliang@kylinos.cn>
References: <cover.1740638334.git.tanggeliang@kylinos.cn>
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
index ac7b39148bd3..1844107f6f93 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -139,13 +139,13 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk)
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
@@ -632,7 +632,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	WRITE_ONCE(pm->addr_signal, 0);
 	WRITE_ONCE(pm->remote_deny_join_id0, false);
 	pm->status = 0;
-	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	bitmap_fill(pm->id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 }
 
 void mptcp_pm_data_init(struct mptcp_sock *msk)
-- 
2.43.0

