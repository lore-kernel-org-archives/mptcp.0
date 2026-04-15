Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0335A33EB10
	for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247091; cv=none; b=eqAWRcEIdXs8+p6YtiF02xJJezaVyPU8WPKdpK/I0qV2Hir1Alg9lmmn7tQqZ8vq9BlI9Rd1rL+/7qKCedtC7cAt1CjR3tZtfG5B9CKLvKozi1yFkqikNlm34SeQOpkjnxxyj9ExPff5x5ou+/ugIpEAtjk5jNTfXMj9gTw7U8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247091; c=relaxed/simple;
	bh=eOyW8wz5+N6rl1kWachoZ76LpA4DjM/NuDQRQrOt5t4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nqXbgEFBFVWPaliRq6ZwdUgrE+jfEzirM5jbume0o9b2nvTP8uZ80JEuY0U5blnshMU+HgZaNNgT5/zbUvr2UGxTEJhdrRZn4WP8tlymZSbvrNnij+Ze1hIj6M1SYF6rH6Gtzrl7NcNgN1ghYfSTcL4eHjDkvEcfI1a5JL/op/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fd88R4Pb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fd88R4Pb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0CAC19424;
	Wed, 15 Apr 2026 09:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247090;
	bh=eOyW8wz5+N6rl1kWachoZ76LpA4DjM/NuDQRQrOt5t4=;
	h=From:Subject:Date:To:Cc:From;
	b=fd88R4PbZdajHknH71XwCfWE49gFHBMBvEFc5dfMafqtWqJdSZpO2kn3oEaCDqY4I
	 I5461P512BhPC4CZLB8s7Jr47ROnyW41g/dmGrEF3H9pnX8Z92Gvy4WI9t9meEAXhO
	 t5vpRP8c5Yl9IHkjYNHC9EQh0GMmIV2cx70afwaRiRiLOVNr/RWJQS69oBKZXnGnsS
	 89RG8c/rj9oPfMVSLAcAE4ewRoCgQpaqjRIsg36WbtpHXachGKrHkUVfT2txemCtmp
	 CFH2zGE0kNbNzskZVOsP7rzfwPZiwIdCeNdMiXTwUbI7FE2r9QEYDyuq69z2KfQlb4
	 GP5/ekJWe6UAA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v5 00/20] mptcp: pm: increase limits, and related
 fixes and cleanup
Date: Wed, 15 Apr 2026 11:56:48 +0200
Message-Id: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23PwW7DIAwG4FepOI/KGEhLT32PaocMnJatJREwt
 KnKu4+mPWRKjpZ/f798Z4mip8QOmzuLVHzyfaiDftswe2nDmbh3dWYI2IACyW9DtgP3wfKrv/m
 cuCWzFwJQQdOwejZE6vzPRJ7YMx0os/fnKn1/fJLND/IRvviU+/g71RcxnbyazLKpCA4cSOmul
 eCMUMcvioGu2z6eJ7/gTBCwImAVtAJEMB1oJxeCnAsr3xZZBedkY42sEYkLQc0FtSKoKuz2uFP
 kXKud+yeM4/gHheAzyJQBAAA=
X-Change-ID: 20260403-mptcp-inc-limits-ce9811024066
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4043; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=eOyW8wz5+N6rl1kWachoZ76LpA4DjM/NuDQRQrOt5t4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvJyqd9xNIP74zIUTaT8n/vv/5fpfMlJuHTJNWS8TkZ
 UR4xMzqKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmIioFSPDjC11G8o4G6P3cr+y
 mOptt/77K+nKSXnBhRHb3C6dlVSbzPBX/FPFl4OLl4qb2l9tOHJT6nXbIZkeNxvZmln9LyQtWdW
 YAQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The initial intension was to increase the limits, but some fixes were
needed, then when looking at the code around, other fixes had to be
added too. So now I ended up with 11 fixes (including one early exit
while at it), followed by 4 patches increasing limits, 3 to validate the
modifications, one small improvement in the selftests, and some
renaming.

The patches with a Fixes tag are for -net, the rest for net-next.

The last patch contains multiple renaming: please tell me what you
think before I start splitting in smaller commits.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v5:
- patch 5: only set timer_done to true in the timer handler: safer.
- patch 9: fix typo in commit message.
- patch 10: 3rd check expects error, better err msg, rename var.
- Link to v4: https://patch.msgid.link/20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org

Changes in v4:
- patch 5: reset timer_done when the timer is reset.
- patch 10: new: selftests: correctly catch error in 'check output'.
- patch 16: add example with init_shapers to silence AI reviews
- Patch 18: clearer way to check errors (without buggy '&&')
- Link to v3: https://patch.msgid.link/20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org

Changes in v3:
- patch 1: new: retransmit ADD_ADDR for ID 0 with right ID.
- patch 5: moved below + support calling sk_free().
- patch 13: new: allow flushing more than 8 endpoints.
- patch 12: clarify single batch of 8 subflows as known limit.
- patch 16: fix typo in comment.
- Link to v2: https://patch.msgid.link/20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org

Changes in v2:
- patch 2: new: fix potential data-race.
- re-order patches 1 to 5 and use shorter prefix (ADD_ADDR rtx).
- patch 6: restore accidentally deleted icsk->icsk_rto > max check.
- patch 16: fix already present checkpatch warning.
- Link to v1: https://patch.msgid.link/20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org

---
Matthieu Baerts (NGI0) (20):
      mptcp: pm: kernel: correctly retransmit ADD_ADDR ID 0
      mptcp: pm: ADD_ADDR rtx: fix potential data-race
      mptcp: pm: ADD_ADDR rtx: allow ID 0
      mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
      mptcp: pm: ADD_ADDR rtx: free sk if last
      mptcp: pm: ADD_ADDR rtx: resched blocked ADD_ADDR quicker
      mptcp: pm: ADD_ADDR rtx: skip inactive subflows
      mptcp: pm: retrans ADD_ADDR: return early if no retrans
      mptcp: pm: prio: skip closed subflows
      selftests: mptcp: check output: catch cmd errors
      selftests: mptcp: pm: restrict 'unknown' check to pm_nl_ctl
      mptcp: pm: in-kernel: explicitly limit batches to array size
      mptcp: pm: in-kernel: increase all limits to 64
      mptcp: pm: kernel: allow flushing more than 8 endpoints
      mptcp: pm: in-kernel: increase endpoints limit
      selftests: mptcp: join: allow changing ifaces nr per test
      selftests: mptcp: join: validate 8x8 subflows
      selftests: mptcp: pm: validate new limits
      selftests: mptcp: pm: use simpler send/recv forms
      mptcp: pm: clearer ADD_ADDR related helpers names

 net/mptcp/options.c                             |   2 +-
 net/mptcp/pm.c                                  | 182 +++++++++++++-----------
 net/mptcp/pm_kernel.c                           | 106 +++++++++-----
 net/mptcp/pm_userspace.c                        |   6 +-
 net/mptcp/protocol.h                            |  19 +--
 net/mptcp/subflow.c                             |   4 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  33 ++++-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  |  16 ++-
 tools/testing/selftests/net/mptcp/pm_netlink.sh |  74 ++++++----
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   |   8 +-
 10 files changed, 276 insertions(+), 174 deletions(-)
---
base-commit: 438914ced649b46cb53b49d7cb5ff99860bbe103
change-id: 20260403-mptcp-inc-limits-ce9811024066

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

