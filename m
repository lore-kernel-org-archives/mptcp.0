Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD951C07E7
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071237; cv=none; b=OrqCzJQilXjMcP4R0Pu5BGb0ncqPoTIAq/nA9lDgK27U+nwNY5snsnA3s010eea5OMK4N2bHQIjKS34t/tF9TK658fH/GaArut9+SDKQFX0B8jy2TRvhgtewBT97fghitVNGirzc5XkY6EQjhK7LwEvOMM3g0NwkvkaSh9V+xA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071237; c=relaxed/simple;
	bh=kluoBO/R6sSTRa++1QN22ufQ3f93T/nrEDI8kCfpCTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F6aLOgLzNQ6d3+SMk9f4TDwLfTJXK7pt7C50zfjX69Jm3PPGcnm1Tfbk6YNfjQtJqUo7IbgmJejAKab8DFmHI/kQaazMhswnC7vmIbbxiayn2/+6YgF9AJ2QjhIDM/CVsi5KETh5zu5QOmctv1vG97ARU3eHcNwGYxFsgXotl2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1QLejXY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1QLejXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BD4C4CECF;
	Wed, 16 Oct 2024 09:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729071236;
	bh=kluoBO/R6sSTRa++1QN22ufQ3f93T/nrEDI8kCfpCTA=;
	h=From:To:Cc:Subject:Date:From;
	b=Y1QLejXYdhaUj3TLxSm421j1MLptGpjKEuaniRYK3FVq42ez28+Yk5iTjIlDMf76H
	 XdfNE0XfdmvWxxYWeSAJgnsVxQuZxZOgSTvjCcwC3OqOTjoajQupcteqXZEssa71St
	 /JR+23Khoey8Pn0IRTHfrgLwIa9JuUeiYClCzjamISrrp4TrGPkXmYAoeUEnzPRStC
	 LsvPhgQk0UeP4aclxyp7BFpAnq1QFLYgc6qlGbXj+4Le+flftYHX2jvo2M6pT6GYCm
	 4O4e4dQ7e0HMxMp7+UT5Ie+Z1Uhd0megD40qn16UE0iSiVbx64RCGmxG7aiycQB3aC
	 llXgf9n/MkyXA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 00/10] use bpf_iter in bpf schedulers
Date: Wed, 16 Oct 2024 17:33:36 +0800
Message-ID: <cover.1729070999.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

Depends on:
 - "add mptcp_subflow bpf_iter" v10

Based-on: <cover.1729063444.git.tanggeliang@kylinos.cn>

Geliang Tang (10):
  Revert "mptcp: add sched_data helpers"
  Squash to "bpf: Add bpf_mptcp_sched_ops"
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
 net/mptcp/protocol.h                          |  2 -
 net/mptcp/sched.c                             | 22 ------
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 48 ++++++------
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  3 -
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 16 +---
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 77 ++++++++++---------
 .../selftests/bpf/progs/mptcp_bpf_bytes.c     | 39 ++++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  8 +-
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  8 +-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 24 +++---
 12 files changed, 133 insertions(+), 140 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_bytes.c

-- 
2.43.0

