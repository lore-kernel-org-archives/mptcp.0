Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E658086ACA
	for <mptcp@lists.linux.dev>; Thu,  4 Apr 2024 13:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235837; cv=none; b=nax+yoSyAiOcBq4pIteLCnleZAOZiAr89lXwTze4oqXIgSppnp1qnefPK8jlyp7Rt013HyeLaPNNK+05ohsWQl6iCJXhWtQb2CT+5Xspq/xDHT9+gzj6GC+lz+7Sby2g1B9vkayCtrce7HmA3VGbXgoCudaKvY0zAVmp9OvSFd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235837; c=relaxed/simple;
	bh=wypyHMo6J5VAhOsJcmWPyZix3yqAdti89mNEUG6GFGg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uSsUv/9ntmjqgMeWorRht+H7m/RfJA/qbBbDVdkEplw8llfs/wMUd0TV9GiTI0PPVliptGi7XQOluy31maL4ViskwC0dkeHO/Jir2BdHs0uFPuEAJrQoTVJq1AsCXEprFjbup46AN3yBe5OU1QHBvfRPeOiSuOB3PP0Snuc1XZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBPbd/nF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBPbd/nF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8773FC43394;
	Thu,  4 Apr 2024 13:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712235836;
	bh=wypyHMo6J5VAhOsJcmWPyZix3yqAdti89mNEUG6GFGg=;
	h=From:To:Cc:Subject:Date:From;
	b=CBPbd/nFvGl9CMaSHCynrrxEFoKYHdZVR1OfmxZmcm3svgD+8Ciu07CJmrDKb3rab
	 5kOrsDqskfUq71kZFyfKTScrgq9BNonoojkiS2PLP72lJLnoeHC97YRhNLzmWonqJ/
	 FtVpsdc+5jYTztkBcXOypztoDJRE/HFfXYKD3FODjf3HzypDlgXKF6+tNkaOgWLEN1
	 SA9t122PlgCrPtyqUUUo6W0JEcwHctxeSOApRPt/FfCtRsKCQYFDDv5ozBLEWcEes4
	 SwGJXktFUaupHUpefl8jZR8b8DvIhqg/Vj9CwlwVWQtaV3t92zrzgyyKFsz4tqhtSP
	 kif2yefeBP18A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 0/9] refactor mptcp bpf tests
Date: Thu,  4 Apr 2024 21:03:02 +0800
Message-Id: <cover.1712235379.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v6:
- drop patch 1 in v5 and rebased.

v5:
 - drop patch 5 in v4:
  Squash to "selftests/bpf: Add bpf scheduler test" 4 cleanup

v4:
 - add set_nonblock to make BPF tests stable.
 - split 'Squash to "selftests/bpf: Add bpf scheduler test"' into 4 patches.

v3:
 - part 1, bpf schedulers.

v2:
 - add two more helpers, send_single_byte and send_recv_data.

Refactor mptcp bpf tests using newly added macros MPTCP_BASE_TEST,
RUN_MPTCP_TEST and MPTCP_SCHED_TEST macro.

Geliang Tang (9):
  selftests/bpf: Add RUN_MPTCP_TEST macro
  Squash to "selftests/bpf: Add bpf scheduler test" 1 verify
  Squash to "selftests/bpf: Add bpf scheduler test" 2 time
  selftests/bpf: Add MPTCP_SCHED_TEST macro
  Squash to "selftests/bpf: Add bpf_first scheduler & test"
  Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
  Squash to "selftests/bpf: Add bpf_rr scheduler & test"
  Squash to "selftests/bpf: Add bpf_red scheduler & test"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 265 +++++-------------
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      |   1 +
 .../selftests/bpf/progs/mptcp_bpf_burst.c     |   1 +
 .../selftests/bpf/progs/mptcp_bpf_first.c     |   1 +
 .../selftests/bpf/progs/mptcp_bpf_red.c       |   1 +
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |   1 +
 6 files changed, 77 insertions(+), 193 deletions(-)

-- 
2.40.1

