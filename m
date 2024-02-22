Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9896C28EF
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 03:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708573261; cv=none; b=NpeHmDQqSAhgYJIhRGEehk7Ynp7ayMGqOMJK9UFucswVzhoFLqX0PO3Gpyrsp+e3Pcq/of+nPEQ2LPvBK+Tw6VmnUbwk51ZX/YUrpXZu8dW0QDR8ntahmiEL9BbMiU7AOBCqsGp6hBqOf/5TuyVsHU9EmB8m3qQhk+giC2yO9N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708573261; c=relaxed/simple;
	bh=j0Phbs0oyW6ixuE55EvSpYwUoHpwHELmEuRzYvCLeu0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f8vM47gXDfAFZeYNMZatZVRH9wCDDUuMUNjXL8UqTx4WAJUwdwHfPW5cQTtJEqhPScRzhtgfowvPSz1PXPMe54t8YXtUu6J3mYhkRbW+H+CUTNadKcnuTpnaWwDDB6L4z17smLAFa9k1IfGJPAlgpSEPQX78DekdXNVABFUvsaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fahS0K+B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fahS0K+B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C711C433C7;
	Thu, 22 Feb 2024 03:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708573261;
	bh=j0Phbs0oyW6ixuE55EvSpYwUoHpwHELmEuRzYvCLeu0=;
	h=From:To:Cc:Subject:Date:From;
	b=fahS0K+BYUq/1nRI+RU0kv7nUk583WR8B5/sQlosyrVAQ9iF9FaS60ytDgE0Xhco9
	 77bUpaAi2DbC1M0+v5xqFuNYBfXbsWoGY4Lji7rLe3efys7d6QePLps3Zl3dbLL9nx
	 /AOe73hQ9BnoOxMHaCnSY5Mnc55ILxPwhqwGnY3QEtTV8MughRokEQsUhZX/DBdoyA
	 zRN2X5LLnDSIV566DpXIGXAr6dOMAWHfv8aCZxSdEovhl6Z86ftyvW322YmWmIl6gh
	 +jneso9l18N2g2kbS4d3JiY1LsTtlpTmb+1V9DFnnkXKvhT1YVhAHe++nrs+TqRUBK
	 Pgk4WQxAXMNnA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/4] add helpers and vars in mptcp_lib.sh, part 2
Date: Thu, 22 Feb 2024 11:40:32 +0800
Message-Id: <cover.1708572320.git.tanggeliang@kylinos.cn>
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
 - address Matt's comments in v3 except
 - keep #1, #3 as separate patches, not squash them into #2, to keep #2
   clean.

v3:
 - patch #2, drop this line in mptcp_lib_ns_exit():
        rm -f /tmp/"$netns".{nstat,out}

Geliang Tang (4):
  selftests: mptcp: add local variables rndh
  selftests: mptcp: add mptcp_lib_ns_init/exit helpers
  selftests: mptcp: more operations in ns_init/exit
  selftests: mptcp: add mptcp_lib_events helper

 tools/testing/selftests/net/mptcp/diag.sh     |  9 ++---
 .../selftests/net/mptcp/mptcp_connect.sh      | 28 +++++--------
 .../testing/selftests/net/mptcp/mptcp_join.sh | 26 ++----------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 40 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 22 +++-------
 .../testing/selftests/net/mptcp/pm_netlink.sh | 10 ++---
 .../selftests/net/mptcp/simult_flows.sh       | 21 +++-------
 .../selftests/net/mptcp/userspace_pm.sh       | 29 +++-----------
 8 files changed, 77 insertions(+), 108 deletions(-)

-- 
2.40.1

