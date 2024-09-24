Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E1580C13
	for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169002; cv=none; b=CDrNfHBwqsgvmY2pu81fhM5QTWXeSyaqt47q8wYzhzYhubOsWGgjPeJE0gDnMNFH5IZ25dl0pKcbQr8MD2Movy+hTdFQWmVtj8yB5cD2mdEPyIvGGnFoXNL7ry5nnjeA9QAbgZbqVi7hF5xPhMf4tsPXpvBpbUObOZvDAtpNUdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169002; c=relaxed/simple;
	bh=96nczBFjvoYYJDxipK2F2JDhfKh/PVPupETGb42V3Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NvirOTcgxOOLtLBvb3ci5grrSDWugzCt0X1kJ9CXc/ohd2FffX1Da/1USv0Tv7y74byEIBo0Cg5aGTnMFxffRaq3rTifgxbVuul7wR2zk2IpNXol4t83Ape+r0TDFeRmEi/iDU/K7Tg57cv9OoB+TmqMOdu3vSh+n09Xj7TFEjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEddF44n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEddF44n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42E0C4CEC4;
	Tue, 24 Sep 2024 09:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727169002;
	bh=96nczBFjvoYYJDxipK2F2JDhfKh/PVPupETGb42V3Xs=;
	h=From:To:Cc:Subject:Date:From;
	b=kEddF44nDI9A1F7WTdC/738qXILfw4ZpMrKZKGd/n1dyzB0mXVDNX1Lx8qwWClFya
	 MgF5N2LIHCqUL0+kXGfLCa6BP3gR8mITxKHK2IK/8TJUu+4OMipQfEJfM8+qcCvhFb
	 MNMVHHZ8067lNlj80QULc7jHRhAMWt6gk8dyKr86RNunxX+Q0ppZvLhYxQYbO2R0xr
	 JFfBSs8k7H9jJdB4Lv25bTTRK0SMelVNjuiev8kWbnnssU30cgj4m1r7mljnunqT11
	 xF4XgIYr5NYDbWjEvQumBHxtjLN6sqRDAgRWk8vvF4W/5F64f02nqR3aqvij3qypb+
	 Yos/b/t8rIhNg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 00/10] add mptcp_subflow bpf_iter
Date: Tue, 24 Sep 2024 17:09:44 +0800
Message-ID: <cover.1727168628.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v6:
 - add KF_TRUSTED_ARGS flag in patch 2 (Andrii, Martin), then acquire
and release helpers (patch 3) are needed to be implemented.
 - test mptcp_subflow bpf_iter in "cgroup/getsockopt" (patch 5),
instead of testing then in "tracing" (Martin).

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

Geliang Tang (10):
  bpf: Register mptcp common kfunc set
  bpf: Add mptcp_subflow bpf_iter
  bpf: Add mptcp_sock acquire and release helpers
  selftests/bpf: Add mptcp_subflow bpf_iter test prog
  selftests/bpf: More endpoints for endpoint_init
  selftests/bpf: Add mptcp_subflow bpf_iter subtest
  Squash to "selftests/bpf: Add bpf scheduler test"
  Squash to "mptcp: add sched_data helpers"
  Squash to "bpf: Export more bpf_burst related functions"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"

 net/mptcp/bpf.c                               |  85 +++++++++++-
 net/mptcp/protocol.h                          |   3 -
 .../testing/selftests/bpf/bpf_experimental.h  |   7 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 122 +++++++++++++++++-
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |   6 +
 .../selftests/bpf/progs/mptcp_bpf_burst.c     |   1 -
 .../selftests/bpf/progs/mptcp_bpf_iter.c      |  46 +++++++
 7 files changed, 255 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_iter.c

-- 
2.43.0

