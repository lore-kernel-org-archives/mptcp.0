Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470F130FC36
	for <mptcp@lists.linux.dev>; Fri, 10 Apr 2026 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831527; cv=none; b=Upm4XP/M3XQd0O4BcRX/898+W0Y7EXTGH5aVDKDq6mkR9W5giVxJQGIGWFMP2cTe7kphWLXcP0IcZTUhOM7cyFgGBf3wlxQ+zhUgtjjCVBr/kWbfY66FWQ0fftMNySdCbVifXO27ZaMJRWJo+1NC8UWaSIHN5YW6ECE2uMv1aMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831527; c=relaxed/simple;
	bh=LE6AHa7bAvkwFkcbe740Kgb/SySFTvV+LQcxoxfKpy0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ff4d3IYzk/BveecHvDqYFJIbVN4vPGEJPvKHhQXtsr7jzmE0aZsnpKs0pHUol6gZ485ECns++Hyx9dFa+i2pq5zI53IA0TpSrMb6LJoplRCcR8V32+TuepmIZJ9HMuroRWOtXQPByOZ1JJ/0QYNHJm4Pf6l4oGivg/f+gyqd0EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCYXnbXB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCYXnbXB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7404CC2BC87;
	Fri, 10 Apr 2026 14:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775831526;
	bh=LE6AHa7bAvkwFkcbe740Kgb/SySFTvV+LQcxoxfKpy0=;
	h=From:Subject:Date:To:Cc:From;
	b=CCYXnbXBSWR9lG4oTLVArhXZKGMOlNejy68UbDuZLrOk2gR2VDKP3u/p2bz4T/HCb
	 5TurrlKawnzvArlo/KvQiyA+2dEhIisQOaQlk2EHsv7X4N1/vV3bnuL70XXxmFBLfH
	 nMDnSDT16cdQSy8ea+DMIJ4qB7WTALQLMjKv3I08SjyQaDbwUryK2TOYiwwL+i7qQY
	 zA8aq57M79ZlzE3/uz5ek0CsRRZFdNvlwDKQocYUeS4Q3oBgRiJosDiqu/kwr6YHay
	 3vNEQa8i/78GDBwl/GKmk9D0Q0YOZFd8tVedC3KgbF0E8GE+fU3ewgt29wDjWXsSmD
	 A+T8O1Rf7mYCw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v2 00/17] mptcp: pm: increase limits, and
 related fixes and cleanup
Date: Fri, 10 Apr 2026 16:31:38 +0200
Message-Id: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNzQ6CMBCEX4Xs2ZptqUQ88R6GA5YFVqGQthIM4
 d3lx5vHycw33wyeHJOHWzSDo5E993YN6hSBaQpbk+ByzaBQJagxFt0QzCDYGtFyx8ELQ+lVSlQ
 akwRWbHBU8bRf3uFYW5oC5Efn348nmbB9buuGfejdZ/ePcmd+qvRfNUqBAklfqiLGMpU6e5Gz1
 J57V0O+LMsXs8EaQM8AAAA=
X-Change-ID: 20260403-mptcp-inc-limits-ce9811024066
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2756; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=LE6AHa7bAvkwFkcbe740Kgb/SySFTvV+LQcxoxfKpy0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvcl73niS/IfCuSPlD/wMnO/57bNrHer1zpjGDrqjc8
 R3zl//Y0FHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRRUGMDDfu3ReNmVUyx/hd
 9I2/yyfZx+aq52gzT+d9/tjReGvA8lMM/5TjJrMvz983Z4uj9EzXXy/mXk7R3DrHU6y2O7iM7cr
 RLj4A
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
Changes in v2:
- patch 2: fix potential data-race.
- re-order patches 1 to 5 and use shorter prefix (ADD_ADDR rtx).
- patch 6: restore accidentally deleted icsk->icsk_rto > max check.
- patch 16: fix already present checkpatch warning.
- Link to v1: https://patch.msgid.link/20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org

---
Matthieu Baerts (NGI0) (17):
      mptcp: pm: ADD_ADDR rtx: free sk if last
      mptcp: pm: ADD_ADDR rtx: fix potential data-race
      mptcp: pm: ADD_ADDR rtx: allow ID 0
      mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
      mptcp: pm: ADD_ADDR rtx: resched blocked ADD_ADDR quicker
      mptcp: pm: ADD_ADDR rtx: skip inactive subflows
      mptcp: pm: retrans ADD_ADDR: return early if no retrans
      mptcp: pm: prio: skip closed subflows
      selftests: mptcp: pm: restrict 'unknown' check to pm_nl_ctl
      mptcp: pm: in-kernel: explicitly limit batches to array size
      mptcp: pm: in-kernel: increase all limits to 64
      mptcp: pm: in-kernel: increase endpoints limit
      selftests: mptcp: join: allow changing ifaces nr per test
      selftests: mptcp: join: validate 8x8 subflows
      selftests: mptcp: pm: validate new limits
      selftests: mptcp: pm: use simpler send/recv forms
      mptcp: pm: clearer ADD_ADDR related helpers names

 net/mptcp/options.c                             |   2 +-
 net/mptcp/pm.c                                  | 174 +++++++++++++-----------
 net/mptcp/pm_kernel.c                           |  59 ++++----
 net/mptcp/pm_userspace.c                        |   6 +-
 net/mptcp/protocol.h                            |  19 +--
 net/mptcp/subflow.c                             |   4 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  33 ++++-
 tools/testing/selftests/net/mptcp/pm_netlink.sh |  62 +++++----
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   |   8 +-
 9 files changed, 219 insertions(+), 148 deletions(-)
---
base-commit: 0d8ee8bb5ee08c331531dc4ee482409d7fcef713
change-id: 20260403-mptcp-inc-limits-ce9811024066

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

