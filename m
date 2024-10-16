Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AA917D378
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070012; cv=none; b=RbDcrR7NdZZoE4LT3d5vBkmEWc2iU6CveexN/FJJK9MeDiK/011o2HN9njmBoM/hFcVAt+DiVTgVQcH4BbEguj9JMKinM+Kfjs/mPFqW/MbqX5Npyl/CAM+WChjKTlocIle9MC5y9fkd7FgWM14EkkcpGgLnO5dmmGYjKO/+230=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070012; c=relaxed/simple;
	bh=5tiU3/NqMdSOpzLHTkGlUsiReoRGKrah8GYOP1kp7k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t82UxgpRPdCYDOFC0ui3ncwwoBxwPILFp+3JAItmeMQHvh1BDGSWA9qNLLLKqTemXtKk9HD6GUD8e2lSZW+wqrOD18o+nnb+PQqtwoJ6AkJgZ5Fepy1uitrL3LPVCaDzVl90h9+b/ph5+VZtIeMC2tOMGPv0PsyzTeWc98rUNTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9UQQvuX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9UQQvuX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080EEC4CEC5;
	Wed, 16 Oct 2024 09:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729070012;
	bh=5tiU3/NqMdSOpzLHTkGlUsiReoRGKrah8GYOP1kp7k8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z9UQQvuX+Yqv3CxQD+RCFWcQO9d+sLiOA2CXMNupaeMkWRYaBvJN/tgjfIhRc6GUu
	 3AVgIsOz/zD7tXAYK00Xs+NMt9cz+nNetagFCNDmcTkuTXDaCYXXp/CdnKrbBklcvp
	 kzNjK9mT4YD/JoqOF0ZzOxp/fzHED7S587W/R7XfXpm5ebBXS92MKcQIb7u4P/4eoN
	 0DMj829rh6R7C7U+X3vhspxjUYHscxr1pfij/r45vrD1dzcA/eDbO+C5Plj/C5UbJD
	 +8r9E1AxaHh/K/3hdHMAXx9kCgxkNgZnVB+uuOhAS3/SZxKcnetW2r0VSpaWPiuKor
	 c5sdhixEm23Xg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 26/33] mptcp: hold pm lock when deleting entry
Date: Wed, 16 Oct 2024 17:12:30 +0800
Message-ID: <80d439c5214a721750b1f77a097502a4a32d478e.1729069854.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729069853.git.tanggeliang@kylinos.cn>
References: <cover.1729069853.git.tanggeliang@kylinos.cn>
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
2.43.0

