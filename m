Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FD717C21E
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 09:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381525; cv=none; b=ExjfV4i6aRjB/wIBjHukDgcc/5fTDbZoHOGssmO15sE6gCjY0Dal/PLozwC+sdZF9/dDxRLexB/9X4LftM2U4bwspdc+NPTBq9qV4yDIMhKF7g827jc0ner2ZEUWb5MIRwu8sAgMhH4TpnaTVxPr1ruDvaGnZ8Vg6C1X3D4HDRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381525; c=relaxed/simple;
	bh=Vgmg8a6K8iVpjllsRYvZXr5hm6ZiY+oZFMBddg6YNeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGWPG+Mp9KcQ97TFWzB8TI/Z+rGI0PsM7FfAhNJrJ9yVGKRUxUZfAx6dtzN3wyOoB10T1wrQufTSB71DYH+ZLwrKtnSnaJZkWDy1MmkZUwK4tIXpXJNGN29/RzomdXSkSlYJiPg7gJPz2AhO1TpP1Upzw6jjFWQLu5lP3LvreJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQ6NidVo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQ6NidVo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBF8C4CECD;
	Tue,  8 Oct 2024 09:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728381525;
	bh=Vgmg8a6K8iVpjllsRYvZXr5hm6ZiY+oZFMBddg6YNeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uQ6NidVojKn2REAazzAdplKxy7XThnum9cdABlZw/Yhx8Yi2JR6Ht8nXLj+QwIwiv
	 vQx7d8YNZqSySmduzvzcqrxyuY//U2+3gf2viuEHR7w1pw8k0imhFK4HSFjaIlyGr8
	 lQkXbHdVWBP9aeJe2Lh78jPgsa6SQf4qkcxgBG4Kalz6aGujFFVh1BBItu5sQGkAf/
	 ZI0DKfNt3/6R1PxMVrnQQD7Q1r62zaP/6RiAGrSzq3ZF/kHLhRWUBfDvCipbZU8n6p
	 r21UEh/UZEd5Q8qRyZudsPRg+gqJlOtff3NCOn1oa/f2AFMNxdxtySRLCOyiX7niLC
	 aYSWS5TrI0FQw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 11/13] mptcp: hold pm lock when deleting entry
Date: Tue,  8 Oct 2024 17:58:15 +0800
Message-ID: <0d59dc868a22ce07619ffa503b489a6ccf179fc6.1728381245.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728381245.git.tanggeliang@kylinos.cn>
References: <cover.1728381245.git.tanggeliang@kylinos.cn>
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
index 50b1aea7a719..05ad0d17ea81 100644
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

