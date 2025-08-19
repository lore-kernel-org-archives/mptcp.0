Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD3117BB21
	for <mptcp@lists.linux.dev>; Tue, 19 Aug 2025 09:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594020; cv=none; b=aj7bBweRrqw58QYSJ1sa+GCb32s3A4+VshBN3OV+mqcb7PBm93+iGjNZyiCjaBsfPvHW4ZX4f5Ps0NZ4T2EUecdV2478zL5u2hpNFhmdP4H0yJAv9oH9kPt9KMVznXu2p3+yNyFafWUva4krOBrF+eOEHTXqN1DLcJn/4QJ6F9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594020; c=relaxed/simple;
	bh=Xy4w+3+NgaDMQWHgddc85Ud+8nbmg5+UWwOjgzEZvws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iCENS33M8YHr5mnrs93ZkSGdytXEDmLNC4TyrX3ImpwY9zk7t+D23lUiEpf634soarkfe/SEM43rXAh3tDkGxB7KBR9cBrqrzj0U7kDA/QTsSW2BMFCACXZlEiVOlYal2ByZWR9k5bPOKolbqKl9jxTqC0wsSG5RKR4P2EeKQr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnvXSHWK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnvXSHWK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6EAC4CEF1;
	Tue, 19 Aug 2025 09:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755594020;
	bh=Xy4w+3+NgaDMQWHgddc85Ud+8nbmg5+UWwOjgzEZvws=;
	h=From:To:Cc:Subject:Date:From;
	b=AnvXSHWKWsuJkk8KpMfMjoqC8nncsBm6EpV8GOQoNVtt5ih9XFk+AvOJ+iQsDKJXy
	 nyudnBrzUa3HWZJI4xgKD7utu6A6ozUt3saY2VxoV0DgKiUsA/hpC7ziFjZLQ1Ah1c
	 ZTmq2iYKDR5pP5vbIT9HgwwCaJYjGnJTNyZaVxBAZiszZoWXl8uYpmyWjL/NE45kg9
	 fwNivZEsP2CJ3H45btbXD8nUO7v6XNu0F6HOFi6TP5fgRfVBZm1re3fxXPdI5zqTeP
	 rvRp/NrF/uqTVmYvT+C4LEcIp6AwWQMCCc9veNzsdLe+sX2ro2QfRVcOvab3InKFoG
	 Sg0RguT9Qlwtg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 00/11] selftests: cover more MPTCP socket options
Date: Tue, 19 Aug 2025 17:00:06 +0800
Message-ID: <cover.1755592822.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This series significantly expands MPTCP socket option test coverage
by adding validation for 10 more socket options:

1. SO_REUSEADDR/SO_REUSEPORT - Test socket reuse capabilities
2. SO_BINDTODEVICE/SO_BINDTOIFINDEX - Validate interface binding
3. IP_TOS - Verify Type of Service handling
4. IP_FREEBIND - Test free address binding
5. IP_TRANSPARENT - Validate transparent proxying
6. IP_BIND_ADDRESS_NO_PORT - Test deferred port binding
7. IP_LOCAL_PORT_RANGE - Check local port range restriction
8. IPV6_V6ONLY - Verify IPv6-only sockets

Each commit systematically adds:
- Setsockopt/getsockopt operations in mptcp_sockopt.c
- Dedicated test cases in mptcp_sockopt.sh
- IPv4 and IPv6 coverage
- Error handling and edge case validation

The new tests verify that MPTCP correctly propagates socket options to
subflows and maintains consistent behavior across address families.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/525

Geliang Tang (11):
  selftests: mptcp: sockopt: improve test output clarity
  selftests: mptcp: sockopt: add SO_REUSEADDR test helper
  selftests: mptcp: sockopt: add SO_REUSEPORT test
  selftests: mptcp: sockopt: add SO_BINDTODEVICE test
  selftests: mptcp: sockopt: add SO_BINDTOIFINDEX test
  selftests: mptcp: sockopt: add IP_TOS socket option test
  selftests: mptcp: sockopt: add IP_FREEBIND tests
  selftests: mptcp: sockopt: add IP_TRANSPARENT tests
  selftests: mptcp: sockopt: add IP_BIND_ADDRESS_NO_PORT test
  selftests: mptcp: sockopt: add IP_LOCAL_PORT_RANGE test
  selftests: mptcp: sockopt: add IPV6_V6ONLY test

 .../selftests/net/mptcp/mptcp_sockopt.c       | 359 +++++++++++++++---
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  94 ++++-
 2 files changed, 403 insertions(+), 50 deletions(-)

-- 
2.48.1

