Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FEA422542
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172937; cv=none; b=tTUY/66DBWTE0eOM8AUee42VewqnGMgMUDLf6xeuZwCkC4rM2F+8jZGxUMdVdFYIxblsOGkFmf4mH1e9Yb+pRj5lsZ6Wgvjzh1IJMHA2soaRT429q2027dXXCV/viINGMBi1tz7DuMXjERLHGxcznwrcy5q7d0LhterGJAaiISw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172937; c=relaxed/simple;
	bh=HK9L+6tl3LujYYtnelP5O+OSxu6zrrP1LJK/5MtqHoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=usRTblsfDBMXsELZyxGwp9GxUEpPZLErVYwS03sbCIhuA5Rd3qCSld+9nXiu6CnAZ13X0ZxhUGPO5G80S8cpPmjLurqfotLHyUB9RApC9pVxU6xw4Evi16zYOAkO7hlIWvX/l5HAP28XoVFrZV7VdZEyunoQ3uLaZeyoE0d174s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6TLxPct; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6TLxPct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F661F00A3F;
	Mon, 27 Jul 2026 17:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785172934;
	bh=wxqlRLSfsSsYWTiI1qlo0C2/ebcerc8vCmW30va7YjQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=X6TLxPctnK8hzVpSoXxcUt2PF0O3/1g4iWvzWkhK9f7s32qMcDh9pGkodVRlHDJih
	 IXX02fLoRdNSOxUKKawdeaPAKyHGufULeJmpiFniMJ6u75sVqAWOceq4OVOw9HNBaJ
	 uFpMxTZ9zWQMkl9LUIQ2B8pAoSuo5UfJZo3gdG4sPwDuCaLrHj0WqNkfJ4VPmM+nMa
	 ZpzMASGgfoc6wsmuq4BY9sE4bycoRK+IaLtqwfy2RuH/fKrCmenvvd89z89n4IdpYo
	 be64OGsPTe+OASeu1+GEDh3zZ3UqDftIoM/jOBDJI5BSvbqF/XkeL/Z3LwP2t4CCv8
	 3A+UFgpwBEN+g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 27 Jul 2026 19:21:55 +0200
Subject: [PATCH mptcp-net 6/6] mptcp: pm: restrict in-kernel worker actions
 to this PM
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mptcp-pm-userspace-id0-case-v1-6-9877f02a9bae@kernel.org>
References: <20260727-mptcp-pm-userspace-id0-case-v1-0-9877f02a9bae@kernel.org>
In-Reply-To: <20260727-mptcp-pm-userspace-id0-case-v1-0-9877f02a9bae@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=713; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=HK9L+6tl3LujYYtnelP5O+OSxu6zrrP1LJK/5MtqHoM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLSJx84x8+lfdz82bI9k/tlI9vq8hw+vl20oOPow7w7f
 4JW7Ezt7yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIoQUM/+Pn3VaeuqTxlNiP
 CQtL3F0jNHhvPmOM31PKLzn5ecbm8/8Y/iceVT96k3PWZMNfJmbr5TrctiZ83fhPSeZI9vxJv/z
 ebuEBAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

No need to check them for the userspace PM.

Fixes: a49eb8ae95b8 ("mptcp: pm: worker: split in-kernel and common tasks")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 8421048f1a20..9bb2da3956b9 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1138,7 +1138,9 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
 		mptcp_pm_rm_addr_recv(msk);
 	}
-	__mptcp_pm_kernel_worker(msk);
+
+	if (mptcp_pm_is_kernel(msk))
+		__mptcp_pm_kernel_worker(msk);
 
 	spin_unlock_bh(&msk->pm.lock);
 }

-- 
2.53.0

