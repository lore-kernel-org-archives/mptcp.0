Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF6E1E511
	for <mptcp@lists.linux.dev>; Sat, 12 Oct 2024 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728740554; cv=none; b=d3K985tpv4anVqWQbfS0Sk+VuB1dLkWJ3iO1E3Sx0NFdsEswXd1PZT4eqeer8leB8/SOoNoEb1ayCxhe8md/NtFbiMWiYGg4zVdcQUlnGubPDK9vyeSjcLOTNQ6aRlluYRPF/X+/xC+SczpSk1nuDlcNKU3BLeuytQmR8Xw0mvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728740554; c=relaxed/simple;
	bh=j4Uj5DrngfGmQwvR6lGp9aXosSR+ale94j92vqbJhfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KvBayY5EndvXuV7luY2cZhVJZRy03Uz2qpl9iTTRxOkvJnsXRvPoG/UV3+kkcn5Ja2c40yJkkMWglrjzt3TSqUipasjfqtw2qBkUTXSjjq/kV9EPO4l857kltba6RT/Kscadrim6103zoTbh4XXwy9Df5loVfo7x6Qq1FIan5SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaW/qH+U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaW/qH+U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6A5C4CEC6;
	Sat, 12 Oct 2024 13:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728740553;
	bh=j4Uj5DrngfGmQwvR6lGp9aXosSR+ale94j92vqbJhfg=;
	h=From:To:Cc:Subject:Date:From;
	b=XaW/qH+Ua5gNc8yyGzbDYFOAAXqvurVvRwRFcmMRX2Vs77cBkP6M8sdvxEtzCW0P6
	 TFYkt8OvJ/LdqL/JMv45M8IEF9x7L2ADdsgmU6n/Z9e5tFBODNsX8M0IaBrUGoUp8e
	 +TNQsLvmfWhx5tw2qH8hN7JIlAFy2j7TbEWAQTnbGY6Ppmxy11RqMJM3cT0grgGVXd
	 Jp+v9poLPOVeRPY3pAv2N6BwO0mYojYFikrRiZzUBeaR99Uxh1Lv1CtJG6UpGPqcmS
	 RQcf1wBQTAzPake0BPrFehu4etMuZxB+11PtSCh12V/7RAhaZG6ADDKYSTYRjfpt8V
	 lt1VexoOwIVQg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 00/11] use bpf_iter in bpf schedulers
Date: Sat, 12 Oct 2024 21:42:05 +0800
Message-ID: <cover.1728738219.git.tanggeliang@kylinos.cn>
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

Depends on:
 - "add mptcp_subflow bpf_iter" v9

Based-on: <cover.1728466623.git.tanggeliang@kylinos.cn>

Geliang Tang (11):
  Revert "mptcp: add sched_data helpers"
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Revert "bpf: Export more bpf_burst related functions"
  Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
  Squash to "selftests/bpf: Add bpf_first scheduler & test"
  Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
  Squash to "selftests/bpf: Add bpf_rr scheduler & test"
  Squash to "selftests/bpf: Add bpf_red scheduler & test"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"
  mptcp: drop subflow contexts in mptcp_sched_data
  Squash to "selftests/bpf: Add bpf scheduler test" - drop
    has_bytes_sent

 include/net/mptcp.h                           |  2 -
 net/mptcp/bpf.c                               | 24 ++----
 net/mptcp/protocol.h                          |  3 -
 net/mptcp/sched.c                             | 22 ------
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 48 ++++++------
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  3 -
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 16 +---
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 78 +++++++++----------
 .../selftests/bpf/progs/mptcp_bpf_bytes.c     | 39 ++++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  8 +-
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  8 +-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 24 +++---
 12 files changed, 133 insertions(+), 142 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_bytes.c

-- 
2.43.0

