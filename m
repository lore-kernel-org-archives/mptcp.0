Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF29A18953D
	for <mptcp@lists.linux.dev>; Wed, 23 Oct 2024 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676431; cv=none; b=TRsrTtVxn4ddBHGZNrllkmJeUZcb19U1C7XSde5/P4pbb39F9k9IHgmv01lBh2ShkgkZXAc8NtKi+1FIpPdYxzLsXJhSlqJOHpu+n7CTLORFsIov6bXLZVUSSQk9K7vXDGLCGpKoRlFx0S5Exu899oqZ6eKj5yWzlBPDDvyTaT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676431; c=relaxed/simple;
	bh=SngQulW+0X7tgGcMUd2Ygo1uRdgtdO0/cljvx9yDrWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iOly8zrxw5B8FW5/i4udU7f3h7ydf0rll7WQ1brxno9/a66fySRRI0v1RCnN+lmrS5+V66TkAVpr7YNKaRTG8BMBHj2hLKATd5Z6UuN4W3mIT4yszrMqTvXzjgQhsOH1dMLTmln5Ik1cPtT0i3pM9WggUW732L42PL9tw8FxkEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOteeIbf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOteeIbf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5035BC4CEC6;
	Wed, 23 Oct 2024 09:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729676430;
	bh=SngQulW+0X7tgGcMUd2Ygo1uRdgtdO0/cljvx9yDrWo=;
	h=From:To:Cc:Subject:Date:From;
	b=BOteeIbfuLamxQPNu4wmCJqaZhHPHhqzODmpvvwxOfY6FowlAfEJFj+91Nr4MoQSt
	 TiKSB234I1YypQt1UAh2HuOnbOcwZfSGoSg/A6Ondxg855RF6myhZDLf6wNu+o/0yl
	 JlSb/Y8etEOESL645Ejith7NWYhyTPhOZ3PM6QKQBvliTRiMDkHUEYv5mgUNrqBULF
	 fBDHjefuFXu36elc5ZG7Yr5iGNr/ij7BAW9DfDICUQ/6FStYlqInxN7OLpQlA3nrg7
	 CkM4T4l2YedNTmMsGnSydml1mvEcwMoVwiuah7gG3cAaWPpopaFBQuwr+47bOrEgEy
	 xjVaX8PRY3/Gw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 00/13] use bpf_iter in bpf schedulers
Date: Wed, 23 Oct 2024 17:40:10 +0800
Message-ID: <cover.1729676320.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

Geliang Tang (13):
  mptcp: check sk_stream_memory_free in loop
  mptcp: make mptcp_subflow_set_scheduled inline
  mptcp: add mptcp_validate_scheduler helper
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Squash to "selftests/bpf: Add bpf scheduler test"
  Squash to "selftests/bpf: Add bpf_first scheduler & test"
  Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
  Squash to "selftests/bpf: Add bpf_rr scheduler & test"
  Squash to "selftests/bpf: Add bpf_red scheduler & test"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"
  Squash to "bpf: Export mptcp packet scheduler helpers"
  Revert "mptcp: add sched_data helpers"
  mptcp: drop subflow contexts in mptcp_sched_data

 include/net/mptcp.h                           |  2 -
 net/mptcp/bpf.c                               | 45 +++++------
 net/mptcp/protocol.c                          |  5 +-
 net/mptcp/protocol.h                          | 12 ++-
 net/mptcp/sched.c                             | 45 ++++-------
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 45 +++++------
 tools/testing/selftests/bpf/progs/mptcp_bpf.h | 14 ++--
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 18 +----
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 74 ++++++++-----------
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  4 +-
 .../selftests/bpf/progs/mptcp_bpf_red.c       | 10 +--
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 33 ++++-----
 12 files changed, 131 insertions(+), 176 deletions(-)

-- 
2.45.2

