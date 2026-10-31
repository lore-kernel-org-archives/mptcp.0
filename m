Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793486691;
	b=sFi1iXSXVCdDUG6QCdcrVJkf6HVtlTMgQhBsZAQU4L+498EjaU8HWOgOWWFaKNV6Dc++
	 zPkrqaGMYgJinxSMvAPB+kca1mi5b1mfDqsd7qMuutaeTDbCC7P8VahVlthdymBLAiimL
	 uFpGGbmH88zjDuKdYzF8IFazJg9+MwE3Zt09LncyJ3x9C7EgIYsUW7HyDX7ZdUA6BvGx4
	 6JWN4r/I8yYLtZU/Qh+1dpRtkwWs44ZRK78T7M/0imlSSi1rryWAH9JtcAGVMeO3BFJaZ
	 HTo1q7rMhSu7mYGWP6Ve9LMj7TO7tf0jGx/tTD/utpSs/nLGA62TAlNv9+3i1C/8BnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793486691;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=sGcRFmbuaoiDAfeDXTnyWwa2XWn4O+OAE4CnsESfdcA=;
	b=qa3JlnekXQRyL3wG+DMMoU+ZK6mWvFeoK2r4ckO4FVILhVDff/jK5TsTlMR3mR3wROpm
	 uPqMU8iP6hNY+FpRSHDgcyrSSc2E5VU96Y88+TK1HksW1F4J344ditYjcZWuWeQ2M2yKy
	 JLyncOntZZAxX/jECiUHz3oDgN0pCQzOlFLMN7xtmFgN3BuFJ2Ydxh5dPgGZyKXxgd88C
	 4LChryw6DSFAwfCgjBPdUUTNEjAm/7ej46mzEMWkdBNVcE0A/D+8/bJGy7fRGgTzOO3nf
	 O9Yl9Nf4zuf0GHETfsKYCTN45i7RelWAEd1scLusTbIEvJOiZ2gY5OdwinGjJCUmCoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dm71odeB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BFD606A31A
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 22:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dm71odeB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8301F000C1;
	Sat, 31 Oct 2026 22:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793486690;
	bh=sGcRFmbuaoiDAfeDXTnyWwa2XWn4O+OAE4CnsESfdcA=;
	h=From:Subject:Date:To:Cc;
	b=Dm71odeBOxhyFsWeWaxW5hI7y1lTIJS3zX7xhz33E9HvFRxSjKtXg0sD9UXlm0I3O
	 hfsC3J+4xbIFa2POXIj3v+PQCawm5FMGOCr9UOh1sEoW3o/qJiiiPQ0KOcLP+Fckel
	 4G10D8F01ib/Wjr/fnB1PUWyB7lvorBzzvwSWxW4jIAQZOUhVIPHF3BVBqfCnJtBr3
	 M3mi/+jwmh18AdXl9f3Z8v+NRGNo80YkDk1kL4KFGFfcofx5hdu9pll9gVe/YlxAC5
	 0LkvqZyyVxkJSyKBgJuMkNx+hUQqVrVGwjuw6dRLcGuLrq4VB57RYkEQ8li0LCY5+n
	 J1Fj5FbdeD9Ng==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v2 0/8] mptcp: sched: reinjection and a send
 limit as scheduler actions
Date: Sat, 31 Oct 2026 23:44:32 +0100
Message-Id: <20261031-mptcp-sched-opp-retrans-v2-0-e9c4a30f6841@kernel.org>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMAwAf2Xk2cBaoai/Ij50beYi2IWkk8HYv
 1vd43HcbWCkTAa3bgOlDxvPpYE/dZCmWJ6EnBuD731w/dnhW2oStDRRxlkElarGYhjyNbqcQxo
 uI7RalEZe/+c7HFGhtcLjcLYML0r1t4Z9/wI2k/68hwAAAA==
X-Change-ID: 20261031-mptcp-sched-opp-retrans-6d9a1dd6cb8f
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Abdul Wasey <w453y.me@gmail.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gregory Detal <gregory.detal@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6537; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=c3PGiJMWKMuGcRIcNDTWxFUSZrY+YAc39PukX9gBrGo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLKe5Uc1dSvl1XEcFTpx+Pm9eb7mM19vV30eGCGSapjcO
 Mlho/j9jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIm0bWVkeOLKe+9DXcftvw+4
 PrtopaxO3cRbntbVM+WRorfHQ403mxj+KSzXZVBzKjKyvTmRuTXrPJdYamLvqW1PPIJLLBhUyjk
 YAQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Note: this cover-letter has been written by Abdul. I only modified the
ChangeLog to add my recent modifications. (The results from the perf lab
were the ones from Abdul, before my modifications.)

This takes over Gregory's "update scheduler API" RFC [1], and redoes the
opportunistic reinjection RFC [2] as a scheduler action, as Matt asked.

Patch 1 is a fix: the send window could go past what the peer offered
after a retransmission, which reinjecting makes a lot more likely.

A scheduler can't do two things today:

- Send less than one dfrag per decision. msk->snd_burst is only checked
  once a whole dfrag is sent, and a dfrag can be 32 KB, so for example
  one MSS per subflow in turn is not possible. Patch 2 adds send_limit,
  a subflow field set in get_send, used for that decision only. This is
  the "limit" of [1], as a struct member checked at load time and not a
  second call with flags, as Mat suggested on [1]. Stopping inside a
  dfrag leaves it the send head, partly sent, as when a subflow runs out
  of space, so first_pending moves as before. Patch 6 lets BPF
  schedulers set it.

