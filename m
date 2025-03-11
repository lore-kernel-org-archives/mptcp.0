Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD2153363
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 06:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741674244; cv=none; b=DFCVNClS+PS88a4B+v9NvuXB+kggAik0XakA7jXdlAqeTVx4jCsPGw1fYY6o41u80WIoIhq9DG568HANaEmR+Xswm08i9LyfqYCKMf9hgg7WCcigjBpRfF9yxlilb6ziz8kQoo9NJk1ZnyG5j2I5kdAmaJjcaVaPM1OJkx78HpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741674244; c=relaxed/simple;
	bh=qyH7G/PSrMXfa1UWBsjNGo4uFAVc4sOS709CgM1Kw5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKnBBynbwN+noZLgU+S8bBbZBlR3vf9hxhI2P9l5xQtnGEEr2IoQBASa0WhvMMOF6Pf8OQkQdqZrXRwz0PK2nkNCWpjDSdx5IJ5XIs2jyo20yiuSferJeq3zhTC5FrBnyOgCH/XqlfAinr7ryPdMXEDR4ZP0DrX90GOCsyLaFrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iw6jQ6PU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iw6jQ6PU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30EAC4CEED;
	Tue, 11 Mar 2025 06:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741674244;
	bh=qyH7G/PSrMXfa1UWBsjNGo4uFAVc4sOS709CgM1Kw5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iw6jQ6PUcQJyXCuuW+/2RDMV5DXFcEHAHQGUxR5gBdkGsHIRQw4aSv5tovASo136G
	 Gso3tRH7sbLp2nl2tc/qsJyANm8jgDsUUFoq0l5xskGI6HXpm0e9CRvNT5ou6OZb1G
	 QTao7Z1mQg5of6Yv6PIIiYYeuJ1SkuGwyBUXOAceWzhms9yNRyvgjn38+SFeHrMQcW
	 +00bGWuFEeEz1VNLEscNP0fOWw8Ov+11iDKO9e2tGCct9ZCtWzRobyEjlkj7VoB7Ro
	 KCFqCupEXdR4/eoZfk+by2+SZ9bfGOjtwoTujK1nxK09esUp5D376BvXubjgsWDIm1
	 2nKM1uZQ+F5Mw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v2 1/2] mptcp: pm: only fill id_avail_bitmap for in-kernel pm
Date: Tue, 11 Mar 2025 14:23:54 +0800
Message-ID: <39394e46c5ac35184aac9e12da8aab530a0c0ea2.1741674102.git.tanggeliang@kylinos.cn>
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

id_avail_bitmap of struct mptcp_pm_data is currently only used by the
in-kernel PM, so this patch moves its initialization operation under
the "if (pm_type == MPTCP_PM_TYPE_KERNEL)" condition.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 04a156395aad..af009661477b 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1000,6 +1000,8 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 			   !!mptcp_pm_get_add_addr_accept_max(msk) &&
 			   subflows_allowed);
 		WRITE_ONCE(pm->accept_subflow, subflows_allowed);
+
+		bitmap_fill(pm->id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	} else {
 		WRITE_ONCE(pm->work_pending, 0);
 		WRITE_ONCE(pm->accept_addr, 0);
@@ -1009,7 +1011,6 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	WRITE_ONCE(pm->addr_signal, 0);
 	WRITE_ONCE(pm->remote_deny_join_id0, false);
 	pm->status = 0;
-	bitmap_fill(pm->id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 }
 
 void mptcp_pm_data_init(struct mptcp_sock *msk)
-- 
2.43.0

