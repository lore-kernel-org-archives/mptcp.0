Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D698520262C
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248731; cv=none; b=MN7SiPfXqbuVAJlJXlhEDWqBFiVx4uf6pBCAyahgVHaFdDqw/cOYK0AMyhIyAFYJXYspB1Q+3+9qaZQRseKHzJtHtMT4wEN11XBVwSf3VUFyKorA6pfkwSzd7/EIuxlYLEtYEO6halOuuLpC+4WVk1LkvsPQhZwPU1WmZtFmAUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248731; c=relaxed/simple;
	bh=stCVvQ6rKIxdGUpMlz/ijnf/vQEvvqxYoS3QLSlidrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVoRJWNbq1j+EMa6dvNFOz2FSbLKvOr5TeczBXIY09YLELjeaRIiqTBoUtBoldbHgiM3/XGiU/CIqGltDhNkCSzadtrEUe54tydHNVrycsl9vh/7/p7IFDxXJ8renLekbZxvimJkodnVBHkCDPuAfXAo0GwGquO5RjLJwTUEWJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IU0g17G4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IU0g17G4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4398FC4CEC3;
	Fri, 18 Oct 2024 10:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729248731;
	bh=stCVvQ6rKIxdGUpMlz/ijnf/vQEvvqxYoS3QLSlidrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IU0g17G4ZiXv+bLQNRcwVh+o2kucmEwyLoqD7sANHUZNBbWe9B8TsROEZeCx+nzqt
	 h/YGgZ+XFOgNhc4EiVOOy/4FEyPCWEtjeWbd8sP/nXrY9qaKY/hPCtJETOfUSqUYWw
	 OwX/mcXHWBWtoaAn/fZ68Wb853fYF22AHclWwmEsdqbk3pRLKxwJ0mqm2IjpnhC5Uy
	 ++WJ6m9OcmwNWjQBuLufbqQT9ms/uRS1Ggn8OYD687hE2a0J3eFqy64njfQb9pacZe
	 Ux2uHoAfoUfXDdHlUdchQArKNVXGHWgzXuX2TKsgtnLnZ3nKyeWEHy4gPHDd5wLvju
	 8QhcdgF2GqkpQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/6] bpf: Add mptcp_address bpf_iter
Date: Fri, 18 Oct 2024 18:51:55 +0800
Message-ID: <ba6be35e277528249653ea525a158102f401d406.1729248083.git.tanggeliang@kylinos.cn>
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

Just like the mptcp_subflow bpf_iter used to implement the MPTCP BPF
packet scheduler, another bpf_iter is also needed, named mptcp_address,
to traverse all address entries on userspace_pm_local_addr_list of an
MPTCP socket for implementing the MPTCP BPF path manager.

In kernel space, we walk this list like this:

list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list)
	kfunc(entry);

With the mptcp_address bpf_iter, bpf_for_each() can be used to do the
same thing in BPF program:

	bpf_for_each(mptcp_address, entry, msk)
		kfunc(entry);

This bpf_iter should be invoked under holding the msk pm lock, so use
spin_is_locked() to check whether the lock is holding.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 1ad7f703abb2..102d4d63f390 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -214,6 +214,15 @@ struct bpf_iter_mptcp_subflow_kern {
 	struct list_head *pos;
 } __attribute__((aligned(8)));
 
+struct bpf_iter_mptcp_address {
+	__u64 __opaque[2];
+} __attribute__((aligned(8)));
+
+struct bpf_iter_mptcp_address_kern {
+	struct mptcp_sock *msk;
+	struct list_head *pos;
+} __attribute__((aligned(8)));
+
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc static struct mptcp_sock *bpf_mptcp_sk(struct sock *sk)
@@ -264,6 +273,37 @@ __bpf_kfunc static void bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_sub
 {
 }
 
+__bpf_kfunc static int bpf_iter_mptcp_address_new(struct bpf_iter_mptcp_address *it,
+						  struct mptcp_sock *msk)
+{
+	struct bpf_iter_mptcp_address_kern *kit = (void *)it;
+
+	kit->msk = msk;
+	if (!msk)
+		return -EINVAL;
+
+	WARN_ON_ONCE(!spin_is_locked(&msk->pm.lock));
+
+	kit->pos = &msk->pm.userspace_pm_local_addr_list;
+	return 0;
+}
+
+__bpf_kfunc static struct mptcp_pm_addr_entry *
+bpf_iter_mptcp_address_next(struct bpf_iter_mptcp_address *it)
+{
+	struct bpf_iter_mptcp_address_kern *kit = (void *)it;
+
+	if (!kit->msk || list_is_last(kit->pos, &kit->msk->pm.userspace_pm_local_addr_list))
+		return NULL;
+
+	kit->pos = kit->pos->next;
+	return list_entry(kit->pos, struct mptcp_pm_addr_entry, list);
+}
+
+__bpf_kfunc static void bpf_iter_mptcp_address_destroy(struct bpf_iter_mptcp_address *it)
+{
+}
+
 __bpf_kfunc static struct mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
@@ -302,6 +342,9 @@ BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_address_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_address_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_mptcp_address_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_mptcp_sock_acquire, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_mptcp_sock_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
-- 
2.43.0

