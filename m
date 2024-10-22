Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B1136124
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 07:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583293; cv=none; b=P4IBPl7K+eKgnB4WBM+4jyJSJxaQgkCgHbgBNFhnLjg1H1w10N7c/myPxtDYcFuiOxTKlS4kvsoGprgqesyzkzMG7iuA11iroIx8+8WS/9OTFAzpZcc7QbXZFHCmcF+VXLLXAQbdF356bxPR3Mynv3v0g2e8sklCi4ET7HHS5tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583293; c=relaxed/simple;
	bh=/ZW0LmjaKhBp10DMOxqXaZ7TjypcW1MActVI30YmzNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryc4BZOv0m2Z52P29y+pLkIpDYYRkYQaHjKNjACZmWCpeYD9h4HvATCVobhrFykq1GYhHs4nxfFm/T/ZrEoRJGaGb7UVHIt9geJUPQWnV8auOTqpRepJam+Nlk2Zfbve3VDzAjEErbJda3qGiMZdf5JKZcdtEfuh2x60AX06+ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m992TW2O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m992TW2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2526C4CEC3;
	Tue, 22 Oct 2024 07:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729583292;
	bh=/ZW0LmjaKhBp10DMOxqXaZ7TjypcW1MActVI30YmzNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m992TW2OqkWUzC0H4eKCdkyfYYr058GRTntrzDDyezmH8Lt4jOamQQqoVj6WfZQGN
	 CzxxPwFhZBYuDvEI0n463VM4hM107pNr4P9fK5Ii2yZ1gpWS8Q+vz9r5rw3YUWbYx4
	 3W4Dq4HJk9xjLp7r5utlmX1mobGdK4L88vuticzEN95ZhjtGafL2QgM3ARVDbLEusY
	 guDKQWuHAER0cFWK8GgAQZzSTVbYUBUiPedipz+uV3D1bby3buPowyY90WplqDTmz2
	 LpBiIqi1PRzZHdeKDkc8PXYBW6RxAZOiNkphhrjnPXzvMepUTKGLlnyKqueCygYWMq
	 46lntZqaPtNlw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 4/5] bpf: Export more helpers used by mptcp_address test
Date: Tue, 22 Oct 2024 15:47:59 +0800
Message-ID: <5063a458ea30f6393526ab034f4479e25b898231.1729582332.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729582332.git.tanggeliang@kylinos.cn>
References: <cover.1729582332.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The mptcp_address bpf_iter should be invoked under holding the msk pm lock,
so spin_lock_bh() and spin_unlock_bh() are needed in BPF program to hold
or release the msk pm lock.

And bpf_ipv6_addr_v4mapped() helper is also needed by the mptcp_address
bpf_iter selftest program.

This patch adds the corresponding BPF wrappers for these helpers and adds
them to the mptcp common kfunc_set.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 8889e5351897..057017d3f5c0 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -325,6 +325,24 @@ __bpf_kfunc static void bpf_mptcp_sock_release(struct mptcp_sock *msk)
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
+__bpf_kfunc static bool bpf_ipv6_addr_v4mapped(const struct mptcp_addr_info *a)
+{
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	return ipv6_addr_v4mapped(&a->addr6);
+#endif
+	return false;
+}
+
 __bpf_kfunc struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
 {
@@ -352,6 +370,9 @@ BTF_ID_FLAGS(func, bpf_iter_mptcp_address_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_address_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_mptcp_sock_acquire, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_mptcp_sock_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_spin_lock_bh)
+BTF_ID_FLAGS(func, bpf_spin_unlock_bh)
+BTF_ID_FLAGS(func, bpf_ipv6_addr_v4mapped)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
-- 
2.45.2

