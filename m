Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE4E26A0ED
	for <mptcp@lists.linux.dev>; Tue, 15 Jul 2025 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572964; cv=none; b=aV2bEF4uDmthAKQVPFP+EAEFxRkC+l2exkFVovw2dfhGypA6a+ZQpzWyELYffT3rFx/bkDLNKTgXMuEjb1LObTxpVvvWc/1yCBKMbV2yYnTwsGkXfOwrF5wNN/sYa3o5NF/L9wazYg1dFthfzE/OUOoeTZi9OPu/JDAPBLrQRiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572964; c=relaxed/simple;
	bh=73ly6u9i80aN3HAgYJYy95mei+rLPGrKDOgGRQ3bCNk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SmbEkp5/tfH9BbDbP8vmrLSh0p5oloX8EMMmY9mITFBLsRS0t5xl4GaQycD5qExjVw9QE3A8cDWQPNE6Ttg75eGm9kb0SQcou3om9jSyrALCxXWxpoVykyYSHtZ8oXDQb9yh/bNHLjB+xpQ5ogBZNIhFj9PxUjjg5mDs3rchX5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czcn1Mj4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czcn1Mj4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE93C4CEF5;
	Tue, 15 Jul 2025 09:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752572963;
	bh=73ly6u9i80aN3HAgYJYy95mei+rLPGrKDOgGRQ3bCNk=;
	h=From:Subject:Date:To:Cc:From;
	b=czcn1Mj4c78j/7nXyJ3EudgazVdU96ilwxSr8og5C0KA4fznG5LkrHDWRwk5LnYPj
	 56n5S0i8zLEEHh9SenS8YudEmeR+324d9Hc8YtaNgtHTQ5HsIbuD+cfZ7/6yk1krtf
	 FqS11xpNrAuanj427a1RK0JXeo4giF41tYdeo22FoVzhGv/oMPEDmBqQXA+So/IF3y
	 lM4xd89YlCAGAPks3wMSsc+PtG1udi9L5cz437FGpr77qj7lxg9HdM8MenE5Zg+UWt
	 fNmbznzRWNOIMCLIKdLX58I6Jbi7qJwa9AmmYzUMlQKgcaGb+UFKBVXcW8b6HiOxaV
	 pf6QvTnKcU32w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/2] Fixes for "selftests: mptcp: connect: cover
 alt modes"
Date: Tue, 15 Jul 2025 11:49:07 +0200
Message-Id: <20250715-selftests-mptcp-connect-modes-fixes-v1-0-58fc475d9397@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABMkdmgC/yWM0QqDMAxFf0XyvICtdo79yvDB1bgVZlqaMAbiv
 y/oy4XD5ZwNhGoigXuzQaVvkpTZwF0aiO+JX4RpNgbf+tAOLqDQZ1ESFVyLxoIxM1NUXPNMgkv
 62V5dd+vC0D97P4GVSqXjsNADTo1JYdz3P1pKMECAAAAA
X-Change-ID: 20250715-selftests-mptcp-connect-modes-fixes-61383574b42a
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=73ly6u9i80aN3HAgYJYy95mei+rLPGrKDOgGRQ3bCNk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLKVOR3hujO2KDRlym2L1x2asuylMRO4/KUXz8PPw/LM
 ZgU6ZXTUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMBGNnQx/5b3uPtiTpeon+nyR
 ueacT6159tb3l/iuLH74vneXbbEKL8N/vwBBvfc/39mLuZbN3FVy2qftyV35zeZ2GWvP3C703Wf
 FAQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Without that, all mptcp_connect*.sh subtests have the same name, e.g.

  mptcp_connect: ping tests  ## from mptcp_connect.sh
  mptcp_connect: ping tests  ## from mptcp_connect_checksum.sh
  mptcp_connect: ping tests  ## from mptcp_connect_mmap.sh
  mptcp_connect: ping tests  ## from mptcp_connect_sendfile.sh

In such case, the CI will only see one subtest, not 4 different ones.

To fix that, MPTCP_LIB_KSFT_TEST env var can simply be set.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      Squash to "selftests: mptcp: connect: also cover alt modes"
      Squash to "selftests: mptcp: connect: also cover checksum"

 tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh | 3 ++-
 tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh     | 3 ++-
 tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)
---
base-commit: 422cf93634436650f6ea5dacb37f1edfed7ab3c9
change-id: 20250715-selftests-mptcp-connect-modes-fixes-61383574b42a

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

