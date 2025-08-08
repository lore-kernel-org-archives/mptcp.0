Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FE5156678
	for <mptcp@lists.linux.dev>; Fri,  8 Aug 2025 02:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754621116; cv=none; b=r7jjITpAMuQCoQzKHnQ54kx5ZmxrbSSZUOsnmZJ+wJo+hRiRRn+QLsrwUYTPNVAISflELMbby0pHrg6pjHzYCzM6uXsbTC6K2UtCQuDm0rXUiEi4jPlJKYL5rYnkFpypskllDQ9MyaPI13ymoq27dHQlUX2j2zRBEfQ7g3PwrQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754621116; c=relaxed/simple;
	bh=XRL/m0Hr9LaV14bo3kkWj7YRlrt+v5bNdn2XmnobjQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bdUZOVUEvv8RFxdtCWosIl5c7bG6hKd9wNEKEO1PfupOpuxtJ/oFXu15YNRNfRqQZdkSDqk5Mz56SHuWK4cK4ekRsXeibfzipjpGOJeT5uZQ9kLy2rg2ozic13g7Y8j9Xy/rfVPwP6P/WHU74WefzfUgVLO1XUgmJUdjA2EJyJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAuM27Pe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAuM27Pe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA14C4CEF1;
	Fri,  8 Aug 2025 02:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754621115;
	bh=XRL/m0Hr9LaV14bo3kkWj7YRlrt+v5bNdn2XmnobjQM=;
	h=From:To:Cc:Subject:Date:From;
	b=jAuM27Pe7Cvvqi5N+GwMGbq01s1HBHOoqulPHinR6A32Vi/PkuEk32+jex40TpbqY
	 /P+vz+YhGCezedJZWJXKykiq1Uk/EAXDk1HPE6RCY+v+10sKot+hrADRcTQc7+smPi
	 kfHa3sS4vy6hCHyR6fwR/WgIPg413QPIqHvmg3knI9w/hetqHyQbJoI2ViErqsQGir
	 XhkRG+gMMVxKVhGSGVcOiijHy1NwPMbz/qEjVzIrJqLG4IY5JhF+Y6K3f7ff/9NzqO
	 ZFgu+qYRqptQsLLMqOv6wqeOpuYXrBkNP+n4jfk8c4/MngyZQzZ65cyLGxihNk2k80
	 7hgkah1RAvjIA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/8] selftests/mptcp: consolidate TCP_INQ testing into sockopt
Date: Fri,  8 Aug 2025 10:45:01 +0800
Message-ID: <cover.1754620968.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

The series is structured as follows:

Patch 1:  Simplifies RNG initialization using getrandom
Patch 2:  Adds protocol selection arguments for tx/rx paths
Patch 3:  Introduces '-i' option to enable TCP_INQ testing
Patch 4:  Renames pipefd to ipcfd for better IPC abstraction
Patch 5:  Implements TCP_INQ client processing logic
Patch 6:  Adds TCP_INQ server connection handling
Patch 7:  Updates test script to use sockopt instead of inq
Patch 8:  Removes the obsolete mptcp_inq binary

The changes maintain backward compatibility while extending
functionality, and all tests pass with the same coverage as before.

Geliang Tang (8):
  selftests: mptcp: sockopt: use getrandom for initialization
  selftests: mptcp: sockopt: add protocol arguments
  selftests: mptcp: sockopt: add inq argument
  selftests: mptcp: sockopt: rename pipefd to ipcfd
  selftests: mptcp: sockopt: add TCP_INQ client processing
  selftests: mptcp: sockopt: add TCP_INQ server connection
  selftests: mptcp: replace mptcp_inq with sockopt
  selftests: mptcp: remove obsolete mptcp_inq

 tools/testing/selftests/net/mptcp/.gitignore  |   1 -
 tools/testing/selftests/net/mptcp/Makefile    |   2 +-
 tools/testing/selftests/net/mptcp/mptcp_inq.c | 608 ------------------
 .../selftests/net/mptcp/mptcp_sockopt.c       | 347 +++++++++-
 .../selftests/net/mptcp/mptcp_sockopt.sh      |   6 +-
 5 files changed, 321 insertions(+), 643 deletions(-)
 delete mode 100644 tools/testing/selftests/net/mptcp/mptcp_inq.c

-- 
2.48.1

