Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBE31FB4
	for <mptcp@lists.linux.dev>; Wed, 10 Apr 2024 02:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712714733; cv=none; b=ewVmyo0O4YVD7EJpBQ5BRuLUARYfiV9soREyMJzPPbxz6JoQnA2551hb3PBRw4jH7cWRWl0AmE95yKnHs7xapO2PKO2td0YslLFihsbxoyLILaN7TKYq0LPICygpWbG/KN9h7BOw8oSpECF9uesR8igUDsUIRE/bWBMCyjza2uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712714733; c=relaxed/simple;
	bh=v8p1pqjzlgJOk++fNHeS+hm1yOgfXQ7qWgQ+cqLr43U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JgBRhvEb3TRQ8OyN+y8uoqSSSAt5hGPXzZhNCBPQRUtwbjGY+y9CtuJm+/8xQBZBnBbK4+dq8T76h/YhYFFwCrnR8eX5EprFepC0wyl+nZmRDcgg4oi3xORwqvkbplnLlqtkH6W/05uZ5RCHMAQhr85Tl1yQyum47un4CY9FAHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idJzIwV9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idJzIwV9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C1FC433F1;
	Wed, 10 Apr 2024 02:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712714733;
	bh=v8p1pqjzlgJOk++fNHeS+hm1yOgfXQ7qWgQ+cqLr43U=;
	h=From:To:Cc:Subject:Date:From;
	b=idJzIwV9dEW776BWxKCeJCp5VBRrruTiPBuBmlv7P6dCOguArxDyhzwAsUNKUGzjY
	 /tEYMcS4TvXGk4Waq2UtVvuF5R+tKXs4BGUrTwElVqxxFdzCPKu1+q/Bx7H6q9TjEq
	 5i0tE8js40adX1nxaeWL1gR7PvfSsQoPHO36MNMUQ4rTFbUEoU+385XBtc4EGESFjJ
	 5me77JJLMn+IFinUrBCGi9jt9XER7b3yuttWXZsCtAbqtgf/qK6bj+0viytF9qpLBb
	 ZRjwqtD/jDDCt1TX5Y9UEEZQJ/jKHV3Ka9WY5CWcEkiqsLHfbUgvcGxC+3loybbTTx
	 gKLuN6pJiY8EQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 0/9] refactor mptcp bpf tests
Date: Wed, 10 Apr 2024 10:05:15 +0800
Message-Id: <cover.1712714407.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 267 +++++-------------
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      |   1 +
 .../selftests/bpf/progs/mptcp_bpf_burst.c     |   1 +
 .../selftests/bpf/progs/mptcp_bpf_first.c     |   1 +
 .../selftests/bpf/progs/mptcp_bpf_red.c       |   1 +
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |   1 +
 6 files changed, 79 insertions(+), 193 deletions(-)

-- 
2.40.1

