Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FC11CEAA0
	for <mptcp@lists.linux.dev>; Tue,  5 Nov 2024 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799672; cv=none; b=h7cbmuvQVREQA4EvNH6PKkc7qg6NAbsBG1aAO9yA9pK2vSAq567WV56vJs3G9yyzu9GwtNSBTPHajUM/K9OHldCfOJE6emQ64RgIzDI6/+RhBxxs2hZGrTSLvJN1NO2TqC2Nt5AcHWxApTDwQGi0tFqpR9FoGZP00lXQrEjYPkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799672; c=relaxed/simple;
	bh=TdwHDStTHz0ZtxdE65IPfp02PyLZIKupedSDnKUIAzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQZqeIvmnuQO304/NaZAmNGMbodk5RFpReUzvZnT9bzqxgdF4gEI3IsyyHCKmGuCc82etevlrEp9vsqwow/gov5UnATv6cHNBTbH/Cp2XJzUObBfUmvqif8OYW7TAvTA7wZ4YeyF4/Vk8H16FVBQ5ipNLNRUyLwrTIYM9QcWKxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UH/Wwnta; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UH/Wwnta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209ECC4CED0;
	Tue,  5 Nov 2024 09:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730799672;
	bh=TdwHDStTHz0ZtxdE65IPfp02PyLZIKupedSDnKUIAzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UH/WwntaI1zE6V8wI2CZ2cC3P1v9pENkWKdbTHC36OQr/4XeJN9yMTz94AcDcjKSS
	 0XdCBCp7B2Ov6qWZECc5aploRvQq/4zH7yVLIEtJxtO1PuKES82cHexPMJQ+U4aY8/
	 J40xNc4RdHMAipRWY+5+qTU476cKZiKcH0msTsEHeMMrQ/4GTeKl1JpAZb4zwLHkYa
	 jfGDvvTBKuJzn2MiUVOdN5Y+T0BHEP5xDiesojRcM3T2u8uB+etPpalT6QSnfHg6GS
	 KDoOtPYvA/5s3xZLewPU1xY9oOpsQY6XWquXWlqEMSfTjkWP4us03bHC2x1jfPObxM
	 hX06BWKPjteCg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net 3/3] mptcp: hold pm lock when deleting entry
Date: Tue,  5 Nov 2024 17:41:00 +0800
Message-ID: <49c522bf883b5720c41d614885405f0deb38f518.1730799589.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1730799589.git.tanggeliang@kylinos.cn>
References: <cover.1730799589.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When traversing userspace_pm_local_addr_list and deleting an entry from
it in mptcp_pm_nl_remove_doit(), msk->pm.lock should be held. This patch
holds the lock in mptcp_pm_nl_remove_doit().

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 0c0f6f65accb..3664f3c1572e 100644
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

