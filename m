Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF096BA2D
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 04:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730953766; cv=none; b=ZgJ8cv+9K8dLQdnGbqAGyKDu8q9ZSq8rKdL17zjctiQv1/9b1MFZYZwNhx2ajFaIX+86zA8/ZDsqkoWF4YBAW/MPNeNmMznc2YBCfYahTuqxXr/2fpZtiCfdmScC6FBYbHxhXq/5BAft4jjRWD54KQIvcPJOfuwUHZu4tCvhKwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730953766; c=relaxed/simple;
	bh=0qNYKKGrTWHlM2l3gNRxl1Dta1+AqGADYbaq8jEftvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AM0DhXonVfIYxUekVWDH8cXKRwjyBemPMa8Z332jO5fvhYpugp1t0NeFO5FBotOHgCqVhE13Bg5/clTJE7biSK95qaI049MmYebeCv7KHfgvSe/3PWXHYH9ROcWzE1NPScO6JQgfTwvRZZsrHjctqNXSsha5blLphdhMghk6Nq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBW5Etsm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBW5Etsm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF26C4CECC;
	Thu,  7 Nov 2024 04:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730953766;
	bh=0qNYKKGrTWHlM2l3gNRxl1Dta1+AqGADYbaq8jEftvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XBW5EtsmyiHWrGWNaUPWbq2BonsvXH9EfA8ovJHitrJUhZTTW/46CqPe6ef+5iNuh
	 eAALBmC7lqMc+PJH1lMWUeoj9Zr1+N6vaedd6Om5alWst2CseMS1wbMaR26iikIGu9
	 l6VIIa+IA/efARzC1IWv5gQd6Ih4HcdwVe0VfqnexI6JDlUBah29y8EiHBLbSLofkR
	 4RN5NwfADkJpvj2PFEfYHfKNHSHH59x+CetkUkD9NtJbMxKsqYRmpSfZo01kVnPLOi
	 cxdjBEGVn7R/PY3ZoYVV+3sf7zweT4he9/a7P2IrGbNC3jpPPjbhPweTjN1R0wp9vE
	 dzsQovwbO4JBA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 4/5] bpf: Export more helpers for mptcp_userspace_pm_addr test
Date: Thu,  7 Nov 2024 12:29:09 +0800
Message-ID: <ea7e5fe9651149f3f0eb09fbd70f7942d3049b8b.1730953242.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1730953242.git.tanggeliang@kylinos.cn>
References: <cover.1730953242.git.tanggeliang@kylinos.cn>
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
program to hold or release the msk pm lock. And bpf_ipv6_addr_v4mapped()
helper is also needed by the mptcp_userspace_pm_addr bpf_iter selftest
program.

This patch adds the corresponding BPF wrappers for these helpers and adds
them to the mptcp common kfunc_set.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 2c0701f5b0c9..6352b2b4f505 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -326,6 +326,24 @@ __bpf_kfunc static void bpf_mptcp_sock_release(struct mptcp_sock *msk)
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
@@ -353,6 +371,9 @@ BTF_ID_FLAGS(func, bpf_iter_mptcp_userspace_pm_addr_next, KF_ITER_NEXT | KF_RET_
 BTF_ID_FLAGS(func, bpf_iter_mptcp_userspace_pm_addr_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_mptcp_sock_acquire, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_mptcp_sock_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_spin_lock_bh)
+BTF_ID_FLAGS(func, bpf_spin_unlock_bh)
+BTF_ID_FLAGS(func, bpf_ipv6_addr_v4mapped)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
-- 
2.45.2

