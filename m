Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0393A1FBEB0
	for <mptcp@lists.linux.dev>; Wed, 11 Dec 2024 03:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733886725; cv=none; b=HyWh/RW3TXzdE8BZu+2eEYKVVzgnyW4wpj7xPiqcGFTsfV8ts3c3Q9GOAbxYs1DvTo/37ZAHVoR+m++NItHeILGZ3SNoAHf+nPeQxZKOqxUrjCU6WgfdJAYRNwOlE5UBl32RRq56xnsEx2vvMKwZvTdcyUH6bU19l4RRlaPC9H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733886725; c=relaxed/simple;
	bh=lHS8/0HUSxPFDgeUc2eWpSM8uOINI79q4S+aar3JY48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fzf9OqBnM02hdWE1YHsvwmPIeIyMhCoOutAfRvSMqizKmfu13e5RqwSFCGGoRxXMShleDWKAZVJ5QDG0rGR8QxXGLB1p70jxpqMo9QjOSHygbIa+twic/OmQ4aZetJ7YnMBjVZxWDKtz17EigiESVv8LQDuQps6FYQJHer53xnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvgDg0ur; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvgDg0ur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64134C4CED6;
	Wed, 11 Dec 2024 03:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733886724;
	bh=lHS8/0HUSxPFDgeUc2eWpSM8uOINI79q4S+aar3JY48=;
	h=From:To:Cc:Subject:Date:From;
	b=CvgDg0urmMBoHXde9FynmBNRZFlU1ikmiJcp5LxLJn5iySMBHKHnX/FYb5OWQ9xlC
	 KTNOKgM7tgU8pSOTLEu0hS0kl8/x4q9hL25mcoCsiEAZidM5JuO0kodkK4gZVKqLQX
	 lKOrwYhEu/Y06cRZordUoShHl+kLKtoYNwBEcrfHNS2eC+7FQgLR53J63H/N5r8Pup
	 3/dBE5Kl+8M4cAW2y8J6WVd4QT5hF99zDBSf6/TSr7H7Ge/Z3cKOvJICNppH5qjgWq
	 330xBsU2mO86hn2scfvj/nNN1GJx9q1g0jtRqyHcr4pqpvJkmciHl8pAakmilI6Wt/
	 IsE3pvTVdMdrA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 0/5] Squash to "Add mptcp_subflow bpf_iter support"
Date: Wed, 11 Dec 2024 11:11:51 +0800
Message-ID: <cover.1733886326.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v5:
 - update subjects and commit logs as Matt suggested (thanks).
 - avoid repeating checks in patch 1.
 - do stricter checks on subflows in patch 3.

v4:
 - CI reports the following BUILD_BUG_ON fails on i386:

 BUILD_BUG_ON(sizeof(struct bpf_iter_mptcp_subflow_kern) !=
 	      sizeof(struct bpf_iter_mptcp_subflow))

 Just like in bpf_iter_task_new(), change this "!=" to ">".

v3:
 - check sock_owned_by_user_nocheck(sk)/spin_is_locked(&sk->sk_lock.slock),
   instead of lockdep_sock_is_held(sk).
 - add "sizeof" and "alignof" checks.
 - drop bpf_mptcp_sk() and bpf_mptcp_subflow_tcp_sock() definitions. Use
   bpf_skc_to_mptcp_sock() and mptcp_subflow_tcp_sock() in mptcp_subflow
   bpf_iter selftests instead.

v2:
 - add CONFIG_LOCKDEP check in patch 2 to fix the build error reported
   by CI.

Address Martin's comments in v1.

Geliang Tang (5):
  bpf: Extend bpf_skc_to_mptcp_sock to MPTCP sock
  bpf: Allow use of skc_to_mptcp_sock in cg_sockopt
  Squash to "bpf: Register mptcp common kfunc set"
  Squash to "bpf: Add mptcp_subflow bpf_iter"
  Squash to "selftests/bpf: Add mptcp_subflow bpf_iter subtest"

 include/net/mptcp.h                           |  4 +-
 kernel/bpf/cgroup.c                           |  2 +
 net/core/filter.c                             |  2 +-
 net/mptcp/bpf.c                               | 41 +++++++++++--------
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  1 -
 .../selftests/bpf/progs/mptcp_bpf_iters.c     | 11 +++--
 6 files changed, 33 insertions(+), 28 deletions(-)

-- 
2.45.2

