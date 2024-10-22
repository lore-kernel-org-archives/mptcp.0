Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87559127E37
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 07:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583555; cv=none; b=ssqCmfVIkvZ7EPiQXcrIHCqBGYd6F20YM06icdoq0rzaLpfXK+LTl6uv4XAcJMof4tkCtEWdscCkNFreJqNUMOW3r+65hBpEoVFKw+VuJwYyxbOcl9USsTLxUTxHNf9S1CtVSS9AeJwapdvUowJ8Q1GR99n8x3rdBLJBZV/5mLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583555; c=relaxed/simple;
	bh=7iMPCmMc3LqwxgaY6FMhdVqnu1UU8qSMI+KdGQpygDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m6BAuAyOSPZ/aYKeOboD0fu62tKOYXmsCAnmL5NNzrw8kMheZ2TyPpO+hMvB1K5UYWciIWPMa+Buv9SzRa1DdYolZcT/mM5DAeBquGrBIHfYnG+8cnytEAPh4yC+vbJsCqWDTI8JNVzfVXKGUkIbglbFYoC6m+uBef/g9kBQSHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDwXTRB2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDwXTRB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2E6C4CEC3;
	Tue, 22 Oct 2024 07:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729583555;
	bh=7iMPCmMc3LqwxgaY6FMhdVqnu1UU8qSMI+KdGQpygDc=;
	h=From:To:Cc:Subject:Date:From;
	b=VDwXTRB2t2wWOHGr7dKK5ri1V/ayohuBz0rSXzN/GieXPYniCq1pptQa+dNQAI1RB
	 uonqYozy0x4xQbOcBklO10ejXMPZBwf2plNIkuu8LlpQkp/b+eeZ7J2iPqJ6dcKsMQ
	 2QLZKS4UCwZoNdlQet/U+AVu9V5pW/sI3bJ1uWjEoIgDJCvLmcMdKeWN9gsVP2zFUG
	 +IVP5KgDoMb+blvCYpSEg34sWV5t7K7yG6jJKb5oCp3rWVE+Hd4PWL1uAgAjwSN0Py
	 HxRu8GIeBVZQFOJ0tRUjhZJxuv+dEO1ffLxkphiwsEfml+JR9ihC6X7AMiSYoNJodM
	 h+OHzg7L9NeHQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 0/5] use bpf_iter in bpf schedulers
Date: Tue, 22 Oct 2024 15:52:24 +0800
Message-ID: <cover.1729583414.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

Geliang Tang (5):
  Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
  Squash to "selftests/bpf: Add bpf_rr scheduler & test"
  Squash to "selftests/bpf: Add bpf_red scheduler & test"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"
  Squash to "selftests/bpf: Add bpf_first scheduler & test"

 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  3 -
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 18 +----
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 79 ++++++++++---------
 .../selftests/bpf/progs/mptcp_bpf_first.c     | 10 ++-
 .../selftests/bpf/progs/mptcp_bpf_red.c       | 10 +--
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 26 +++---
 6 files changed, 67 insertions(+), 79 deletions(-)

-- 
2.45.2

