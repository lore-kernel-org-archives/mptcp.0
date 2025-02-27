Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312E221CC7A
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 06:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740638659; cv=none; b=ZFCGdiiL1SQ2KN0re2AP2MEjbSZcO2iMgnguP+hzzLZ4VVgiiaLZ3L4SiV42OKDtOHl1Vs1D8b72Yfe1y9s+gwa2GNm1t1bI5ODFLlwvvkBzvVNqRO3WCSPDvyWkoX8MeMlISRnNkf2FZGCHVI2svzzypY36x2i51prNvq2izds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740638659; c=relaxed/simple;
	bh=gxuTkKbOCy4bu9PXasmL1Uor5onEMyuwFWhPMFeTMhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=furX1DoQmsbQJD0p/oByBDAKkhad6W4EvSNhRG7bz3jiVkUcExnlj4B3h+qgIdR4dJd8M3VbIlTmNZq6GyKcOGjKsDtVufwhRuWKD/IxFCC2X22x2POCj0WIBF/ZWHNr5U+1GZ1HFjmVxg2j22KaMl4ZmKgIJEjKd/oZxAcdYbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3Dkb+qU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3Dkb+qU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E6CC4CEDD;
	Thu, 27 Feb 2025 06:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740638659;
	bh=gxuTkKbOCy4bu9PXasmL1Uor5onEMyuwFWhPMFeTMhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E3Dkb+qUFi4ZFkwwh9iSiv2+yOBQqH6H9xZiGdg6TQ9FGWh9OmSS7uq04uiQK+16e
	 CyJMt7bjBIUSjt82NYOSaXwutKf0kZxv70S22dAy5Kb5q6fD/DMEjeh2ysyq5qHnGG
	 B+IqmE2yajfdIE6RDo6vR8yPo1dBSzSD8/b8YymxVos6YFt7VAXovP+fQDZdGZZ6mq
	 fkethGm1nlEKdkttJCt50E+EbfGxOXf3Ovnf6fpOjOeTANPOeAFoi9LAFr5zrIO509
	 ed5ADghlr6xsIPgsGkd866nqSiIEkBfm267R5Cp6f8Cvpkvay/JYbEO/53rRUUEYhb
	 2qeEmP2CC5Z1A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 2/6] mptcp: pm: userspace: drop is_userspace in free_local_addr_list
Date: Thu, 27 Feb 2025 14:43:53 +0800
Message-ID: <c6d028fd4593ea6459a8625ebdea463043fb214d.1740638334.git.tanggeliang@kylinos.cn>
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

To reduce the path manager's reliance on mptcp_pm_is_userspace()
and mptcp_pm_is_kernel() helpers, this patch drops the check for
mptcp_pm_is_userspace() in mptcp_free_local_addr_list() and
replaces it with a check to see if userspace_pm_local_addr_list
is empty.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 5b3ee43130be..98fe8808d1e1 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -18,7 +18,7 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 	struct sock *sk = (struct sock *)msk;
 	LIST_HEAD(free_list);
 
-	if (!mptcp_pm_is_userspace(msk))
+	if (list_empty(&msk->pm.userspace_pm_local_addr_list))
 		return;
 
 	spin_lock_bh(&msk->pm.lock);
-- 
2.43.0

