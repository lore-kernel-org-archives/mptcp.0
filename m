Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2103224CF
	for <mptcp@lists.linux.dev>; Wed, 11 Sep 2024 03:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726023785; cv=none; b=XKBiIQWONRMrNexDUnu5M+6pNxo3S8BX9E6w1Ql3UljhlzJCTIXfS6duTWIjjn3aq4gJ86KodAinJf51Fcny43wlnR7HCEHU12ejiiqanzcyc5uNcHb7rm5aRL1HfmC4fNwfG0huDmSvAaE1tl//s4sHjcdPIapACcXMe2ljaGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726023785; c=relaxed/simple;
	bh=tuVZJIfNQcbjugH+lD3xpEQVp35muFTBF8IPJaNWBqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I8sm3I8iGWexgjhfgCWR+B5HZbOUneMeqpodWWprWoerMfG9A/kILKVO90X0ovu2z3Sdq0cfJ3/VDxXgyWGdZn5dDKRQ/L84TCwdMmYTbMFGTIHcLdeEdOz/a/ClHnYBn4u1R2HFhFcuHjNZt9WyKJmNkKC3FqGTFge/7zViUoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xf0GOK35; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xf0GOK35"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463C8C4CEC3;
	Wed, 11 Sep 2024 03:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726023785;
	bh=tuVZJIfNQcbjugH+lD3xpEQVp35muFTBF8IPJaNWBqU=;
	h=From:To:Cc:Subject:Date:From;
	b=Xf0GOK35e/+2Y5G+XCXCbA7j+EAgPAfgNSrjPlP6DyevBxEsVAW87KZXg7r/wFrsA
	 htWDDevjWZ02NdBAJGgsF7WLsmlKZR4W1/+EZgtyUfBFz6+BrGSsAYtjZAqUdfacEa
	 b5xtcP0z4pZ08l33ayaI8QcbTS0vpvHNgpe6IzduCcT24UIIGto+ZMcjybnKSZg/mk
	 zz/eusU2fTh6J+usOXubacj+2l6vMS0bbZ3Oe/to5FHBKsNjyWeHPsRB8sGZ6vhyA0
	 7Eu63zkzUFQVZ1/KBvuWVS7lUMA0piGdZNrTcensGdraC/D5/KCHHKelTSdGVI7mLz
	 8i1dGjH+l31fg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/5] add mptcp_subflow bpf_iter
Date: Wed, 11 Sep 2024 11:02:54 +0800
Message-ID: <cover.1726023577.git.tanggeliang@kylinos.cn>
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
 - squash patch 1/5 and 3/5 in v3 together as Matt suggested.
 - a new squash-to patch to drop mptcp_subflow_active declaration in
   bpf_burst.

v3:
 - drop bpf_iter__mptcp_subflow, __diag_push, __diag_pop and
 __diag_ignore_all
 - drop declarations for bpf kfuncs

v2:
 - update patch 1 as Martin and Andrii suggested.
 - fix warnings and errors reported by MPTCP CI.

This patch set adds a mptcp_subflow type bpf_iter, and self tests.

Geliang Tang (5):
  bpf: Add mptcp_subflow bpf_iter
  selftests/bpf: Add mptcp_subflow bpf_iter test prog
  selftests/bpf: Add mptcp_subflow bpf_iter subtest
  Squash to "mptcp: add sched_data helpers"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"

 net/mptcp/bpf.c                               | 54 ++++++++++--
 net/mptcp/protocol.h                          |  2 -
 .../testing/selftests/bpf/bpf_experimental.h  |  7 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 85 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  4 +
 .../selftests/bpf/progs/mptcp_bpf_burst.c     |  1 -
 .../selftests/bpf/progs/mptcp_bpf_iter.c      | 38 +++++++++
 7 files changed, 183 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_iter.c

-- 
2.43.0

