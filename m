Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478981EA85
	for <mptcp@lists.linux.dev>; Thu,  5 Sep 2024 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544337; cv=none; b=ZvIMuzhfiMUFHRwFizwS9D7zV1oQGpKCWmTKwOOUm3c71wwrh6apHVVBP5LHah/tJGGaUSsZl+4FTEdrs9L92g1ay8zO59VZmtFvuAhxYlAv77jxrgLUxxI/wwxqe+lc+3gBw9/Lz2vxn61+BCHhVbbqbbZFIWL5LNE/BmYF+pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544337; c=relaxed/simple;
	bh=JtDeQBYHIBMI95EHnCOYo0SZuG3SG6NDsr9tX0EXves=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U/H1l6BURBjKWnnVjUJlsA2L+9mGrVnP4G6xGS/5vtN3YWlmQhUov6aO1xg9qZbavd9BfwwAM1CWJCGIhQrFWeZvax4owgC0S1C4He2vKmFn4YxQqbK/WmN9SBafTStLFrnEHnMR0Gqqb89wLF5Key8XFmRXndo/Smss9iD3zz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mn3mG6Cw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mn3mG6Cw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C95C4CEC3;
	Thu,  5 Sep 2024 13:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725544336;
	bh=JtDeQBYHIBMI95EHnCOYo0SZuG3SG6NDsr9tX0EXves=;
	h=From:To:Cc:Subject:Date:From;
	b=Mn3mG6CwEoLKl/pR2fvtQmsXE7Q3waHBXN6tF7NR1SjTcQ26HHw3Rnwt/d3AOWwF3
	 LuaikqyYSJhfBe5o3k+9vNjMBn5le2Nrr3M26uPhiKF/KJhtxdyo04qhu6BWkSu0z2
	 LfP7V7hf11vZxv5d6grYniC1ONLgDqnM85/46r5wqLzAXnkEs4DJWNIsFTYL7tO8ij
	 HjVT0IEXWqMU5w2UMEfmnf4v/TUS6cG1ezDY2tZlf15GUr6KnE6N0NVBzkttgPCkGm
	 zVFTcEwKcBbMLC6CJ7Q+8gbZqxlE3ZiCFC6MyQfXgSUp0ySXX/JD19uRkem21YSsgD
	 kUXiPa9eohroA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/4] add mptcp_subflow bpf_iter
Date: Thu,  5 Sep 2024 21:52:08 +0800
Message-ID: <cover.1725544210.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch set adds a mptcp_subflow type bpf_iter, and self tests.

Geliang Tang (4):
  bpf: Add mptcp_subflow bpf_iter
  bpf: Register mptcp tracing kfunc set
  selftests/bpf: Add mptcp_subflow bpf_iter test prog
  selftests/bpf: Add mptcp_subflow bpf_iter subtest

 kernel/bpf/helpers.c                          |  3 +
 net/mptcp/bpf.c                               | 59 +++++++++++++++++++
 .../testing/selftests/bpf/bpf_experimental.h  |  7 +++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 55 +++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  3 +
 .../selftests/bpf/progs/mptcp_bpf_iter.c      | 38 ++++++++++++
 6 files changed, 165 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_iter.c

-- 
2.43.0

