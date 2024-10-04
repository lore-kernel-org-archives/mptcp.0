Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9CA15CD64
	for <mptcp@lists.linux.dev>; Fri,  4 Oct 2024 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046805; cv=none; b=QcJLEgXkbIUEz0yrHetNf6Rv5KJE1mCtrc2e9mpC3YFYUYfvH25mbJZLI7S4Z7O5v/gyahiv3hizIfOrtOEkZfQsF4PhX3D+QcZ9SsnSxzIT+92SZmexcaXbFYaO8Im10ISREFc9M4z6+TSM54R4IQBddNhCat03Zuu7hpRt+nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046805; c=relaxed/simple;
	bh=wPSQZ2+OJoT5vaEJtWUM9005coDDnnS24lyWp0XW+2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mthECiTxsyar5rLHtlKXxc0FkScMXN33kIjpLF90By3bqrx6WIaW5+HCNUBr+Z9CKEeXW94Sh6JdIcbwlfBxpH8AL05mhEKU4GddslbjN7m9N2q4lMeq5j/AvHs/c4H/6RUDvkP05mMB/ObQ9mjYLUTN/kAjbJRvvzyzVm104ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLMOWGX9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLMOWGX9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A802C4CEC6;
	Fri,  4 Oct 2024 13:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728046805;
	bh=wPSQZ2+OJoT5vaEJtWUM9005coDDnnS24lyWp0XW+2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sLMOWGX9Ma8wHgLB7l6+i9Z0S6nPTLRUKCCwOYJ1Z1d0cUMbAarIz2c959NVYuUHk
	 Z2OCd0BzY0ipg44Yt2ytM/hWce7V7LH14ckteXxj1FMHxHfUESSpEsdLkE4JjPkZxU
	 tcD+CQaPStOPe+O7R8zxtSJo8zqppIQQw5qfPc2X6XKIcfMvBaVQYmYjxhaF3oA57r
	 EtQOrg1D88zxoKwXooVvykCE7zIjy5TC0XiyBjXqed+8+UuXrZJY6mqfJNDZ5LENsO
	 /BcoRWb2Q/+MlY8BGhCWc7iDXAmQmhVyt+EfOUOipXNQyL3OTQC15XzrEyvuyNXFFM
	 GUqIx5IrtJ8Ow==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 6/9] Squash to "bpf: Export more bpf_burst related functions"
Date: Fri,  4 Oct 2024 20:59:46 +0800
Message-ID: <9cab58ab8790150dd205a1e6bf69c0b69900526c.1728046491.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728046491.git.tanggeliang@kylinos.cn>
References: <cover.1728046491.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop bpf_mptcp_subflow_queues_empty declaration.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index da6341008aa9..a47aa7938afa 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -725,7 +725,6 @@ void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
 void mptcp_set_timeout(struct sock *sk);
-bool bpf_mptcp_subflow_queues_empty(struct sock *sk);
 struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
-- 
2.43.0

