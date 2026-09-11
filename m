Received: from sender6-of-o52.zoho.com (sender6-of-o52.zoho.com [165.173.180.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655883D75A2
	for <mptcp@lists.linux.dev>; Fri, 11 Sep 2026 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120681; cv=pass; b=m5rG/9pPdeIIOg7N6GTP3ITUFVCtbzk1ZGvxu9z+F5kWWD9/mEBt4NRQOOEngkWJpEymPD8sj5r7b4V6b1qPnaCbEriGagzGzZAaVA0NWAaFlWNeExsoQPVtx9E7pYGZHe7gUyTddD1bDchMwbC1xtayZWEpTr4Z/9GhFZBPTjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120681; c=relaxed/simple;
	bh=S4+HVSpCmnonYSPo06r0WIpVX4dhmngvPJHjpzM7G+A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mVtRUgInT9D4eOGlN5/BTNzbqbAxCsVGDFaaWanJ55NuQPmoK7ovuoPQeXM5vUefKw3eh5kjFETUxAtrhnAcHzdgCNUqjae6yOikvBIPQAPYtgNNbmnU7xD917GcA6JlyCQ+n4CWzfpYcQDK+iG4JBKDfYWaNZaQJV+uUbzoNGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=WGNQeJu3 reason="key not found in DNS"; arc=pass smtp.client-ip=165.173.180.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="WGNQeJu3"
ARC-Seal: i=1; a=rsa-sha256; t=1789120676; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jtU9JELdDfcOaVHYWqk99RSz8r3/TesFe0l/dbaCUXszuXj3CvT7+k99kJE78kfB9VMyghy2oxCLJJgCfgoL3sOfwAkX4M5THvqVSEMG0IG7s4nF2D8ahWpKwb/D1ZXKtL5OEa+Lka/Aqv4zA7ZhaCAhBPEnrzN+OGrcC4TkXsY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789120676; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WRFZS+xTcZDoJwE+PhIPavD8sJjBLcr+bhqwNhLPvDk=; 
	b=SvmspeEVigW4AK75pMR6UIlHgvqr9ogIaFTrJZXEsjfd/DldHfMW0xTgcCIc6/ZtQS0/HFceKfCgmu9+s7gfnoTmCgoDxeAmCcGCP40vHo79Z+ZPJ8c8KnVJP3Oih3GnppNShXYUypeJhumswSbFymaFEZUCVbMCzJtJ54j+TH8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789120676;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=WRFZS+xTcZDoJwE+PhIPavD8sJjBLcr+bhqwNhLPvDk=;
	b=WGNQeJu3nHXYumMh/fg3zrHsPA/Y/TFu+2IJGu0YC63Uwd/8WJDd1j/Tnhe6PR4e
	mkGWMyl3gRzZ5wjLTDgTpjFj+LH7ZjE1a5KDZuydy8YbOgVe7ymWMsMs6+eEQYYIt+T
	TTt0GfgoQL0yyaY8q8vKsJVpf+RVgM6EqMkU/gEE=
Received: by smtp.zohomail.com with SMTPS id 1789120674514806.7023163377794;
	Fri, 11 Sep 2026 02:57:54 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH mptcp-next v4 0/4] mptcp: sched: penalise a slow subflow
Date: Fri, 11 Sep 2026 15:27:43 +0530
Message-Id: <20260911-mptcp_penalise_send_v2-v4-0-820f2be4a8fe@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJjQo2oC/4WOQQ6CMBBFr2K6tqYUKOjKexhDShlkjJSmrYgh3
 N1SNy40JrP5mXnvz0wcWARHDpuZWBjR4aBDyLYbojqpL0CxCZlwxgUrk5z2xitTGdDyhg4qB7q
 pRk6hEZyJtmCyzEiAjYUWpyg+kchQDZMn5/fO3esrKL+a1+sOnR/sM34x8sj8KwzDaAo5y/ayS
 EWZHHuDFpUbWv+QFnZq6GPbmH76ip++NPhASC4b3iZ1yb/6lmV5AQBtERYzAQAA
X-Change-ID: 20260815-mptcp_penalise_send_v2-ed6206f70a84
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Janak Patel <janak@mpiric.us>, Kalpan Jani <kalpan.jani@mpiricsoftware.com>, 
 Shardul Bankar <shardulsb08@gmail.com>, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

A subflow that is slow relative to the others can soak up connection
resources and cause head-of-line blocking of the aggregate stream. This
series lets the packet scheduler send less than such a subflow's
congestion window by halving it, and leaves the congestion control to
raise it again. It implements issue #345 [1]. This is a deliberately
simple first form.

- Patch 1: a prerequisite fix. The scheduler truncates the pacing rate to a
  u32, which skews subflow selection on fast paths (Fixes).
- Patch 2: penalise a slow subflow by halving its cwnd, triggered on its
  pacing rate and gated on the fast path being cwnd-limited.
- Patch 3: skip the penalty when the transfer is receive-window-limited,
  where it would otherwise slow the transfer.
- Patch 4: MPTcpExt counters and a dedicated mptcp_subflow_penalise
  tracepoint for observability.

Validation, baseline versus this series (test helper, its run_matrix.sh
base-vs-patch driver, and run steps are in [2]):
- No regression in the mptcp selftests.
- No regression versus baseline across the buffer-limited transfers
  (send-buffer, receive-window, both, sndbuf>rcvbuf): the two-path completion
  time with the penalty enabled matches the unpatched kernel. Where the
  slow subflow is beneficial (send-buffer-limited), the two-path transfer
  stays faster than the fast path alone.
- Patch 3's gate keeps the penalty from firing when receive-window-limited,
  where halving cwnd would slow the transfer.
- With a bufferbloated slow path, the penalty roughly halves the slow path's
  queueing latency (subflow srtt), with the transfer time unchanged. It does
  not reduce the aggregate out-of-order volume or move data off the slow
  path; that is the role of issue #332 [3], and the two are complementary.
- The conditions above do not catch one case: with the buffers left to
  autotuning and a subflow that is slow because of latency rather than limited
  bandwidth, penalising it costs throughput, and the cost grows as the added
  delay grows.

[1] https://github.com/multipath-tcp/mptcp_net-next/issues/345
[2] https://github.com/shardulsdk-mpiric/linux/blob/e0f78406d921/tools/testing/selftests/net/mptcp/mptcp_sched_penalise.sh
    (run_matrix.sh + runs.conf are alongside it in the same directory)
[3] https://github.com/multipath-tcp/mptcp_net-next/issues/332

Changes in v4:
- Patch 1: compute the pacing-rate average with 128-bit intermediates
  (mul_u64_u64_div_u64); a single 64-bit numerator overflows at a high
  pacing rate with a large send queue. Dividing before multiplying loses
  too much precision on slow paths, details in the commit message.
- Patch 1: add a second Fixes tag. The u32 truncation predates the
  averaging formula; it dates to d5f49190def6.
- Patch 2: evaluate the conditions on the subflow itself where the penalty is
  applied, under that subflow's socket lock; the scheduler only marks a
  candidate. Annotate the cross-subflow tcp_is_cwnd_limited() read with
  data_race().
- Patch 2: exclude backup subflows from the fastest-path comparison. A
  backup carries no data while an active subflow exists, so its rate and
  cwnd-limited state go stale, and using one as the reference penalised
  the subflow that was actually sending.
- Patch 3: drop a throughput figure taken from an early debug-kernel run;
  the mechanism argument stands without it.
- Patch 4: add the send burst to mptcp_subflow_penalise, and emit the
  verdict once the burst is known.
- Longer explanations moved from code comments into the commit messages.
- Retested base versus this series on one kernel configuration, congestion
  control pinned to reno, three runs of the full matrix on each side. No
  behavioural difference against v3.
- Link to v3: https://patch.msgid.link/20260817-mptcp_penalise_send_v2-v3-0-e6a2ad2f1b82@mpiricsoftware.com

Changes in v3:
- Dropped the RFC tag (Matthieu Baerts (NGI0)). No changes to the patches themselves.
- Rebased on current export.
- Link to v2: https://patch.msgid.link/20260815-mptcp_penalise_send_v2-v2-0-3e5049a73681@mpiricsoftware.com

Changes in v2
- Patch 1 (new, not in v1): fix the scheduler's pre-existing u32 pacing-rate
  truncation (Fixes: 3ce0852c86b9).
- Patch 2 (v1's 1/3): also skip a subflow already at the cwnd floor
  (MPTCP_PENALISE_MIN_CWND); clear the flag when returning without send-window
  room; re-check TCP_CA_Open in the apply path; express the rate trigger as a
  division (avg_pacing_rate < max_pace / ratio, using the widened pace from
  patch 1) instead of a u64-cast multiply.
- Patch 3 (v1's 2/3): make the receive-window test wrap-safe
  (after64, like tcp_snd_wnd_test()); same condition otherwise.
- Patch 4 (v1's 3/3): real MPTcpExt counters (dropped DO-NOT-MERGE) plus
  a dedicated mptcp_subflow_penalise tracepoint (not a field on
  mptcp_subflow_get_send).
- Rebased on current export.
- Link to v1:
  https://lore.kernel.org/mptcp/20260726-mptcp_penalise_send-v1-0-84485e0e995b@mpiricsoftware.com

Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
Shardul Bankar (4):
      mptcp: sched: avoid truncating the pacing rate in the scheduler
      mptcp: sched: penalise a slow subflow by halving its cwnd
      mptcp: sched: do not penalise when receive-window-limited
      mptcp: sched: add penalise counters and tracepoint

 include/trace/events/mptcp.h | 33 ++++++++++++++++
 net/mptcp/mib.c              |  2 +
 net/mptcp/mib.h              |  2 +
 net/mptcp/protocol.c         | 89 ++++++++++++++++++++++++++++++++++++++++----
 net/mptcp/protocol.h         |  2 +
 5 files changed, 121 insertions(+), 7 deletions(-)
---
base-commit: b49aa4201a14e200297db9adcde3495e5a778517
change-id: 20260815-mptcp_penalise_send_v2-ed6206f70a84

Best regards,
--  
Shardul Bankar <shardul.b@mpiricsoftware.com>

