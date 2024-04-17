Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A73F4685
	for <mptcp@lists.linux.dev>; Wed, 17 Apr 2024 02:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713321548; cv=none; b=mhWYE0ddlLohsXvWzrTF21FzYSoEVEED6PglFPoRHZ9xQCw7EA7VNmQmSY3kmWmOC6oWHjmmvRu9vJ1F66o98ZASSODeBl27A+sCRQOznxILc+rmzf2Z5bH2sXkj8qkomcIVq0JvmOjtDvcDuSlKjb0dF55b4jkQU5HxP04zuZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713321548; c=relaxed/simple;
	bh=gez818udLGxYiJTq3ebGQMgyEN8anMXvpQe/j0QnF0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FD352xDilN/hPFyXd/CSFe1J0dYnc5huHFz/GtKxEB10+pRI6zb+ZcWfhcFBOh6qZUF9/tg3/ZsR17DdT3GDNVpQx2InLdIGy3TYMd3/KHI0ay4CO7RUWQIuXAy4QfVBBJVROF1wBxVG9O3spfyIgiPCyKQ7nrAc0w2j33GIx7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYulCzWB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYulCzWB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3804EC113CE;
	Wed, 17 Apr 2024 02:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713321548;
	bh=gez818udLGxYiJTq3ebGQMgyEN8anMXvpQe/j0QnF0I=;
	h=From:To:Cc:Subject:Date:From;
	b=dYulCzWBxgp8Rc+BUvQWIS94+L84H9RroEUwHNzHa7abmCJrilIOXnRo13NNuyv23
	 oXtXquSJRwhPDYOaWTIn54ENKAXPQY3aXYmnP5uAs9nR8G/v/FJaPCIv6oqtkroFq9
	 QdT2RroFJ+8W7FqsQf2qxsEI9t0x8Iqn7EWZUFvrtYpo2u7wCvHBnlx3UdbIYaex7+
	 g6HSSytH4NR8Oynpd5UGIT10wjuVOjrfdk5pHL3Dj44fbivOjJ8XmrssGRMvwvv2vF
	 O3o5KPPba14JPmuditZY0v9vFfPy6sJr6QQOtQRxksmKdNUlrxDPmFh5ZcOZg99iS3
	 ApIZt2MpnmGRg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 0/8] refactor mptcp bpf tests
Date: Wed, 17 Apr 2024 10:38:46 +0800
Message-Id: <cover.1713321357.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v9:
 - extract a new helper test_bpf_sched() from MPTCP_SCHED_TEST() to make
   the macro simpler as Mat suggested. (thanks)
 - squash MPTCP_SCHED_TEST() into "selftests/bpf: Add bpf_first
   scheduler & test", not "selftests/bpf: Add bpf scheduler test" to
   avoid a build error "test_bpf_sched is not used".

v8:
 - change argument types of send_data_and_verify from strings to
   booleans as Matt suggested.

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

Geliang Tang (8):
  selftests/bpf: Add RUN_MPTCP_TEST macro
  Squash to "selftests/bpf: Add bpf scheduler test" 1 verify
  Squash to "selftests/bpf: Add bpf scheduler test" 2 time
  Squash to "selftests/bpf: Add bpf_first scheduler & test"
  Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
  Squash to "selftests/bpf: Add bpf_rr scheduler & test"
  Squash to "selftests/bpf: Add bpf_red scheduler & test"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 249 +++++-------------
 1 file changed, 69 insertions(+), 180 deletions(-)

-- 
2.40.1

