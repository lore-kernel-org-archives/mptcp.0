Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D097083C
	for <mptcp@lists.linux.dev>; Thu, 10 Apr 2025 02:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744253979; cv=none; b=fqe281OjWjI0L1lws79QMP+KB2aDNExVkAGRTuWxMcnR00H8ddSJ5QUlUYvh+I316KkPiS0A8BezH7oZvbJFWoA6+SH5bK8oe1r0zOj8IV3icMmyfX6J7IsLvlzASJ/ynyBNPkmjg0CsfhT5n/qUnxtVb/gExorEUeZBC1roIxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744253979; c=relaxed/simple;
	bh=fIlRCy70MEavjps/aVpnT/S+ods3CSag7WtID+9NHHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=euUiYMdMoyaoIAx0nOEUDLmm9W2ll4NtqCx3yTRMnQHd66i4jw5d7F9UACMazxk+OhAJO4kOahikorHKdzPczFCN7YyKnap0ikZod2NHkPg3IRugp8wGo3mKvYXiQNEsPNsIGFqODUBuWYH48mPkw85drQUVLhde0Bttz4i4c9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDvRbbXj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDvRbbXj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC21C4CEE2;
	Thu, 10 Apr 2025 02:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744253979;
	bh=fIlRCy70MEavjps/aVpnT/S+ods3CSag7WtID+9NHHA=;
	h=From:To:Cc:Subject:Date:From;
	b=BDvRbbXjBns9P7G1sEF9r9f9LNyzHuAVFMi7i/AerEGQ0bbYe85F5wu/3sU9K2EYy
	 ixXJS7A9id7NAFZLV4nbCz7U8IjlIrQzH6Rq4XJ//rD5GbG2Z4NDy3eGst8eGnFBGj
	 30tJZx+O1iQy5e/YZzpstC+MEq/tRKWsYUGDFUVwtAX6yBIXpYju6Rq8uLyxRewCuf
	 diTWRNqrQLsBRJtOztBgQOTnaOzTsje/h2cTGD1c8xG7BBZLEipydEmDmtT1Dy/a4M
	 G6NKmdGPcTtHiPkrYi8jAWFCmz/Su34Gq/xUFwEWMQ91j+3Eyd0dYBVhw5YXOno+0c
	 woAKIMUNIuOpw==
From: Mat Martineau <martineau@kernel.org>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>
Subject: [mptcp-net] mptcp: pm: Defer freeing of MPTCP userspace path manager entries
Date: Wed,  9 Apr 2025 19:59:29 -0700
Message-ID: <20250410025931.1882967-1-martineau@kernel.org>
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

Signed-off-by: Mat Martineau <martineau@kernel.org>
---

My first implementation did add a sock_kfree_rcu_s() function like
Geliang suggested, but kfree_rcu() is a macro so that approach got
complicated. sock_kfree_rcu_s_mightsleep() seemed cumbersome, so I went
ahead and open-coded it. This should be applied after Geliang's v2,
which will delete similar code in a helper function.

---
 net/mptcp/pm_userspace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 7fc19b844384..959af1e42a97 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -337,7 +337,8 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	release_sock(sk);
 
-	sock_kfree_s(sk, match, sizeof(*match));
+	kfree_rcu_mightsleep(match);
+	atomic_sub(sizeof(*match), &sk->sk_omem_alloc);
 
 	err = 0;
 out:
-- 
2.49.0

