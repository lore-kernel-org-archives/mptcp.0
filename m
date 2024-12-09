Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C158E2165EB
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737772; cv=none; b=pinCths7pe/tjlYQ/BDPeHR3i0VWW8JDNodiVAp8UmZh9uWm8dTgp/qaMHm0lRFPMK4ovcpiM3aVoQ73eFVx5TNx/IN9XrFybi3O4+KNjJFxTk7Fy3wkJLexQSqUw2PwIGTXqEwAuBv5Phm6AazYsydsXbNWNOunvWvOZ1CsTXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737772; c=relaxed/simple;
	bh=aWI0nfm8q4DhlAOplQpsRC/JZhmRdSYaCaVnxm1wn3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X0MyfSSvmsIsymWhqU7deuMA6Kg4ENx7T18Q70t5ZPx0UVtgLyq6NMmJJnUU8T4iROH6H8X0dJPd0c0+hNK9avz6kHsOp3F5TJtsw0b2A9mN0lHjUrRx+ekkGY5L3FGuCemVki3H5cT87AKBNY9GlvP4UDhEXmMwfG77bxywllI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deQmyA9M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deQmyA9M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4F4C4CEE0;
	Mon,  9 Dec 2024 09:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733737772;
	bh=aWI0nfm8q4DhlAOplQpsRC/JZhmRdSYaCaVnxm1wn3s=;
	h=From:To:Cc:Subject:Date:From;
	b=deQmyA9MqM3OzetwfC735jNVo1Hfuz3CUssUHdxMXRdjo2xa8bXj0Z75kED01dYMW
	 3D9dgAi1ZUHfKVuXBNj4M5MfNxnspClniC3gWiaCeZDDAUGHJbJmCmqHMlA1/4QT5h
	 ho1t2AcHwIbXxsmxnPUfa1E++2DzYKS+XV6k1PKFnXsZKSdB6kChsBM1lu2CIlsiDf
	 xB5xt998BgGJYuMqxCNgln/lY1zQ83lS7ufMdwCGV0th0NW4bYPQFh4gZ0aZMue+Gd
	 SUk8tR3IsKE5pvbmymhqvgXEEnWFmxzj5i3e0p9Qt7L1CD3W3NBpxSvinNTm6mq8sw
	 KyptXk91pY3tg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 0/9] use bpf_iter in bpf schedulers
Date: Mon,  9 Dec 2024 17:49:16 +0800
Message-ID: <cover.1733737459.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v10:
 - drop mptcp_subflow_set_scheduled() helper and WRITE_ONCE() in BPF.
 - add new bpf helper bpf_mptcp_send_info_to_ssk() for burst scheduler.

v9:
 - merge 'Fixes for "use bpf_iter in bpf schedulers" v8' into this set.
 - rebased on "add netns helpers" v4

v8:
 - address Mat's comments in v7.
 - move sk_stream_memory_free check inside bpf_for_each() loop.
 - implement mptcp_subflow_set_scheduled helper in BPF.
 - add cleanup patches into this set again.

v7:
 - move cleanup patches out of this set.
 - rebased.

v6:
 - rebased to "add mptcp_subflow bpf_iter" v10

v5:
 - patch 2, drop mptcp_sock_type and mptcp_subflow_type.
 - patch 3, revert "bpf: Export more bpf_burst related functions"
 - patch 4, merge "bpf: Export more bpf_burst related functions" into it.

v4:
 - patch 2, a new cleanup for "bpf: Add bpf_mptcp_sched_ops".
 - patch 3 should be reverted.
 - patch 8, register kfunc_set.

v3:
 - rebased.
 - put the "drop has_bytes_sent" squash-to patch into this set.

v2:
 - update bpf_rr and bpf_burst

With the newly added mptcp_subflow bpf_iter, we can get rid of the
subflows array "contexts" in struct mptcp_sched_data. This set
uses bpf_for_each(mptcp_subflow) helper to update all the bpf
schedules:

        bpf_for_each(mptcp_subflow, subflow, msk) {
                ... ...
                mptcp_subflow_set_scheduled(subflow, true);
        }

Geliang Tang (9):
  bpf: Add bpf_mptcp_send_info_to_ssk
  Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
  Squash to "selftests/bpf: Add bpf_rr scheduler & test"
  Squash to "selftests/bpf: Add bpf_red scheduler & test"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"
  Squash to "selftests/bpf: Add bpf_first scheduler & test"
  Revert "mptcp: add sched_data helpers"
  Squash to "bpf: Export mptcp packet scheduler helpers"
  mptcp: drop subflow contexts in mptcp_sched_data

 include/net/mptcp.h                           |  2 -
 include/uapi/linux/bpf.h                      |  7 +++
 net/mptcp/bpf.c                               | 31 +++++++---
 net/mptcp/protocol.c                          |  5 --
 net/mptcp/protocol.h                          |  7 ++-
 net/mptcp/sched.c                             | 22 -------
 tools/include/uapi/linux/bpf.h                |  7 +++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  3 -
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 16 +----
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 62 +++++++------------
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  8 ++-
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  8 +--
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 31 +++++-----
 13 files changed, 92 insertions(+), 117 deletions(-)

-- 
2.45.2

