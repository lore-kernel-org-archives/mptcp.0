Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA2E1FAA
	for <mptcp@lists.linux.dev>; Mon, 17 Mar 2025 03:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742182181; cv=none; b=VpZXVcIz1r7ed/9e5BBiPgH7Qx+XHpl3BOEpCAsRm1EGUmbpi/QxdaFNceyL3izNx6rDcCvgR8dlk9LgAC3z6a6tCu3dZjtrg+4erWgbDd2EzUPv/tPDMvC9XO8LjKqJz9huc8W/Z91X9IdSDX30QKK4jR7HGBaS40f3BA9nAeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742182181; c=relaxed/simple;
	bh=+BHezsHc1gqy99U6METqoEda3MyfLV9kcSSM37rajjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQkvAaieocE3HKYBpvbYX+3nNeWpJvF02p4oBJ7eOvxcAL+DNUdPoyRGaz2OPxq+SisPZdPhYebgeEDwt/D+lbJmiVbpzu3yz1bTE9FrFNSRXuD2W8y71HKHcwJ9s4F10KhL3M0fsytYUYVv75oEg7gOXGTg0gXAOHu4xVCJ1ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JklmXRPP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JklmXRPP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA761C4CEEC;
	Mon, 17 Mar 2025 03:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742182181;
	bh=+BHezsHc1gqy99U6METqoEda3MyfLV9kcSSM37rajjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JklmXRPPYgoGo2spiZc+aXqMHKC51gUlsqPW+pBpCwZoTLcN+JggZwNBIe710UZoT
	 YGqw8gdOYC+756cVm4cVLZAApa9X2YQomt9wyoHw3+8ODJEEBW2iRt5jQTJmQv1hYI
	 hgedbSanvu+Pt/1VWVdT5XTRJjsNw5iRqm1wJmCcp3AROL6n6CtcFzU3TDMmzau0bn
	 tZmiO271R2Rl+fDdEVmFc9GX3LpfvyUhhuOVLrullVyOc53Q3+5e2Vt8DwxuwqX2uP
	 qV2HgxTf2meiJ5Xwv4xvsp7x5zV0oL5VdbPdcPI5oSWv4BIpJQrYo8YpqaoLwbaVIM
	 UTEuXTqXQRPzA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 2/3] Squash to "mptcp: pm: add established() interface"
Date: Mon, 17 Mar 2025 11:29:28 +0800
Message-ID: <2979f2af3a16e17153a22a2ee6b6dd254a75bd3b.1742181977.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742181977.git.tanggeliang@kylinos.cn>
References: <cover.1742181977.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Same as .subflow_established, .established can't be invoked under mptcp
pm lock too.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c        | 2 ++
 net/mptcp/pm_kernel.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 38abf15718b9..788fbe31a40f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -938,7 +938,9 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 	}
 	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
 		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);
+		spin_unlock_bh(&msk->pm.lock);
 		pm->ops->established(msk);
+		spin_lock_bh(&msk->pm.lock);
 	}
 	if (pm->status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED)) {
 		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 0c78715ed87f..f8cac996694c 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -369,7 +369,9 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 static void mptcp_pm_kernel_established(struct mptcp_sock *msk)
 {
+	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_create_subflow_or_signal_addr(msk);
+	spin_unlock_bh(&msk->pm.lock);
 }
 
 static void mptcp_pm_kernel_subflow_established(struct mptcp_sock *msk)
-- 
2.43.0

