Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8501BF510
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 03:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740368269; cv=none; b=Dj4bf80MDdIfc7YcArUGRuOwDN2QPpAmM9TZZ1c/cfj83JYCLQNVe1NMY52BCyDqOV2KQpR9FImKKEJyUrOzCB97ivwbqS85yT6pGGt8KXfsrS5+j+vsTqFqPyoqFMOoyRkZdcW0Z19w6IO200E/EwVSFsFI18kUH24GlPsSt7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740368269; c=relaxed/simple;
	bh=0pq5NPRLRrOQGS4UVVx8emfLPkSKB0Vj+hx+VIZulLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YxGb3+sDGil6XCo/azlPVBP0Am2fwI0UP/pnSllY6UFkTX42jSHxG9M57C3G8BMl6wh0dLCrTlzJ8M8v7XUpMLQo+NubZfURwsSzSUcrIsFGik07HbsRMqjc69g1U/AuxUAp3LkbK2cFpFE/9bl5ndP1K6kyat3IkUEV1cHA9Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVv5YVfA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVv5YVfA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA1EC4CEDD;
	Mon, 24 Feb 2025 03:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740368269;
	bh=0pq5NPRLRrOQGS4UVVx8emfLPkSKB0Vj+hx+VIZulLw=;
	h=From:To:Cc:Subject:Date:From;
	b=WVv5YVfAyvEF6QuCRxuJ85Bkvk9mQVSPqvnrAPueRUOdUkKjEVh+LWAIBAVTh4toK
	 8M6sibO5xUNOActw/8QOmZnPzGvRZgkEW6ByZLWdTapOtx7I5trQ/LknU5GhftEhRo
	 g++x18leQaQT0EIgH49l8BTru/Lu+AE/C3TF13o5UoMkprkRdhL1RRnyI/4sWbzJSh
	 njAytSyeg58+ImMaBzQ8LvWglc+sNQOmmpXZstI3A7qM8K64FlJNGawWJsbEA4MYCK
	 U6Wf5czEFz0Ly/T+YlDZO5clIRO98/J0L8c8GT3n3wRZQPo0VmbcAc3m2sxVQfNdKk
	 xqhZQQzs56ysA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/5] Squash to "Add mptcp_subflow bpf_iter support"
Date: Mon, 24 Feb 2025 11:37:35 +0800
Message-ID: <cover.1740368110.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v4:
 - drop sock_owned_by_user_nocheck and spin_is_locked. According to
   comments from Mat and Martin, in this set mptcp_subflow
   bpf_iter only used from a cg sockopt bpf prog, no need to add these
   check at this moment.

v3:
 - patch 3, continue to use sock_owned_by_user_nocheck() and spin_is_locked()
checks instead of using msk_owned_by_me().
 - patch 5, drop declaration of bpf_mptcp_subflow_tcp_sock. It's no longer
used.
 - patch 5, update the comment for mptcp_subflow_tcp_sock(), which is a BPF
helper, not a kfunc.

The commit log of "bpf: Register mptcp common kfunc set" doesn't match the
code, please update it as:

'''
bpf: Register mptcp common kfunc set

MPTCP helper mptcp_subflow_ctx() is used to convert struct sock to
struct mptcp_subflow_context. It will be used in MPTCP BPF programs.

This patch defines corresponding wrapper of this helper, and put it
into the newly defined mptcp common kfunc set and register this set
with the flag BPF_PROG_TYPE_CGROUP_SOCKOPT to let it accessible to
the 'cgroup/getsockopt' type of BPF programs.
'''

v2:
 - Drop bpf_skc_to_mptcp_sock
 - Check the owner before assigning the msk as Mat suggested.
 - Use bpf_core_cast() in mptcp_subflow bpf_iter subtest instead of
using bpf_skc_to_mptcp_sock().

Address Martin's suggestions for "Add mptcp_subflow bpf_iter support" v2.

Geliang Tang (5):
  Revert "bpf: Extend bpf_skc_to_mptcp_sock to MPTCP sock"
  Revert "bpf: Allow use of skc_to_mptcp_sock in cg_sockopt"
  Squash to "bpf: Add mptcp_subflow bpf_iter"
  Revert "bpf: Acquire and release mptcp socket"
  Squash to "selftests/bpf: Add mptcp_subflow bpf_iter subtest"

 include/net/mptcp.h                           |  4 +-
 kernel/bpf/cgroup.c                           |  2 -
 net/core/filter.c                             |  2 +-
 net/mptcp/bpf.c                               | 41 ++++---------------
 .../testing/selftests/bpf/bpf_experimental.h  |  2 +-
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  5 ---
 .../selftests/bpf/progs/mptcp_bpf_iters.c     | 10 ++---
 7 files changed, 15 insertions(+), 51 deletions(-)

-- 
2.43.0

