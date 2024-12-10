Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E2C1ACECB
	for <mptcp@lists.linux.dev>; Tue, 10 Dec 2024 03:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733801525; cv=none; b=g7teDEiClUCCqy8pDAsYMyxXcjypGwHsS8kq2eFzis3xm7nr3EVfVWDJYE5+yWeF34U3XQ9AIjdjJikWXVvA/FcLxGJ0weRCMvD77VeLj+wR4zQmNY9rYzVfFdsXn5OP9+MFsq7ROkCEi9qqpRhBfJQRqjrcT7MeLqyCQIRaJNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733801525; c=relaxed/simple;
	bh=aY5v7BMr6ADgztx7SSslT2+Zvw03ZeOaZBFjJ2pdbWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lDxblrdeeYHyBpmC5TrM91xCKrgF9Ovm1LWxEtdEXj2wOVb4Y5gH95LPftdmsQaTVKd5eB7uEk/WWbp3rLGCwcJmG6T64a1LSCq3haoVVvW1PaenGn+4SslF2bjIKiH/sh4S5fa0s8a2ToA7ufENBoAmfDLzNHBgyPBY7bIU06E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/sROs5d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/sROs5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98683C4CED6;
	Tue, 10 Dec 2024 03:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733801524;
	bh=aY5v7BMr6ADgztx7SSslT2+Zvw03ZeOaZBFjJ2pdbWw=;
	h=From:To:Cc:Subject:Date:From;
	b=p/sROs5dOX3ZFeKIn2jTqKI6dnNdTIyxmru2Wu9f/rIop6VoBRqGMEpuojM42QymG
	 6gsR80sFfWbwAO51KjJzwFkgxfgbuP5vbrWAdZNXCFFa0VxrSkpuP2BAAY6apBidz3
	 3M6qOE3wGM4xbJmHvnwUj88UUjqXdNKy736b+7Ef0UeMvgzhy6/VBrSW/AtF8+PxB/
	 2H+WSEmbRXTjxmT86bT2wjiCsuYzIUQ8a8m2UYnrCnWAtZHXM5VU1cJAIE0yFlxXiR
	 DRNRDIEh+v0pg0xtBSWl3rI2astoITm9zyQ3BIfYGTSlRED5lODjQyKJFn25pdub01
	 T7BtVizjS0U6w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 0/9] use bpf_iter in bpf schedulers
Date: Tue, 10 Dec 2024 11:31:37 +0800
Message-ID: <cover.1733800334.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v11:
If another squash-to patchset (Squash to "Add mptcp_subflow bpf_iter
support") under review is merged before this set, v10 will fail to run.
v11 fixes this issue and can run regardless of whether it is merged
before or after the squash-to patchset.

Compared with v10, only patches 3, 5, and 8 have been modified:
 - use mptcp_subflow_tcp_sock instead of bpf_mptcp_subflow_tcp_sock in
   patch 3 and patch 5.
 - drop bpf_mptcp_sched_kfunc_set, use bpf_mptcp_common_kfunc_set instead
   in patch 8.

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
 net/mptcp/bpf.c                               | 47 ++++++++--------
 net/mptcp/protocol.c                          |  5 --
 net/mptcp/protocol.h                          |  7 ++-
 net/mptcp/sched.c                             | 22 --------
 tools/include/uapi/linux/bpf.h                |  7 +++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  3 --
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 16 ++----
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 54 ++++++++-----------
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  8 ++-
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  8 ++-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 31 +++++------
 13 files changed, 93 insertions(+), 124 deletions(-)

-- 
2.45.2

