Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C7F18EA8
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 05:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712034765; cv=none; b=k+zOjCX/xKuRCSThfVEIwXsECbsUn2VzuF+2h166a8BfPWhH0TJIm6CZbFeHXV1nnzM5EkjJGvVApMqd997AhrNVc64A/Uf8HxdmmssxcUNi8oK2JROfILvMZnckNbVz1Ies4WsehEvE7pSKoVV46j2RpYQTE56MJg1bzryFBKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712034765; c=relaxed/simple;
	bh=623YlOXJjUMC0yDBmj44HuHGc9DVKJCu0r2pokduuW8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NMhfSbemstPtu/uHqAhcYR9rpW1aivmCVekCsmvf5nDOSH9cH3ZJjYHHMRRA6IahAZZB6f/no8whbrRVsFZ9W4Gy/yHeTCCvGUXx6/2r2rFC87TnmCmNQnBDdjj7mmldcmzxLR405NtQBSivGqJRa+DpotzqQocG7zvhh1aQ1co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4+CRNWe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4+CRNWe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1616DC433F1;
	Tue,  2 Apr 2024 05:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712034764;
	bh=623YlOXJjUMC0yDBmj44HuHGc9DVKJCu0r2pokduuW8=;
	h=From:To:Cc:Subject:Date:From;
	b=O4+CRNWefYzACm+Aj2unvCuW2XJod7/oHk8K0jd9KL8HsZMr89R/DAitAJSISv4JB
	 So3niRroDU9I6GYXlfqbF7deXduXUfwf6iawqnWZKRWiPI0pnkebD+u5NZYIectE4U
	 YSsPTGNfAF8hwT8z287U7Ht/fKFXniE2MMsvKY8Jm73TCTqG0X5N7PvWbUlJfvkdRD
	 5hq651cyuJgLf2YhKQZ3BF0l7AqaGvPdh/wXy1TiJJk2HgPGngZ0jpZWs/OqFM4rTL
	 mL2YJg3FKJyvc4L1cZeJkFnv3gkSDE1auuomOuiRhSkG3XVaD/UqjUVbfgt6HYhWeg
	 8l5TACtao3SaQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 00/11] refactor mptcp bpf tests
Date: Tue,  2 Apr 2024 13:12:23 +0800
Message-Id: <cover.1712034575.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v4:
 - add set_nonblock to make BPF tests stable.
 - split 'Squash to "selftests/bpf: Add bpf scheduler test"' into 4 patches.

v3:
 - part 1, bpf schedulers.

v2:
 - add two more helpers, send_single_byte and send_recv_data.

Refactor mptcp bpf tests using newly added macros MPTCP_BASE_TEST,
RUN_MPTCP_TEST and MPTCP_SCHED_TEST macro.

Geliang Tang (11):
  Squash to "selftests/bpf: Add bpf scheduler test" 1 nonblock
  selftests/bpf: Add RUN_MPTCP_TEST macro
  Squash to "selftests/bpf: Add bpf scheduler test" 2 verify
  Squash to "selftests/bpf: Add bpf scheduler test" 3 time
  Squash to "selftests/bpf: Add bpf scheduler test" 4 cleanup
  selftests/bpf: Add MPTCP_SCHED_TEST macro
  Squash to "selftests/bpf: Add bpf_first scheduler & test"
  Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
  Squash to "selftests/bpf: Add bpf_rr scheduler & test"
  Squash to "selftests/bpf: Add bpf_red scheduler & test"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 291 ++++++------------
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      |   1 +
 .../selftests/bpf/progs/mptcp_bpf_burst.c     |   1 +
 .../selftests/bpf/progs/mptcp_bpf_first.c     |   1 +
 .../selftests/bpf/progs/mptcp_bpf_red.c       |   1 +
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |   1 +
 6 files changed, 96 insertions(+), 200 deletions(-)

-- 
2.40.1

