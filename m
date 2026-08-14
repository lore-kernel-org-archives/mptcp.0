Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB352E739D
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786732327; cv=none; b=Nv/LWTYQujjq6ouCRaZSAvGXB8J5qJxGf7ROArIF+QzC/KeVyXHNEO13xdqojZz3LoMWSmBD4GEVAUG62Xd6zoakOfUODPsEIk2UjBkn8gHDRHNWf/HXjOr7RcNlJSEeSbU2bkHkqfO6d5asFk/5TB7deY31PSCZmnokYywjwSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786732327; c=relaxed/simple;
	bh=TYjPj/ntJUZ1ixfDZfsHxIjLAqWfZ5Lj+BnraehckUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A6dkeXEMRUaugtKVZQv8VC/2/oIS1zEXP8LkzVZApruv2fJxfAfAer9sFo+fj0Vb5UqqB0ZCYVUfZhRnj+muui3x8D4Vy+w0BOyp5rN47xdAw7AS9UTngu5Ed3e1TE2xN6aV7uWrm4O/z8kdNQj0WSgsKc9blp2dR2ECljLsi9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKTBwcU8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKTBwcU8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297111F00A3A;
	Fri, 14 Aug 2026 18:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786732326;
	bh=3/QjQ5BVhWSHYc3I+F4GtRTLbnlNLO/jS8nMxnzmOT4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QKTBwcU8sWSUB5kR3NrVh7cb/jyg5kDqedWMSQSDFlNe2z8OqG7/tygFbW9IGgsPd
	 pkV5DNWn/k2m9ZbiCXNEJ28MxwkM9m6G7HHQlAitw/728wQv8uW7hXBDO/e0CMSz5Q
	 W5PZle1bunB1qfPqjouCLO9TdY9xN4FORnXKD+hKZqRK9NYJHdQfko9e3ujJZ87DJG
	 Elp9T3tT5b5SCAhiIUOOeTEs6pSlnB64r4koou9HJ5nwuoyMNgNla8kbdXarJEIwIG
	 nzVAXCQmz/9GNP1KCM3Dd9vJWel9aBQybxlnhe/+sTkpvkUqsB+kkGQI7pjk6+1jnT
	 QkeQgU5/SQ38w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 14 Aug 2026 20:31:56 +0200
Subject: [PATCH mptcp-next RFC 3/3] mptcp: pm: kernel: skip operating on
 closing connections
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-mptcp-reset-mpj-early-v1-3-3ca3260f9474@kernel.org>
References: <20260814-mptcp-reset-mpj-early-v1-0-3ca3260f9474@kernel.org>
In-Reply-To: <20260814-mptcp-reset-mpj-early-v1-0-3ca3260f9474@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Chenguang Zhao <chenguang.zhao@linux.dev>, gang.yan@linux.dev, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2607; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TYjPj/ntJUZ1ixfDZfsHxIjLAqWfZ5Lj+BnraehckUE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLq4xV4zk7e3rXoXscR100zruk38V5V/XmzbKoDY/XZT
 3mPrXKOdpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExE6Q4jwypXWUmpw2ruRlwP
 9M4eSQlh3+5Q5vP88dKixcnKr3ImxjL8lf4nIPc9QZHt895Ttmc1d/xaWvtKy3/v7DQm253BW+f
 f5gYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When iterating over each MPTCP connection after having manipulated MPTCP
endpoints, there is no need to operate on closing (or not ready)
connections.

We can then safely skip those.

Note that mptcp_nl_add_subflow_or_signal_addr() was already checking the
fully_established state, but it is better to check the connection state,
which is what mptcp_is_fully_established() is doing.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index d3014bf57bf3..c185e53fe42b 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -969,7 +969,7 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net,
 		struct sock *sk = (struct sock *)msk;
 		struct mptcp_addr_info mpc_addr;
 
-		if (!READ_ONCE(msk->fully_established) ||
+		if (!mptcp_is_fully_established(sk) ||
 		    mptcp_pm_is_userspace(msk))
 			goto next;
 
@@ -1095,7 +1095,8 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		struct sock *sk = (struct sock *)msk;
 		bool remove_subflow;
 
-		if (mptcp_pm_is_userspace(msk))
+		if (!mptcp_is_fully_established(sk) ||
+		    mptcp_pm_is_userspace(msk))
 			goto next;
 
 		lock_sock(sk);
@@ -1141,7 +1142,9 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 		struct mptcp_addr_info anno_addr;
 		bool announced;
 
-		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
+		if (list_empty(&msk->conn_list) ||
+		    !mptcp_is_fully_established(sk) ||
+		    mptcp_pm_is_userspace(msk))
 			goto next;
 
 		mptcp_local_address((struct sock_common *)msk, &msk_local);
@@ -1288,7 +1291,8 @@ static void mptcp_nl_flush_addrs_list(struct net *net,
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 
-		if (!mptcp_pm_is_userspace(msk)) {
+		if (mptcp_is_fully_established(sk) &&
+		    !mptcp_pm_is_userspace(msk)) {
 			lock_sock(sk);
 			mptcp_pm_flush_addrs_and_subflows(msk, rm_list, NULL);
 			release_sock(sk);
@@ -1502,7 +1506,9 @@ static void mptcp_pm_nl_set_flags_all(struct net *net,
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 
-		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
+		if (list_empty(&msk->conn_list) ||
+		    !mptcp_is_fully_established(sk) ||
+		    mptcp_pm_is_userspace(msk))
 			goto next;
 
 		lock_sock(sk);

-- 
2.53.0

