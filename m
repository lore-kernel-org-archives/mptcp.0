Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D2D20FAA5
	for <mptcp@lists.linux.dev>; Fri,  4 Oct 2024 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046263; cv=none; b=Xj6OYxIB10AWlGOQl5drcy5/hmLCO8QdkTpptS1R2Xdoj3cpNtni14r3yhKlbBpqo+bEq5GdxNmllfyDo04sIVdaDqYvo3b1RoB79jfM3dfOMftls0dDboW5BMmaFOofHFdiYPR244I9+19ULJqkpOR5h/SVDDmlQ3NCv/GgVcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046263; c=relaxed/simple;
	bh=0P98k2kbn1JDGXOA7L1TdtV3EdYEW0K492uJ/WjTCNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s0tSEfZRqPn543ujpBJL/wcSZvbnZ/Ve01VHHn3Wes8Ad1zAvWzznuergDIhu1krMNRquw10YJGmhFDEudkOaREWdl3uZFEBZRIC8mvPPYevvdUX4a19hejuHtUI7IJ+t3RJb0uHZ8sshGt4oZ/X5pCXCyoloWVg6T/nXVAcAlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3qTNBGR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3qTNBGR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB00C4DE09;
	Fri,  4 Oct 2024 12:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728046261;
	bh=0P98k2kbn1JDGXOA7L1TdtV3EdYEW0K492uJ/WjTCNg=;
	h=From:To:Cc:Subject:Date:From;
	b=e3qTNBGR13iGuug9QYccLkQPr1bX36DFbxrt1eUwgy8KrEAwJe+Hwy+GfqvHOVN+C
	 yU7Od6DgAe0l80cTnkJ98WZut9E9pB+Osi5Y/xMXEswuUVaDe/vfVTOBc9k0PzSRZT
	 6ZRWQpawvGODsZ6zvDJ9UvZK+qH8FHYqAOPv7tEp7B8vkgKRPjDsjZRI/DWxxenBr+
	 EJ2evfWT0eXv/isBNOBpzdx8Ist/eWJJC6toWg2ZX/mD2d7FeFAmLQ3gZm1Q5W6g3N
	 jELcrHuCrITb/A7RpS3vcXGdwTDzzo/wpGEXqvw+Bnz64RE9/XVD5XuxsAKQYI2XfI
	 IJnUmvoMJEVeA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 0/7] add mptcp_subflow bpf_iter
Date: Fri,  4 Oct 2024 20:50:46 +0800
Message-ID: <cover.1728046021.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

Geliang Tang (7):
  bpf: Register mptcp common kfunc set
  bpf: Add mptcp_subflow bpf_iter
  bpf: Add mptcp_sock acquire and release helpers
  selftests/bpf: Add mptcp_subflow bpf_iter test prog
  selftests/bpf: More endpoints for endpoint_init
  Squash to "selftests/bpf: Add bpf scheduler test"
  selftests/bpf: Add mptcp_subflow bpf_iter subtest

 net/mptcp/bpf.c                               | 101 +++++++++++++-
 .../testing/selftests/bpf/bpf_experimental.h  |   7 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 126 +++++++++++++++++-
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  10 ++
 .../selftests/bpf/progs/mptcp_bpf_iter.c      |  42 ++++++
 5 files changed, 274 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_iter.c

-- 
2.43.0

