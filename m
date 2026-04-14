Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21452146D5A
	for <mptcp@lists.linux.dev>; Tue, 14 Apr 2026 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173652; cv=none; b=mMVjOcCADHl8fXs0BVwS4curZUiqlOfKGWKjNJU7vvnK7Oi4TUj/2tCoMmYArCE/+Wvu1nPTLHzxr301CydJbb82l4bgqyt1aljJNtEdeDZkjZrNzxQlEQ9j2kUOE6XqqvpH7QJRC+yDY4mtBFqOFJv/1hQpgj61dSgw5zDzluY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173652; c=relaxed/simple;
	bh=wOMtxnDRbIgBtqx4B0/KEe4snU6wRo78iItZKCpz85s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RYn9CyN4oWTjEc9x4/XytKwcpZpfwKIS2ukOHOxvoERSZxgTCMWBHgV92KbDwxuqjg7YeZxrwgiFcYqNoL7/Do4E21hajV25W/2RIJTZRoNm2vU8ZQJ3x1pQiEbcGTjOUA6VniFlaEF4PiHJ+f+0l+JdujCicu8aPmDK3jcFzLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slBEFO/g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slBEFO/g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53503C19425;
	Tue, 14 Apr 2026 13:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776173651;
	bh=wOMtxnDRbIgBtqx4B0/KEe4snU6wRo78iItZKCpz85s=;
	h=From:Subject:Date:To:Cc:From;
	b=slBEFO/gCbJAW5lmCxlPHmPEl/F2ei49Izd9cZ8buMDKqGs+20lEAAJqSQpCml99G
	 tM6ORwE4mmHZ9p2jVzLbWGI4eDJf2TS0kWv9PLwzaPVhhvd1wbpoOow28oz3Cd1bCi
	 7lya4jnbE92CqeAYqYzie5ulGGPnva1InEnjZk88vJFEh036Ej/Jsq92OyOrD2uIl7
	 6t1J0cAjo0vxd+hLTCGQzv5ERooDUqDGMKpQ3GajnN4BHhsMq7KdxZxNi4wxoWWsK0
	 NYkYg0+5FSnU4XDcqbEiHE7VPRWzcz9BhVLcLlKwB6cR1QbkHF29/+31oTZa7CMyMK
	 rPrxpz4slRGfg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v4 00/20] mptcp: pm: increase limits, and related
 fixes and cleanup
Date: Tue, 14 Apr 2026 15:33:53 +0200
Message-Id: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23PSQ7CMAwF0KugrAlyhlaEFfdALCBxwQxplYQIV
 PXupIUFCJaWv9+XexYxEEa2mvUsYKZIrS+Dns+YPe78ATm5MjMJsgYNil+7ZDtO3vILXSlFbtE
 shQCpoa5ZOesCNnSfyA17pT0mtn2t4m1/QptGcgwfKaY2PKb6LKaTd5P5bcqCAwfUVbNT4IzQ6
 zMGj5dFGw6Tn+WHIOCPIItQaZASTAOVUz+C+hT+fJtVEZxTtTWqRJT8EoZheAKoveW+UgEAAA=
 =
X-Change-ID: 20260403-mptcp-inc-limits-ce9811024066
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3754; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wOMtxnDRbIgBtqx4B0/KEe4snU6wRo78iItZKCpz85s=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvOXnop/5LUJVz7cg/bXDhZ6qdnfmieRdmfjvUf1PHW
 Fxvn+7FjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIkIZTMyLDq/Vedp9voWPdNt
 z/iDr33iFP4vuPiHSq/67FVXa9u+rmb47xd7IZD1+J8a7bwD+h4hynMUSwTXPRPl/PCFXcfq48M
 jDAA=
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
 net/mptcp/pm.c                                  | 184 +++++++++++++-----------
 net/mptcp/pm_kernel.c                           | 106 +++++++++-----
 net/mptcp/pm_userspace.c                        |   6 +-
 net/mptcp/protocol.h                            |  19 +--
 net/mptcp/subflow.c                             |   4 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  33 ++++-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  |   8 +-
 tools/testing/selftests/net/mptcp/pm_netlink.sh |  74 ++++++----
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   |   8 +-
 10 files changed, 272 insertions(+), 172 deletions(-)
---
base-commit: b5a5b4d1643659280a5566b761679182ef7a8b25
change-id: 20260403-mptcp-inc-limits-ce9811024066

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

