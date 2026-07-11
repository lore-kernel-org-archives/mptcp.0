Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BDD23B62B
	for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 03:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783741470; cv=none; b=VYdfBdEvrcU8qNacrX2m6YWBGnIaovvSsmEqM42E8tXV3iFEPeaFQ/UY2Q/Go/oTTZfvWO5KLLWiOZY2fKBHRyxPY2hNdK7/RzWq3VQI1JNRsVNXYo59CPUbpbW7rPA0wBoW3+o29qQeI/4KPoF7DDhs3gRwXCO1jl27jeNRnKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783741470; c=relaxed/simple;
	bh=epRUm09AnTFc3iUlbyfmJ1swH4Ngp4K914CXG2BhCzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LX+hvgjUIdJhhtrimJmckp+QwWW1fcIXVlVO0f7DomGTuibJsI5zRdBplYObB91wx/ku9GonorN1QCx2Ki9KTC91hHBDUB6emb9rMzSYvFT8lrywbn6L7EJ4rxs03qUPFcrUXLboVmGhOP6h0Q37uzrZL4jqEyi42Z8Q7N2zXt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV3zRkRu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV3zRkRu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E891F000E9;
	Sat, 11 Jul 2026 03:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783741469;
	bh=1/fLjoIMdqwnB5CnwsjgLRzAlcpUjsNe/tJGi4xGzL8=;
	h=From:To:Cc:Subject:Date;
	b=FV3zRkRuiQObEWSQ6NbM6St0JLj+h6T5gJm06PErjajJ8u72l8k6q5o/SNsUWmjXY
	 6tJ62UoHWsmma+s6Z2LxTs5ScvoCT7umCTU2VSUhJpY3FTFAb4Zx1H5Io8c80yqQ69
	 vBeAZrORej4lTV4XPjuWPGr1DgqXiWnkDRorYL03eksrMS3iNL5Tv+dH0nFPWWQyIR
	 9ozFkgKaa4KECgIadXZqh3S7F/GHpDgf4twmPkHXH4W9ZYAXnnC7OtWrJQMPA2vqkh
	 wYUokFShLlQ8ECScY7gcnpweEMDaxGU5gtmqgM20LDZuxRTFuaogevgG5uHfqL2+HJ
	 Dqo8JE4K7R5Qg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 00/14] selftests: consolidate TCP_INQ testing into sockopt
Date: Sat, 11 Jul 2026 11:43:28 +0800
Message-ID: <cover.1783740443.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

Geliang Tang (14):
  selftests: mptcp: sockopt: reseed RNG after fork
  selftests: mptcp: sockopt: validate bytes_acked against sent bytes
  selftests: mptcp: sockopt: use r and w for byte counts
  selftests: mptcp: sockopt: add tx/rx protocol options
  selftests: mptcp: sockopt: add TCP_INQ test option
  selftests: mptcp: sockopt: use unix socket instead of pipe
  selftests: mptcp: sockopt: read exact payload length
  selftests: mptcp: sockopt: pass echo length over unixfd
  selftests: mptcp: sockopt: set FIONREAD ioctl
  selftests: mptcp: sockopt: add huge data transfer tests
  selftests: mptcp: sockopt: wait ack for huge transfer
  selftests: mptcp: sockopt: use recvmsg instead of read
  selftests: mptcp: sockopt: get and verify TCP_INQ
  selftests: mptcp: sockopt: replace mptcp_inq with sockopt

 tools/testing/selftests/net/mptcp/.gitignore  |   1 -
 tools/testing/selftests/net/mptcp/Makefile    |   1 -
 tools/testing/selftests/net/mptcp/mptcp_inq.c | 614 ------------------
 .../selftests/net/mptcp/mptcp_sockopt.c       | 415 ++++++++++--
 .../selftests/net/mptcp/mptcp_sockopt.sh      |   8 +-
 5 files changed, 372 insertions(+), 667 deletions(-)
 delete mode 100644 tools/testing/selftests/net/mptcp/mptcp_inq.c

-- 
2.53.0

