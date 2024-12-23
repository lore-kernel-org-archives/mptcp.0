Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE302207A
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734948363; cv=none; b=R3PNKWmR61sqYdK8hGILssrjSsZtsxIg3hTnZN553ELykQON69ropA3+G0osoM6wCzpB2KnLMACDc30viLvaLJ7u4VH1VOPU0ckYKIsjB9IpdpijI6RXyT9rikXODjjiRwd05JV7mXefLTk9Aq7jptVCb6cnmXEj7IODhFdQZb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734948363; c=relaxed/simple;
	bh=ntBvwPmlibDVnPC2SSzvncvbiDnANTrq4ZmS1NdZ370=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YcptjgowqIVlApqLXXUe6vXpqPZfoNnoYXegykdC+zeWD+2x+Q496bd1F/IO/28Sab3EHf0XtM21dQQ6Tsgv0Fy2Mm+2ICuK1p8EZfrNURx9PLLB8koZ+1HQGLKt39h91vEF8caeZjLVf3gvwFVnvl+kAelYnjwWT7vneWDfd6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gr019xEx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gr019xEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5451C4CED3;
	Mon, 23 Dec 2024 10:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734948363;
	bh=ntBvwPmlibDVnPC2SSzvncvbiDnANTrq4ZmS1NdZ370=;
	h=From:To:Cc:Subject:Date:From;
	b=gr019xExW1vbo1OLYrO1wMoSX/cG9M/zAuaNlnZ9LOzdJhWm+paxo8NaWHZMqm6Ig
	 nLb7x+yKzLXyEtH9Gx1o8zfQzEl+8bxDwRB0lDQuFDXCF/BhDMu2FtVmsEZlaAFLxh
	 ppdnxLExiHTFtKZfDZwnsyETM983jLVBC4pdmtHi39d+pYQ5PoxV6QOvTvQU+2lYFY
	 XIEQ5ML8nUMS77OdnfvUiWKpmpfH2TJKKgVPh45kSCY76mXxDqxDL20prLbjzMhW3z
	 E7dzQhy7gpRiJwOUixqNp51VGNDgp4XEjqI63pPKl5FP48iJ3oGKpmTMB2DUdk1hqA
	 b7x8M7dp11Kww==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 00/10] use bpf_iter in bpf schedulers
Date: Mon, 23 Dec 2024 18:05:42 +0800
Message-ID: <cover.1734947922.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v12:
 - drop struct mptcp_sched_data.
 - rebased on "split get_subflow interface into two" v2.

Based-on: <cover.1734942318.git.tanggeliang@kylinos.cn>

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

Geliang Tang (10):
  bpf: Add bpf_mptcp_send_info_to_ssk
  Revert "mptcp: add sched_data helpers"
  mptcp: drop struct mptcp_sched_data
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Squash to "bpf: Export mptcp packet scheduler helpers"
  Squash to "selftests/bpf: Add bpf_first scheduler & test"
  Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
  Squash to "selftests/bpf: Add bpf_rr scheduler & test"
  Squash to "selftests/bpf: Add bpf_red scheduler & test"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"

 include/net/mptcp.h                           | 13 +---
 include/uapi/linux/bpf.h                      |  7 ++
 net/mptcp/bpf.c                               | 55 +++++++++------
 net/mptcp/protocol.c                          |  5 --
 net/mptcp/protocol.h                          |  7 +-
 net/mptcp/sched.c                             | 40 ++---------
 tools/include/uapi/linux/bpf.h                |  7 ++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  3 -
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 19 ++----
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 68 +++++++------------
 .../selftests/bpf/progs/mptcp_bpf_first.c     | 11 ++-
 .../selftests/bpf/progs/mptcp_bpf_red.c       | 11 ++-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 34 ++++------
 13 files changed, 119 insertions(+), 161 deletions(-)

-- 
2.45.2

