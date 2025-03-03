Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36901F0E2C
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 10:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998024; cv=none; b=gbRD1pNboaF8WdSqnad1L0gwWxm+UtCaHacZdrIH9Sx4W1TDBfWcBXwgcUIen5efu4NoV9wrVkj+UDC2CtIvVJFBd7t342OkrewfjJb+TH2U+2JFIK3lBw5OXe3gWbtaj6zAebEeqpdB4qlwaafyQ31IH/0JfPIJFG8vE7Co5J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998024; c=relaxed/simple;
	bh=xFsYzDi24UmvPTPVT7ZoR+mOi3Iszbyg0BpESjj90xw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X480dq2gYJ3lVuNIRrPj6tXmqOcCvcTt4bmk+3eLdRvUGdWsoWo0+m2xTKO6qBE3zb5uWw334S6tiWRHJEgUh0vhdZPadnaneMgERB0Ona0/nQjHHEP8m4t/kd7NEO61+8HP5/X0WA9KWmMn3+Z4QdhxnuFgVH4Jd495v9qFgfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoeWf2Oi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoeWf2Oi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A612C4CEE5;
	Mon,  3 Mar 2025 10:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740998024;
	bh=xFsYzDi24UmvPTPVT7ZoR+mOi3Iszbyg0BpESjj90xw=;
	h=From:To:Cc:Subject:Date:From;
	b=HoeWf2Oi7TggNpc7b+4ZIlh+us/7ZQ/v7bfpLy70+pxUJq4itjXi7cSoT3wjV0icv
	 mBRjvIKuVMe3a1epqceIOzaYPoxumzkBQyIH9XTqVGp0VaKFvYIK+Ok9FLKKkjkYak
	 qE/ZQ/2wE8Nx9RHo6vRz5O0Z08BKE3d1BCKbj9XvDHdaCeHLZWcehswhOdL5KP+uxa
	 hRlHQEUSKU6HEGiMx2i6AT5CAERoovIhwfLR//fbAawhi9NTAIEV6IsMgFC7iP35fb
	 o1MCNR4h5jXDpTLNvuNRtnSLQdWNRLoTGXb6WKtk9ovtnR3y3RDaN+aXd8Z5NIKqrP
	 BNHhArha1lNfw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 0/5] Squash to "Add mptcp_subflow bpf_iter support"
Date: Mon,  3 Mar 2025 18:33:32 +0800
Message-ID: <cover.1740997925.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v5:
 - check bpf_iter_task in mptcp_subflow_new() as Mat suggested.

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
  mptcp: add bpf_iter_task for mptcp_sock
  Squash to "bpf: Extend bpf_skc_to_mptcp_sock to MPTCP sock"
  Squash to "bpf: Add mptcp_subflow bpf_iter"
  Revert "bpf: Acquire and release mptcp socket"
  Squash to "selftests/bpf: Add mptcp_subflow bpf_iter subtest"

 net/mptcp/bpf.c                               | 56 +++++++++----------
 net/mptcp/protocol.c                          |  1 +
 net/mptcp/protocol.h                          | 16 ++++++
 .../testing/selftests/bpf/bpf_experimental.h  |  2 +-
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  5 --
 .../selftests/bpf/progs/mptcp_bpf_iters.c     |  8 +--
 6 files changed, 47 insertions(+), 41 deletions(-)

-- 
2.43.0

