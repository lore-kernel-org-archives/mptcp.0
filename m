Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4EF804
	for <mptcp@lists.linux.dev>; Fri, 11 Oct 2024 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638849; cv=none; b=X0G645Lu+/gdF2OYj8vryQfkAqBReD/al2/SV/nIj+mAPnkei811U3q0J10zMnhxciVYs1ZIAb9FXjNHjgpNU6k8ZJ+S8irldVSA47v5LZN5SkKyh4Xw5Ov2PsWQZL6cltRKrM5XQvspay4F/q1mPWunb0sERQsjoPZTQrwO0a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638849; c=relaxed/simple;
	bh=71oiZ6wGLv1a4qH0LLqygBqm2PvQmeh7TjdN4eNPtkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=idagC8qI5V1EJONJukHrYY+lWQzrD6n/YHpWiLSKmAhKHEMNj0RtkaHggt4N3iY52OSGChPwWXybqgiqzWpdZuGlBPZsJJuTgZYl6UOK43o3UiavNqXs/6TYkmit7td2Wv/sLU+bWmK1u+g1ac7UHNEPWJbEXNC1TmgyBK1RBGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmGCzhH2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmGCzhH2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D272C4CEC3;
	Fri, 11 Oct 2024 09:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728638848;
	bh=71oiZ6wGLv1a4qH0LLqygBqm2PvQmeh7TjdN4eNPtkg=;
	h=From:To:Cc:Subject:Date:From;
	b=kmGCzhH2TVRq8V0UL3Py2gjFRSaAVH2HYJg+sninm6PzCbmRpmEPEH6gt99NOEBc8
	 rUv1PDzQmh7xbr/TrO6MdOYrrCXn3IsI2/oruDuAC6xp4TJ37+0WGQss1QRifchs70
	 RaxFS6BKU33xHAFzDJ5L8Ij22PTmeXNLcy00D/GJBQ3DAaP/p3dDPrqj3hlVH6BHDZ
	 Xf3mzW/B+rPMP4HW8wJtvvmnutcOXijOxsQaSw3EaoGlV+x8YlIdw0819zHX6Nvnrf
	 LDU0OViQP9BqAz8vd8XUyek5Nt7Ezx4ioUbW48QPyub1628O5ZDLo3XkjK1jPsF9Uk
	 L3FkprrS09bdw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 00/11] use bpf_iter in bpf schedulers
Date: Fri, 11 Oct 2024 17:27:12 +0800
Message-ID: <cover.1728638310.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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
  Revert "bpf: Add bpf_mptcp_sched_kfunc_set"
  Squash to "selftests/bpf: Add bpf_first scheduler & test"
  Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
  Squash to "selftests/bpf: Add bpf_rr scheduler & test"
  Squash to "selftests/bpf: Add bpf_red scheduler & test"
  Squash to "bpf: Export more bpf_burst related functions"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"
  mptcp: drop subflow contexts in mptcp_sched_data
  Squash to "selftests/bpf: Add bpf scheduler test" - drop
    has_bytes_sent

 include/net/mptcp.h                           |  2 -
 net/mptcp/bpf.c                               | 14 +---
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
 12 files changed, 131 insertions(+), 134 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_bytes.c

-- 
2.43.0

