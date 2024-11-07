Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A124BA2D
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 04:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730953765; cv=none; b=F1DCsNM3qP61xHbjfS9fgSG+G4T3/hr+reJoUhiW3Pfl3XJydaU8arpH91wFGVdU/g8PGS1P1tu8VqKWJqHEf4ul7wci02IRdOrdDWxImRb0XyYaIfH67sw9WJfnvK3Mamlk/IQlFLcP5olTmn93jjJtr4Vj+s5+NQXaHUJdwqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730953765; c=relaxed/simple;
	bh=6jAeo9bgsyZFFUGuANsZ6laBPC4E8CX/YQCdXEnYE4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6ZlIVa1SObR4NHSq9cZ0xsvGJ1PxaxG99f1vJ+1Lg8gnw2vV+Xo+JjpEZJ0+EUdKNbIkthpOQITpx5dV7eEOYR6vMYT5EFRCTMHOOB4EodPLK7iUaSU0a3txXJBcIB+QRhStREk2xCEuKe69UoV3K/wDoykgRcgu2POeY13esE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rieIypk/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rieIypk/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AA6C4CECC;
	Thu,  7 Nov 2024 04:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730953764;
	bh=6jAeo9bgsyZFFUGuANsZ6laBPC4E8CX/YQCdXEnYE4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rieIypk/vMgh9tsvVMfLveYS1mFSJIzd7lDzEIAEvVS6K1IWfw8kVBkk4I8bOLG9o
	 huUVtkdKb4g+Afr+TVlsYCp/5VH/t1o7k6Dn3hQiQLxCwVID1JPuWfCwe5N6XiuMRx
	 hOAlvg/WNPGOoYaa1NacroLa4wgXgywvOsOmfL883oqSWHtDsmSAtO08xhJsKUTXtx
	 zGKErftEAkjYYBagYzZcKK4lHXG2CiDkkM+1cA1m1A6ymaHiJvuPxsSSR9s2LEac6I
	 0QGjwNVxs32TgC7IzeCAWJT92rAtFu0ZrUApMsK1iykpekcbfggDPi606cGTegXhYA
	 AGpg3eKTJyKFQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 3/5] bpf: Add mptcp_userspace_pm_addr bpf_iter
Date: Thu,  7 Nov 2024 12:29:08 +0800
Message-ID: <b7e3f523165ecc1456af06842c0e4631188fbcc8.1730953242.git.tanggeliang@kylinos.cn>
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

Just like the mptcp_subflow bpf_iter used to implement the MPTCP
BPF packet scheduler, another bpf_iter is also needed, named
mptcp_userspace_pm_addr, to traverse all address entries on
userspace_pm_local_addr_list of an MPTCP socket for implementing
the MPTCP BPF path manager.

In kernel space, we walk this list like this:

        mptcp_for_each_userspace_pm_addr(msk, entry)
                kfunc(entry);

With the mptcp_userspace_pm_addr bpf_iter, bpf_for_each() can be
used to do the same thing in BPF program:

        bpf_for_each(mptcp_userspace_pm_addr, entry, msk)
                kfunc(entry);

This bpf_iter should be invoked under holding the msk pm lock, so
use lockdep_assert_held() to assert the lock is holding.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index e9db856972cb..2c0701f5b0c9 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -214,6 +214,15 @@ struct bpf_iter_mptcp_subflow_kern {
 	struct list_head *pos;
 } __aligned(8);
 
+struct bpf_iter_mptcp_userspace_pm_addr {
+	__u64 __opaque[2];
+} __aligned(8);
+
+struct bpf_iter_mptcp_userspace_pm_addr_kern {
+	struct mptcp_sock *msk;
+	struct list_head *pos;
+} __aligned(8);
+
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc static struct mptcp_sock *bpf_mptcp_sk(struct sock *sk)
@@ -266,6 +275,40 @@ bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
 {
 }
 
+__bpf_kfunc static int
+bpf_iter_mptcp_userspace_pm_addr_new(struct bpf_iter_mptcp_userspace_pm_addr *it,
+				     struct mptcp_sock *msk)
+{
+	struct bpf_iter_mptcp_userspace_pm_addr_kern *kit = (void *)it;
+
+	kit->msk = msk;
+	if (!msk)
+		return -EINVAL;
+
+	lockdep_assert_held(&msk->pm.lock);
+
+	kit->pos = &msk->pm.userspace_pm_local_addr_list;
+	return 0;
+}
+
+__bpf_kfunc static struct mptcp_pm_addr_entry *
+bpf_iter_mptcp_userspace_pm_addr_next(struct bpf_iter_mptcp_userspace_pm_addr *it)
+{
+	struct bpf_iter_mptcp_userspace_pm_addr_kern *kit = (void *)it;
+
+	if (!kit->msk || list_is_last(kit->pos,
+				      &kit->msk->pm.userspace_pm_local_addr_list))
+		return NULL;
+
+	kit->pos = kit->pos->next;
+	return list_entry(kit->pos, struct mptcp_pm_addr_entry, list);
+}
+
+__bpf_kfunc static void
+bpf_iter_mptcp_userspace_pm_addr_destroy(struct bpf_iter_mptcp_userspace_pm_addr *it)
+{
+}
+
 __bpf_kfunc static struct
 mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk)
 {
@@ -305,6 +348,9 @@ BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_userspace_pm_addr_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_userspace_pm_addr_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_userspace_pm_addr_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_mptcp_sock_acquire, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_mptcp_sock_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
-- 
2.45.2

