Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D45339A8
	for <mptcp@lists.linux.dev>; Sun,  9 Feb 2025 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739095338; cv=none; b=Qu2v1XAq/Zusom2BFKKyATPYd6jGDoznVw3DOmK/NPPHTkqaXmcJ/B1enFZ1KnEMLePRAulSWWUY+8SILCvPJZC4bvLZXv9aNKHBY9/V0ekxCkYW0C2GQKqrt8At/Np8Vo+yG+YFoy1s76exwQTj8gCv9QccaOijQO1bhmVE6aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739095338; c=relaxed/simple;
	bh=EO84FoolsfkzFKeWSWDsBWamsRzYy2nPfODV9mVTZZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aoN6syncsz52JjWk/KOUMRZcMH9LN6M6urU8kOBOK9ZWXzLtjsDxu0q2qZnSB/JfpCUaA7Q0CjBLe+QW2iCbcsErwAT1+Y5D0J8ovS2wWT7HXJss7YkV0kp3+LkCDE7sxRY7JPQxv62h0MSAI4Fq/7uWqId18Dif/OBZSq+aJQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJkCg5qF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJkCg5qF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C957AC4CEDD;
	Sun,  9 Feb 2025 10:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739095336;
	bh=EO84FoolsfkzFKeWSWDsBWamsRzYy2nPfODV9mVTZZQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ZJkCg5qFXIXyvSp0DK2wuOoLRNeI00wklF0OP2YuVVXCacL7MabhyWZY2JqunqLAb
	 Z1FtT0ktK4TaONwuXjwKj+rU17OAGOC4tz3vAH17npEW9K1BnY7jvzSr+iP3cimOkf
	 pFi6VHidc/Lj1VVT5BJqrHDinNsUFePwiOx8P+yGvAnpGgy0PSXoJtw5AQfM49xToO
	 bTr1aZXfcQYEIB1LUxtzGwj3fTmpZaQarGmy3lalgVdo1V1QWaaeSpF7aFwnLCHS4t
	 8KLDKQ+NzYJU4Lo0ldzu3/5YVZVTHjKaokZQOemx66Xws+oX5WOQSzKjl4n0q3t+Wj
	 Wy8590TTTwHtg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 0/8] use bpf_iter in bpf schedulers
Date: Sun,  9 Feb 2025 18:01:59 +0800
Message-ID: <cover.1739083793.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v14:
 - patch 1, keep mptcp_sched_data_set_contexts() helper for future use.
 - patch 2, use "sk = sk__ign" in bpf_mptcp_subflow_ctx() and
   bpf_sk_stream_memory_free().
 - patch 8, drop "subflows" from struct mptcp_sched_data too.

Depends on:
 - Squash to "Add mptcp_subflow bpf_iter support", v2

Based-on: <cover.1738470660.git.tanggeliang@kylinos.cn>

v13:
 - use '__ign' suffix to ignore the argument type checks of
   bpf_mptcp_subflow_ctx() and bpf_sk_stream_memory_free(),
   instead of adding a new helper bpf_mptcp_send_info_to_ssk().
 - use 'bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk)' instead
   of using 'bpf_for_each(mptcp_subflow, subflow, msk)'.
 - keep struct mptcp_sched_data for future use.

v12:
 - drop struct mptcp_sched_data.
 - rebased on "split get_subflow interface into two" v2.

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

        bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
                ... ...
                mptcp_subflow_set_scheduled(subflow, true);
        }

Geliang Tang (8):
  Squash to "mptcp: add sched_data helpers"
  Squash to "bpf: Export mptcp packet scheduler helpers"
  Squash to "selftests/bpf: Add bpf_first scheduler & test"
  Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
  Squash to "selftests/bpf: Add bpf_rr scheduler & test"
  Squash to "selftests/bpf: Add bpf_red scheduler & test"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"
  mptcp: drop subflow contexts in mptcp_sched_data

 include/net/mptcp.h                           |  4 -
 net/mptcp/bpf.c                               | 50 ++++++------
 net/mptcp/protocol.h                          |  2 -
 net/mptcp/sched.c                             | 15 ----
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  3 -
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 16 +---
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 78 +++++++------------
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  8 +-
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  8 +-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 31 ++++----
 10 files changed, 81 insertions(+), 134 deletions(-)

-- 
2.43.0

