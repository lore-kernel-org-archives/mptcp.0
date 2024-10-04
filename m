Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913CA69D2B
	for <mptcp@lists.linux.dev>; Fri,  4 Oct 2024 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046794; cv=none; b=ogsu5MCPZKT9ryTncJv2LmQyDeec/ONE9M7LiKlGDVdUUI4WZeI+jwPzuljqdf1glIg/U2kgQWEHqReLdXDLNwJQMNBH18DQd7vbJQUZqF1kAHOC4mZ/+BVe4y+75PxF8t/+ImWHkv+BcPtUeZ5/M6lcT9P/fYbCzpX6/cX7mVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046794; c=relaxed/simple;
	bh=4kXnBbE3IEQr6rrN+auHWtxB+l7c4nU75brfFJ3q0Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O3NHNzkAtElLG4b0Zl/GR3+bM1iWopPh+rQysGIyYdz6k/EzVimz3FJt6jrvjkGDJyOe4D+Aa5DZW8HGforwFah8162izWT4DQd9PeRLUcS3as714huSAYvmQsva0zvUsiMK36ojkEw30aKbpLLvGuW7DW9YUAu0/rJ6Wn8xk18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wiv6kVBD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wiv6kVBD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E96C4CEC6;
	Fri,  4 Oct 2024 12:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728046794;
	bh=4kXnBbE3IEQr6rrN+auHWtxB+l7c4nU75brfFJ3q0Uw=;
	h=From:To:Cc:Subject:Date:From;
	b=Wiv6kVBD7+ltmJoVhPoG83u9T/+kMAOLSlk+guAltSwIq5QG+zbDOwDNZ5MCPWdeq
	 F9pJNkfuY0+pJhTtCN2yxTmzNmQgTtwW27WwaPdymgbr334RZE36aL0DMPj8ZPKueb
	 KCuLUSfYLeOal60cAD22JSBkysqmPV9cCcHVKknPQjASKAysrbNyakFpJSEE8ls6KF
	 eM3FjcsizwXKsOjvCrtHeS0OQ3xm1pgpq5Pwn2O3+uBWTnhpUtcdBDQr1d4RQqM37o
	 FszPSfWk4hSG+WKreVhVGBmdha1o232xlHkTA8TKe36hM7zTmU1yHg0VYPxN1WClT1
	 akFsvfOcSCvQw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/9] use bpf_iter in bpf schedulers
Date: Fri,  4 Oct 2024 20:59:40 +0800
Message-ID: <cover.1728046491.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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
 - "add mptcp_subflow bpf_iter" v8

Geliang Tang (9):
  Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
  Squash to "selftests/bpf: Add bpf_first scheduler & test"
  Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
  Squash to "selftests/bpf: Add bpf_rr scheduler & test"
  Squash to "selftests/bpf: Add bpf_red scheduler & test"
  Squash to "bpf: Export more bpf_burst related functions"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"
  Revert "mptcp: add sched_data helpers"
  mptcp: drop subflow contexts in mptcp_sched_data

 include/net/mptcp.h                           |  2 -
 net/mptcp/bpf.c                               | 19 ++---
 net/mptcp/protocol.h                          |  3 -
 net/mptcp/sched.c                             | 22 ------
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  2 +-
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 16 +---
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 78 +++++++++----------
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  8 +-
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  8 +-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 24 +++---
 10 files changed, 68 insertions(+), 114 deletions(-)

-- 
2.43.0

