Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A7B1FBEB0
	for <mptcp@lists.linux.dev>; Wed, 11 Dec 2024 03:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733886731; cv=none; b=glAEOH+1ob/hkmXQd+SBPbxYl5ZthWhPkCUW22uGtDN5fFf/E55iSVgH7QTPFtKt4gFGRytJXC66/2Gkk5bfYWVxSjoKqGhHQ9y2q3K3Efv5adQvccp+/TWBWXu37dyKl5GZWFW3pAXPy/clUvrJoQBofHT36iHFfoLehYzxF38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733886731; c=relaxed/simple;
	bh=PDBrDJi05Q8UiAIfhxiONeZT7FvBxt/RW1GzR0gGdBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTT5NJ7X5Ro2WkD/vdSl4ZDA0elVtJQn55N6n15UwPAc1ve9uHdLXd11PNOBRzyPvkKUu6SPSU27gZ7kCqc7yYEhe+lFvW/NLSXdaNEToLdZ5Z47D8KCuiNJTuikUZHiyA0g+esCQlkHjfUFjDDEgR7OIoZlc/bhJkDighQysdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDmulhNi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDmulhNi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FEAC4CED6;
	Wed, 11 Dec 2024 03:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733886731;
	bh=PDBrDJi05Q8UiAIfhxiONeZT7FvBxt/RW1GzR0gGdBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FDmulhNif9iZept6R4OAJDDS2mdreUQjnOAoZiAt/5PeprXzrvNr0OxQJyZFF/Q2S
	 +uZYfT4aSQDYhdsPGQ5kVDAxxWd9ZwSSODYCfTmiwFvUvPeNCaT9Ewj076b2lS7YXO
	 x7LMi0njZHuVBKq+02fhFCj6RkVQ6SF2UcIeL8PNc+y49iP2xIUsNV6jZyrBj5EjhA
	 1sqInc4pqBT0DZ4juYTMS2+TuZaBTbuuW2eKsP9ifPZ6L1zXP0RaaH8g5XRwpJjBLf
	 4FnYghk+wKJhmvuETMVJpamEc4Ujt0z8ub7F2lZnfdhR83G5HFi/oe5shd/8i1DGoV
	 GX6ubOG3NyctA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 4/5] Squash to "bpf: Add mptcp_subflow bpf_iter"
Date: Wed, 11 Dec 2024 11:11:55 +0800
Message-ID: <5ee4ae1ecdec196e339e472bf759487991839d7f.1733886326.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733886326.git.tanggeliang@kylinos.cn>
References: <cover.1733886326.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add "sizeof" and "alignof" checks.

Address Martin's comments in v1:

- bpf_iter_mptcp_subflow_new returns -EINVAL when msk socket lock isn't
  held.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index e2a85ada213e..923895322b2c 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -237,12 +237,20 @@ bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
 			   struct mptcp_sock *msk)
 {
 	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
+	struct sock *sk = (struct sock *)msk;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_mptcp_subflow_kern) >
+		     sizeof(struct bpf_iter_mptcp_subflow));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_mptcp_subflow_kern) !=
+		     __alignof__(struct bpf_iter_mptcp_subflow));
 
 	kit->msk = msk;
 	if (!msk)
 		return -EINVAL;
 
-	msk_owned_by_me(msk);
+	if (!sock_owned_by_user_nocheck(sk) &&
+	    !spin_is_locked(&sk->sk_lock.slock))
+		return -EINVAL;
 
 	kit->pos = &msk->conn_list;
 	return 0;
-- 
2.45.2

