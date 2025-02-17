Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E23F216E1E
	for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788884; cv=none; b=mCWcIGBn3pMme7Er9lOfX3Gbjt23lbV5pu/APduGQ8BMzF7bceVcrFkozD21A+b9xJLZNPBzLf/HNOWTY/1/LEYSRwDWqbMApRRfVyw6nk18mJAFELI74Q7A17SeRVe3jaY/GHapSLNLd90B5xkbSnmVUSYCaAHCTGOKmU3kTDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788884; c=relaxed/simple;
	bh=AAchjyF7/bM3uqlzcH4g3fQuvIasppuJz5DGIo5D81I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cp5AVhTnbYgESFnmGJEUzG46VODmwlyks6xplIwon/kL9pzdtDYXEpbs+eayV8Kp+FDgo9GLiHuJ+DYxpQT6oXJhw0+QAMAHRUEp4P0CbCom6pg/yuppPo4By345gce8fwbEqS63TYtPMi0IDUIjnAH/4n4euHiR4i4b66jLee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gABeQTK5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gABeQTK5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B23C4CED1;
	Mon, 17 Feb 2025 10:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739788883;
	bh=AAchjyF7/bM3uqlzcH4g3fQuvIasppuJz5DGIo5D81I=;
	h=From:To:Cc:Subject:Date:From;
	b=gABeQTK5L2Jld3NpRrunqrltJTRkHvnuTP0AjAnX/xh6L9ZKAf62SqPEt/Q66mpPW
	 g998YDCctAJSTHsVuLZWMT+uzdmroc8eLvzsGkdH4Ij7j0uJl1N4FIH6+7SkP+YeQr
	 vPH7PU7ybdhqjbvOukpl2gouIn1tts30xKrYea0/o/u/Z0d8bTLpYiaan2ETuvyw8e
	 MwVWnBTYzeTFIj12cRL7nixh7oWZ42OQP1gr0KCuOW3RQAwzOm1BnBOaYlm9YdbnKA
	 a+/bHOOqqlIS5QyxgWqY8sGl0wXS2LoO2c7t1oRk5FucBdQSQEVCiynkApcWrBMWAk
	 6yn1khgDbyk7g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v15 0/8] use bpf_iter in bpf schedulers
Date: Mon, 17 Feb 2025 18:41:10 +0800
Message-ID: <cover.1739788598.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v15:
 - patch 7, add the declaration of bpf_mptcp_subflow_tcp_sock

Depends on:
 - Squash to "Add mptcp_subflow bpf_iter support", v3

Based-on: <cover.1739787744.git.tanggeliang@kylinos.cn>

v14:
 - patch 1, keep mptcp_sched_data_set_contexts() helper for future use.
 - patch 2, use "sk = sk__ign" in bpf_mptcp_subflow_ctx() and
   bpf_sk_stream_memory_free().
 - patch 8, drop "subflows" from struct mptcp_sched_data too.

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
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  5 +-
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 16 +---
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 78 +++++++------------
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  8 +-
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  8 +-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 31 ++++----
 10 files changed, 83 insertions(+), 134 deletions(-)

-- 
2.43.0

