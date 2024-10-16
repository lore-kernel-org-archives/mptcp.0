Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073BF433CE
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064004; cv=none; b=A+h34MJ7U5trsZ9hY3b0xZYLC4s78w7jPZZ6VvIehuWELXQHXe/hZIAxZM/7guqB7UZu3gggeHAQAbXfEXT/sjpZFeDX5SpM9wuGGvDQMzFrWAYTRGg8lLSByuOXUZ7vjK7tzNgVspA78poAeTxU5bZ7huY/O3HpWO9bTQtc3ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064004; c=relaxed/simple;
	bh=f2ekFtVmUWkCDiODpxrqa6AxlcHS1d7x2zLuePh5qwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u81bQ2Gs/UjQUz0Go5G5F5Sqf0mLvkbQbmSptf2/0h21U9kR2aopMBqu/Fyd91gjp07Hpxr8VMD70MGx/YxFdwMX4q4916tNCjNbgdYUb376mpe1Wi2oREvLm3IZv8xqYjDRLb7qRNGAiytUz9K5/uwNd/1FZfFH/ZONdOJUKFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OISio+Tz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OISio+Tz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F93C4CEC5;
	Wed, 16 Oct 2024 07:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729064003;
	bh=f2ekFtVmUWkCDiODpxrqa6AxlcHS1d7x2zLuePh5qwo=;
	h=From:To:Cc:Subject:Date:From;
	b=OISio+TzF+V/DAzkgXAsbFUhaWp3f0RyFBycfQ+gQOkrqQBeILraFbwyCMasHoiom
	 pPuNCYCARm7AvtBNAO6U6weMctnjkntnMRoZQqdbg3Ng6hysnB7hnofBYrclPqx32c
	 pDgmyPRl66Js5bjy6uZtv2qevuck3WdQDXw+EX2JiptZ4GThd6VClMRqDh5SxS8Y9k
	 YyCiAap3NIW3pAzuS3CP0s2aCOFjdK05IfoBLG/sKQ8Vpnxs8wCCm3O1O3JjyDV0jP
	 fmymOZSBe1718V0BknYfP+albH8RZL1qFBt/IojYhumdGA7tGXpg/bKNzoXg9Td9gi
	 0wBYfpvlp1FmQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 0/9] add mptcp_subflow bpf_iter
Date: Wed, 16 Oct 2024 15:33:07 +0800
Message-ID: <cover.1729063444.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v10:
 - rename bpf prog to "mptcp_bpf_iters.c" and change it as
   "cgroup/getsockopt" type. Since another bpf_iter "mptcp_address",
   to traverse all address entries on userspace_pm_local_addr_list of
   an MPTCP socket for implementing the MPTCP BPF path manager, will be
   added in the next set. The test program for "mptcp_address" bpf_iter
   will be added into this "mptcp_bpf_iters.c" file too and also defined
   as "cgroup/getsockopt" type.
 - change all bpf kfunc static as Matt suggested.
 - drop mptcp_subflow_active and mptcp_subflow_set_scheduled from the
   test program as Matt suggested.

v9:
 - rename bpf prog to "mptcp_bpf_iters_subflow.c"
 - drop the helper bpf_mptcp_sk(), it's not used in this test.

v8:
 - Make the test prog in patch 4 more like a bpf packet scheduler.
 - Export more mptcp helpers into BPF in patch 1.

v7:
 - As Martin recently replied, mptcp_stubflow bpf_iter can still be
used in tracing. So go back to the tracing selftest.

v6:
 - add KF_TRUSTED_ARGS flag in patch 2 (Andrii, Martin), then acquire
and release helpers (patch 3) are needed to be implemented.
 - test mptcp_subflow bpf_iter in "cgroup/getsockopt" (patch 5),
instead of testing them in "tracing" (Martin).

v5:
 - update patch 1 as Andrii suggested: if msk is NULL, initialize
kit->msk to NULL in _new() and check it in _next().

v4:
 - squash patch 1/5 and 3/5 in v3 together as Matt suggested.
 - a new squash-to patch to drop mptcp_subflow_active declaration in
   bpf_burst.

v3:
 - drop bpf_iter__mptcp_subflow, __diag_push, __diag_pop and
 __diag_ignore_all
 - drop declarations for bpf kfuncs

v2:
 - update patch 1 as Martin and Andrii suggested.
 - fix warnings and errors reported by MPTCP CI.

This patch set adds a mptcp_subflow type bpf_iter, and self tests.

Geliang Tang (9):
  bpf: Register mptcp common kfunc set
  bpf: Add mptcp_subflow bpf_iter
  bpf: Acquire and release mptcp socket
  selftests/bpf: Add mptcp_subflow bpf_iter test prog
  selftests/bpf: More endpoints for endpoint_init
  selftests/bpf: Add mptcp_subflow bpf_iter subtest
  Squash to "selftests/bpf: Add bpf scheduler test"
  Revert "bpf: Export more bpf_burst related functions"
  Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"

 net/mptcp/bpf.c                               |  93 ++++++++++++-
 net/mptcp/protocol.h                          |   1 -
 .../testing/selftests/bpf/bpf_experimental.h  |   7 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 126 +++++++++++++++++-
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |   8 ++
 .../selftests/bpf/progs/mptcp_bpf_iters.c     |  60 +++++++++
 6 files changed, 283 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c

-- 
2.43.0

