Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8795A1EB3D
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734041; cv=none; b=Hscl7xtpBpRj6DG+avz0BDqCl78VLU20lhpTQOUbEfC5ZNqyKkMyN8hvcuh3jmZOsfKtawUVytAEvWse1OE7l+X9AWetnrP+8f47XrhpckgVol1BqCMUU3HKAIsViyevWmnqX5FuaPfv/0vkP5+YZH0daP2WqQFyTDTuezR9saA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734041; c=relaxed/simple;
	bh=7x4kE9Vr94gGe1N2KZZpihcupw4k6xiHIVEV3nAPbPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nR4Didh7NgTkPUieC2dkwv4PpGNzb6lLog21QulpmlczQ82VCzwdY/ZPmiTbLSm7otBm1TlA1SUxVFPiVxGLGni8A7FVm0zgxQ1Gr4/5gTvoOfi3ykqJEXrsKVliPMGa1QAH++dWmg4g/OVLinbtmNEsaBdTigW+isBP3IXy44A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1VQOJE3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1VQOJE3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03B3C4CED1;
	Mon,  9 Dec 2024 08:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733734041;
	bh=7x4kE9Vr94gGe1N2KZZpihcupw4k6xiHIVEV3nAPbPM=;
	h=From:To:Cc:Subject:Date:From;
	b=c1VQOJE3/waIo+KXIs2+zqy57iOTqY4om/gA+dpmN2kbQfBU1OZPKTiMhUJPoSxBn
	 kLwU6HYOLXyVI3nf91Dq/wXQhwVP/ko82/7QahFOpvcphkWsUgPCg/7NaJZ0QDhb/N
	 emBzXCuxCIKTYLHEzmLItQAjWibj1C4hKSzX0btQgDjiXIcXVJc2TeSwoWh2TnFhGc
	 ziLXvkSM8NVN78U8Q5OMmo43fyVwD2icSnTrLYezxWrRpUTq2OgVDlv64NaJSKAQ+i
	 eO3cvBQZzXKzFZyEOTxLKX8nDM689AFNDMDjJdMWLdq2GtNWz7JIGlF2Gik5mo6mUn
	 n3YLlrJrk6X8w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/5] Squash to "Add mptcp_subflow bpf_iter support"
Date: Mon,  9 Dec 2024 16:47:11 +0800
Message-ID: <cover.1733733573.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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
  mptcp: update bpf_mptcp_sock_from_subflow
  bpf: Allow use of skc_to_mptcp_sock in cg_sockopt
  Squash to "bpf: Register mptcp common kfunc set"
  Squash to "bpf: Add mptcp_subflow bpf_iter"
  Squash to "selftests/bpf: Add mptcp_subflow bpf_iter subtest"

 include/net/mptcp.h                           |  4 +--
 kernel/bpf/cgroup.c                           |  2 ++
 net/core/filter.c                             |  2 +-
 net/mptcp/bpf.c                               | 34 +++++++++----------
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  1 -
 .../selftests/bpf/progs/mptcp_bpf_iters.c     | 11 +++---
 6 files changed, 27 insertions(+), 27 deletions(-)

-- 
2.45.2

