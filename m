Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6591A5B8C
	for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788454; cv=none; b=qQxEBhAu4xmqI6A0qiTKgZp94wjqY8KlOqjmVagJQkrt4saClPffW91vA63Huscy61/So8f+lmyz/7Q7JTOkzGI6Ri8EM2fSehe8ZHOTtkmW9lZfqdW7nXXbVtIgBgFfw1tjm5lsvLvFARJO4sUWR1R82VrBC09w3aSxlWBN198=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788454; c=relaxed/simple;
	bh=uNMVqv4YBalTJC0bicKoa36ZNouE1vzGkeNHqVUhMn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L41CbeqQzY1DxC3Tq4P+8+fZXOKe0J3LV03S5SgJ3gqjwW2ncPIxjqurXGFM40ptwpAY1//A6kTLdQ/aKjhRFCcR8uy7LRE6X3cf3lJzifrR9J1oh0ETQaAhfACoXOllfvnKpNpkbXZI9ahBcUlbsZJ7isKlNkbRobpCowxjgXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHXb7Y1x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHXb7Y1x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5976C4CEE4;
	Mon, 17 Feb 2025 10:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739788454;
	bh=uNMVqv4YBalTJC0bicKoa36ZNouE1vzGkeNHqVUhMn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KHXb7Y1x5RtTq6hBAllMc1khLlNxhk1aenxpKTL6TWotPfLOy7tIKhLilKNUeKnz2
	 GKgNMz113tTpf1z9v0yJMLGj/ZkG6FeZZl1KT7EBt7+fMvDQw9GKx1NGPj5V3Sj2Tt
	 6z2YuQxY/tb6/v2/WVnVOjPL415vQcQncL6/wPNUxjuBMJtoNXqeFZqv1nuwhTRQOg
	 DDh5udRDylqK3yF2n4pNfHVmgXaZHCXx8w8kSra77loy6SECeNVJ/0/adRQDMOjRPb
	 ANUJZ2V4zPyt68a9gpVYg1JepcJlviqlqYZUSOTkrJDwxLUYdnwMD6tocysSIKXJkF
	 7Ko132BJJ1H3A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 3/5] Squash to "bpf: Add mptcp_subflow bpf_iter"
Date: Mon, 17 Feb 2025 18:34:00 +0800
Message-ID: <f6469225598beecbf0bda12a4c33fafa86c0ff15.1739787744.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739787744.git.tanggeliang@kylinos.cn>
References: <cover.1739787744.git.tanggeliang@kylinos.cn>
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

v3:
 - continue to use sock_owned_by_user_nocheck and spin_is_locked
checks instead of using msk_owned_by_me().

v2:
 - check the owner before assigning the msk as Mat suggested.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 7e9d9c9a04cf..06fb0f88e35f 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -235,24 +235,28 @@ bpf_mptcp_subflow_ctx(const struct sock *sk)
 
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
+		return -EINVAL;
+
+	if (sk->sk_protocol != IPPROTO_MPTCP)
 		return -EINVAL;
 
 	if (!sock_owned_by_user_nocheck(sk) &&
 	    !spin_is_locked(&sk->sk_lock.slock))
 		return -EINVAL;
 
+	msk = mptcp_sk(sk);
+	kit->msk = msk;
 	kit->pos = &msk->conn_list;
 	return 0;
 }
-- 
2.43.0

