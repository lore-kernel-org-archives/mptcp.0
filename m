Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647C81F3BB2
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998030; cv=none; b=gVb3L0L8nrwt/QIlMRAGLWJDFpqv+XWETZJ/1ciauUxUVC+/icBdvFJTl7WclZef0WNuzmCMZSNhqO8DVABnKEA8EQ1XWNb9Da5gnN8zBLtT63O4GGz9GQt+/Xeoo7BjhZq4f1LcWjzIndG0qjPI6EnEpEsvtONdk3097HmpgJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998030; c=relaxed/simple;
	bh=GxH2KhnDE+Z4TKKIkD4+oWWc3Mf1jcD4ONU5q7pfUjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlxNpOhi2S7vzcQDPvJJtDa4fSA2DkFcD6w75E1Uomsdfq+15qYum74X30qI/i3jAd0wNyHDf8jrGJcnCH51jlsjVN0q57ETkSjsj8BgOqcaI1IW0ZCAwC7np51dV7qX/iJm0axFNxMoEtzr6MxH24vZ6v+ER6o9opVUmYQ4CeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqpRv3aw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqpRv3aw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7722C4CED6;
	Mon,  3 Mar 2025 10:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740998029;
	bh=GxH2KhnDE+Z4TKKIkD4+oWWc3Mf1jcD4ONU5q7pfUjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fqpRv3awfLSiPUShEd7fe4sUCaiJlmvOqsDVliqkjuC6B4KOasK8jksAanuXZAyPr
	 ChmTEWDNC9G5k37dyMsUlGrPJ40MuBVjQJCNapkwsSU+5y8moa+ctqLabgQzuXDznF
	 ghpJMIU/g1W5/b8Rj4s/9qYFLJLbJuJ/l43APg5xnvABvV0n0rT51Js/eri7O1dghW
	 l+6/QfQaHv2RgSlY9saqE6QCSGoz3dfEcrD2JnICZ7kx+1mxw6RlWAMzp8QqkU9GqA
	 WrKYZTCLzjUzxf2jspLwjxupiZkdmWe2sqDfoy+wETXMWM8yG4wUGfR+Sg9J+/idej
	 gsjEJVO6q5VtA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 3/5] Squash to "bpf: Add mptcp_subflow bpf_iter"
Date: Mon,  3 Mar 2025 18:33:35 +0800
Message-ID: <f8d59dcb8391483787f832ddb43035846055aafb.1740997925.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740997925.git.tanggeliang@kylinos.cn>
References: <cover.1740997925.git.tanggeliang@kylinos.cn>
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

v5:
 - check bpf_iter_task in mptcp_subflow_new()

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
 net/mptcp/bpf.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index aff92f458e7f..a307490bb20e 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -249,24 +249,33 @@ bpf_mptcp_subflow_ctx(const struct sock *sk)
 
 __bpf_kfunc static int
 bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
-			   struct mptcp_sock *msk)
+			   struct sock *sk)
 {
 	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
-	struct sock *sk = (struct sock *)msk;
+	struct task_struct *task;
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
+	task = mptcp_get_bpf_iter_task(msk);
+	if (!task || task != current)
+		return -EINVAL;
+
+	mptcp_clear_bpf_iter_task(msk);
+
+	msk_owned_by_me(msk);
+
+	kit->msk = msk;
 	kit->pos = &msk->conn_list;
 	return 0;
 }
-- 
2.43.0

