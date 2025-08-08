Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7AB282FA
	for <mptcp@lists.linux.dev>; Fri,  8 Aug 2025 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664221; cv=none; b=berPdlJ60wSceL6Fj3RAF8wev0RYPhYPD8ch5pj5WtQ8W4kBgZ+0LnE3vZkRfmKof5zeCSPmty2aaQ3zqgJaU+JtKlblvsN11ltf9Ns18QHx/7HX46RJg8r27Fy8lB7a0c0oQN+ZlON4bVHwPQqnWhcIx0JR5/9bpzJ9+4PNGtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664221; c=relaxed/simple;
	bh=eSjP+SxAEsQPzW8EYL9n0qPGiKDO1oD5dvvRT+Dbtsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WfeSN53rmRA2MdeTJDu6uUaLT0BfXgfoiC9z2l6j757JEW9CfDMStwy+ynKFI25nn9JpwhEjJR5WG4sNtXCCWY/g4AA+0wtlgJ3PcxiRFuUnx1mnuxJqiKlF5RV37nraNYLnHsG2JurTPe7t+4spXIVYzfPZLr9gNIaBFTl5UeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oey1rZl+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oey1rZl+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E220C4CEED;
	Fri,  8 Aug 2025 14:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754664221;
	bh=eSjP+SxAEsQPzW8EYL9n0qPGiKDO1oD5dvvRT+Dbtsc=;
	h=From:To:Cc:Subject:Date:From;
	b=oey1rZl+d+YHnnNeA7PuwotocuEtblMfHtcu1AnaXu3o3u4JJF6P0+HQPkUM8yWLh
	 64k4SDa2M5XnFpx0THGVsDKkNud8oEteTKF6/j5zFIu/6QgNarBcBjmqdPBevF6yZG
	 vEtuLZuJTyxXzIdsKiZJEVj6zqVuxQl4a1HVvA3Y8C5WqWp8sGi6ml7fWf5y+iP4DT
	 MqeYN/Stv6vRIGBZz5CNsoEDL2ofPTLX4g4Gjv7Yv/ClEcQD5HI27HwmXlEmhB0VhN
	 q2uwZ064sNPUkolEDdF1DVq3BOWfjfSNb0QHzK9NU+mVCra0fyAvvvyDsfmzEboyxW
	 tNrBepRdVATRw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/9] selftests: consolidate TCP_INQ testing into sockopt
Date: Fri,  8 Aug 2025 22:42:45 +0800
Message-ID: <cover.1754664106.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - patch 4, a new patch, add do_setsockopt_inq helper.
 - cleanups.

v1:
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1754620968.git.tanggeliang@kylinos.cn/

This series consolidates the TCP_INQ test functionality from mptcp_inq
into mptcp_sockopt, simplifying the test suite while maintaining full
test coverage. The key changes include:

1. Adding necessary protocol arguments and IPC improvements to sockopt
2. Implementing TCP_INQ test logic within the sockopt test binary
3. Migrating test execution to use the enhanced sockopt binary
4. Removing the now-obsolete mptcp_inq test binary

The consolidation provides several benefits:
- Reduces code duplication by sharing common infrastructure
- Simplifies maintenance with a single test binary
- Maintains identical test coverage for TCP_INQ functionality
- Improves code clarity with better IPC naming
- Enhances flexibility through new protocol selection options

The changes maintain backward compatibility while extending
functionality, and all tests pass with the same coverage as before.

Geliang Tang (9):
  selftests: mptcp: sockopt: use getrandom for initialization
  selftests: mptcp: sockopt: add protocol arguments
  selftests: mptcp: sockopt: add inq argument
  selftests: mptcp: sockopt: set TCP_INQ on accepted sockets
  selftests: mptcp: sockopt: rename pipefd to ipcfd
  selftests: mptcp: sockopt: add TCP_INQ client processing
  selftests: mptcp: sockopt: add TCP_INQ server connection
  selftests: mptcp: sockopt: replace mptcp_inq with sockopt
  selftests: mptcp: sockopt: remove obsolete mptcp_inq

 tools/testing/selftests/net/mptcp/.gitignore  |   1 -
 tools/testing/selftests/net/mptcp/Makefile    |   2 +-
 tools/testing/selftests/net/mptcp/mptcp_inq.c | 608 ------------------
 .../selftests/net/mptcp/mptcp_sockopt.c       | 359 ++++++++++-
 .../selftests/net/mptcp/mptcp_sockopt.sh      |   6 +-
 5 files changed, 333 insertions(+), 643 deletions(-)
 delete mode 100644 tools/testing/selftests/net/mptcp/mptcp_inq.c

-- 
2.48.1

