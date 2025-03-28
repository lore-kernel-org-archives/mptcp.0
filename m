Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAD9153BF0
	for <mptcp@lists.linux.dev>; Fri, 28 Mar 2025 04:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743134509; cv=none; b=ODusfLAlKqq8VmC7xP0rQg4vnbWNo2FsxCJtBHortebfo1XX/AxwBiOiFqVBMbHSB3jVe2M8OW1cR/0pJUvu4UlktWnqGreY9hbDJ+UOR3Lr6lAQd7MC4ebK/z1t40f6meO5zBXlSMiJhl5xAHsbH6d90Ron3ZrfVzI42zcbABI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743134509; c=relaxed/simple;
	bh=CkwURKMR0Xnl/UHcQBVP6kPm2ThnSRWYyXX3JmyyL7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spIK0goSkrc3DrfUyDdSrC2jBdQZLyst/nwgtU4qTXaQCbn3xA125ygdoBd/sCBc5XsHG29bQVnJg+2vLzP/z5GfGHLSmfC62ITrp9iv6nmEIfIe0wazppGbu8YmuAdnnpl/23VWypfiCIw7qsXtb0sveWvAoy/eowUeZ5drcC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phL2Cw3b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phL2Cw3b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752D7C4CEE4;
	Fri, 28 Mar 2025 04:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743134509;
	bh=CkwURKMR0Xnl/UHcQBVP6kPm2ThnSRWYyXX3JmyyL7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=phL2Cw3bPksAhK5XH31yOEjKuy++mCoE4wEMT6lhVytrBEO5tmGSx1/3G4yzaYKbX
	 YTFGxon/AbBAqC87Sc9vCPl81ilSOKQy1vV5HoiFOKQGRvI4KsOTrFX4JuCkVkZmGG
	 A72XcRNPZE6pwvIB02gCo+Tz+wXfa6kxOa1RzHCOmkbPpBWON/jgylxJ2cyE4Sg2DK
	 6zH2lQmwalwSmJbHGiEd9qhYMoGBtDafQhEqC6/i3WFfnJdJaF03V6BOKpFF6/rYZ2
	 zvFZM6URhqIAVwDMVtRvsIqkB8LxUdGPIhgVOjyzuDvKJaI2/ijLPHFJK6eYKom4Lo
	 tE5Sc8CVp0JvA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 5/5] mptcp: pm: drop is_userspace in subflow_check_next
Date: Fri, 28 Mar 2025 12:01:35 +0800
Message-ID: <fa7f97455f81117b47e9f11742c894752e791f82.1743133948.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1743133948.git.tanggeliang@kylinos.cn>
References: <cover.1743133948.git.tanggeliang@kylinos.cn>
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
index 673313b9b25f..d576b03a64e1 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -559,22 +559,14 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
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

