Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C872837B
	for <mptcp@lists.linux.dev>; Mon,  8 Apr 2024 03:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712545276; cv=none; b=plvxW9JfAMgUPhlq82zA6tNxNZdq3GKOynOdcC1qHvBzqwdJLHfRg1GqrcffGDqUf5KUWcyur+Nrm1ZWYXI+8f9pGVPOhWBZ+wxiOG5qpltfUKiZufxbzD72tKtmNF+Ln0dLCEJOI2pV3iHfVA65QOAWfyebBcxl8iFztvMJjQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712545276; c=relaxed/simple;
	bh=NyX18gO5XUgmvZVOnpDrhBCoJUvBuTM2H/AOe3psW58=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k1jkTTyvnY4nrrzBdfSSZeCieRFrhusSOULMjTZ/cie0dYYf/uDVCLIFvB0khWIB0+hWXx/diJR/rmNdv0j75Ey7JN3ninr+7iLkUXl1lJdjWdlAaOxccFzP9b1g2JfwZUEIuycRrut4TPyssezZxz30qoiTnizbarX9blbs04M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n41/hO+e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n41/hO+e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE71C433F1;
	Mon,  8 Apr 2024 03:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712545276;
	bh=NyX18gO5XUgmvZVOnpDrhBCoJUvBuTM2H/AOe3psW58=;
	h=From:To:Cc:Subject:Date:From;
	b=n41/hO+enxYqNra7MWVIKsX7wqxNLnWKQi/XFoiYVXlfcn+ChJ/qbGo6zz829EDR8
	 ZhvgyMLM7nA2+P53btROIYK40atdBK2cd3VvIssxBmf7TfjeeHZ6eVodKoL4tkHQUa
	 DyvLpNm47EeW38DETGO90iFzEv47KRXohU5hSSA4ROvDbBxWPAjEm8krCTgC9dYYy+
	 tkOSgXMWdT0tOetIgS5wVAVx2QyCi2TjF3vnrx5PAPfR9Ml30uHsA3BEtdMRmADeDQ
	 0Ebb8ITmz54JFAFiRixqnvFA/mW2vDCsgWbWS8KZqPfp5Llw3Dy07FGjcB615Egi33
	 m9+/KlDzB5rEw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 0/9] refactor mptcp bpf tests
Date: Mon,  8 Apr 2024 11:01:02 +0800
Message-Id: <cover.1712544986.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v7:
 - address Matt's comments in v6 (thanks)
 - add more commit logs.
 - use WITH_DATA/WITHOUT_DATA instead of 1/0.
 - make patch 3 as a squash-to patch.

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
  Squash to "selftests/bpf: Add bpf scheduler test" 3 MPTCP_SCHED_TEST
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

