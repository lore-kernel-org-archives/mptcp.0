Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C932E11B0
	for <mptcp@lists.linux.dev>; Fri, 13 Jun 2025 23:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749856297; cv=none; b=pgKvzlYsHh56v76vftaTpyRg/jowPr2/Y0Yr68tQ0UG5aZocyUJ4u4Rh/2smJ1OkWkPIkrcj/HW3g57+A9nQJ9ZFBLudbF0PzYNz5PdpDcgo6FS91BYvOKBW7UoCUyyCp/1X+kaykywBnF0eVPrXUWkmBj8Th5F/6dK5V5xQB40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749856297; c=relaxed/simple;
	bh=3lySYEy8vjVWERRzS7PEobgY3k+qhhLq36jClij68yk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uIoE7J0ygOMXT6vDIcKhkdPO+QE1CUtAT0j7eCq45NxBgrfuwE7/MDbQx+txGfZXxNU4OBry+F8zU+N1oohUUYBBffgYDh0oapzrWuXQZJAJfSoLRmckRHvPCjCD4KwNPqYJRQu7UZ7ZG4TIujE5NMXFDxn8t3WrNo5BMJGDw2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYomtW4f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYomtW4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3731FC4CEE3;
	Fri, 13 Jun 2025 23:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749856296;
	bh=3lySYEy8vjVWERRzS7PEobgY3k+qhhLq36jClij68yk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=qYomtW4fYyyadScrENvqVTy+ka6E1zlLR8Pm1S9HWNGe2y6g7oheN33fIeUgQPAeH
	 FRmOVi2TX7JkxeN/jAFGXI4zGj3oQUQ2lCuuVUNbq9bAJJS1HoELFkYHFb8zEefblk
	 iJkJWKA3rH5I5n0Pm4lAw8wUCgT0bdTX8/Ms4nnpipjtJXqP+wWLfD4S2+3rKmIlks
	 m7GTOtmrKDNcAdPg23RuOvkrLgXZtlIAVlLCFDpxFwKKayRfchSrkM3BQUoBuu5GEB
	 9l4W+EUeaho3yGYMc5K6g+EjqkYR/3nNou2mROe2zH2Oj28Qq4aguImiTrWm0WO+EO
	 eHWr4KgPbyITA==
Date: Fri, 13 Jun 2025 16:11:35 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/3] send() fails with EAGAIN in blocking
 IO mode #487
In-Reply-To: <cover.1748484770.git.tanggeliang@kylinos.cn>
Message-ID: <a5c20f9f-3038-ed11-b78c-522ef40f9031@kernel.org>
References: <cover.1748484770.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 29 May 2025, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Good news! I finally solved the unstable issue of MPTCP BPF sched selftests
> I reported a year ago, #487 "send() fails with EAGAIN in blocking IO mode".
>
> The fix is simple, it can be solved by explicitly setting SO_SNDBUF
> sockopt, but be sure not to set SO_RCVBUF at the same time
> (see sk->sk_userlocks & SOCK_RCVBUF_LOCK in mptcp_rcv_space_adjust()).
>
> With this fix, BPF sched selftests are now very stable, I run loop testing
> using mptcp-upstream-virtme-docker (run_loop run_bpftest_all), and can run
> it normally for hundreds of times without error:
>

Hi Geliang -

I can see how changing SO_SNDBUF on the sending socket side would shift 
timing behavior in a way that affect the test outcome, but it doesn't 
address the root issue with bug #487:

It is either OK to get an EAGAIN from a blocking send(), or it's not OK.


If it's not ok to ever return EAGAIN from a blocking send, the existing 
test code is a reproducer for a bug, and changing the test is hiding that 
bug.

If EAGAIN is ok, then we should change the code in send_recv_server() to 
allow it.


