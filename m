Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BE91E492D
	for <mptcp@lists.linux.dev>; Sat, 25 Jul 2026 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784983394; cv=none; b=tAW5lB2n7ORlLq4FVNQ2Hy0bmBKOOODhtvRPYfq2ZNFLwpxZBfDNAL6q1epGS5eXbi2ovW/LAi6eSEFwDmDMzXEJq/UUKhtgaETRkFRnExZBvn5QDUwYV5k7brkWkJavAlu9sHA6tvMSC/fjF1HClnwmsGfU9g5TwFHHfaUxb5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784983394; c=relaxed/simple;
	bh=aXSsZ1pcUwJu8DbYNN32LoCmX/v+aHCsMw7aBFlmw5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NjN+ZFrUc2If8BrciCYKSnsqbmM4UXPiT5G1Be/D4ctNDniV6XXM0sm50PgZuJ6cHsh5D3yiYIjuNwKRk1jD6j8SyAD4KH5PH4HfiVOZ59uw2gszlhQitTF8bzyFJkjhEboMagdw8r5f0UkJGkKrAFCmk3FQ1qvDgByfEjoQjT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qlctco9F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qlctco9F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C131F000E9;
	Sat, 25 Jul 2026 12:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784983392;
	bh=B/nFfCPt1B7zLgzWDQOtuEEod4OEbOfqCUtjf4+Yuds=;
	h=From:To:Cc:Subject:Date;
	b=Qlctco9FIbRkWIyX624FN1BUChxndHhnlxUI0i0qEVVu0zuyrXH7GvX1y6ux4k0T+
	 q6zIgZL5vnPsNb7VoqhPPH46LQnc7zgZyTS00Ed4f5ijWiOUTaDOb1xSB5wbXZIKvQ
	 Zd/oi9g82sWri+xb2CZz+cveBvtV6QIlz5g6zmleEot4uvsF+GZ/JsBPGAX2lfbnfe
	 vmN76UfyN9Wb4zlqdhW/mjaabD1oXSYKEiJg+uhLvB8LknONSsUUauZkTfwv+pSzK2
	 rI53zL/c2Wzyv9aLeFDamebLCIL8EFDRs6A+DRHRRl9+YGEbwGtKPg6OgVEVz0ApV/
	 X1q5uaNYckxqg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 00/12] selftests: consolidate TCP_INQ testing into sockopt
Date: Sat, 25 Jul 2026 20:42:21 +0800
Message-ID: <cover.1784981974.git.tanggeliang@kylinos.cn>
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

v12:
 - Patch 6 is the only one updated. It no longer uses
	proto_tx == IPPROTO_MPTCP && proto_rx == IPPROTO_MPTCP
   to check for MPTCP sockets - now it uses TCP_IS_MPTCP via a new helper
   in patch 5, which is more accurate. This also makes it work for future
   TCP_MD5SIG tests that use fallback MPTCP sockets.

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
  selftests: mptcp: sockopt: add is_mptcp_socket
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
 .../selftests/net/mptcp/mptcp_sockopt.c       | 457 +++++++++++--
 .../selftests/net/mptcp/mptcp_sockopt.sh      |   8 +-
 5 files changed, 404 insertions(+), 677 deletions(-)
 delete mode 100644 tools/testing/selftests/net/mptcp/mptcp_inq.c

-- 
2.53.0