- Resend data that a slower subflow holds on an idle one. Patch 3 calls
  get_retrans for that too, so there is still one call per decision.
  msk->sched_retrans says why: the MPTCP RTO as before, or a subflow is
  idle while nothing new can be sent because the receive window is full,
  the send buffer is full, or the application has nothing more to write:
  patch 4 checks this on each DATA_ACK.
  The scheduler marks a subflow and sets reinject_limit there, and the
  core resends the DSN ranges the other subflows hold, which a BPF
  program can't walk. Patch 5 gives the default scheduler the policy of
  [2]: only when the copy arrives at least one RTT of the idle subflow
  sooner. Patch 6 lets BPF schedulers set reinject_limit too.

Shardul asked whether the application limited case should trigger it
[3]. I measured it: it is where most of the latency gain is, so it stays
and the reason is passed to the scheduler, which can ignore it.

Tests, on the current export with Shardul's v5:
- the two new BPF tests and the other mptcp BPF tests, on a debug kernel
  (KASAN, lockdep); the send limit test fails without patch 2 (32728
  bytes in one decision instead of at most 4096);
- mptcp_connect.sh (all modes), mptcp_join.sh, mptcp_sockopt.sh,
  pm_netlink.sh, simult_flows.sh, userspace_pm.sh, the kunit and
  packetdrill tests, on the same debug kernel;
- the perf lab [4], 5 runs of the base above as history, then the
  series (alpha 0.01). 106 tests unchanged, 28 improvements, 5 flagged.
  The largest changes, iperf3 received in Mbit/s:

    weak_secondary                                       20.6 -> 70.1
    bad_secondary                                        22.8 -> 70.5
    bad_secondary bbr                                    39.2 -> 68.0
    bloated_slow_secondary receiver_tcp_mem parallel=99  41.4 -> 92.4
    huge_lat_primary rmem=200                             8.1 -> 17.3

  Of the 5 flagged, 4 are only how the data is split between the paths,
  the total does not go down: huge_lat_primary, clientlim slow_secondary
  bw=5 and slow_primary bw=10 (their totals go up by 2-7%), and
  weak_secondary backup (about 12 bit/s on the backup path in both). The
  one cost is mem-pressure slow_primary both_tcp_mem parallel=10: iperf3
  received is 1-2% lower (51.2-51.7 vs 52.1, 4 runs), the receiver total
  is the same, so these are the copies. I reran the flagged suites to
  check, the results were the same.

[1] https://lore.kernel.org/mptcp/20240527-sched_per_packet-v1-0-09a41d405f7c@gmail.com/
[2] https://lore.kernel.org/mptcp/20261025134643.1537069-1-w453y.me@gmail.com/
[3] https://lore.kernel.org/mptcp/6ac6cd6f5c7d67c598ae34bbf3bcf6a0edd0e983.camel@mpiricsoftware.com/
[4] https://github.com/multipath-tcp/mptcp-upstream-virtme-docker/blob/latest/PERF.md#tracking-regressions-locally

Based-on: <20261028-mptcp_penalise_send_v2-v5-0-32fb379ce117@mpiricsoftware.com>
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2 (of [2]):
- a scheduler action through get_retrans, not in the core for every
  scheduler;
- rebased on Shardul's "penalise a slow subflow" v5;
- the reason is passed to the scheduler (Shardul);
- the subflow list is only walked while no process owns the msk, the
  ranges are merged, and the budget is exact (sashiko-bot);
- a scheduler that doesn't implement get_retrans never wakes the worker
  (MPTCP CI, BPF first test);
- fix the send window after a retransmission, new patch 1;
- check for an idle subflow with all schedulers, deferred if msk owned;
- a refusal is only final for a snd_una with an idle subflow;
- joining and closed subflows are no longer seen as gone;
- only copy what slow or gone subflows hold, lowest DSN first;
- clear left-over send_limit and scheduled flags.

---
Abdul Wasey (6):
      mptcp: sched: let get_retrans reinject on an idle subflow
      mptcp: sched: look for an idle subflow on each DATA_ACK
      mptcp: sched: reinject on an idle subflow with the default scheduler
      mptcp: sched: let a BPF scheduler set the send and reinject limits
      selftests: bpf: mptcp: test the send limit of a scheduler
      selftests: bpf: mptcp: test a scheduler reinjecting on an idle subflow

Gregory Detal (1):
      mptcp: sched: let get_send limit what one decision sends

Matthieu Baerts (NGI0) (1):
      mptcp: do not use a raised snd_wnd for the send window

 net/mptcp/bpf.c                                    |   6 +
 net/mptcp/mib.c                                    |   2 +
 net/mptcp/mib.h                                    |   2 +
 net/mptcp/options.c                                |  12 +-
 net/mptcp/protocol.c                               | 122 ++++++-
 net/mptcp/protocol.h                               |  51 +++
 net/mptcp/sched.c                                  | 384 ++++++++++++++++++++-
 tools/testing/selftests/bpf/prog_tests/mptcp.c     | 130 +++++++
 .../testing/selftests/bpf/progs/mptcp_bpf_limit.c  |  94 +++++
 .../selftests/bpf/progs/mptcp_bpf_reinject.c       |  70 ++++
 10 files changed, 868 insertions(+), 5 deletions(-)
---
base-commit: df540f052ed58044886a6f6f98cc98c25172764f
change-id: 20261031-mptcp-sched-opp-retrans-6d9a1dd6cb8f

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

