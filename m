Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADEB1DFDB8
	for <mptcp@lists.linux.dev>; Fri, 26 Dec 2025 06:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766731238; cv=none; b=bsjjNAsdje5wkAhkmtcYa/AUGvNuyRhoiAN1uyy0Osa/w5qRhjKR3tvowl7sj/062VEofjG/ebAN3DQYLpCsfIE7hT+UXah5pvazbSG4Q93VuPtOVEqrUrsqEuUuCggH7hpbxBGZqW4907g9IxnL5ySZ5I2DPb7Cz30FN7xyevY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766731238; c=relaxed/simple;
	bh=k1HH37N/+LdMO3D3j6FFXd2KyvV+/0o4Wiz9ImKXi74=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ajga/ZGMXqGvh1qKC3Uj/5R5K5hLzJwbE5N6XJMZTwlnfCHJpccsGsXx2GlPolwHG1NHJxoBUiWM+IxX/dg1ZN3qdd4YenCorzXIEFH45M/3/C11eEKd5sW3Wcuhvdis00z0f5N+/vikNjywT6+TNmOJfJ0NuDtvPQ3pimpxv1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1cQbv+k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1cQbv+k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A26C4CEF7;
	Fri, 26 Dec 2025 06:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766731237;
	bh=k1HH37N/+LdMO3D3j6FFXd2KyvV+/0o4Wiz9ImKXi74=;
	h=From:Subject:Date:To:Cc:From;
	b=N1cQbv+kH8jAYpnwPuOykhYtxQdsYONtCCIXjOR771vCnWXtiy99FAa3g8Tf2xbat
	 +c47METTbUS3jEksTEvs6pB7adawga9SxBzvHc7F/3EkMyou7Fw9nsj2Mnp3Z8wEbj
	 ClSbgo1nWPmfmiVKEgDncHcForDl0WUNinJNC/0bOFRXXS+l7ofAsm57RFise1LZN9
	 BoolALgwdGBQAHod1cG721aG8FPK80h71mpDzJx/5An07MOnBgEE6wtQ5yzPMmlgm1
	 ieSQGlSqxZjvUygH9XIWzfyebFuWPnjbTDMiBsFciWC3FBbb33mohn/feCRrpkD7GH
	 TH9WJm/r/Ctjg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 00/11] mptcp: avoid dup events + error + misc.
Date: Fri, 26 Dec 2025 07:40:14 +0100
Message-Id: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM4tTmkC/yWMSwqFMAwAryJZG6gRv1cRF9JGzcJaGt9DEO9u0
 eXAzFygHIUV+uyCyH9R2X2CIs/ArpNfGMUlBjJUFUSEWzhsQFH9MdamRNdWrqububFmglSFyLO
 c73GAT/Z8HjDe9wNy5kqBbQAAAA==
X-Change-ID: 20251222-mptcp-issue-603-d85d967f7c0a
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Marco Angaroni <marco.angaroni@italtel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1538; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=k1HH37N/+LdMO3D3j6FFXd2KyvV+/0o4Wiz9ImKXi74=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL9dG/OWPxrbugtz96ozKDCvsnqgrFLPLj3LC86/bj5x
 hrrj6/+dZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzk51aG/84aVzJudB0WiPGr
 9rrt5B4nnfY+ZPb1oH8L5Rwrf/mdvcPw36/urmx25unpoW43VN/ydV9nqli/xGj9isWT/V9LtRk
 t5AcA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here is my last series of the year :)

There are two fixes with their tests:

- a subflow closed event can be visible multiple times, see issue #603

- the subflow closed event didn't contain the error as expected.

The 4 first patches are for -net, the rest are small fixes and
improvements for net-next. Some tests should be quicker now.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (11):
      mptcp: avoid dup SUB_CLOSED events after disconnect
      selftests: mptcp: check no dup close events after error
      mptcp: only reset subflow errors when propagated
      selftests: mptcp: check subflow errors in close events
      selftests: mptcp: join: wait for estab event instead of MPJ
      selftests: mptcp: join: fix wait_mpj helper
      selftests: mptcp: join: userspace: wait for new events
      selftests: mptcp: join chk_stale_nr: avoid dup stats
      selftests: mptcp: join: avoid declaring i if not used
      selftests: mptcp: connect: fix maybe-uninitialize warn
      selftests: mptcp: connect cleanup TFO setup

 net/mptcp/protocol.c                              |   9 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.c |  19 ++-
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 146 +++++++++++++++-------
 3 files changed, 116 insertions(+), 58 deletions(-)
---
base-commit: b3ae75d680ea6ef281101b0f5029056c4f87ff02
change-id: 20251222-mptcp-issue-603-d85d967f7c0a

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

