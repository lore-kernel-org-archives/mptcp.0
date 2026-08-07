Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7914940DB2E
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092129; cv=none; b=ayP/Ezl8EAU+anig5Z7OA5f9rGTtkC2BNinRVIqP7KtC3HsBfNyzcmj1SKwxdPofN7d0XRSc9zM8fAyURgq4yYd41I9Q/cBFGTda+ok3EjRTUWSFZUvwVpoXZdnns8j5j1Ybe0USUuJiTWY0aJ6daDWSmqcqgto/ugJoLCdFtXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092129; c=relaxed/simple;
	bh=pVlY5V1NdZnRmS1Bty8FhCGUI3wTuQyo/9EimjK5A2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ct/qJqAWUPP1pvkoUFrCwYgpY9E63/4gmO3GJeDDY1JKZBxxI4ZJM6FafQIxaWtU3LzfSHae5NsLbVbZoOt26sBsB57nYM5t1+cfRayRrH4h3F1bUhHZho2EqvzM/+IvKxcyDdftb0DOYeJ7LRlXRC2N/j+NV1M8wvCc1VNR5U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyJ75GhN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyJ75GhN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA9D1F00A3A;
	Fri,  7 Aug 2026 08:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786092126;
	bh=4WRRWXYFEP0SFsYWbYx26UZhcenm1tKE9W3RVC8waQk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DyJ75GhN7hmbh/Xv0oTxXMVAGXMfUM8344S0ooQEGDGmtqQcLHgpfkOFm1ThmNPIn
	 NUliJiJy8mMxeuTtJEqemwjJ4yE0xFT6+SxApNbhjWWsBrXerjEnAz/PoNdH2LEiPT
	 l+ZBZrWg9ZNo9fPg4Dp6zWe4z3Xrb56r4fgjTPRGVUb2IKr8yrMA2php7lubffVMmi
	 72sX/kKVtUPQB0FnR9ptJyip/iWEs3V4y4fZKc6fE3KRdMqTPqaM6O1xzyMPe62SCV
	 kligEBXJf23KumR1b+DyJMAL2jSZtiQha+PpfR5cKkG0UH057RU++YwvNn43cALzcH
	 SSIyZZ8hX4HGg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Aug 2026 10:41:55 +0200
Subject: [PATCH mptcp-net v3 8/8] mptcp: pm: restrict in-kernel worker
 actions to this PM
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-mptcp-pm-userspace-id0-case-v3-8-de9088549924@kernel.org>
References: <20260807-mptcp-pm-userspace-id0-case-v3-0-de9088549924@kernel.org>
In-Reply-To: <20260807-mptcp-pm-userspace-id0-case-v3-0-de9088549924@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=784; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=pVlY5V1NdZnRmS1Bty8FhCGUI3wTuQyo/9EimjK5A2w=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJKZ4Vf/Lj4+YX/U77tCy7b+XyW8N5ZzW83ZU3oERXi4
 Nq+88j9FR2lLAxiXAyyYoos0m2R+TOfV/GWePlZwMxhZQIZwsDFKQATOWXPyPCb7e3zKQVXLaZO
 OlMl+OlaaV0/c57OHbaQL26tm1z3HZ3P8D+uSpPvUOjpVv+p94tPBN/LYMg4tVW3yeyO69KWyu3
 m5vwA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

No need to check them for the userspace PM.

Fixes: a49eb8ae95b8 ("mptcp: pm: worker: split in-kernel and common tasks")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v3: use !mptcp_pm_is_userspace(), to handle WIP BPF MPTCP PM
---
 net/mptcp/pm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4ff12fe25d0b..ecf123526786 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1141,7 +1141,9 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
 		mptcp_pm_rm_addr_recv(msk);
 	}
-	__mptcp_pm_kernel_worker(msk);
+
+	if (!mptcp_pm_is_userspace(msk))
+		__mptcp_pm_kernel_worker(msk);
 
 	spin_unlock_bh(&msk->pm.lock);
 }

-- 
2.53.0

