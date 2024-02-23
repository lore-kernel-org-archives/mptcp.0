Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98511BE68
	for <mptcp@lists.linux.dev>; Fri, 23 Feb 2024 03:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708657696; cv=none; b=HWfgajBsW0vJyg7yFo1yg53KmMUWBdY1LVTikgIVXsYsK2p0yl+a3P+X3rXBDbx7Km6lq6ZbuLIj92EVDN4fIjzobuvFVFTry+bTSD14jIHDD/GyCc7ZhqhQFyT0Ip7F5+XMiexINamoKB/MnkstlYw5Z5OP9dpLseP1AAI7akA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708657696; c=relaxed/simple;
	bh=7n1Ze9dlHwt68I/t2FpKLFSf22gdF/TkN6KbZMUcHdY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NCEBsYQKCQMKTKQmlHnMPQ1uyZu+oVFd23bsdXSACV2OnIG9n6czWUgU4u2NYGJOi2VueCX9z0+t4UpkzFzYDjxx+NGVqWp0hGDrMvdm9VPhm4VGjAbEyhqRgjz2kyreJiAa1tFA16xFdp5Kp9d9k/qqD4J2QJDipkjY7oiriGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fytXROzL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fytXROzL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0A8C433C7;
	Fri, 23 Feb 2024 03:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708657696;
	bh=7n1Ze9dlHwt68I/t2FpKLFSf22gdF/TkN6KbZMUcHdY=;
	h=From:To:Cc:Subject:Date:From;
	b=fytXROzLUDcGHKbnMNQP74EKcPam02NP6olQI8bPFigqTXecGNbD804g4aRf2WLL3
	 oAfzcrhiE671/M5cNwselmLaPXlHyHI1sLhsvbHECyWwY4yY5obFjdccp3f3/OCMPS
	 AfFHWpKaUE2l9qzbd1Wmkt/7WbNTIlSOgQ+QrmsKM2dtwEwkMItY2t1REX2rEl3KIP
	 lw8OQvRr+CSEVlHjhElASL5lJdm4qCqePZtDhiY/mpbjWAFTncQ9lq0hd/JloWOxmE
	 Bnl3uODI9mdVZRpY3bgku3bFP4MIqEWbkzM3kY/M5B8v7ZaeRQXM5kqLHRaPNLivPf
	 kQ9msgIKbbUDQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/8] add helpers and vars in mptcp_lib.sh, part 3
Date: Fri, 23 Feb 2024 11:08:03 +0800
Message-Id: <cover.1708657486.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Depends on
 - "selftests: mptcp: fix shellcheck warnings" series queued on
   patchwork.

Geliang Tang (8):
  selftests: mptcp: capitalize ok/fail/skip
  selftests: mptcp: unify TEST_COUNT/TEST_NAME
  selftests: mptcp: sockopt: print every test result
  selftests: mptcp: print test results with colors
  selftests: mptcp: move test_fail out of check_expected_one
  selftests: mptcp: extract mptcp_lib_check_expected
  selftests: mptcp: export event macros in mptcp_lib
  selftests: mptcp: add mptcp_lib_verify_listener_events

 tools/testing/selftests/net/mptcp/diag.sh     |  24 +-
 .../selftests/net/mptcp/mptcp_connect.sh      |  36 +--
 .../testing/selftests/net/mptcp/mptcp_join.sh |  54 ++---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  82 ++++++-
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  28 ++-
 .../testing/selftests/net/mptcp/pm_netlink.sh |   3 +-
 .../selftests/net/mptcp/simult_flows.sh       |  10 +-
 .../selftests/net/mptcp/userspace_pm.sh       | 213 +++++++-----------
 8 files changed, 240 insertions(+), 210 deletions(-)

-- 
2.40.1

