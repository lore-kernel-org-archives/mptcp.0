Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AA3231832
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786005997; cv=none; b=pdYEMCrEwq2P1dS1Z3Us9jl1mOX170tbaNI6HfSGQaOWwk5uu3csJIXvNm701ckargIcoQwqZOI69xMxJ7nafVUaLhk8qJHPSP+thKmMjRUQsOAT1L+X//wJY0w6LBeR7GRGyduJV/RNir+G3QJuvtBVleAl0XaW8We42Zu8p1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786005997; c=relaxed/simple;
	bh=WIDaibfPCb/hRcVG1H/uibVqODsxK8qORSYZJgbiMFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SW4a66eRdyKGFbSEsM5WouPpGxhXnGbQkceS5FLgk+2k6VRrv6x5VK9SEy/T7K1vLq0+FV2N30VSobTr/OHV8c8eoBAiueKSOBCWjSFxAIAoQ46Tzbw7sTJmM6fySRPqoWx+nQAUvW/hfHT86vi6K28R8xW9Dz8qGVJGOCPBSA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUtTVcof; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUtTVcof"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9471F000E9;
	Thu,  6 Aug 2026 08:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786005996;
	bh=BQ0dDdJpfJEk57RRec/1WhhKnmTWu2tj330IfarJZ2E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TUtTVcofjaIUJNy5x3/QDsGv5F9EcxcFnmJAC4w/NLDJhm/bKxFI/Y4aqGfoDYX3O
	 PlEAM701l2Te5Ii50zE4RZHfvkYCDQIZsuW2eU8WucKxu+ba9WMryDIrjVyz81pJ2+
	 AJCFxsADfxacReECVb3x8cnFVYCO5AbFTD+N8LFslvW9DgDrvtEhMjFUhgcJtwTbSf
	 vG7CZsYUlsnsbFtiFpkmn+6hyhrFKxwxdcl5ua1RTEgFeLy5YnNkEwqG70Ko5N1II7
	 Nu3WoKpy1maX8F7Q5eEB5KDQkjamwPVquEDg+LPZKxUR40dFsrPRk1qKrgGiFpyWok
	 KBwTTGC9JPxJg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 06 Aug 2026 10:46:23 +0200
Subject: [PATCH mptcp-net v2 6/6] mptcp: pm: restrict in-kernel worker
 actions to this PM
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-mptcp-pm-userspace-id0-case-v2-6-fea1808e1c57@kernel.org>
References: <20260806-mptcp-pm-userspace-id0-case-v2-0-fea1808e1c57@kernel.org>
In-Reply-To: <20260806-mptcp-pm-userspace-id0-case-v2-0-fea1808e1c57@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=713; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=WIDaibfPCb/hRcVG1H/uibVqODsxK8qORSYZJgbiMFM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJKPJ/xPjizJTP51SRd3d9pAWzXZ97x3ndubYvmFu5tM
 Z8lrBbO7ChlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIpOkM/2NuP1AtSGxYdN31
 P+ecG4fmZS/jU55hvUO2I+zJJvfghQcY/oeuef2gsTq5Mrz8Zva0+rdVKs/0A2x+f/jC/3OFlXX
 QGhYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

No need to check them for the userspace PM.

Fixes: a49eb8ae95b8 ("mptcp: pm: worker: split in-kernel and common tasks")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4ff12fe25d0b..da4c6686971d 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1141,7 +1141,9 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
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

