Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B379121D3F5
	for <mptcp@lists.linux.dev>; Wed, 19 Nov 2025 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546728; cv=none; b=HBzrmsMH9HQ+yv46l9V/lVY4s/3ihYuQge/9Paz6107SDhwmfAJjXfaJF1UA9eWHqF2P45RCrvCqNEur/79VmSeV3k+nXtrdlEX9ShdxXzGWjY8jS67byOshLVv9GTB0eHbTv/450a0GxyiuLuONiv6KbNwB9h2tzpyvUMPprME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546728; c=relaxed/simple;
	bh=R/5IQ65z+8sB5AWtrLzBDnIuJuafAJ2XM+NwphOdvXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rXRLekR6Y2cFfrybN85scba7GzNA/bqI+eMO9nxwre6XJCH0TT2DiwlrpfgFeIzhJo6cF6ZZupLx9evg0gCUE1giQsj40cXNOXjWaa5LNFhCWyXgGJniQTFDFUojOOa1SSvYQND8AwX5wFBySORiq6wiRnmASRRGuAZWdOHa7BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIm9AUy1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIm9AUy1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE0EC2BCAF;
	Wed, 19 Nov 2025 10:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763546727;
	bh=R/5IQ65z+8sB5AWtrLzBDnIuJuafAJ2XM+NwphOdvXI=;
	h=From:To:Cc:Subject:Date:From;
	b=ZIm9AUy1w/Za43rmwK4T1mEHTz+uRGPBbCLjih+d4amZ4IaVLZlE5V4vFa+zYMLud
	 eQH637z6FULRr1iNvL9/QtO9WeOP8KHwEZ+YMg+Zu01mTdVV2Nbw0N6JIOrddcOBMu
	 o6otQIOEy6uZN2/rYJpU/YQFVY9rRqINyybbSMF1TUv41W9TadWTQvSJOo7wXYK9cH
	 9BNDjoHIDUrYpy34zvXXXMqm2G5fUtSgUY64ROrha4SqFoCxbV+wJ+RPkkifkvbiZU
	 pfXG5aEuEDZnXWteRMLnqZTksJ91+tm+OEp6zS7UVpkdHjRXCavWbAgr9taEDVSLyV
	 2/dost2XjHIWQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org,
	hare@suse.com
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v2 0/8] MPTCP KTLS support
Date: Wed, 19 Nov 2025 18:04:59 +0800
Message-ID: <cover.1763546473.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - fix disconnect.
 - update selftests.

This series adds KTLS support for MPTCP. Since the ULP of msk is not being
used, ULP KTLS can be directly configured onto msk without affecting its
communication.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/480

Depends on: implement mptcp read_sock, v13
Based-on: <cover.1761198660.git.geliang@kernel.org>

Geliang Tang (8):
  tls: add MPTCP protocol support
  mptcp: enable TLS setsockopt
  mptcp: update ULP getsockopt
  selftests: mptcp: connect: update sock_test_tcpulp
  selftests: mptcp: connect: fix uninitialized peer warning
  selftests: mptcp: sockopt: add protocol arguments
  selftests: mptcp: sockopt: skip mptcp getsockopt for tcp tests
  selftests: mptcp: sockopt: add KTLS test cases

 include/net/mptcp.h                           |  42 ++++++
 net/mptcp/protocol.c                          |  66 ++++++++--
 net/mptcp/sockopt.c                           |  30 ++++-
 net/tls/tls_main.c                            |   6 +-
 net/tls/tls_strp.c                            |  20 ++-
 tools/testing/selftests/net/mptcp/config      |   1 +
 .../selftests/net/mptcp/mptcp_connect.c       |  40 ++++--
 .../selftests/net/mptcp/mptcp_sockopt.c       | 121 +++++++++++++++---
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  47 +++++++
 9 files changed, 325 insertions(+), 48 deletions(-)

-- 
2.51.0

