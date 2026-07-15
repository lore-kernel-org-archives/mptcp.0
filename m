Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B548248881
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 02:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083756; cv=none; b=nSRU1NYWEKT4yrv8pXItRZLsaJuXCV77+FobzSy1QpQSpLoAFqnFIL560i+xsd2UYc6+e33d7lpZ9ZQLhVXWVt1O8fjKVFs/d/Ld5ejf4BLGoAuzHt6Dysfvd2eGHghoeBxGE1FaunpNFwAIpfqczcAOM4p36Td+BBim248D3Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083756; c=relaxed/simple;
	bh=JdAei5M/koA4aDWy28RXcvzfGW1TqdBn6lUMLgLNw68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=okyK6n3qlnnmlpDs+Mzt0NetQbBmBFex6D35h9uOFvtIgqvHNKbnkRM4j2ILnNx9WS+9SmNW78sb97/uYHGWK6ABvj92Fq0sfZ/DCI0fkAgrbmWi/WtC6/63w2e867nRlrAEy7F2SNj5QaRkYl7Tf+i6Kz2E17n/FpSS3I3oO3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJgbbAuK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJgbbAuK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EC41F000E9;
	Wed, 15 Jul 2026 02:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083754;
	bh=1sqnu3GilF6/+2jz8HI8IL2irRlzjYaJbZ8R5AU/TvY=;
	h=From:To:Cc:Subject:Date;
	b=BJgbbAuKnkZrl0e/tx7dWKVBbBsqwAfHkAtbLZiKZK5NckRY2dZmkoLFKM2Dzf3O5
	 IwJv9pjmAQicn5kKgr9F5UgAtRO3a7TRyxaw0EsYZkqUm8Eihrzx5rODdDkBenSH1g
	 XyJipkOAPDrbtrfU85lbZ5bfMraviehzDdMAuA3Xm/WUj3AMwOSXooqtKHNPBTtXVC
	 ShosHdJrpcQEqq/1vE5gyVKifamoejh20DQpUsw+823GUTfuaq3hz7Et8Y8VC2GInL
	 Q6JsuUnID6H5eZ6XqeRim1E4aLlJOi8TQWYNCCNwODqLLXWjcHJ+uXYHTb/tly7G1p
	 UGliPT3+zCb5Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 00/11] selftests: consolidate TCP_INQ testing into sockopt
Date: Wed, 15 Jul 2026 10:48:46 +0800
Message-ID: <cover.1784082850.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v11:
 - Drop "replace /dev/urandom with getrandom".
 - Add check_stat_equal() helper to centralize and simplify MPTCP stats
   validation.
 - Fix cmsg_len format specifier in get_tcp_inq() (%u -> %zu) to match
   size_t type.
 - Fix format specifier in EOF error message (%lu -> %zd) for ssize_t
   type.
 - Add poll() with POLLRDHUP in client_huge_transfer() to wait for FIN
   arrival before reading the final byte, preventing flaky EOF detection.
 - Pass total to server_huge_transfer(), instead of len.

v10:
 - Patch 1, a new fix.
 - Patch 3, change the type of r/w as size_t.
 - Patch 12, in client_huge_transfer(), do a blocking read for EOF on
   unixfd instead of sleeping.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1783994494.git.tanggeliang@kylinos.cn/

v9:
 - No code changes compared to v8.
 - To address Sashiko's complaints that the implementation of
   server_huge_transfer() was split across several patches, the patch
   order has been rearranged, some patches have been squashed into
   fewer ones, and the commit logs have been updated.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1783913010.git.tanggeliang@kylinos.cn/

v8:
 - patch 2, a new patch to replace /dev/urandom with getrandom().
 - patch 4, check against the accumulated total r instead of ret in
   process_one_client().
 - patch 7 and patch 9, update commit logs.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1783849522.git.tanggeliang@kylinos.cn/

v7:
 - Add a new patch to reseed RNG in child after fork.
 - Add a new patch to fix bytes_acked validation against sent bytes.
 - Add a new patch to use r/w for byte counts in process_one_client().
 - Split v6-0004 into two separate patches: read exact payload length,
   and pass len over unixfd.
 - Change socketpair type from SOCK_DGRAM to SOCK_STREAM to avoid
   indefinite blocking when peer exits.
 - Fully initialize buf in server_huge_transfer() to silence MSAN/Valgrind
   warnings.
 - Use a union containing struct cmsghdr for control message buffers to
   prevent unaligned access on strict-alignment architectures.
 - Reorder and renumber patches accordingly.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1783740443.git.tanggeliang@kylinos.cn/

v6:
 - A new patch to use recvmsg instead of read.
 - Squash the four original patches into two.
 - Reset msg.msg_controllen.
 - Check cmsg_len in get_tcp_inq.
 - Check return value of client_huge_transfer.
 - Address other comments from Sashiko.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1783673158.git.tanggeliang@kylinos.cn/

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

Geliang Tang (11):
  selftests: mptcp: sockopt: reseed RNG after fork
  selftests: mptcp: sockopt: use exact length in connect_one_server
  selftests: mptcp: sockopt: add check_stat_equal helper
  selftests: mptcp: sockopt: use size_t for byte counters
  selftests: mptcp: sockopt: add tx/rx protocol options
  selftests: mptcp: sockopt: add TCP_INQ test option
  selftests: mptcp: sockopt: use unix socket instead of pipe
  selftests: mptcp: sockopt: use recvmsg instead of read
  selftests: mptcp: sockopt: get and verify TCP_INQ
  selftests: mptcp: sockopt: add huge data transfer tests
  selftests: mptcp: sockopt: replace mptcp_inq with sockopt

 tools/testing/selftests/net/mptcp/.gitignore  |   1 -
 tools/testing/selftests/net/mptcp/Makefile    |   1 -
 tools/testing/selftests/net/mptcp/mptcp_inq.c | 614 ------------------
 .../selftests/net/mptcp/mptcp_sockopt.c       | 445 +++++++++++--
 .../selftests/net/mptcp/mptcp_sockopt.sh      |   8 +-
 5 files changed, 392 insertions(+), 677 deletions(-)
 delete mode 100644 tools/testing/selftests/net/mptcp/mptcp_inq.c

-- 
2.53.0

