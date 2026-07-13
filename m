Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3850314A86
	for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 03:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913148; cv=none; b=uROP7Ka5Qh5aW/KpC5afKrss8vECBrv7ePz/64z/J9pKywiB7OAkHESRPotpCpBfVZuTJHi7rRQIsnFP5EB6PN7j8dBA89CPT9xaVZz1ThjXaXSBCozcBDlGvEDxBi6MEezv0GRDb6QiG0vAuEx4liYDUyrfDb6zktx7+cX54O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913148; c=relaxed/simple;
	bh=5ba0wtSaFh/vw62lYR/PPY3Y2QQMeXWeOnaBB5oF7A4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X3carxxwnoCOkH5IJDDNVbAKFda/hJSnli2cXQkvLIXPfMkFVEnUzYHQlQ/NPzOzqG6QhBzBa7AtHDgXz39NNhMuxTcF/mAYYUPH8ysFkuJJENKYBrd5ZI5Ux6v5l72Ph++Er5odVYF7CUKqXkcLRttUmom/94wmVd9NtroS3xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVfdxOsE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVfdxOsE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E95D1F000E9;
	Mon, 13 Jul 2026 03:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783913147;
	bh=g9dlPAteO9ajP9G7FFUav/HgZgCU2XZu1Bu7TajzczQ=;
	h=From:To:Cc:Subject:Date;
	b=AVfdxOsEyJqyLqWXN2rDJXMs30jwB4I68IHHtBr9BPwsyqA1ny6Xb2Xl5xfX8oHAV
	 cvP6H5QTE6eM/I6YcYoAnXnhNKz7reofrYulc2GTUqoAwcQjFqsK1coPDCHXIf5pV7
	 mNeTXztPHr1vsnN8bfChWyb2V+ZfQ9G9FSorJKrOMXxJ6bpvUDI29KvosHABj6SACY
	 GhcKfqzolQUpDUuzjgqZUIe1ichUkyhdVs8crpvf9lkB7HRyqC9aSCeDxXCgcki++d
	 0SQtdhCttLqB3vDpyC+HbvSygV/xxSL4nQcSYKqECy3du1OXf3pfqzQUC4XHc3BsWp
	 1jBfLRXAmAxOg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 00/12] selftests: consolidate TCP_INQ testing into sockopt
Date: Mon, 13 Jul 2026 11:25:24 +0800
Message-ID: <cover.1783913010.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v9:
 - No code changes compared to v8.
 - To address Sashiko's complaints that the implementation of
   server_huge_transfer() was split across several patches, the patch
   order has been rearranged, some patches have been squashed into
   fewer ones, and the commit logs have been updated.

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

Geliang Tang (12):
  selftests: mptcp: sockopt: validate bytes_acked against sent bytes
  selftests: mptcp: sockopt: use r/w for byte counts
  selftests: mptcp: sockopt: replace /dev/urandom with getrandom
  selftests: mptcp: sockopt: reseed RNG after fork
  selftests: mptcp: sockopt: add tx/rx protocol options
  selftests: mptcp: sockopt: add TCP_INQ test option
  selftests: mptcp: sockopt: use unix socket instead of pipe
  selftests: mptcp: sockopt: use recvmsg instead of read
  selftests: mptcp: sockopt: read exact payload length
  selftests: mptcp: sockopt: get and verify TCP_INQ
  selftests: mptcp: sockopt: add huge data transfer tests
  selftests: mptcp: sockopt: replace mptcp_inq with sockopt

 tools/testing/selftests/net/mptcp/.gitignore  |   1 -
 tools/testing/selftests/net/mptcp/Makefile    |   1 -
 tools/testing/selftests/net/mptcp/mptcp_inq.c | 614 ------------------
 .../selftests/net/mptcp/mptcp_sockopt.c       | 436 +++++++++++--
 .../selftests/net/mptcp/mptcp_sockopt.sh      |   8 +-
 5 files changed, 378 insertions(+), 682 deletions(-)
 delete mode 100644 tools/testing/selftests/net/mptcp/mptcp_inq.c

-- 
2.53.0

