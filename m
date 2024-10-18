Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D547200B94
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243146; cv=none; b=qWOtB+f+P1avLCyYAHwoDTfoeQvj+CL8wpcppIXNDZrNCP0PddX1ZVk9Erqw9QzmdGcNjBYUxU3VDCQhHF3n881OYMcWLoQHNjnKpABsYjrSrVNThZlD2QVky0XG6CC58wynclXMaZXBjHMejbHvpR6+Ja1+5e/9/UNMsH+XkhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243146; c=relaxed/simple;
	bh=3lhgcHf23cXR2oG5wHiv+YLvO6VK6YmwGoIRBBX78yc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B7vLrYvy2swtMTlgNXYrvKgH/ruWvIsGkHU8LPcmXhRrv0oiHwuPIWKGssFF/39sb0B3xXY6XtmD0U2M9NsaJM1k0/ryK2QSooOfGKy7ZRT/9STbMB0EsTHtjy02w+jDxGLo/5REnnXTLW/NuLfPKCb57GeJlVq4DcYmHsCxOdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sje/6yja; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sje/6yja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DC0C4CEC3;
	Fri, 18 Oct 2024 09:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729243145;
	bh=3lhgcHf23cXR2oG5wHiv+YLvO6VK6YmwGoIRBBX78yc=;
	h=From:To:Cc:Subject:Date:From;
	b=sje/6yjabJZHVomJ8y5BcyKT8OluT7PCnIAgSVNpICaCN9t2cHtTl/TABhGKaW02C
	 kwItYDO71dtEiFiozTqwy0G/EI2tdWc6pDlkf+QP6+WCNE+rhwtfY8EvUQIzbb3Xe8
	 2Ow8BxhBbt0EVJiJRhK3TtOz/b4Ci00etv1xPWoPkA89nRl10EKa/6s9PuD2xr6ssb
	 WOmnBYGnSjuQ393IyfTaxHvPCPVg387Pwg3iJUqquzn/K1CdBT2+vUnK0BJlyGDyX8
	 pGW1MfrRfXjzH6yTv+CszenhYv0D8YskinCJhqKzLVbKAWB9n35N4EthwMXmggQTO8
	 ZLbK7gEwytNcQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 0/9] add mptcp_subflow bpf_iter
Date: Fri, 18 Oct 2024 17:18:02 +0800
Message-ID: <cover.1729242644.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v11:
 - fix building errors in v10.
 - update patch 5, change bpf test IP addresses more like that of mptcp
   join selftests from:

	#define ADDR_1	"10.0.1.1"
	#define ADDR_2	"10.0.1.2"
	#define ADDR_3	"10.0.1.3"
	#define ADDR_4	"10.0.1.4"

   to 

	#define ADDR_1 "10.0.1.1"
	#define ADDR_2 "10.0.2.1"
	#define ADDR_3 "10.0.3.1"
	#define ADDR_4 "10.0.4.1"

   This ensures that it can be expanded to two namespaces in the future.

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

 net/mptcp/bpf.c                               |  99 +++++++++++++-
 net/mptcp/protocol.h                          |   1 -
 .../testing/selftests/bpf/bpf_experimental.h  |   7 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 127 +++++++++++++++++-
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |   9 ++
 .../selftests/bpf/progs/mptcp_bpf_iters.c     |  60 +++++++++
 6 files changed, 290 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c

-- 
2.43.0