As Matthieu noted in the comment here 
(https://github.com/multipath-tcp/mptcp_net-next/issues/487#issuecomment-2083123666), 
it may be due to the BPF context that the socket is really non-blocking. 
Did we ever figure out if that was the case - I couldn't find the 
discussion on the mailing list?


- Mat


>
> 	=== Attempt: 465 (Thu, 29 May 2025 04:04:09 +0000) ===
>
> BPF Test: test_progs -t mptcp
> TAP version 13
> 1..1
> # #198/1   mptcp/base:OK
> # #198/2   mptcp/mptcpify:OK
> # #198/3   mptcp/subflow:OK
> # #198/4   mptcp/iters_subflow:OK
> # #198/5   mptcp/default:OK
> # #198/6   mptcp/first:OK
> # #198/7   mptcp/bkup:OK
> # #198/8   mptcp/rr:OK
> # #198/9   mptcp/red:OK
> # #198/10  mptcp/burst:OK
> # #198     mptcp:OK
> # Summary: 1/10 PASSED, 0 SKIPPED, 0 FAILED
> ok 1 test: bpftest_test_progs_mptcp
> # time=3
> BPF Test: test_progs-cpuv4 -t mptcp
> TAP version 13
> 1..1
> # #198/1   mptcp/base:OK
> # #198/2   mptcp/mptcpify:OK
> # #198/3   mptcp/subflow:OK
> # #198/4   mptcp/iters_subflow:OK
> # #198/5   mptcp/default:OK
> # #198/6   mptcp/first:OK
> # #198/7   mptcp/bkup:OK
> # #198/8   mptcp/rr:OK
> # #198/9   mptcp/red:OK
> # #198/10  mptcp/burst:OK
> # #198     mptcp:OK
> # Summary: 1/10 PASSED, 0 SKIPPED, 0 FAILED
> ok 1 test: bpftest_test_progs-cpuv4_mptcp
> # time=4
> BPF Test: test_progs-no_alu32 -t mptcp
> TAP version 13
> 1..1
> # #198/1   mptcp/base:OK
> # #198/2   mptcp/mptcpify:OK
> # #198/3   mptcp/subflow:OK
> # #198/4   mptcp/iters_subflow:OK
> # #198/5   mptcp/default:OK
> # #198/6   mptcp/first:OK
> # #198/7   mptcp/bkup:OK
> # #198/8   mptcp/rr:OK
> # #198/9   mptcp/red:OK
> # #198/10  mptcp/burst:OK
> # #198     mptcp:OK
> # Summary: 1/10 PASSED, 0 SKIPPED, 0 FAILED
> ok 1 test: bpftest_test_progs-no_alu32_mptcp
> # time=3
>
> 	=== Attempt: 466 (Thu, 29 May 2025 04:04:19 +0000) ===
>
>
> This set also invalidates the following set named "add io thread mode
> tests":
> https://patchwork.kernel.org/project/mptcp/cover/cover.1722502941.git.tanggeliang@kylinos.cn/
>
> v2:
> - mptcp: fix the default value of scaling_ratio
> https://patchwork.kernel.org/project/mptcp/patch/0ccc1c26d27d6ee7be22806a97983d37c6ca548c.1715053270.git.tanggeliang@kylinos.cn/
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/487
>
> Geliang Tang (3):
>  selftests/bpf: Add sndbuf for send_recv_data
>  Squash to "selftests/bpf: Add bpf scheduler test"
>  DO-NOT-MERGE: selftests/bpf: Increase total_bytes of bpf sched tests
>
> tools/testing/selftests/bpf/network_helpers.c | 20 ++++++++++++++++++-
> tools/testing/selftests/bpf/network_helpers.h |  2 +-
> .../selftests/bpf/prog_tests/bpf_qdisc.c      |  2 +-
> .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  4 ++--
> .../testing/selftests/bpf/prog_tests/mptcp.c  | 13 ++++++++++--
> 5 files changed, 34 insertions(+), 7 deletions(-)
>
> -- 
> 2.43.0
>
>
>
