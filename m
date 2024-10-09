Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AA628EF
	for <mptcp@lists.linux.dev>; Wed,  9 Oct 2024 09:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467168; cv=none; b=G7X4yotU8nx9MmV9+j3nzqDiljwoqm8AnZmTQ/KLzqqGiee+FrpxXShfbk/xNbYbYYyIL/xN78S0C3+xL0c0EZuVEhxTWdUs8cRBOcXlhbR6dm/z17GZjX6CwZb7JMSm0QGmGEglGPNsxyzPVZHeCDv3fmMHLitMTaULyaJ89cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467168; c=relaxed/simple;
	bh=mZ2XjQArd4dAg/rj8WrWrbwmGsxsntVr72MiACAM2oA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Syfd0jCUE/j5JQogkqQBDUHrZUbOCN58JcazWLLRrojkTJo/UqT+Ujtn0frx265w1JoODte9WPMGKyhnq5u0qpxJ2M+lWLQVyzzn6Ch0Fp4KYzByGb8Il//a8udYJEXTtcPingsAcqFiMEWAJPDJQne7ZMndJzmFEbMb5/BKSz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqjL0v1v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqjL0v1v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB648C4CEC5;
	Wed,  9 Oct 2024 09:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728467168;
	bh=mZ2XjQArd4dAg/rj8WrWrbwmGsxsntVr72MiACAM2oA=;
	h=From:To:Cc:Subject:Date:From;
	b=DqjL0v1vLIRuEeJMmqSb6gk7B01Uwt86pc0D5k94nieqZ9AzuiwKsiAMRgyXC59eB
	 3Y2MnBPNPgRjBBtzmFFD47UWrw9ke+1vlyCRH4dLP4l5uugtT2MexW/mANbUrUmcrw
	 wTK+zrgl7gQRJRE94A9fei12Wn+v91dhwalnloGzeyxBxhcg6FdWXWd7dlUG5ZDh9z
	 4MthfsKXhbcPvuMWLQ3W5c6brssu2IKzTL1oOLsafQDvWL6pl8tlmrKmDo+UL7xB5+
	 y7C/mZNKI7q3xOl+CskYIJUgZ7GAIykREIDh0kAbkaGaS3Wq6qUepgrTvMn1pzIj59
	 0CjqGRK2KQ5jQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 0/7] add mptcp_subflow bpf_iter
Date: Wed,  9 Oct 2024 17:45:42 +0800
Message-ID: <cover.1728466623.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

Geliang Tang (7):
  bpf: Register mptcp common kfunc set
  bpf: Add mptcp_subflow bpf_iter
  bpf: Add mptcp_sock acquire and release helpers
  selftests/bpf: Add mptcp_subflow bpf_iter test prog
  selftests/bpf: More endpoints for endpoint_init
  Squash to "selftests/bpf: Add bpf scheduler test"
  selftests/bpf: Add mptcp_subflow bpf_iter subtest

 net/mptcp/bpf.c                               |  95 ++++++++++++-
 .../testing/selftests/bpf/bpf_experimental.h  |   7 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 126 +++++++++++++++++-
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |   9 ++
 .../bpf/progs/mptcp_bpf_iters_subflow.c       |  42 ++++++
 5 files changed, 267 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_iters_subflow.c

-- 
2.43.0

