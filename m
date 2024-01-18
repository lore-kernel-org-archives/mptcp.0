Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAEA2D603
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 18:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705602475; cv=none; b=d1lwUf9yMc/BCTU1RiK+E4O1raxdF3CJcJ8GxnwbU33iX8wp+SHJe2tRl5I+G/vaxTUarYpwkyXgx/FTM/b6fInl/Np55chaeoAD3FeAIDfti1tzNdH4R6LcNVfbVSWSGQovZGcfh4Cm5p8L/XeyXp6e/yadEbpCUq9NdpTkAvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705602475; c=relaxed/simple;
	bh=loqJ83MLAG1L0qRH3DuB8cb7jPzyZf89xYMc6h9fHJI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ELB5hqfOYMS23pbk6F8TkuXSSgChgcd0Tny3xgfKzsPJwMWhmmMh6Gwruy8bcaCQhI1NEu8GwWJmFlbqX4pIuChZEj1zsFgldlUFrxS4u1rkBreIVuGU39qPaUB64vkNQdBeKwlMUqTMmrdD9Ue0OXHzTdaMF1zED9SEfD6o5Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLWWLuvr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLWWLuvr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0513FC433C7;
	Thu, 18 Jan 2024 18:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705602474;
	bh=loqJ83MLAG1L0qRH3DuB8cb7jPzyZf89xYMc6h9fHJI=;
	h=From:Subject:Date:To:Cc:From;
	b=uLWWLuvrU2oAsCScf4WXQ8VM4JOC/NctTqzKSFLQJ+FuduiW4HbsTuOVbByP/M2Y0
	 AEZHgfAGb4z16pMfTL12uWiMrXtjCjpTs5+oTN1BMWo4HCrOaR7F8nLUg/YMNZA3TO
	 zSWxT7FEojvZOccbmoGVeA9kXhO6KvZJS0Du15v8zFM0C78iF41DFa/FitHEgrGopG
	 ImFDPQRIy3XhCX8Ritlr+fFKiWviEV1cWzZQd5G1kbUXvO+cOTKyN9LakK5DZXBrDG
	 1GOhnEqSuxOUdUhADicLVEGhygyU+8J+QLL21+cLiqdg5uo8fWADGlTxYqAGjL87ql
	 J1vwUvVjIrcdg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/7] selftests: mptcp: improve results in slow
 CI envs
Date: Thu, 18 Jan 2024 19:27:30 +0100
Message-Id: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-0-f3a4db41c3be@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJJtqWUC/yWNQQqDMBAAvyJ77kIiWrFfKT2EZG0Xk5hmowji3
 w3tcQ4zc4BQZhJ4NAdk2lh4iRX0rQH7MfFNyK4ytKrtlNYKhfxUSIpgSMUmFA6rLyje2Bm/FFa
 MC85bQGfugxtV31vVQc2lTBPvv9UT/m6kvcDrPC+wwcv8hgAAAA==
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2696; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=loqJ83MLAG1L0qRH3DuB8cb7jPzyZf89xYMc6h9fHJI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlqW2p2x+PQGzt262xIKysU5iGFeXyK6CF4t/SB
 hDfNItseUaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZaltqQAKCRD2t4JPQmmg
 c74XEACXAJ9HkcgRhNJsandjS60kdyDd+oxf7ookWRyZbBDQtICQxp6ZoDJJIvdVsHEdQrqqm2z
 y7Ab0RhAg+1m23X6NJzfl7f2eDXzqQPmLCLgRSA4vn/n1cadXsiozd3gPHarfClvlrlsG3tFW/N
 +JupSbWfADWZKHTP5LM10KVMuJ4pS3N4tY1Mv8Pb8EZnaW2ZR8ttCA5CaIPRfiJXRk19azPvAh2
 qK1lZyd1c2PXTbfQyPSBUV87nOnJTEx4r9TKY04PIgw5Wz7DL3S3Brna7zsdrJ1uVhiCTWqK8CI
 hzw3V9+fPhqjOV+EJ0OZSiM7fFDnwetICflYgCx4trusz3jDyCtjEB8/qthtRzqeVnC1wkuSl87
 lumt571HI4TJ0VcIsMwHT9Ysz7A5yf9Ixo3tiFX2VP4f2TeCeANFYOBHqvaJ+vIwdsbgd6IGVpg
 vzY3PVi+yA18JL5Zftzmc8gufV2y28sQkiH2xQRwLfPk4yIBszAboyqE4k8Qf8iecaMCIb1PCOY
 NVX0iF19aQpVcRk1zhNovwEbR1Z+ZDG1niJIp1moIrwEZOWGFS6XSRdOd0LyFs2xSzYN5I6hQrg
 AAVGhTn7wMkU1F1NSvUvFg5n4NfEv8P6Gzm4NRPMEZ81zhi7QUtC34G276jo+MN5FAKdlp+eIW1
 vTiGOv1tNYOUqYg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The initial goal of this series is to improve the results when slow test
environments, e.g. when using QEmu without KVM.

I looked at the results from LKFT [1] and noticed that some mptcp_join
subtests were skipped because it was not possible to add IPTables rules.
It looks like some KConfig were missing. The 3 first patches should fix
that.

I also noticed that mptcp_join selftest stopped after a timeout of 20
minutes. We keep adding tests there, it is normal to increase this
timeout at some points, especially because we forced many subtests to
have a longer connections, to have enough time for some actions to
happen. Patch 4 fixes that.

Patch 5 decreases the BW in simult flows, hopefully reducing the load on
the CPU, and improving the stability.

Patch 6 is needed because our CI run MPTCP Connect twice: the second
time with '-m mmap'. When parsing the results, the tests from the two
runs have the same title, hence the same "fingerprint". Instead of
having a post-processing step modifying the results for this specific
case, it is now possible to set a prefix.

When looking at the results of mptcp_join, I also realised that the
'userspace' tests were blocking after having displayed the results.
That's because they wait for the end of the transfer, while they don't
need to: tests are the end are ignored because this is done in the
background (but that's fine, other tests check that). Patch 7 improves
the situation there.

Link: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240108/testrun/21966973/suite/kselftest-net-mptcp/tests/ [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (7):
      selftests: mptcp: add missing kconfig for NF Filter
      selftests: mptcp: add missing kconfig for NF Filter in v6
      selftests: mptcp: add missing kconfig for NF Mangle
      selftests: mptcp: increase timeout to 30 min
      selftests: mptcp: decrease BW in simult flows
      selftests: mptcp: allow changing subtests prefix
      selftests: mptcp: join: stop transfer when check is done

 tools/testing/selftests/net/mptcp/config          |  3 +++
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 27 +++++++++--------------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    |  2 +-
 tools/testing/selftests/net/mptcp/settings        |  2 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh |  8 +++----
 5 files changed, 20 insertions(+), 22 deletions(-)
---
base-commit: 387cadd951df0629cc1098546acb3da13e8f6ebf
change-id: 20240110-selftests-mptcp-simult-slack-qemu-no-kvm-da67d9055c04

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

