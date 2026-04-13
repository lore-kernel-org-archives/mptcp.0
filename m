Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A163CBE63
	for <mptcp@lists.linux.dev>; Mon, 13 Apr 2026 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089526; cv=none; b=WC9024NqLu+w45U3HgPrIctPnfiJXeKv5mZDqBE4yU+H3++jJUM+WSHG+WeN9GT/hFTgjCNKdYzq0JItNyTbSFbc751kiI/vxx+ROk0Gic6mnMio9aRUxz0ETYT3wcWhIE9AE+7nZzvPUjyQIQmleJ4xAYiIjGaXoZB+qconyok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089526; c=relaxed/simple;
	bh=7tq7wc2XBfXdeD3BAFLzTXQ3rCNZMn2lF1mZJKFJMko=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n3c6p4a1NKOSC4itT+T4BZNA9S1qA0MHer/ClyJGwSkHS6QDEAnQVFE8vMRpTDWQoSGXlzH3LZQoew59hileQaEUG3CO4FFNwaBOq12J2AtnMqtL+GQ0pBUc0LkbfrtTPRA1IOgS+zD27AUCKY0scfBIRG088BSNhXMqpA1K8yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maPd4bmf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maPd4bmf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A802C2BCAF;
	Mon, 13 Apr 2026 14:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776089526;
	bh=7tq7wc2XBfXdeD3BAFLzTXQ3rCNZMn2lF1mZJKFJMko=;
	h=From:Subject:Date:To:Cc:From;
	b=maPd4bmf2+Z0cAdy43HiinHOI/lRnhmQm7uN1h42E1TZ7BB04fgtQtOpXPZcz26xE
	 bSxjLfXPXiJYrwcDWC33NebCGDDEGE5ZiaSgW6ZDjmYEIqzqPlhAOb1rSuXHCpJgOI
	 l6IVOYdz7sbTrS5z0G12cZrjib2q5EspCvjMhiR2eqSTKsrnMYmunWLStI+qa/0Sgv
	 DbprT6k4eYuk9Z1bJ9SLef1dJCs/y1hI7HnDZR0Q/jZX8oS5mHuAOCD3HQcfUKODe8
	 8hl7XZzqEk5ZGlp3X3FAErt9bAs+RnS9CaHB+GH/akW8/zBKRP4s6D0IkCpxhSle8V
	 YO94soyyhb5hg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v3 00/19] mptcp: pm: increase limits, and related
 fixes and cleanup
Date: Mon, 13 Apr 2026 16:11:46 +0200
Message-Id: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NTQ6CMBAF4KuQrq2Z/kDElfcwLrAMMIqFtJVoC
 HcXiguNLl9m3vdG5tERerZPRuZwIE+dnYPaJMw0ha2RUzlnJkFmoEHxWx9Mz8ka3tKNgucG850
 QIDVkGZtrvcOKHpE8svXbYmCn9eTv5wuasJDLc0M+dO4Z5wcRK++l/HdpEBw4oE6rQkGZC324o
 rPYbjtXR3+QH4KAP4KchVSDlJBXkJbqS5im6QV1E5S9EAEAAA==
X-Change-ID: 20260403-mptcp-inc-limits-ce9811024066
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3271; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7tq7wc2XBfXdeD3BAFLzTXQ3rCNZMn2lF1mZJKFJMko=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLv/Fzxj38Hl/xhB0U9GYX/l9/aiAkdYlxxLfGbypd3v
 HKm0y74dJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzkuBEjwzJjeZEVy9b8b7ea
 +N/zedTia7H8T+VCkn2P/L0bEBd07h8jw1x+m4YtxeITsxjuHYt/eiaNxWO52ePkit0/YptX1ux
 tZQAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The initial intension was to increase the limits, but some fixes were
needed, then when looking at the code around, other fixes had to be
added too. So now I ended up with 8 fixes (including one early exit
while at it), followed by 3 patches increasing limits, 3 to validate the
modifications, one small improvement in the selftests, and some
renaming.

The patches with a Fixes tag are for -net, the rest for net-next.

The last patch contains multiple renaming: please tell me what you
think before I start splitting in smaller commits.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
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
Matthieu Baerts (NGI0) (19):
      mptcp: pm: kernel: correctly retransmit ADD_ADDR ID 0
      mptcp: pm: ADD_ADDR rtx: fix potential data-race
      mptcp: pm: ADD_ADDR rtx: allow ID 0
      mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
      mptcp: pm: ADD_ADDR rtx: free sk if last
      mptcp: pm: ADD_ADDR rtx: resched blocked ADD_ADDR quicker
      mptcp: pm: ADD_ADDR rtx: skip inactive subflows
      mptcp: pm: retrans ADD_ADDR: return early if no retrans
      mptcp: pm: prio: skip closed subflows
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
 net/mptcp/pm.c                                  | 184 +++++++++++++-----------
 net/mptcp/pm_kernel.c                           | 106 +++++++++-----
 net/mptcp/pm_userspace.c                        |   6 +-
 net/mptcp/protocol.h                            |  19 +--
 net/mptcp/subflow.c                             |   4 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  33 ++++-
 tools/testing/selftests/net/mptcp/pm_netlink.sh |  62 ++++----
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   |   8 +-
 9 files changed, 259 insertions(+), 165 deletions(-)
---
base-commit: 0d8ee8bb5ee08c331531dc4ee482409d7fcef713
change-id: 20260403-mptcp-inc-limits-ce9811024066

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

