Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62B71D5CFE
	for <mptcp@lists.linux.dev>; Thu, 29 May 2025 04:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748491753; cv=none; b=MUPgZ0cd1/41e8FL4a1cVdE3sqSGMQVNCUFNSI/sM0345au7Yu0yDSwIiUjbFlzJRQ3H2xeR5dsv3SYJtinT7iXiJHk4A1te0OCdZK+wrJcJm+HRMddtkYnlz8w3H2XXXBnsV/JG+7FK3vTe6wMRDRv/i1YKZWrz0aUyItNomE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748491753; c=relaxed/simple;
	bh=aqxm23umlCWxbo81FasfxDCEmvIBbGIrg4Gw7LcAgMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xfj2AWoY31amwXzkzGtcSQy+bscFhvXPEJ6qMbq6eHRSkYSC9tlIFaHg91iCWDTB9Roz84cJ+SgJwk+84jITZcPXTrfXsxdd2IGiDiUfG/VEarCLO2nnLkN7rESwbASjp1eik/FvaIk0lzlnaDTGgYQlMLHMFOsPonb5lFlcdJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1LsouaP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1LsouaP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13476C4CEEA;
	Thu, 29 May 2025 04:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748491753;
	bh=aqxm23umlCWxbo81FasfxDCEmvIBbGIrg4Gw7LcAgMc=;
	h=From:To:Cc:Subject:Date:From;
	b=u1LsouaPvWdFpTYt6qsVGjd78l2sStajlfNKsI15SH2svL+NUAPfhjPrCDbtMQ+ZT
	 Wvw99p7sKygz6X4HRLs8bxvqiaLzJJSTne+7jRBI3fRKp7UL/aRtvLeuuI7/ihVKDA
	 aw/PUw4cSKmW/tBKP2yE0zbByVFlItDmzCoqU+Qcu5AFIDI2fBBrTm6fozGD9OKtRy
	 mW/eGPmNzvJu2sZecRE8NGFN72TdV24nlfP+LGL1lYXWVkD0CeBA08BSW8lGN58QCt
	 K878vXX3K9U7j7V4tll3Oza8rbBmzYWqTz1LQUQ+Fn8SqSRfpDFsdlGTcjet4fZpDa
	 4DDmvgMWJBlIQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/3] send() fails with EAGAIN in blocking IO mode #487
Date: Thu, 29 May 2025 12:09:03 +0800
Message-ID: <cover.1748484770.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Good news! I finally solved the unstable issue of MPTCP BPF sched selftests
I reported a year ago, #487 "send() fails with EAGAIN in blocking IO mode".

The fix is simple, it can be solved by explicitly setting SO_SNDBUF
sockopt, but be sure not to set SO_RCVBUF at the same time
(see sk->sk_userlocks & SOCK_RCVBUF_LOCK in mptcp_rcv_space_adjust()).

With this fix, BPF sched selftests are now very stable, I run loop testing
using mptcp-upstream-virtme-docker (run_loop run_bpftest_all), and can run
it normally for hundreds of times without error:


	=== Attempt: 465 (Thu, 29 May 2025 04:04:09 +0000) ===

BPF Test: test_progs -t mptcp
TAP version 13
1..1
# #198/1   mptcp/base:OK
# #198/2   mptcp/mptcpify:OK
# #198/3   mptcp/subflow:OK
# #198/4   mptcp/iters_subflow:OK
# #198/5   mptcp/default:OK
# #198/6   mptcp/first:OK
# #198/7   mptcp/bkup:OK
# #198/8   mptcp/rr:OK
# #198/9   mptcp/red:OK
# #198/10  mptcp/burst:OK
# #198     mptcp:OK
# Summary: 1/10 PASSED, 0 SKIPPED, 0 FAILED
ok 1 test: bpftest_test_progs_mptcp
# time=3
BPF Test: test_progs-cpuv4 -t mptcp
TAP version 13
1..1
# #198/1   mptcp/base:OK
# #198/2   mptcp/mptcpify:OK
# #198/3   mptcp/subflow:OK
# #198/4   mptcp/iters_subflow:OK
# #198/5   mptcp/default:OK
# #198/6   mptcp/first:OK
# #198/7   mptcp/bkup:OK
# #198/8   mptcp/rr:OK
# #198/9   mptcp/red:OK
# #198/10  mptcp/burst:OK
# #198     mptcp:OK
# Summary: 1/10 PASSED, 0 SKIPPED, 0 FAILED
ok 1 test: bpftest_test_progs-cpuv4_mptcp
# time=4
BPF Test: test_progs-no_alu32 -t mptcp
TAP version 13
1..1
# #198/1   mptcp/base:OK
# #198/2   mptcp/mptcpify:OK
# #198/3   mptcp/subflow:OK
# #198/4   mptcp/iters_subflow:OK
# #198/5   mptcp/default:OK
# #198/6   mptcp/first:OK
# #198/7   mptcp/bkup:OK
# #198/8   mptcp/rr:OK
# #198/9   mptcp/red:OK
# #198/10  mptcp/burst:OK
# #198     mptcp:OK
# Summary: 1/10 PASSED, 0 SKIPPED, 0 FAILED
ok 1 test: bpftest_test_progs-no_alu32_mptcp
# time=3

	=== Attempt: 466 (Thu, 29 May 2025 04:04:19 +0000) ===


This set also invalidates the following set named "add io thread mode
tests":
https://patchwork.kernel.org/project/mptcp/cover/cover.1722502941.git.tanggeliang@kylinos.cn/

v2:
 - mptcp: fix the default value of scaling_ratio
 https://patchwork.kernel.org/project/mptcp/patch/0ccc1c26d27d6ee7be22806a97983d37c6ca548c.1715053270.git.tanggeliang@kylinos.cn/

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/487

Geliang Tang (3):
  selftests/bpf: Add sndbuf for send_recv_data
  Squash to "selftests/bpf: Add bpf scheduler test"
  DO-NOT-MERGE: selftests/bpf: Increase total_bytes of bpf sched tests

 tools/testing/selftests/bpf/network_helpers.c | 20 ++++++++++++++++++-
 tools/testing/selftests/bpf/network_helpers.h |  2 +-
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  2 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  4 ++--
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 13 ++++++++++--
 5 files changed, 34 insertions(+), 7 deletions(-)

-- 
2.43.0

