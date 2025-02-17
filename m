Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BC418C907
	for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788449; cv=none; b=rpLMKVXNcX4OX7ZrLwKv8HmDkrATzJ51q8wKI37hg0E26IzP8XvMLAfx9xexN0S12WLPZMIFCA49HXAb0r7Zs+7iuczBKgPpFwusWH8z9bMDCFHI5NoGoQCaU/eogkQ/Jv1Bxv3PzE5JewEy7t80kQBHmcDt07PridORlpKDwS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788449; c=relaxed/simple;
	bh=7NIEgNdrmWAl6FeiZI67EFgJ52l8bnu6zkr7z4MDHn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oo+WSq6EAoup2DPFQww02dsg7zDaEcmTPrdeuPm0oNgJvoHeYmihO+5C0GE543Ni23x8gNsib66LEhhGIq7byRGJsr/oqy+9BnyWaIgJl5s7eDqQP/P+57HYuXOCliVpKrm0O6y0kGZysC1rQPzoUTVZrvG4Qr2TDi9UF9irQe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVw1V01i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVw1V01i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2E9C4CED1;
	Mon, 17 Feb 2025 10:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739788448;
	bh=7NIEgNdrmWAl6FeiZI67EFgJ52l8bnu6zkr7z4MDHn8=;
	h=From:To:Cc:Subject:Date:From;
	b=fVw1V01iERVkEJ7l1OvN3UMuzQBoKEWOYUJUJdUK7xBRJRedfrRL2JqHxR1zhGxh+
	 Aa20N/VyE00Ymcks80kZiwrVRJOwLyro5bf1G/y/cqrRCMhEibVPZ3KX2iRV0pJkkK
	 xCQ2pVlYtt9+Uuiz+LsXTyojrng4d6xLxIkxBO/v0nxCXsjBSXpfMoCpYS+WGCwSoK
	 R46xmEESeNN20eyKtpie5Bn31/aS5A0OLabHHlpNl22wvRk4q/BXm7fg18RpZODQDr
	 p8ctzikndbFsCFqe+2DfhHlF9u9jYZVslWWjLFZ/rE0QzJ+1vOQFqnf8sYZDqUI/pm
	 mEfxCWuROg8dg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/5] Squash to "Add mptcp_subflow bpf_iter support"
Date: Mon, 17 Feb 2025 18:33:57 +0800
Message-ID: <cover.1739787744.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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
 net/mptcp/bpf.c                               | 41 +++++--------------
 .../testing/selftests/bpf/bpf_experimental.h  |  2 +-
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  5 ---
 .../selftests/bpf/progs/mptcp_bpf_iters.c     | 10 ++---
 7 files changed, 17 insertions(+), 49 deletions(-)

-- 
2.43.0

