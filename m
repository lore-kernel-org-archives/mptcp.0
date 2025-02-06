Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA13225A52
	for <mptcp@lists.linux.dev>; Thu,  6 Feb 2025 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738832707; cv=none; b=GSznz8oRxLHhm5PdYbzHLfU5X7u3SxR+HEiw24b/XvS50+3Do+q+pVezo17t49YAsV0y/k+AzpsCBOJbaywhl6BkOSWmM3FKEvHmvPVq+U52cy4AGOzMBBX8DdX545v1U/pQ3XSsim3HdiGPyuLzljiRXBqs9sXH+2iSyKqM1e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738832707; c=relaxed/simple;
	bh=0WefdEzH+mWENIx4ClLg1JdoIWgD6w+cobF69R0UgJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IFkfdBfwUDYi4QVM/E4MdER/TAr07lDSX60/MkiTu1ewuWbqfTwrJj5XaVSaApMigj8uQcL4WkiwkrVa+HNXvYLRFBy+eEenz/Jyf+GeaA6na5g6pXg0ZQ+/xDSPcVp/N4ia0QCxcOU1QdRPNCKs6HhQ6cfHeBeyc9uNPv+wHJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0NOcQk3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0NOcQk3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A65C4CEDD;
	Thu,  6 Feb 2025 09:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738832706;
	bh=0WefdEzH+mWENIx4ClLg1JdoIWgD6w+cobF69R0UgJk=;
	h=From:To:Cc:Subject:Date:From;
	b=e0NOcQk3eiMJHD5rfuwE+Y09t8DgeVoqGXuKX/81mHLvta2UDq0BGp9bWO/6Jacos
	 7AVx+ArB4k+Ooni6sa/veavtwOxnFNnBTdXKFDznHgBHBcX7bqHZwfZA/KOnhNSlBE
	 DQEgwB8OSu+mgc484nHlYcR85mvA7j/0VuU89fey1InWB2BTWwlCobImqXIDpbZovf
	 WQwzIFqbi/GxL9D55m1788/UB2sELn4F0Y6GRbSth40jl0dqNobv/+6ZE/NFZapj8n
	 YM2yJP6PIQXzEbJQp2qNYGQK8pdeDeoflMODIMtuHkkYNGR4lFg2zmr+mNTrmRDY1n
	 bS6OwsmqrgA4w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 0/9] use bpf_iter in bpf schedulers
Date: Thu,  6 Feb 2025 17:04:50 +0800
Message-ID: <cover.1738832147.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v13:
 - use '__ign' suffix to ignore the argument type checks of
   bpf_mptcp_subflow_ctx() and bpf_sk_stream_memory_free(),
   instead of adding a new helper bpf_mptcp_send_info_to_ssk().
 - use 'bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk)' instead
   of using 'bpf_for_each(mptcp_subflow, subflow, msk)'.
 - keep struct mptcp_sched_data for future use.

Depends on:
 - Squash to "Add mptcp_subflow bpf_iter support", v2

Based-on: <cover.1738470660.git.tanggeliang@kylinos.cn>

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

Geliang Tang (9):
  Squash to "bpf: Register mptcp common kfunc set"
  Revert "mptcp: add sched_data helpers"
  Squash to "bpf: Export mptcp packet scheduler helpers"
  Squash to "selftests/bpf: Add bpf_first scheduler & test"
  Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
  Squash to "selftests/bpf: Add bpf_rr scheduler & test"
  Squash to "selftests/bpf: Add bpf_red scheduler & test"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"
  mptcp: drop subflow contexts in mptcp_sched_data

 include/net/mptcp.h                           |  3 -
 net/mptcp/bpf.c                               | 52 +++++++------
 net/mptcp/protocol.h                          |  2 -
 net/mptcp/sched.c                             | 22 ------
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  3 -
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 16 +---
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 78 +++++++------------
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  8 +-
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  8 +-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 31 ++++----
 10 files changed, 80 insertions(+), 143 deletions(-)

-- 
2.43.0

