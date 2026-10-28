Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793186138;
	b=k/j72kcngTIr4pIecI99fEw/2HMycyiRyXFAACT3KqEqCHgh0DTUv2LQEEjHk/MG1qEk
	 QZxJUNWty5e3oTuJyBtWdTcka371B/71Fgl0el0hG649T8+hdDFPViQD/ETk7xKiKyLAX
	 +1zpat0L1F9QhQrmyeYzV60SEOaIbEi7MlyWcfdOGLit/KkcUghUV6qvQXsdZScFBjY9w
	 YU8t4trhvTJVKpzmnFHhaINWn1WychUCcQsCtuaNlxO+bdxFkAJPoAUfWSzn6rWDXxnuz
	 V/m6ANrpTvR2Yk/EoRrlglsALWF2G31aRXYLaSslxDN5a7R8issDHYcxXbcDwBASrsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186138;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=pFlxJwCj0HMDvgGNwLKgKAsxgmxkMgUkmSbE4clw0uo=;
	b=skNX6YmFEPYKUo/MRw+dUm4UiJmfkSwlvOOyYDdvX1jPsgRi0pqNjCA4I+mLSRO4K79K
	 W62XmxsSvc/FGo9fNyZWa9WA1mTsLkQsnqmIJAqBTe9vzsCaMQvWANwrUm/C5NEe5hV3g
	 QybzQ3Gxnpsw0Ok3N5MTnXYpzQvuPkyJ+70ArbVzW5cdDxqvNoQbLuRTAaBeCl5akpPAx
	 kPpxSJVn+QoRxt5zCY2PHzN5oDzebAuNzIzkQejTtkxhV0yWDqdBOxTYx8khtthhKFszO
	 7ta4ZVizV/sQaHoe+B6o8s1VbI2H6/BwjrN//iLk6qmUCXskyr9y9K2zIPBDuOutXYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.52
Received: from sender6-of-o52.zoho.com (sender6-of-o52.zoho.com [165.173.180.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32603606A31A
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 11:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32603606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1793186134; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=M+H2EZ4vrsBg1pPYUH4BegPGHiV0ZDD9qFscOUAg6NT2MFcj6aPJT2YwxlxlqBeYG4UIIBM9zU2MbfLRUDM738RgOWgYSVaFZEHpFSZVG+Srh+/1uwhqY1sA7KtjsASODw6qw+8dBHe75DLeLqiHjGfhP06i6PnRah/pfAcZrbQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793186134; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pFlxJwCj0HMDvgGNwLKgKAsxgmxkMgUkmSbE4clw0uo=; 
	b=EkSUS1oiFzc9VAjtGHCTULkqXASQDSomUx7oTDiLuRn+bDMBWGDP1HENmfivM1kgy00Gia6FYqYWIJUKJU6eyGPVXSL7D+srpIa3RsEesK7cqvf5LWMnCUwr/y55PBCPR1rZCOOhidw7xUkEGsd7E2lbzp4nWwZaWAPOhpzhYQI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793186134;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=pFlxJwCj0HMDvgGNwLKgKAsxgmxkMgUkmSbE4clw0uo=;
	b=lRqolIF+Kj+rUSlLrytuZxoqxLWAqcK2LAAMm8XuCf3Sqh9iNUB4YeJi55DOe+sW
	KEuGPSmvXnmAlUSw5cIjDZxoin2/G5J6zj4AoDeVTFu/BsCMniFDI3XF/RzYANRwtsW
	EKCRyvUcGUK9Hgo6v6O+ieQDr7tmI8HocARs/UNo=
Received: by smtp.zohomail.com with SMTPS id 1793186131378554.6728296751378;
	Wed, 28 Oct 2026 04:15:31 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH mptcp-next v5 0/4] mptcp: sched: penalise a slow subflow
Date: Wed, 28 Oct 2026 16:45:07 +0530
Message-Id: <20261028-mptcp_penalise_send_v2-v5-0-32fb379ce117@mpiricsoftware.com>
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
X-B4-Tracking: v=1; b=H4sIADvZ4WoC/4XOwW7DIAwG4FepOI8KHELoTnuPqYoIMSvTQhCwt
 FOVdx+lh+3QqJIvlv1/9pUkjA4Ted1dScTFJTf70rQvO2JO2n8gdWPpCTCQTPGWTiGb0Af0+ss
 l7BP6sV+A4iiBSdsxrQQp4RDRukuF30nNUI+XTI73WfoePtHkm3zbPrmU5/hTv1igZp4dLMVog
 y0TB901UvG3KbjoTJptPuuIezNP9drS/Pe6Ta8pHkoNegTLBwWbnvjzDpxveqJ4CpiFAYVWFh9
 667r+AixgobeDAQAA
X-Change-ID: 20260815-mptcp_penalise_send_v2-ed6206f70a84
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Janak Patel <janak@mpiric.us>, Kalpan Jani <kalpan.jani@mpiricsoftware.com>, 
 Shardul Bankar <shardulsb08@gmail.com>, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>, 
 Abdul Wasey <w453y.me@gmail.com>
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

Used LLM for design, review, coding assistance.

[1] https://github.com/multipath-tcp/mptcp_net-next/issues/345
[2] https://github.com/shardulsdk-mpiric/linux/blob/e0f78406d921/tools/testing/selftests/net/mptcp/mptcp_sched_penalise.sh
    (run_matrix.sh + runs.conf are alongside it in the same directory)
[3] https://github.com/multipath-tcp/mptcp_net-next/issues/332

Changes in v5:
- Rebased on the current export; no code change.
- Dropped the Assisted-by tags, which the kernel docs no longer describe;
  tool use is noted in this cover letter instead.
- Collected Abdul Wasey's Tested-by, thanks:
  https://lore.kernel.org/all/20261025192320.1831707-1-w453y.me@gmail.com/
- Link to v4: https://patch.msgid.link/20260911-mptcp_penalise_send_v2-v4-0-820f2be4a8fe@mpiricsoftware.com

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
base-commit: d367c3b57a16822766c0f0c9b039a3d29d9dca56
change-id: 20260815-mptcp_penalise_send_v2-ed6206f70a84

Best regards,
--  
Shardul Bankar <shardul.b@mpiricsoftware.com>

