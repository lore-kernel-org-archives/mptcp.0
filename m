Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF372FFDE1
	for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785054623; cv=none; b=h1oGm9kiTjaZcxGd+tBO1zpwXxC5v323AHiBKe+y0RxXd1NI4no5vPsL0UzuwwfW7HITSCduwX8mTtUHWleDYUBZdrK8VhoTxMSD/ykVUjEQFjjhVaeGjBNxyEV+ckc9+KjygkcaQyUWLEfpEMGbu5C+F+4uSOwIXOX8cpdh/dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785054623; c=relaxed/simple;
	bh=0q6QdcDtvQMhCAyxDdpREQg465tnPLS1ZrnBwgEyzZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tIjhH+zUAIwYmJw6Mf4vstPb/E4jRc/udIoLnvONV3CBFhPrH7jAUoM5xQBlLW71QarEeVNcRKscYVTHyaBz4MehJpwG59qqjTbqtPRRdE5VOfusuBBaKfB8Ztp0A5BBvY94nFir4W2oMR4fSgyG83DgPZ/oOudYDN53KmRFAlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtyQPW8F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtyQPW8F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EDA1F00A3E;
	Sun, 26 Jul 2026 08:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785054622;
	bh=QUFjbMW0RAw+dAPS++gXK16CFiKpiWAakYkF95Jy/uE=;
	h=From:To:Cc:Subject:Date;
	b=VtyQPW8FTbOL3y5cVUZla1Rrfxp80JCgiI7gNVx2v89hfjeQLSOuhjI6VMTFXC8ft
	 2pO9fOCLQByEG9TIwvjTYCYgPE2FysBN9CnGvqFi+0r39a1NrIC66WNyVSSyiWzKYZ
	 x28Vo2nDlrbflLiaftYr23fHDCcHv+jXBb3nloOQC0r4aJf8evVNQhDKbwZmZhNKBr
	 RxsiOulBqQhtS1ka6da+86uwStXCmM3nL1KzmWgrrD20evCR5CDezx7T3ktQOFH+hW
	 HeqE9ZKwcqzpdzey/D/+roQzD20MgpHUswwD+FnunKVjOs/NoHrW1sgXaXvQIZf600
	 B631wzEGffMgw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 00/12] selftests: consolidate TCP_INQ testing into sockopt
Date: Sun, 26 Jul 2026 16:30:05 +0800
Message-ID: <cover.1785054129.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
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
test coverage.

The first version of this series was sent out a year ago. Recently, I
refactored it and addressed all the review comments from Sashiko. During
this process, I fixed several bugs in the original code, so this is a
much better version.

All CI tests are currently passing, including Sashiko and nipa/ai-review.
The two checkpatch warnings are false positives. In addition, I've also
run extensive loop stability tests, and they all passed as well.

v13:
 - Patch 1: seed RNG per child in init_rng fallback. The
   previous fallback 'srand(time(NULL))' collided for two
   children forked in the same second (1-second resolution);
   mixing in getpid() (per-process unique) gives each
   child an independent seed even when /dev/urandom is
   unavailable.
 - Patch 5: fail loud on legacy kernels lacking TCP_IS_MPTCP.
   Previously, getsockopt() returning -1 left is_mptcp at
   0 and do_getsockopts() saw 0 and silently skipped every
   MPTCP-specific assert. Initialize is_mptcp to -1 and
   die_perror() on getsockopt failure, and update call sites
   to handle the tri-state return ('<= 0' / '> 0').

v12:
 - Patch 6 is the only one updated. It no longer uses
	proto_tx == IPPROTO_MPTCP && proto_rx == IPPROTO_MPTCP
   to check for MPTCP sockets - now it uses TCP_IS_MPTCP via a new helper
   in patch 5, which is more accurate. This also makes it work for future
   TCP_MD5SIG tests that use fallback MPTCP sockets.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1784981974.git.tanggeliang@kylinos.cn/

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
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1784082850.git.tanggeliang@kylinos.cn/

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

Geliang Tang (12):
  selftests: mptcp: sockopt: reseed RNG after fork
  selftests: mptcp: sockopt: use exact length in connect_one_server
  selftests: mptcp: sockopt: add check_stat_equal helper
  selftests: mptcp: sockopt: use size_t for byte counters
  selftests: mptcp: sockopt: add is_mptcp_socket helper
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
 .../selftests/net/mptcp/mptcp_sockopt.c       | 463 +++++++++++--
 .../selftests/net/mptcp/mptcp_sockopt.sh      |   8 +-
 5 files changed, 407 insertions(+), 680 deletions(-)
 delete mode 100644 tools/testing/selftests/net/mptcp/mptcp_inq.c

-- 
2.53.0

