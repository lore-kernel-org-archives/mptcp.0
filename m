Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A281D0E35
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 06:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730268653; cv=none; b=npeKEdZmOasTN0UpwZ8v+TuXahg+EAKCMjaJkyQX5jIzgWg5HEhSww8t9UfgeKaFbUE9Fr+ltBlyCyZUt71UiDFv0kYuuDWRuQNi1HmK+JGrL8+8jZsJqbdjt6n4cV+rPFrrArYwyCxN4uOtvn8kYsXUbRjZpYEggTtRVlmbdu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730268653; c=relaxed/simple;
	bh=UumYUY0H70sozznL50fgTD2+qoV9jOFs1AkZsQEUoQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mhv7k6W4DN676+wQVOAmPIrdrkDfYHXs5+TO/XnGwD9DvMadHOVLPfiRNLwRW/PbRD2BNe1roNxz7jBkoI0v1rMIQC4YCSIxebHmBXArhWKQ2eKKnBUvHblRNSOXP+G1x5Oj8U5iAlN3lSYZ+iQept5I0DFw3Z+R9IhbutaFlhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rm8S7yQO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rm8S7yQO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526CEC4CEE4;
	Wed, 30 Oct 2024 06:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730268653;
	bh=UumYUY0H70sozznL50fgTD2+qoV9jOFs1AkZsQEUoQs=;
	h=From:To:Cc:Subject:Date:From;
	b=rm8S7yQOXuEoE3VRXX7J+ZZu87DJ4j85mVw/Z3FhyKyHjBedH/MdDs4y+lNqnOCnH
	 iPtbMbRF11C5j4zzXU42pMLV5pkCKyjfAc3NOajPbJE53IKgt3wY8Ur/esXJAkEyHN
	 rFz54q50J/TI6pE5o2/ZiNmVK+gWMKIZD1VlNN7I0S5q9G6991NhdSCyodPnter9li
	 PuuiIGexCnY/McmYq72pLdp3vIW8Kaqc1+iMdwQla+lQl6pMrPePIKZ5vV6jWSacDW
	 Voh9+QerP4SVYcQFJyNfJ1lIyJ9l21e6QPR74+FToiaWCwtwCLRdI2j+3URZsTCGmV
	 3A12bfxtsgKGA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 00/13] use bpf_iter in bpf schedulers
Date: Wed, 30 Oct 2024 14:10:24 +0800
Message-ID: <cover.1730268415.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v9:
 - merge 'Fixes for "use bpf_iter in bpf schedulers" v8' into this set.
 - rebased on "add netns helpers" v4

Based-on: <cover.1730260715.git.tanggeliang@kylinos.cn>

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
 net/mptcp/bpf.c                               | 45 +++++-------
 net/mptcp/protocol.c                          |  4 +-
 net/mptcp/protocol.h                          | 12 ++-
 net/mptcp/sched.c                             | 45 ++++--------
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 45 ++++++------
 tools/testing/selftests/bpf/progs/mptcp_bpf.h | 14 ++--
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 18 +----
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 73 ++++++++-----------
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  4 +-
 .../selftests/bpf/progs/mptcp_bpf_red.c       | 10 +--
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 33 ++++-----
 12 files changed, 131 insertions(+), 174 deletions(-)

-- 
2.45.2

