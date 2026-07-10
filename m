Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA86D3C8182
	for <mptcp@lists.linux.dev>; Fri, 10 Jul 2026 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673963; cv=none; b=dVMxu015/8N9qQVrfOZxfRpUIYIizP1kznq7ry7xWbbwkPoPwa+U6P2YBUVPbUuPx4WYjwzPOFSAmCiyYFoNIodc+TRhAqhydHGrpo5h+etvmFJaIRwzQd0xHuhEr3T4Ot6Cde1VQYvQvIPB8ifvf3loGSYLhY4KfXZjmrGR38o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673963; c=relaxed/simple;
	bh=vXQ6gFP4+q3D3ffoTGif1pby38C0EhzL5BiTGxRaPuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BKiYldogPnYMqKAa+8hQWwawzVmsYqiKcHFoXw+7NlHI/DyEcdNS1k8laUOK6fJ06BiUFA6173xVFsST49yiVA+O7QCytETDf+Xw2eDPTkWRYDeiwQYiPFHp3fToUOo9Ri8X6EpJr03tof015WNo7qnxRBlH6AEqNOjcUb/gKBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/Zw+fpm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/Zw+fpm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFFF1F000E9;
	Fri, 10 Jul 2026 08:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783673962;
	bh=G2X7kLq6lo78OruSE91CRFxOAVkKqQAu+ON8ZeLeIdw=;
	h=From:To:Cc:Subject:Date;
	b=G/Zw+fpmk0GKm1Uo6VoJpbYvdN5ljXPy4ezO2x5mUHzJCUOke1awfF2Oa7NILJiqT
	 LxGITreVjJRDrNxwmiQkflIBJvy3TnByVUrNMog+TXIE5olJKw1l2v2+wHAq7xH5cP
	 0xiBw5jh+kR3PS/CggRp7Xk3xKeiqLF7IR3c3smW/oIMbNH1GKSM/P9kLDRVNRozQv
	 Ce4//qdEiKNOgnrl6GqadfQPJwEUyogvdAcOdijrNJ3fsh67i34JH1tGpHYUnXbvFx
	 529BHGz5HJTRxI8I5LiWNI3IjUTw7ffCqadEagEWHyCIfWZciQytasMrsQKkzC5Huc
	 F62h/MeZPsyWg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 00/10] selftests: consolidate TCP_INQ testing into sockopt
Date: Fri, 10 Jul 2026 16:59:03 +0800
Message-ID: <cover.1783673158.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v6:
 - A new patch to use recvmsg instead of read.
 - Squash the four original patches into two.
 - Reset msg.msg_controllen.
 - Check cmsg_len in get_tcp_inq.
 - Check return value of client_huge_transfer.
 - Address other comments from Sashiko.

v5:
 - Continue using the approach from v3 and fix the instability issues.
   This version has undergone extensive loop testing.
 - The new two separate functions, server_huge_transfer() and
   client_huge_transfer(), improve code structure.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1783579976.git.tanggeliang@kylinos.cn/

v4:
 - v3 changed the behavior of process_one_client and connect_one_server,
   causing intermittent failures during loop testing. Revert to using the
   v2 approach, along with some cleanups.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1757686538.git.tanggeliang@kylinos.cn/

v3:
 - No longer using process_one_client_inq() and connect_one_server_inq()
   for switching; instead, the inq-related code has been merged into
   process_one_client() and connect_one_server().
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1756200029.git.tanggeliang@kylinos.cn/

v2:
 - patch 4, a new patch, add do_setsockopt_inq helper.
 - cleanups.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1754664106.git.tanggeliang@kylinos.cn/

v1:
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1754620968.git.tanggeliang@kylinos.cn/

This series consolidates the TCP_INQ test functionality from mptcp_inq
into mptcp_sockopt, simplifying the test suite while maintaining full
test coverage.

Geliang Tang (10):
  selftests: mptcp: sockopt: add tx/rx protocol options
  selftests: mptcp: sockopt: add TCP_INQ test option
  selftests: mptcp: sockopt: use unix socket instead of pipe
  selftests: mptcp: sockopt: pass echo length over unixfd
  selftests: mptcp: sockopt: set FIONREAD ioctl
  selftests: mptcp: sockopt: add huge data transfer tests
  selftests: mptcp: sockopt: add wait_for_ack helper
  selftests: mptcp: sockopt: use recvmsg instead of read
  selftests: mptcp: sockopt: add get_tcp_inq helper
  selftests: mptcp: sockopt: replace mptcp_inq with sockopt

 tools/testing/selftests/net/mptcp/.gitignore  |   1 -
 tools/testing/selftests/net/mptcp/Makefile    |   1 -
 tools/testing/selftests/net/mptcp/mptcp_inq.c | 614 ------------------
 .../selftests/net/mptcp/mptcp_sockopt.c       | 382 ++++++++++-
 .../selftests/net/mptcp/mptcp_sockopt.sh      |   8 +-
 5 files changed, 351 insertions(+), 655 deletions(-)
 delete mode 100644 tools/testing/selftests/net/mptcp/mptcp_inq.c

-- 
2.53.0

