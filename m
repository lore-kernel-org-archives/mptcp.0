Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0755F510
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 03:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740368275; cv=none; b=RjeHPaF+JqjURBWt18pUzcSlr5mkWXR5wrJ9Bl5XFtPxa2gV6j3RpOHdEkZWNGttjS8tEI+8PQFMvN8ZKhqoAxNCCzqgXl7wUFSLaGePw5JuvJeBrFwxwSzTfNWPl7+grJDN7V9NlEGgixhRDhXvhrz8K9k94uhh7chnqXJ7mco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740368275; c=relaxed/simple;
	bh=xwIW6vgWO9B/sjBeVdq8gCPHXMMU0QMfI7NpGr9S3II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlPyQlNikzxm7nkuLscPTQsdMOpFWLgaAqoc5kNJfNXGEoxQEXRBr7oyk+VA0G2EKg5LSHgzNAHPP7pdLXpvymI7eEE+Mxtn4hmYqnuOe3chC5wAAV5Tm6Ji3n514F/Z8i57JQdIdEPIs7nzZm8e04BGuprwZIKl5SEzvS85NCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIIOYc+V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIIOYc+V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2C1C4CEDD;
	Mon, 24 Feb 2025 03:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740368274;
	bh=xwIW6vgWO9B/sjBeVdq8gCPHXMMU0QMfI7NpGr9S3II=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GIIOYc+V2pmiy19sbSc+fSh8OJGihOOUMhBhvGTgbexaPD6ZSaowd9IXP9zfoJX3E
	 wL4VWJLC1m5XLcBdPgmC7Nq8dElyDwEv6sIKaCALJ/4153S8DPVCCTeaFdAZKw/6Y4
	 RStW4MY1+sjOwau5e6hsIeuYCjjVkxxetsf00evswB4OUC6jGYC4bUrkyRWd3pdZZp
	 2ilti9EBK+OwnXOmrLlywPOiLps2Grruie2YGeR9J+xRiIJHeXZRVziG6abjcFbrjp
	 Vc/YCkCH2+LVI8kclujLm2HG8iFc4bCrQGMlg5eDEy3KnX5jpOQIWCdpjk+Q6w05Cc
	 Aic0cTir202pQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 3/5] Squash to "bpf: Add mptcp_subflow bpf_iter"
Date: Mon, 24 Feb 2025 11:37:38 +0800
Message-ID: <d2f825f15c288141a1812959a40d23f9a9681520.1740368110.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740368110.git.tanggeliang@kylinos.cn>
References: <cover.1740368110.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop the NULL check for 'msk' as Martin suggested, add more checks
for 'sk'.

Use the "struct sock *sk" instead of "struct mptcp-sock *msk" as the
argument in the bpf_iter_mptcp_subflow_new as Martin suggested.

v4:
 - drop sock_owned_by_user_nocheck and spin_is_locked. According to
   comments from Mat [2] and Martin [1], in this set mptcp_subflow
   bpf_iter only used from a cg sockopt bpf prog, no need to add these
   check at this moment.

[1]
https://lore.kernel.org/all/fdf0ddbe-e007-4a5f-bbdf-9a144e8fbe35@linux.dev/
[2]
https://patchwork.kernel.org/project/mptcp/patch/f6469225598beecbf0bda12a4c33fafa86c0ff15.1739787744.git.tanggeliang@kylinos.cn/

v3:
 - continue to use sock_owned_by_user_nocheck and spin_is_locked
checks instead of using msk_owned_by_me().

v2:
 - check the owner before assigning the msk as Mat suggested.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 7e9d9c9a04cf..a6b07aaddcb2 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -235,24 +235,24 @@ bpf_mptcp_subflow_ctx(const struct sock *sk)
 
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
+	kit->msk = msk;
 	kit->pos = &msk->conn_list;
 	return 0;
 }
-- 
2.43.0

