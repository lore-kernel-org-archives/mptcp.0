Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2A034EF06;
	Wed, 11 Feb 2026 19:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770836811; cv=none; b=accmXBEofM9H+DNWhdzPSFCGFxhdJiNRJCp9hO/98uYzVvXsGXpIpOKTVY7/X4rB4uZUuiIHAxiOLu8jcAT6OIy8jxlrCdEbrtDjEiFlMM8g4yf/pksxFbmN9TqFNgHgwe1uJTSVA77dUtMxSxX0aIZhnD/4OF28PvH5cD73V84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770836811; c=relaxed/simple;
	bh=FOyUaypp9MP5dmnSs9vgrtHmR1Xbw+XY+5ByEL5XUkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GuuWMlBPHDCkyKVo3Q500I6IQlpz9FPPxPpuVlBm4cSV8eSELdYCza/G83laOKa4hzFsVHeVy+sPip7Vt2n9yx5me1Rv4VgseOUbKNI5FAHqcmCvxUOqR2kY1Y8Oi0BFMaYovmIvFgTApljrD3UmNnFUW31p8gpgG1hQWhiI+vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCOkY6gH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCOkY6gH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB39EC19425;
	Wed, 11 Feb 2026 19:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770836810;
	bh=FOyUaypp9MP5dmnSs9vgrtHmR1Xbw+XY+5ByEL5XUkA=;
	h=From:To:Cc:Subject:Date:From;
	b=FCOkY6gH2E3gzcqVLhGIaUwBBRlQEVM/VkfihmUjOJU9/hiwwG2Aq42RKJRy6wmB5
	 3fIUaMDnTnx6TqUrS8ZQiwlNZZAIh1MqmpEc5YeE2tp7DGYR2AeZpbrx/WuFrI4cPv
	 vh8nsyJ8U5y1c1PFJaiWMKb09x8TT6r2q6BqrrCQ7Pqnye7GelpMpqbnCAYetagpEW
	 lmNVR+78DeVB9R1UikTnm2uJEdYjHaGHMX/5kQce90wIRKCZdBMo0IMT3eVV7AJYhb
	 GaG5NrgLXIKtCEW6247LuQky3JfV+SI5bxdYC0AuAmH/dWkxZvQgvi77f0gjJDPVcF
	 3BKESXc+IMnmg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 6.1.y 0/6] mptcp: fix recent failed backports (20260211)
Date: Wed, 11 Feb 2026 20:06:18 +0100
Message-ID: <20260211190617.77192-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1409; i=matttbe@kernel.org; h=from:subject; bh=FOyUaypp9MP5dmnSs9vgrtHmR1Xbw+XY+5ByEL5XUkA=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ7LmsJauj38LamuAkb+G+0UOq11ND7+L/51O/jvmVrO zYx6e/sKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmEhOOsM/PdNcA/XJs/7ueL1o VYHU7quzS9pr1PVl1R60eEXuj9jrxsgw883Kxol2pYH3q/PDrjz+4WqxkWnbEzO3BzcXd8xOc9n GCwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

The following patches could not be applied without conflicts in this
tree:

- 29f4801e9c8d ("selftests: mptcp: pm: ensure unknown flags are ignored")
- 2ea6190f42d0 ("mptcp: schedule rtx timer only after pushing data")
- 86730ac255b0 ("mptcp: ensure context reset on disconnect()")
- 8467458dfa61 ("selftests: mptcp: check no dup close events after error")
- 2ef9e3a3845d ("selftests: mptcp: check subflow errors in close events")
- c5d5ecf21fdd ("selftests: mptcp: join: fix local endp not being tracked")

Conflicts have been resolved, and documented in each patch.

(Note: sorry for the delay, but I was unavailable for a few weeks.)

Matthieu Baerts (NGI0) (4):
  selftests: mptcp: pm: ensure unknown flags are ignored
  selftests: mptcp: check no dup close events after error
  selftests: mptcp: check subflow errors in close events
  selftests: mptcp: join: fix local endp not being tracked

Paolo Abeni (2):
  mptcp: schedule rtx timer only after pushing data
  mptcp: ensure context reset on disconnect()

 net/mptcp/protocol.c                          |  24 ++--
 net/mptcp/protocol.h                          |   3 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 111 ++++++++++++++++--
 .../testing/selftests/net/mptcp/pm_netlink.sh |   4 +
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  11 ++
 5 files changed, 136 insertions(+), 17 deletions(-)

-- 
2.51.0

