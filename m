Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C500204F60
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258920; cv=none; b=TJtdX7h4WhYcnYk7Bg/S5TDJBpqk2tVDyyx4lOrm8Vfc6LqQz2B5Yk/pXk/Xus2F8J15BmHWL21QC4Iqqxby1lr3BIytKq2vTvPs8HdWKeO4TZykHwdai5usacr9sJK+K/d4JkwTN+h4yx7fHA6VwoJD+H2vfOqvc4XNTwXZuWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258920; c=relaxed/simple;
	bh=t0XDHq24HksxSEVNEZxv/WPy0tqXUiPJ/OjxrpGT8Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNgFvFrnx9Ay/KQVR4hqr5h3OzWqDioUSU52P//QgxV0HOVE3piRF923Cbm/YYVKsusskklj1d/uW/DPS6t8fZy/j+C1Gw6zgJylNBqvhzgToUoL+fUJ58TVWcoj47FbbRDR34RzogISnjgnajSXmuxtlhP404Q2kWVR6GhOmt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzvSc+vh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzvSc+vh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21ECC4CEE0;
	Thu,  6 Mar 2025 11:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741258920;
	bh=t0XDHq24HksxSEVNEZxv/WPy0tqXUiPJ/OjxrpGT8Ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XzvSc+vhQYH7Bora1R0Io2dN0wDpMrMsCGxMKJprtTTZaioCk+4HLkKQwMfpUCab/
	 3c1ZK0Box1vlLUKJtMO5LgpnF/N29jfnUYJpvfSeZsmRry2dfbkcEOra3TCMIonXE1
	 FKfBdCE3UtU53+kMdnDPUyiXoJmkWJRpEIdFKupX6miPxDY4xTfP11cGm4wzn3ynzs
	 0ORUEUz5oQJY+mKiem5OgpJM35Ltl7w2tu1TK8iY8SNIa8jM14fk+6TNCperA5AEkG
	 GUw8xbRmRnicc3ASPVN7FwxCFxCjsQy7PBO09tzakFsEo8gbCMgP5QXySQpNev6jDh
	 lKYov8CrxH9dw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v10 04/12] mptcp: add struct_group in mptcp_pm_data
Date: Thu,  6 Mar 2025 19:01:39 +0800
Message-ID: <9133981edb83438ee10e6da9ef4e5cc6bf7f188b.1741258415.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741258415.git.tanggeliang@kylinos.cn>
References: <cover.1741258415.git.tanggeliang@kylinos.cn>
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
 net/mptcp/pm.c       | 14 +-------------
 net/mptcp/protocol.h |  4 ++++
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index eefed554dcc9..1400bfed4b0d 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -983,12 +983,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	u8 pm_type = mptcp_get_pm_type(sock_net((struct sock *)msk));
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pm->add_addr_signaled = 0;
-	pm->add_addr_accepted = 0;
-	pm->local_addr_used = 0;
-	pm->subflows = 0;
-	pm->rm_list_tx.nr = 0;
-	pm->rm_list_rx.nr = 0;
+	memset(&pm->reset, 0, sizeof(pm->reset));
 	WRITE_ONCE(pm->pm_type, pm_type);
 
 	if (pm_type == MPTCP_PM_TYPE_KERNEL) {
@@ -1005,15 +1000,8 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 			   !!mptcp_pm_get_add_addr_accept_max(msk) &&
 			   subflows_allowed);
 		WRITE_ONCE(pm->accept_subflow, subflows_allowed);
-	} else {
-		WRITE_ONCE(pm->work_pending, 0);
-		WRITE_ONCE(pm->accept_addr, 0);
-		WRITE_ONCE(pm->accept_subflow, 0);
 	}
 
-	WRITE_ONCE(pm->addr_signal, 0);
-	WRITE_ONCE(pm->remote_deny_join_id0, false);
-	pm->status = 0;
 	bitmap_fill(pm->id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0ef758d233b7..47710db243f4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -223,6 +223,8 @@ struct mptcp_pm_data {
 
 	spinlock_t	lock;		/*protects the whole PM data */
 
+	struct_group(reset,
+
 	u8		addr_signal;
 	bool		server_side;
 	bool		work_pending;
@@ -238,6 +240,8 @@ struct mptcp_pm_data {
 	DECLARE_BITMAP(id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	struct mptcp_rm_list rm_list_tx;
 	struct mptcp_rm_list rm_list_rx;
+
+	);
 };
 
 struct mptcp_pm_local {
-- 
2.43.0

