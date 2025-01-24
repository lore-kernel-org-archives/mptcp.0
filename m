Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC450219A90
	for <mptcp@lists.linux.dev>; Fri, 24 Jan 2025 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737714530; cv=none; b=uslR4iURIX9qna+8ckrOKDRv54s6keKQPzEjxW94dQCyMlKXsgmXsrGFJqcmJu+UaQE/zUSP2YydADspcIfkmTZQqUCW2FjwfEFxRnEoaQlJcGy8cbDLJgerNRsG5paUJ+9QZYNbM/L682cho0lreSDf+QKIr8WZSdpR+b2n/Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737714530; c=relaxed/simple;
	bh=KOure61nZXVuhZQUsemR0zq/2S631J/op6/b8PjoEfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IV8WiY/mUWelVlxQaYoxUZSlOsa6InaD652yIlynqU4HKeE0XW5jWtu/9mIHcWyLsqLEQk+K2ckFxfQOIPvJtFWE+/uAVcJIagVfzRiDGSN5KMlfFbm09l8ipm4460czTPK8ybxhuu3SyW7sZKq6QUX0KHoS/xZ5AZnHJ0C2YuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1tt2n67; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1tt2n67"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068A0C4CEDD;
	Fri, 24 Jan 2025 10:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737714530;
	bh=KOure61nZXVuhZQUsemR0zq/2S631J/op6/b8PjoEfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o1tt2n67mYvSfGmw8dedFGecemf7yQt3iy0kdM1fMgSensLVdyGP7POf0iZXTCdXL
	 OgWXn/VERUiGsxXDYXFpR1/FqPfJrwfugO107SJaCyhb2986vnIBtrvceEUG+V/HoO
	 kNdRRyRy4eS+U2oFqq4ou6anaFx6vubFlVtzw5Kd95oIIdYd/kPwngYwCJ4l3Wqras
	 0vhzCDkBFEq+KlxC+G4lmUwAUR3KQZxSPUBF5OPO/DLkhsU1W1GkemBA4XqgfdSNPo
	 cP/uPL+D9mrmL2uHgd/U5WPu6dgNz4XEeiuSHlQIdOGmC0JgZjBYmD0zD9vZZPqbzk
	 UOv9QsZF01I8w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/3] Squash to "bpf: Add mptcp_subflow bpf_iter"
Date: Fri, 24 Jan 2025 18:28:39 +0800
Message-ID: <af7dca496d83aaf6fd7163f767ef1bd1abbab59a.1737714424.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737714424.git.tanggeliang@kylinos.cn>
References: <cover.1737714424.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 923895322b2c..def4de34666d 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -234,24 +234,27 @@ bpf_mptcp_subflow_ctx(const struct sock *sk)
 
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
+
+	msk_owned_by_me(msk);
+
 	kit->pos = &msk->conn_list;
 	return 0;
 }
-- 
2.43.0

