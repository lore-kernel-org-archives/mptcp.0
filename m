Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F9A1DFD85
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736325510; cv=none; b=AFGWbTfm8Ml5qAhbW4cfA5PlOsfXJvuIXqIkcF9BgxHag323IIBa/67Kl5FwxexHRvW9KkwAZ9j6ebOZa4hOWr0Q9seS+GCCqvqqGGUnoAtrtyR17/d7b5QAkJ5Zt6RQTyOrScksMHwT0mXils7EtiKnw1jgYdFNg0vhQysNWK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736325510; c=relaxed/simple;
	bh=WAiDKh6AeQkNjXVZ7a6GfC+r0kn5c58+ZE4rhLbaLbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQ2rFKJ/9pSQTMwXTch8NZzewHm6xp98say0R2Fnoo0BK0P4my/qGkHpgT4nYwbhWGxcTMFJ+x7L8buEzB7Bbwq2fs3dSpUtjTV0rshSDTq3YuVvwwUzmlMceWzSEvdeTO0Zw8m9h/Qs08iVYVSTCjAr1e0q9m1tB6hq0/lWErk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUTbPloE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUTbPloE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3D5C4CEE0;
	Wed,  8 Jan 2025 08:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736325510;
	bh=WAiDKh6AeQkNjXVZ7a6GfC+r0kn5c58+ZE4rhLbaLbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bUTbPloEnAw038QTJ7uPPsJWMjJTuXr9W4slPJ629StIZLKJQ5KU36cfAcmj9MYBN
	 7qHZhhzLuhyIhlz9y7g1FCMd9alolPht8Er+nuJ+ls6xW0hS/YGhLWAp3WJHICIeX0
	 F3ZywirO9ZzmDKv1V8+npAuDYxc2tRUMQdnwXtV/RzzpYp3LESCuUoh8Sn9mO/TaHh
	 /3xDRfvFliNflVM5BfyfzOIqK28HkUdwmCkydDYtJiL9pjhc4m6oTZXH3JhFjouRY1
	 HU97c+qw+zorZHGOWDjmOq/TwXnHck6YtY6ScvqTGt4gNjVbrPk3tgOHuCx7P8wQG3
	 K1WNawLNC395A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 4/5] bpf: Export more helpers for mptcp_userspace_pm_addr test
Date: Wed,  8 Jan 2025 16:38:11 +0800
Message-ID: <3e9fbc5a0f28024f130b2d67c6ee38b09e134a7f.1736325184.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736325184.git.tanggeliang@kylinos.cn>
References: <cover.1736325184.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The mptcp_userspace_pm_addr bpf_iter should be invoked under holding the
msk pm lock, so spin_lock_bh() and spin_unlock_bh() are needed in BPF
program to hold or release the msk pm lock. And bpf_ipv4_is_private_10()
helper is also needed by the mptcp_userspace_pm_addr bpf_iter selftest
program.

This patch adds the corresponding BPF wrappers for these helpers and adds
them to the mptcp common kfunc_set.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index c7f5d208f6cc..5e748cebb787 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -339,6 +339,21 @@ __bpf_kfunc static void bpf_mptcp_sock_release(struct mptcp_sock *msk)
 	WARN_ON_ONCE(!sk || !refcount_dec_not_one(&sk->sk_refcnt));
 }
 
+__bpf_kfunc static void bpf_spin_lock_bh(spinlock_t *lock)
+{
+	spin_lock_bh(lock);
+}
+
+__bpf_kfunc static void bpf_spin_unlock_bh(spinlock_t *lock)
+{
+	spin_unlock_bh(lock);
+}
+
+__bpf_kfunc static bool bpf_ipv4_is_private_10(__be32 addr)
+{
+	return ipv4_is_private_10(addr);
+}
+
 __bpf_kfunc struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
 {
@@ -364,6 +379,9 @@ BTF_ID_FLAGS(func, bpf_iter_mptcp_userspace_pm_addr_next, KF_ITER_NEXT | KF_RET_
 BTF_ID_FLAGS(func, bpf_iter_mptcp_userspace_pm_addr_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_mptcp_sock_acquire, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_mptcp_sock_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_spin_lock_bh)
+BTF_ID_FLAGS(func, bpf_spin_unlock_bh)
+BTF_ID_FLAGS(func, bpf_ipv4_is_private_10)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
-- 
2.45.2

