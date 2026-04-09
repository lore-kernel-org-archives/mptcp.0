Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4DA86329
	for <mptcp@lists.linux.dev>; Thu,  9 Apr 2026 20:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775767932; cv=none; b=jGctF5ti+A0QBTbZOnxP/+HXWBAsRskJgQdObKZXG0Nx4GPvWxEPLDT04hl0z7uA16BKDqeXuUiD3z2lcOKA+nKVM022cRj9YXyRaZTkJruaZCk4N2WKXgokssLB9UdKqDCfnnCGGu6+Rj+JUrE7MZKuf4P/Iy1a4rUYtH5SNkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775767932; c=relaxed/simple;
	bh=7BzWDP6Atmqk4wj35RS1FoFdlZr8AVBOtP+9jmyAxow=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lmCeerQdB0z/f9G2MiyYjq1Fgd8WExjQzCKHYmYtGYjBbxOHJ2F97Y93rCEftmbvfnvTdOhaG9rIPFKziSbQjiGpNCx93w/trYOuj6sMBdYf+900giwLlpRhWE9/foY3JVmQODP5/pwWviuu4pjAuC1q+UZjoiiQsgSppIiu61s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrzxZGZC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrzxZGZC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FF9C4CEF7;
	Thu,  9 Apr 2026 20:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775767932;
	bh=7BzWDP6Atmqk4wj35RS1FoFdlZr8AVBOtP+9jmyAxow=;
	h=From:Subject:Date:To:Cc:From;
	b=KrzxZGZCG8lsEGcU9Hew7NOz50sHVC/hNUNmCvMPHL9kWc2cQYiQ+Vafvt0rOXVak
	 uVeqfXYw6ZTThdJBkyGJrr2eYAyTPcMfK5tfe0IQ6kspy5Ggv9gX84UjUtfa47hoHa
	 daG/gWWoFkI4cuI3Wb2m7tsIGJXKPvY3Ws5OUqpWt46YaHPk8kOaJ0B5GT6b1C4jGw
	 0NVB9DuQnGH1y65S+YXkkMJlWi1JI7dCwtZ4EYB6SEMdd182XRs3/Y2KmzO79X/7B1
	 WECr2VB1KMpDtTvspwhiUmVm/HcBGw9CUpSdvoamUNC2WOYA2l/paoH1ILSguNv8wx
	 J/aCRxjqm5ISQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 00/16] mptcp: pm: increase limits, and related
 fixes and cleanup
Date: Thu, 09 Apr 2026 22:51:40 +0200
Message-Id: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMAxFf2Xk2UBaR3H+ivgwYzYzXC1NlcHYv
 1vd4+Hec1YwySoG52aFLB81fcUK7tAAP/o4Cuq9MnjygVo64pwKJ9TI+NRZiyFLd3KOfEshQNV
 SlkGXf/IC+zvKUuC6b/a+TcLl14Rt+wJqhO20gAAAAA==
X-Change-ID: 20260403-mptcp-inc-limits-ce9811024066
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2370; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7BzWDP6Atmqk4wj35RS1FoFdlZr8AVBOtP+9jmyAxow=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvCObNU/tcLd7yf8PlFf+SE0IuJizgmPO/OHLjimaNZ
 +alyZ9udpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExk7z5Gho60/6k3lwpIeBfo
 H7/yulLx3uWF3PH9e49JHbnz83fbiY+MDD2ih6RWJQduWKCRs4MlUenS9hUvy7+k72G48fjMN7b
 0/wwA
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
Matthieu Baerts (NGI0) (16):
      mptcp: pm: resched blocked ADD_ADDR quicker
      mptcp: pm: allow retransmitting ADD_ADDR with ID 0
      mptcp: pm: retrans ADD_ADDR: free sk if last
      mptcp: pm: retrans ADD_ADDR: always decrease sk refcount
      mptcp: pm: retrans ADD_ADDR: skip inactive subflows
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
 net/mptcp/pm.c                                  | 165 +++++++++++++-----------
 net/mptcp/pm_kernel.c                           |  55 ++++----
 net/mptcp/pm_userspace.c                        |   4 +-
 net/mptcp/protocol.h                            |  17 +--
 net/mptcp/subflow.c                             |   4 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  33 ++++-
 tools/testing/selftests/net/mptcp/pm_netlink.sh |  62 +++++----
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   |   7 +-
 9 files changed, 205 insertions(+), 144 deletions(-)
---
base-commit: 7fe1c6148c0a11ed9a1fcfaf70cf380cf890c1bf
change-id: 20260403-mptcp-inc-limits-ce9811024066

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

