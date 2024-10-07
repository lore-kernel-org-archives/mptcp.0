Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61B61DE2B9
	for <mptcp@lists.linux.dev>; Mon,  7 Oct 2024 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325635; cv=none; b=V2lCSiSldHCtmyc7VObEM7CBorcTjtj1Dt+ahdnwer/rIS2h3otctPPERd0Jwga3ZgN0nirgifzIuLoPPUrTOWwgoSdZj/07WDNbL8eVJz1kSfIpoKPOguHwRN54d70Ak7MgsTnCkxb7Ah0kroGeAvtoDOBL3uDzRRVc+HXCZks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325635; c=relaxed/simple;
	bh=kzOE/TGe+NbTd6AtdqMM0FdYBImAmTJZkI8OQgBsZiE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VGVPLOGT2qgm9AGsvJGX+w+TYKQPx4n/N94uB5YuCdpbM5GK5d9gOvDQjiXOjbNekOy7zaS12O8Xon9asefe7jl5Rqimub1Ig0yyachhZQYwBlwsS7OX8A+ZfHnOntS5L/qHDTRSD98wcrVsWE0RPqQdcBrv5eQwOgwZDDUTEuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5pRHBdK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5pRHBdK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7765DC4CEC6;
	Mon,  7 Oct 2024 18:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728325635;
	bh=kzOE/TGe+NbTd6AtdqMM0FdYBImAmTJZkI8OQgBsZiE=;
	h=From:Subject:Date:To:Cc:From;
	b=k5pRHBdK3bfgOaNtvSIrUOOTOHdZ6S/pmVngXKayx6qnkkSix1N0HHxJSeTWbxacL
	 AIVM+l2bhM6oZrocATfeL7YDNp0V87DBr13xErVhr5PSkBa32vzBUFVKmFAl0uV3k/
	 y1HEXZuWPSKEul90fdNVs54WdwdyBQPO64CMJagbu72S2tTGncjfQoK9TMyx7nxQUT
	 aJ5v4WHZsr22HNwzgrhB2SVsZq5XOaHWZK72gUIdUBKDt0SCqFyDJFcxwCHMVKe3h1
	 ENp3fF/OXOX9aJurwSCyvs/iJsq9Vt9GeV/GgL9M+vDypaxt4mrfECmlgZiUIIJAME
	 acSIL0H+3BDxQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v2 0/2] mptcp: prevent MPC handshake on
 port-based signal endpoints
Date: Mon, 07 Oct 2024 20:22:19 +0200
Message-Id: <20241007-mpc-hs-port-v2-0-0c9e7827bd0f@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANsmBGcC/x2MSwqDMBQAryJv3Yj5x656j9JFfD41i8SQhFIQ7
 15xOQwzB1QqgSo8uwMKfUMNe7pAPDrAzaeVWJgvBjEIxYfBspiRbZXlvTTGpTdokPNJOriKXGg
 Jv/v2hpgbZpaowedSS9kja1shf++clOhJj0541LOepJDGKY1mnpTkmoxUi7aD7rkVdrTKCdOvo
 fXZT5TCq9C8+dbjHuE8/0ssQHnEAAAA
X-Change-ID: 20241007-mpc-hs-port-13a6c6c11b38
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com, 
 Cong Wang <cong.wang@bytedance.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1579; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=kzOE/TGe+NbTd6AtdqMM0FdYBImAmTJZkI8OQgBsZiE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnBCgCq22y1zF4KAS32LrdmLgt3aAt8oyXfZ7uX
 wXkATBANrGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZwQoAgAKCRD2t4JPQmmg
 c0jtEADOwX81/qzFNOaSyyAmcM7QNNSGVPPtePdk13bDaNz9Nx0RBf4xPuku/TutBhbMzs3+PNt
 RuoPl8nh+DLTxzzlM6bI6iFuchSp73rmqyVn9Bd6Mgv5ShRAWa7RmxBHe8SaNtal4nPRaIur7Ay
 EO2Yyc5aUHImMWKkI7JfBsoFXjUWdNqgakd9h2WJv+svfMT//b2u6Lc4LSn1FuV1RDeL7wdndY4
 OFhFY+a3KY0GjEp7CDU9SL4AQo/xsX4uqL+UpH5jZZ02c84dokK7/HHhnZfVJDklxToVZ7TF0Oo
 kVTHduCmdnY9LavTYJT2jWfnP3kLTpoETc1tofGREMCkufrUALd0SZ5CLSZXfPfOZf5NcksBaYt
 KRHHLieZNYArcLVdMo60tjuSqc1JCQNz0VuNQaLUCWVjOBNPS6K1JT4Tsgwx+BKV7J+esWflC/b
 IW2My6OX4Q8mw5qlfIHfbU3pF77gSzvLVt6+8WncJ5yD5i7XkuMU0pg310ijEj3hjT5HJzmSE6D
 XZCPl0CHYub/kYXzSrWdau0RyJSZDMpPpqFIvXsCJlhVcdsLPs6pcLqE1Jek1lyDmqDv4Fb/Z0Q
 KKavLS085KaN9mUWBOe/fBlBkteYLH274B/GQ6nyif52chdfQ3oU0hSqyEbVOLojODppGSsFiAk
 lT39rN+vX5pvkCA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This is a v2 for the series sent by Paolo, related to the lockdep splat
Syzbot reported a few weeks ago, and for which Cong Wang sent a
different attempt (Thanks both!).

In this v2, I applied the suggestions I sent on the ML:

- patch 1:
  - moving and renaming the MIB counters
  - move comments/functions on one line when possbile
  - rename subflow_reset_req -> _endp
  - use MPTCP_RST_EPROHIBIT reason

- patch 2:
  - fix shellcheck issues
  - capture: handle $capout
  - fix indentation issue
  - helper for the port
  - stop the capture after transfer like before
  - move new test to 'add addr ports' ones
  - move the validation part to a new helper
  - add missing 'check' names (subtitles)
  - skip if no counters

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Paolo Abeni (2):
      mptcp: prevent MPC handshake on port-based signal endpoints
      selftests: mptcp: join: add test-case for MPC attempt towards signl ep

 net/mptcp/mib.c                                 |   1 +
 net/mptcp/mib.h                                 |   1 +
 net/mptcp/pm_netlink.c                          |   1 +
 net/mptcp/protocol.h                            |   1 +
 net/mptcp/subflow.c                             |  11 +++
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 110 +++++++++++++++++++-----
 6 files changed, 102 insertions(+), 23 deletions(-)
---
base-commit: 2ce52e0f26d35f97f56615bb7854afa633f5d231
change-id: 20241007-mpc-hs-port-13a6c6c11b38

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

