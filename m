Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F433343206
	for <mptcp@lists.linux.dev>; Tue,  2 Sep 2025 19:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756839708; cv=none; b=Q5vTAFt89GLNY99cFhoS5IwSFnks5TsJp+lqZfkLfsO7XtrZCZv/AZC2qv5zZnsv/eUMrfqT/BEpwWqlcSUFTSAWfG0fiG1DYZvR8+3Ylk598E8bl1KCZgdnSB5CUcsoe6REsv4mY3lPgqE/BkTCgVYMUWuD+dqyaqhNwICZKEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756839708; c=relaxed/simple;
	bh=rlR2eaL5rccrd8HIzyeRz8LSl+AtqE8lp2ILCnxqqLM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gH2idlo47WAWHuZyaheIgzBl5GYf+sQ+EatS0ge/qCn9qLSDxdo/eto1/NPAwz9G4yAmBFLl87EGsuIVYZ/7nXGyAxcHpE+cNHR7r5BRdP3Z/oMQtkh3DVHb2kZ91XbDPAUMPB+I79Wp8W8+3XZHFcp3Y2gCOpiZfDDeg6+nUyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idUjLsLB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idUjLsLB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5673DC4CEF6;
	Tue,  2 Sep 2025 19:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756839707;
	bh=rlR2eaL5rccrd8HIzyeRz8LSl+AtqE8lp2ILCnxqqLM=;
	h=From:Subject:Date:To:Cc:From;
	b=idUjLsLBWm2IILuC/mk3q5EK+nuABDKbPs2Vezb1nKSwyfoc62fmn34PUgCQPkM4+
	 fVWblrF8a4LgiyCK8oxfdq/tszJ+31wPS6i+6HryAQtfcWVrsJq0NnKZLTvKx0WPar
	 0KzqbqSiDvnQ/2dCfwmZlXgt/j0TsvvLMOd08/V9OU3WZIVbPHXF/E1HVGDPWjasY/
	 QsEN6NFfKequJXSrjyXpMnSLbGTDIinbquM07W3gxZ1vvMqgbsl0ORx9GWhR82gPsE
	 rk9Kv4hbfA4Gj0Q+5u8+wT1dPireVZ6+ZIn0Fx1YP09BrWNirlww3Ax2di15I+RYih
	 xN7PRQE3f6lGA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/3] mptcp: fixes for adaptive ADD_ADDR
 retransmission timeout
Date: Tue, 02 Sep 2025 21:01:37 +0200
Message-Id: <20250902-sft-mptcp-join-add_addr-no-retrans-v1-0-956a315d6a5a@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABE/t2gC/yWNQQrCMBBFr1Jm7UCMjaBXESlpMqkjOAmTIIXSu
 xvs4i3e4v2/QSVlqnAfNlD6cuUsXc6nAcLLy0LIsTtYY525GYs1NfyUFgq+Mwv6GKeOomRUauq
 l4mV0s4vzeE0+QB8qSonX/8kDjlZobfDc9x92ChOVgAAAAA==
X-Change-ID: 20250902-sft-mptcp-join-add_addr-no-retrans-345b5db46fac
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=rlR2eaL5rccrd8HIzyeRz8LSl+AtqE8lp2ILCnxqqLM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK224t/6To4SczpaOX18Bebo/0kFNfdk1++dsGX1X4pW
 WIRD0587ChlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjI+42MDD3HKtcuFQnPk3De
 mycX837mTVvpiZ+fpX8Qel/WtMZJPImR4ftFt0q/K9UnOX/L3yupfs/umTnzUb+1Fj+fdLTkm8e
 7GAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The recent patch "mptcp: make ADD_ADDR retransmission timeout adaptive"
seems causing some unstable tests, see the links below.

The modification in the selftest is reverted, and more tolerance is
added instead.

While at it, slow down some signalling tests.

Link: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/17391054770
Link: https://netdev-3.bots.linux.dev/vmksft-mptcp-dbg/results/280241/1-mptcp-join-sh/stdout
Link: https://netdev-3.bots.linux.dev/vmksft-mptcp-dbg/results/279881/1-mptcp-join-sh/stdout
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (3):
      Squash to "selftests: mptcp: remove add_addr_timeout settings"
      selftests: mptcp: join: tolerate more ADD_ADDR
      selftests: mptcp: join: allow more time to send ADD_ADDR

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 30 ++++++++++++-------------
 1 file changed, 14 insertions(+), 16 deletions(-)
---
base-commit: 8984ec428a58d1d82ba89db40e462ad1e8dd317e
change-id: 20250902-sft-mptcp-join-add_addr-no-retrans-345b5db46fac

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

