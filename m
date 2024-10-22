Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F22D2209B
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588535; cv=none; b=JZ3svbGf4Hcns9u7s+hvb/5ZDjZt7vs99m9WtFuJkl2Er1a6Xzz8zSyFi+HsUUQ9hWBoNkQh6VXMAhvM0it1LCllbhWBAzYb6fIPvob2nAH1X9dXFxMVd+fdBtie8MtstllOHYhTyynyJC4IuyHwwh6mHCFWB7ixwPYnm91BRUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588535; c=relaxed/simple;
	bh=YsHe0bGP/KKvztIaEHQpiyBhm7sWDCq1n15s9Sksd6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9HpoEJ0IaCayIOsuQ8OrdFABJwP6ceLzSVgZkmAKejNsudw/UtjtYjQYUPeLLtEfZgnB7LT1OZ7Srh12Nbi9PrBU11zvzgRvVRGUikOw3Tm503dTeBcSVqngq0fEBieEVzhNywqh9X1sghPWnF2CQO7rzNsueahv+NafK+GBOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVf7/EVQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVf7/EVQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCF6C4CEC3;
	Tue, 22 Oct 2024 09:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588535;
	bh=YsHe0bGP/KKvztIaEHQpiyBhm7sWDCq1n15s9Sksd6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IVf7/EVQkq5NRvBfpthC6w2SefbOLpNmrfDkbTra/iBEa2GxA2IefVLcIl2ML+mck
	 p+LSEkLHGyZnGa5PPRfJGdoVkjfI4W6ZFTQcdkLec1u1Dz4CguNPT2X2V6wxDoJ1BH
	 LWccsjDWRKwx3mEhy2vScfWIiH1UCNzoJMby8EbMjHbmj7F1ND3zc4eMAW39WSJPgM
	 LB7TQ7F/IlCwvCziIigT/16KQyoB5UJaw+lupkiLwlj0Dzi/Ajbf/J8f/yCdP0irZl
	 3d+MAuAHN6TGAbwTSE6IAWZ3gxSjFEnUw/tOTz+j5D+i6RVfme5gCZrSRxNeC2t5D0
	 Fx3bcZ6sWsF7w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 26/36] mptcp: hold pm lock when deleting entry
Date: Tue, 22 Oct 2024 17:14:34 +0800
Message-ID: <c6c136da73ad1b5f33b8c77c14296b045966dc7f.1729588019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729588019.git.tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When traversing userspace_pm_local_addr_list and deleting an entry from
it in mptcp_pm_nl_remove_doit(), msk->pm.lock should be held.

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 7c23f6f27626..3ad10d8062d9 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -310,14 +310,17 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	lock_sock(sk);
 
+	spin_lock_bh(&msk->pm.lock);
 	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
+		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
 		goto out;
 	}
 
 	list_move(&match->list, &free_list);
+	spin_unlock_bh(&msk->pm.lock);
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
-- 
2.45.2

