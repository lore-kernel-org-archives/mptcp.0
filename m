Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D252D202625
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248733; cv=none; b=tH1z1l7PHpOot8MvtnZXZMD5m/hOiZ6vV0bSTFvTCj3/Yr/5tuQ7omFqV2zOPCpLH6YXTds/u7g0x7SCKGjkRwaP5UHpix4xwclyj933we1MTob62xUlR4GMSUWskEtNZw5gPEu55dS3D6jW0ojvjORVWxsJgZKtHgAMmzVqBjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248733; c=relaxed/simple;
	bh=nu+axcIHmBoHjKkvuSAudbDn1f6k4kUqvtK4lNSSWZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULui2KDZc3GXnCSGfYz5efN8dNXELmTdk9mpl5PlWXl9YwJ/CYeN/BE2/EDkEE84vapt00DFKC4zfwRM0E5ilPHAufSkIh1+T3KHvFm3+vuzqanfWCvC8WWaiRQfrvln8PO8AV2KDoYTyQaORCm3MNPAhpK2BL+VLx+arbjn/Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlUObWxz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlUObWxz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B82C4CEC6;
	Fri, 18 Oct 2024 10:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729248733;
	bh=nu+axcIHmBoHjKkvuSAudbDn1f6k4kUqvtK4lNSSWZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BlUObWxz2BhVr7RWXBXrP4rm4BujzOc5X/CbqNGqy93z07RnDUvwg1qodDZh/5rb6
	 g4WJ69plpUKngFdQV4QLrtkTt/+iePGgfB0yq/3WCP8cpuwHzBpMPgQHZ9VjDbx52K
	 Av7n2c7M+iQEiO8+BGHHBWFQ4RuDIsoRZcvaQcj5vxaChupyj9fNTyb8ezVR0dhb77
	 D7t6rTqq6wS+OAKcNtzLwpVvq5tuzY7+b/rfxvkx2Wp36nU5BPsex6PJjsOSVGqfez
	 ZdU7Z6fgvx0OWcvFXuSmmmXWHbf1FdSkU/ft6nVkql+TmDbKS30n5rHwr0CEX4V/fR
	 hnmdf8rSxXk9A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 4/6] bpf: Export more helpers used by mptcp_address test
Date: Fri, 18 Oct 2024 18:51:56 +0800
Message-ID: <518f962f7005352f6fae4c2c3e31541b5c9b67bb.1729248083.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729248083.git.tanggeliang@kylinos.cn>
References: <cover.1729248083.git.tanggeliang@kylinos.cn>
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
index 102d4d63f390..350fdff6a205 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -320,6 +320,24 @@ __bpf_kfunc static void bpf_mptcp_sock_release(struct mptcp_sock *msk)
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
@@ -347,6 +365,9 @@ BTF_ID_FLAGS(func, bpf_iter_mptcp_address_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_address_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_mptcp_sock_acquire, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_mptcp_sock_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_spin_lock_bh)
+BTF_ID_FLAGS(func, bpf_spin_unlock_bh)
+BTF_ID_FLAGS(func, bpf_ipv6_addr_v4mapped)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
-- 
2.43.0

