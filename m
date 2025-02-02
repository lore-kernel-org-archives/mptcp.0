Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD741CAA84
	for <mptcp@lists.linux.dev>; Sun,  2 Feb 2025 04:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738470967; cv=none; b=BvijbZvxN5T1s+/HqffXdqDetFIOejozLznxwmxoRTkf6jgzcL69A5Zd7Wp22M7nPVb6Zdri88q8dQ9YzmG4A5NJTjS3zK+YNFbqbRShQOshUf00xZQIJC0/P5OzuLaaNOKHVlaYX+/pH0zz+J2F9kKoJ/jE8eLCtT3lqwKjyMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738470967; c=relaxed/simple;
	bh=AlZ/IX+19BzIw4KGnMnChGJpo9RGvmipFLmqNjBj1aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZsupHJBf19gIMvkszW/fhspNBRQe2kw52HHGEgn91ZKVJsAbQFFGHuxzMK0p8X4esUbmEne1i118uncjSQ1ffWy/WrGu3MFOPkWWdkAONIauK1HW+nvWs6Kwckknm5CN4HrFQ7nSXOyEgXfvQOVybfIYPThTXyfEBMHUeXP9JEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBjtyMWp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBjtyMWp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0150AC4CED1;
	Sun,  2 Feb 2025 04:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738470967;
	bh=AlZ/IX+19BzIw4KGnMnChGJpo9RGvmipFLmqNjBj1aQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hBjtyMWp7Dxzu3hIuen16xexfzwQ+6+kRJTdkWP1MXjWn8L10rwEbc9XjfwYp1HvR
	 XzV9jRyEBj1KU+Xv3oNNy30sT9LIv2NZ4ndXnaJaLV5VP0WIDtBjYJEzq1vItQCYYp
	 bz2X9mxzguirTdRjorC9EVLhMYtQYqALW/t8BK4DDCfM+zGkrDLcOmFGGF/D7kLt57
	 wRVMcH8kUEPmqr6Icn9cB//MJyncRhsFzYuB99dkx5BeA1OfMtN2My21/hOw1WxJJS
	 Dh2r2HMmkso3JX7uhoVYcesjzc+ZKVCkfzLpHMs7eJupsnddLflu6sBceirb/XzE+t
	 p3BnYI+Kl72TA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/5] Squash to "bpf: Add mptcp_subflow bpf_iter"
Date: Sun,  2 Feb 2025 12:35:09 +0800
Message-ID: <3af2d8f14fc6870ba12201ee2885b2f509e4e85b.1738470660.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738470660.git.tanggeliang@kylinos.cn>
References: <cover.1738470660.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop the NULL check as Martin suggested.

Use the "struct sock *sk" instead of "struct mptcp-sock *msk" as the
argument in the bpf_iter_mptcp_subflow_new as Martin suggested.

Use msk_owned_by_me().

v2:
 - check the owner before assigning the msk as Mat suggested.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 7e9d9c9a04cf..c0ac11f611b0 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -235,24 +235,26 @@ bpf_mptcp_subflow_ctx(const struct sock *sk)
 
 __bpf_kfunc static int
 bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
-			   struct mptcp_sock *msk)
+			   struct sock *sk)
 {
 	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
-	struct sock *sk = (struct sock *)msk;
+	struct mptcp_sock *msk;
 
 	BUILD_BUG_ON(sizeof(struct bpf_iter_mptcp_subflow_kern) >
 		     sizeof(struct bpf_iter_mptcp_subflow));
 	BUILD_BUG_ON(__alignof__(struct bpf_iter_mptcp_subflow_kern) !=
 		     __alignof__(struct bpf_iter_mptcp_subflow));
 
-	kit->msk = msk;
-	if (!msk)
+	if (unlikely(!sk || !sk_fullsock(sk)))
 		return -EINVAL;
 
-	if (!sock_owned_by_user_nocheck(sk) &&
-	    !spin_is_locked(&sk->sk_lock.slock))
+	if (sk->sk_protocol != IPPROTO_MPTCP)
 		return -EINVAL;
 
+	msk = mptcp_sk(sk);
+	msk_owned_by_me(msk);
+
+	kit->msk = msk;
 	kit->pos = &msk->conn_list;
 	return 0;
 }
-- 
2.43.0

