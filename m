Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB17C23CE
	for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788452; cv=none; b=C2zpBeOqdNVkGbCiaXf0hezRAyDZc9tJVTGmJ6YmmTxv+kVuR4OE353lMGwG81YnN8oVNWHe3dxqDmfTZGHedx5HwzayTPzf3EkhJLTpoTnsv6si7UQbRYRsjSnGsZ2uhELm8P+cehSnWLItO/pfQG/yXSJWLNNuFpJ8BVOWqhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788452; c=relaxed/simple;
	bh=Y/nSLpzRC0NZxGyn2KF0Yxwg1I5WdIB6hNFwT4Y3kEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ED91iAbuojEQhkCuH+XPqxj+oJJ3Mz/9DLL3AEMIwF3ZJHNFDKaVTBFRvM0ZdE9vL9Tr+GcILM2h2CXKzQs2rgRbDzuSNbpCl4H/bslkzt0kTZt/Fi2DGCTGyHNK8nAUQms8Oi1QXbq2bY6o0oXN+S8H008lCyqkNggRzvFdL6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzbvSd1c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzbvSd1c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A93C4CED1;
	Mon, 17 Feb 2025 10:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739788452;
	bh=Y/nSLpzRC0NZxGyn2KF0Yxwg1I5WdIB6hNFwT4Y3kEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OzbvSd1cSpg7ozdWzZEplAJCjHSnfDwvLZpPBVh8hckII+z6TpgY1NTA/4oTB0524
	 eeCbgwwoxm6xHz9g+oOWdQT2q8OjuYvoR8DC3XBQBv3oQjbA8/n3/FIBN5sYErCiE5
	 ivOwU0SbBAlAlECWIjINgvzSYswrbloJgNKE7YizWIQumzTzgi28h6axLJC31kxJKE
	 UBy1nSJN62EEd5MaaLz6YemZcuNclcrhJGIxDc66V9PARVUH6HZWnJU/dPLcKVoKQe
	 QKt3YgJ4isuX6YTZOyK2QFEYsjdp7f03oZFYOHWoF64VvhhazP6IMcnPlkpSSr1W+D
	 1DB26p3wBfA8w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/5] Revert "bpf: Allow use of skc_to_mptcp_sock in cg_sockopt"
Date: Mon, 17 Feb 2025 18:33:59 +0800
Message-ID: <f8db33efcff2a94d611519389b9fb8e6f0da6bd9.1739787744.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739787744.git.tanggeliang@kylinos.cn>
References: <cover.1739787744.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

bpf_core_cast() can be used in mptcp_subflow bpf_iter selftests to get the
msk, instead of using bpf_skc_to_mptcp_sock(). No need to add this patch
anymore, revert it.

This reverts commit d8d42f5a4542c2dc31e4e00c58508a821c6ab789.
---
 kernel/bpf/cgroup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 1ca22e4842cf..46e5db65dbc8 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2358,8 +2358,6 @@ cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 #ifdef CONFIG_INET
 	case BPF_FUNC_tcp_sock:
 		return &bpf_tcp_sock_proto;
-	case BPF_FUNC_skc_to_mptcp_sock:
-		return &bpf_skc_to_mptcp_sock_proto;
 #endif
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;
-- 
2.43.0

