Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C0F63D
	for <mptcp@lists.linux.dev>; Tue,  1 Oct 2024 06:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727765242; cv=none; b=DvZKMMjHAy6ORRjOzU6/zJUC17KU+8Is0TzlKKhLCvUDl0elN+0+BGr+nrhofLdimjdD3Ie4hFzvW5+kRr6crs7HA3FQ8yQVhj4fQRBe/e2FRR/11a+5KTD2y4QqR7GA+wDpD2sr6kJbDX69z4sdltfUUz8T8srPGpFG/XXDsmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727765242; c=relaxed/simple;
	bh=XVIjjSdwpHuDqOi2ja4i7qVwKMc1oPDPKPe6rIqN+iM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PrcgnjeZGn/Dfy9OXLmknMAbzCA0qdIpHJtayUuMrGWpyxdTcK87sS2ZkDTd14AFN6JG+/kVs0i53Rd4rPZwfg1/VexPHVjcgDlaVMVYcnfMUsNanq/7+TS1OP9fhaWxc5KLQDf8053123sQ6hpdK6wSpCXwBv4h72l49PvDFAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIYSMCaG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIYSMCaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150BEC4CEC6;
	Tue,  1 Oct 2024 06:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727765241;
	bh=XVIjjSdwpHuDqOi2ja4i7qVwKMc1oPDPKPe6rIqN+iM=;
	h=From:To:Cc:Subject:Date:From;
	b=jIYSMCaGArLuEgZIlYO8f95OSIwE87OXt4hfqafEW9GnHTAT9eKdfyRj2762XUYZs
	 cgF8SMG0841rFk1XubnJxddm6VemRhQYm4gU9oKzs56LIzAjzr8uZMWlTl+VBPCHxR
	 aU4LbgmBY8pZo1OddoFiKeRh5bdkuaWIGVEPHuS4JV6UnkilVv166FC5Zy/KV6DcMc
	 kznWANCheRSXYKxgUUhE7VuKx0SS2GFL5tJD5ZSM7gpU1SlPfi7yNAbYBNfaElUhBc
	 NdzfZOLdUBsne+x+GH6JqyktGcKTTdCyza+K1BNzHFEPNg+fadDs2YXijpKNBi93G0
	 1ENXmwUmiASGw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 0/7] add mptcp_subflow bpf_iter
Date: Tue,  1 Oct 2024 14:47:07 +0800
Message-ID: <cover.1727764822.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

 net/mptcp/bpf.c                               |  81 ++++++++++-
 .../testing/selftests/bpf/bpf_experimental.h  |   7 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 126 +++++++++++++++++-
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |   4 +
 .../selftests/bpf/progs/mptcp_bpf_iter.c      |  39 ++++++
 5 files changed, 245 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_iter.c

-- 
2.43.0

