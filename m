Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088E8299929
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876042; cv=none; b=d0FzplE4qE/qRxQvyfBS5ynq5vPvGjQVmcUXqM31oDN4XGZ1TrquYtbei7OnDqqo/0Tw0Ojqpku782BfIWhcv5DbtScydWT0BFnJhRbMNvJBmBw1O4W8ZqRhaHfParrvoOst/vH9nC69GLbbEKkTSzQXx+pYp2egUxnyDEugA7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876042; c=relaxed/simple;
	bh=0I/XEOl3BBbdBYy9Na7MR8Q09QeEPSBlH59S/lFHfog=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Jpxd13NKCrcLJPcxYK0QfqaY2D8ZkmoxX+yhy5G4uRxju633M1uQO1ozIFxx1TXry+BRY52EeoGM4VirAUI3RlQawJ4xNGRgD3Z6VsGLOzVOhpbOGf2OyHlgrxqWdmEPU+FRI5UVcn34ne4jFTlpMdj6G0D3H6lKK2R+MtjjTD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBq11yn3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBq11yn3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C88AC19425;
	Wed, 22 Apr 2026 16:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776876041;
	bh=0I/XEOl3BBbdBYy9Na7MR8Q09QeEPSBlH59S/lFHfog=;
	h=From:Subject:Date:To:Cc:From;
	b=nBq11yn3EalpBSFxYb7lHuOuWYgywEnBKsFprWElIG0u6Qr4FO3iw6ZJdC6YjWXVn
	 DBDOBO7r7o2awpsI7tknUvyq4BwAtr5RZa2A78+K9xcN7M6QmLz+i2eyqFdtVYsiKf
	 yVebogUZndZoEfG2SXc2H5DcOvyGvvq+2jj6l2FOCv1+Og8jOkaIfx4dwdVKb4e04t
	 kj3jYtVoZbZ1HcTpZqUYjMoHL2uGllQ07TnKzLWINYkKQGe+ovXyJmhGQaJCSWqHKE
	 JhyhSnHWvRivfyephWHVNY7RtznvzN96EtOMeRqbZsa5cQGi3TyrVn92TPW7VqPlhz
	 DbOgfMn5CApig==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v6 00/19] mptcp: pm: increase limits, and related
 fixes and cleanup
Date: Wed, 22 Apr 2026 18:40:14 +0200
Message-Id: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23QQW7DIBAF0KtErEs1wEDsrnqPKgsHxgltgi2gK
 FXku5c4XbiylyP+vC/mzhJFT4m97e4sUvHJD6EO5mXH7LkLJ+Le1ZlJkAYQFL+O2Y7cB8sv/up
 z4pbaRgiQCMawujZG6v1tJj/YMx0os8PzKX0fP8nmB/kIn33KQ/yZ64uYV/6a2nVTERw4EOq+U
 +Bage9fFANdXod4mv0iF4KADUFWQSNICW0P2qmVoJbCxm+LqoJzythW1YiSKwGXAm4IWIV9I/d
 IznXauZWgl4LeEHQVSKNVx76p96B/wjRNv1AzrPTWAQAA
X-Change-ID: 20260403-mptcp-inc-limits-ce9811024066
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3989; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=0I/XEOl3BBbdBYy9Na7MR8Q09QeEPSBlH59S/lFHfog=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJf/Py554FDxc/ra0pnuGeY+esVrFz6O1B4yrxbFvfSf
 SUaJAXZO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACayfSvD/5Qllfc3/zerPtjp
 eP1Xf8aFrolXT/3/d0u4Pnn11ZkWEkkM/wuvTrmRsl/fYp2NTLaZzpr9MwXC0les+vr7xypz0U+
 RTcwA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The initial intension was to increase the limits, but some fixes were
needed, then when looking at the code around, other fixes had to be
added too. So now I ended up with multiple fixes (including one early
exit while at it), followed by patches increasing limits with some
adaptations required before, some to validate the modifications, and one
small improvement in the selftests.

The patches with a Fixes tag are for -net, the rest for net-next.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v6:
- patch 4: fix label name in commit message + mention next patch.
- patch 7: use min() to improve clarity (Mat)
- patch 15: fix typo.
- patch 20: removed: will be sent in another series after that one.
- Link to v5: https://patch.msgid.link/20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org

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

 net/mptcp/pm.c                                  | 62 +++++++++++------
 net/mptcp/pm_kernel.c                           | 90 ++++++++++++++++---------
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 33 ++++++++-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 16 +++--
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 74 ++++++++++++--------
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   |  8 +--
 6 files changed, 193 insertions(+), 90 deletions(-)
---
base-commit: b3fa12c3ddab70d570c42071efb0edd5dad07060
change-id: 20260403-mptcp-inc-limits-ce9811024066

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

