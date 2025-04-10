Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB501D5ADE
	for <mptcp@lists.linux.dev>; Thu, 10 Apr 2025 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744325111; cv=none; b=nSwaCmu6XbHuCCaRR7eEkQ72ZyKeWqcnMQbQAjbMC+gA8VeUuaq14hPlYQkFMMpPKsDih3jcfM4/4Cu4Ms6GZbHtqJHvXFa0/N9gVQJo6nPPoqob4onUEA8KMiBMcvQEz0XcP6NMqNtKG/lRRAv0mXby+WlLW7lrLlbvgd6ThxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744325111; c=relaxed/simple;
	bh=uzknUSsjoVp7T9PC2rQfoPHZCmjImfXER7CKnP5rH4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W/KyOj5zrnmjnDZZ7fH6TKxfkCYFaOA0T/d5xXtvxyFLZGXsUjl+A8aOe3F+zNNt3WSeCu+AgkEjnbmhKC2n/kGS5BsgBHPpcujCt12eu1rKjZKg9Ccj2/eWj2CZl88uXJnmAcAegunqMg8gV8q/guC1y/vrmkM8Uk++9iQnjCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZNSD809; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZNSD809"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65962C4CEDD;
	Thu, 10 Apr 2025 22:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744325110;
	bh=uzknUSsjoVp7T9PC2rQfoPHZCmjImfXER7CKnP5rH4E=;
	h=From:To:Cc:Subject:Date:From;
	b=GZNSD8096G8A5fYSG8wS4YlWFV1GFYFDSa2CUVt3iUF7eQAnDsZ//Q5ape632Svwm
	 1KPB7rZivJQGuGVR/N3ym3BwXgMrSpBjmb7w46r5qv70k+Fs8LagY6nYrhAYGrhHYc
	 SrDCWrfDE8cjbUvpiD4C4KpqT5WBETMM3nbDYjBHFpW2W5ECVX2A0WjTUNrZkCbLuH
	 DcHCtw+XhUT4vnwCqEYjMcCBT5+99573/ClQ1B9ooSwODhT/54HIogLMFJoeCA7GB4
	 tI/ZhanFtTW8CDeIkKj57fElK3WblX7+m00mCXw+BNlm1LFUCAYpMcYZ5PPxmHKu+F
	 MHV/vlAtuk+6Q==
From: Mat Martineau <martineau@kernel.org>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>
Subject: [PATCH mptcp-net v2] mptcp: pm: Defer freeing of MPTCP userspace path manager entries
Date: Thu, 10 Apr 2025 15:44:59 -0700
Message-ID: <20250410224503.2056587-1-martineau@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When path manager entries are deleted from the local address list, they
are first unlinked from the address list using list_del_rcu(). The
entries must not be freed until after the RCU grace period, but the
existing code immediately frees the entry.

Use kfree_rcu_mightsleep() and adjust sk_omem_alloc in open code instead
of using the sock_kfree_s() helper. This code path is only called in a
netlink handler, so the "might sleep" function is preferable to adding
a rarely-used rcu_head member to struct mptcp_pm_addr_entry.

Fixes: 88d097316371 ("mptcp: drop free_list for deleting entries")
Signed-off-by: Mat Martineau <martineau@kernel.org>
---

v2: Add comment explaining connection to sock_kfree_s, add "Fixes" tag

---
 net/mptcp/pm_userspace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 7fc19b844384..1911fe1799fa 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -337,7 +337,11 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	release_sock(sk);
 
-	sock_kfree_s(sk, match, sizeof(*match));
+	kfree_rcu_mightsleep(match);
+	/* Adjust sk_omem_alloc like sock_kfree_s() does, to match
+	 * with allocation of this memory by sock_kmemdup()
+	 */
+	atomic_sub(sizeof(*match), &sk->sk_omem_alloc);
 
 	err = 0;
 out:
-- 
2.49.0

