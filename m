Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F293F075D
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980278; cv=pass; b=N1N0dmII0+Wm+3SgpS6GdooijqUo2PX4iOm6aUxk/nexGSEq1srZ8DprEgd1FOtpq9fwG92bHQxy5Nh+LkAEd477f/XCf74TFl7XQDN6/WIYkMH/LcTriL3ZDzFh/PsSs7/zWomq/gE90V7N1aSJnBWTiHf6rDL5o/V/MTTZJws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980278; c=relaxed/simple;
	bh=kglVzTs17BNnQU8HHYKK09GzSjKd1JeslfOcqt8l6GE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PVutWBYGc85wjN4PckJscsd7o+uNPHdrOAdDbEa9DZxAZlnKWwdZE42WEsjVXkHJ3d8BgJERZyaCZQmskfk8gZRAH3V+ao3qP6Nb1yQqB7DtKEzZTXi90Z8vruq4tpSLUri8afevZGVF/zpNbAfpLGsniWT7k57/bWZBkC+eAXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=X29fhs4A reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="X29fhs4A"
ARC-Seal: i=1; a=rsa-sha256; t=1786980272; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UQ6nizBCII+jBfp9NlbDrl+2Fd3+N/VuFUl3ScVvmfcQaxchVvBgt+N2WzO+vZ61ZySppvkAtguqcQEW5nCtbZHybmAqbNRnhOp1a7U0NbLXF0Tt6KTBHJI12tNlS4qeTEFpSII9JAMtXBCweIZQUySRM6b3Yf0SWzcEWeRpUYQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786980272; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=58r28QjUBJp+JFyPBRiEVncxTGJdhTsclHxv9QLGfa0=; 
	b=kZTd7j5bDMEABEpLV9xgFm5XHvZJPJdPoo4umV3+s6D6K/WCZ2ZWaw5CbkepBF/ejWQCrsz/mvIxqt7KA6SJXEs/jobaLLxlyO3z3J4N1pa1kNwzctbZfb9lDFVqoJlvk/pAP3hBqpaqd3i0SIKez88YSmVrjAeOQf+bI8fxP64=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786980272;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=58r28QjUBJp+JFyPBRiEVncxTGJdhTsclHxv9QLGfa0=;
	b=X29fhs4AE3rIFINbHUne0V8EXtDpven7CmpTrWp1W4Td/IsgOnQqSnKn1Ca0jNXN
	3APmEoLou46m9PjdkEdN1/sHkwaxNtbsUXQGMQoFsV7NNlsdk2GqwvvRHr5AeexWrfs
	+YmjRIAbdD3gb6wxjCQRPnlsHnL4zaOX8aamk93Q=
Received: by mx.zohomail.com with SMTPS id 1786980270304297.9460309478536;
	Mon, 17 Aug 2026 08:24:30 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH mptcp-next v3 0/4] mptcp: sched: penalise a slow subflow
Date: Mon, 17 Aug 2026 20:54:13 +0530
Message-Id: <20260817-mptcp_penalise_send_v2-v3-0-e6a2ad2f1b82@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ0ng2oC/4WOUQ6CMBBEr0L225pSoKBf3sMQUssia6Rt2ooYw
 t0FPIDJ/Exm3+zMENATBjgnM3gcKZA1q8kOCehemTsyalcPggvJq7Rgg4vaNQ6NelLAJqBpm1E
 wbKXgsiu5qnJYYeexo2kvvsLOMINThPqXhdftgTpuzdt1TyFa/9lXjGJn/j1cxVmGBc9Pqsxkl
 V4GR550sF18K49HbQeol2X5ApVxlYTjAAAA
X-Change-ID: 20260815-mptcp_penalise_send_v2-ed6206f70a84
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Janak Patel <janak@mpiric.us>, Kalpan Jani <kalpan.jani@mpiricsoftware.com>, 
 Shardul Bankar <shardulsb08@gmail.com>, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

A subflow that is slow relative to the others can soak up connection
resources and head-of-line-block the aggregate stream. This series lets the
packet scheduler send less than such a subflow's congestion window by halving
it, and leaves the congestion control to grow it back. It implements
issue #345 [1]. This is a deliberately simple first form.

- Patch 1: a prerequisite fix. The scheduler truncates the pacing rate to a
  u32, which skews subflow selection on fast paths (Fixes).
- Patch 2: penalise a slow subflow by halving its cwnd, rate-triggered and
  gated on the fast path being cwnd-limited.
- Patch 3: skip the penalty when the transfer is receive-window-limited,
  where it would otherwise slow the transfer.
- Patch 4: MPTcpExt counters and a dedicated mptcp_subflow_penalise
  tracepoint for observability.

Validation, baseline versus this series (test helper, its run_matrix.sh
base-vs-patch driver, and run steps are in [2]):
- No regression in the mptcp selftests.
- No regression versus baseline across the buffer-limited transfers
  (send-buffer, receive-window, both, sndbuf>rcvbuf): the penalised two-path
  completion time matches the unpatched kernel. Where the slow subflow is
  beneficial (send-buffer-limited), the two-path transfer stays faster than the
  fast path alone.
- Patch 3's gate keeps the penalty from firing when receive-window-limited,
  where halving cwnd would slow the transfer.
- With a bufferbloated slow path, the penalty roughly halves the slow path's
  queueing latency (subflow srtt), with the transfer time unchanged. It does
  not reduce the aggregate out-of-order volume or move data off the slow path;
  that is the role of #332, and the two are complementary.
- One regime, unbounded buffers with a purely delay-slow path, shows a
  throughput cost that grows with the delay; the current gates do not catch it.

On patch 4: observability is a dedicated mptcp_subflow_penalise tracepoint
rather than a field on the existing mptcp_subflow_get_send. The penalise verdict
is only known after the selection loop, so a field there would need a second,
post-decision emit plus a marker to tell it apart from the per-candidate emits,
and would make existing get_send consumers count an extra event per call. A
dedicated tracepoint avoids the double emit and leaves mptcp_subflow_get_send
untouched. Happy to use a field instead if you prefer.

[1] https://github.com/multipath-tcp/mptcp_net-next/issues/345
[2] https://github.com/shardulsdk-mpiric/linux/blob/161a4bd556eb/tools/testing/selftests/net/mptcp/mptcp_sched_penalise.sh
    (run_matrix.sh + runs.conf are alongside it in the same directory)

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

 include/trace/events/mptcp.h | 30 ++++++++++++++++
 net/mptcp/mib.c              |  2 ++
 net/mptcp/mib.h              |  2 ++
 net/mptcp/protocol.c         | 85 ++++++++++++++++++++++++++++++++++++++++----
 net/mptcp/protocol.h         |  2 ++
 5 files changed, 115 insertions(+), 6 deletions(-)
---
base-commit: 19c6bf13fd58c0d98668764de2f3d68d975685c9
change-id: 20260815-mptcp_penalise_send_v2-ed6206f70a84

Best regards,
--  
Shardul Bankar <shardul.b@mpiricsoftware.com>

