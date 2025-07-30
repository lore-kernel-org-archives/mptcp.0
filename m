Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898431F1921
	for <mptcp@lists.linux.dev>; Wed, 30 Jul 2025 07:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753860174; cv=none; b=Tudb8X8Swg/Hr7Mc55v3ujD+lj3AYiXDcucFAIuxGKjdd2vYswJSJUaOZTs8udHGUBHUFSV7jXlpzHdPG1ClYk6rDJH517gC31Ibf1QQCaUZllDH6liXmFwQLB5EImJoO/vBz/N3t8g0GOiMCkrjcarVzqYtZKFPyJaxuMGSt2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753860174; c=relaxed/simple;
	bh=EqyRhWeHhxmR9HirocAWUBLhzh7RXls1qxzr5mm8qO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KnHfEmipPU485zeNmv1Cvn6mLcN3T3dQTEapWgPaA00nkLvoI9mb8EA1RgszCyPVY/tiQx6+UFVLSGYXqaD+eSrvmX6qHMpSUEwlbW2FF4YmqsiV3CYpOZDbMjlkp4k0L/H1LXOLbQ2E61kJBImkihRfrERgTxNOSBQbZyNFvlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSyX767k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSyX767k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A57C4CEE7;
	Wed, 30 Jul 2025 07:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753860173;
	bh=EqyRhWeHhxmR9HirocAWUBLhzh7RXls1qxzr5mm8qO4=;
	h=From:To:Cc:Subject:Date:From;
	b=DSyX767kjiJyFyjIwNi95AV5eJ27TLGjpH4ib5US4axZhsCs6g9RB31tUXT+xS++Q
	 sww+uGLoFYEq6OJ5vHqvQSFAyRudtjAsTid7g/r6feApRNiDLXqi4oDoYfKXeTGXWz
	 37o4Hg+JMcpqn25yIkDkb1lzB1G5oBRnH4h+oz9LPJCZDPlqknj6iU1XyGuWBschgi
	 Rz5A37VjyumtuAoaQgzF8sF4gx6yYxHcSJ46tqJOfHUHywl9IHVa+5tQlaKFhauOSd
	 msfPbgKFW8VnpdeWMMct4dzFL7yDaLxvN01DG5/m/jEu7uh0q6DcGAzjWHLer1ZXV3
	 /SNw+muNZ4Z6A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/3] mptcp: TCP_MD5SIG support
Date: Wed, 30 Jul 2025 15:22:42 +0800
Message-ID: <cover.1753859907.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This series introduces support for TCP_MD5SIG socket options in MPTCP along
with code improvements and test cases:

Patch 1: Refactors TCP_MAXSEG getsockopt handling to improve code
consistency
Patch 2: Adds setsockopt support for TCP_MD5SIG/TCP_MD5SIG_EXT (first
subflow only)
Patch 3: Implements selftests for the new MD5SIG functionality

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/575

Geliang Tang (3):
  mptcp: Handle TCP_MAXSEG getsockopt in common case
  mptcp: setsockopt support for TCP_MD5SIG
  selftests: mptcp: add TCP_MD5SIG tests in sockopt

 net/mptcp/sockopt.c                           | 10 +--
 tools/testing/selftests/net/mptcp/config      |  1 +
 .../selftests/net/mptcp/mptcp_sockopt.c       | 67 +++++++++++++++++++
 3 files changed, 74 insertions(+), 4 deletions(-)

-- 
2.48.1

