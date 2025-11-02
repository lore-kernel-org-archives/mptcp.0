Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D492D0619
	for <mptcp@lists.linux.dev>; Sun,  2 Nov 2025 11:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762083022; cv=none; b=QdRyQV01XUI78cZ2OvJNFxWLcIh0qa/39PnhxuVSrDDX2r31UE2GBCs9lVnmMBoPH1drEA+EJNt4TZuhFU880awm9f23fgBdz1LvqJxM9i8E3l2AzDK30zFPJJXxSXxsfDiJIMK/7iuPT9tj5XxOk6ig78r9d8yJzyUUVlYA8fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762083022; c=relaxed/simple;
	bh=AbPjeDP/9bMPXhtcTypnEmvURRALUkkjCUF1dEd6HjM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LKqkqd4xnq2K3ZuHkoC1ZxSIAmU3/ffnFdu/4xNssxGxm7LsOdBspghq9epZUaBSchX7+mYBVw1YmzcSeleKmMjmFDFZh0ubRoPvWLqgea0xRuR7KMBLhbdxzH8+DjwQEtb/xgBbljBTqGgwja267bDjjLSrVgqcgu8gQdTbue0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcNSWLP8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcNSWLP8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7207DC4CEF7;
	Sun,  2 Nov 2025 11:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762083021;
	bh=AbPjeDP/9bMPXhtcTypnEmvURRALUkkjCUF1dEd6HjM=;
	h=From:Subject:Date:To:Cc:From;
	b=WcNSWLP8AEKI0c+5FakN52PQLi79YKJTrxNqj85RlaImvsptRlUYr8L301X7lujtN
	 86UKkEyzoK5GhsptFcbzDIXu4vJvmYhpj+lFPGimmpAPo9soRcvbHNYT9Ax/OToWOK
	 tbTaroVlrI8mvvbRruhPtGBYlyv8vIynFw4aLofGf47f5PLBQyzQESiakXXw79bgvv
	 hxerC2/gTfJrBnnCfrWvG3oNrZmnXBOfG58nWQcck4G3Q8/NOU/hvlAYR3UgbhkIi1
	 pfXbbkoxXWIBzK09OLqkV5I2hpLyt2N8ADMUkKv2YN9Vu7+i29anp2xGwyzwf1YtZL
	 TtSGO9+wVS2pg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v2 0/6] selftests: mptcp: join: fix flaky tests
Date: Sun, 02 Nov 2025 12:30:02 +0100
Message-Id: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALpAB2kC/12NwQ6CMBBEf8Xs2TXdRYJ68j8MB8QtrGJL2oZoC
 P9u06PHyZt5s0KUoBLhslshyKJRvcuB9zvox84NgvrIGdhwTYbPGCeb8OnVobqYUCrT2M4emao
 T5NEcxOqnCG/wnlM/o5MEbUajxuTDt1wtVArFSob+rQuhQTJ1kzF35s7XlwQn08GHAdpt2377I
 dKNuAAAAA==
X-Change-ID: 20251029-slft-join-inst-e307faf42138
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1704; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=AbPjeDP/9bMPXhtcTypnEmvURRALUkkjCUF1dEd6HjM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLZHY5+6j/JbtdxTD/P+eirWC7BkNW5D/rtFq39/PDlq
 rcWacm2HaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNpusrI0Hrs0oPMeTqZfL8Y
 /I64ui8wcBPM0s99XG2Scsi8qE1fmeGv9P3TvI46TovSXWv3LNPZkmfk2/TPREz4y3zdEpebcSJ
 sAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When looking at the recent CI results on NIPA and MPTCP CIs, a few MPTCP
Join tests are marked as unstable. Here are some fixes for that.

- Patch 1: a small fix for mptcp_connect.sh, printing a note as
  initially intended. For >=v5.13.

- Patch 2: avoid unexpected reset when closing subflows. For >= 5.13.

- Patches 3-4: longer transfer when not waiting for the end. For >=5.18.

- Patch 5: drop noisy plain RST packets when looking for MP_FASTCLOSE.
  For >= 5.18.

- Patch 6: read all received data when expecting a reset. For >= v6.1.

When reviewing patches 2-6, please double check that I'm not hiding real
issues by tweaking the tests suite.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Patch 6: also handle EPIPE properly.
- Link to v1: https://patch.msgid.link/20251101-slft-join-inst-v1-0-10572512a0b2@kernel.org

---
Matthieu Baerts (NGI0) (6):
      selftests: mptcp: connect: fix fallback note due to OoO
      selftests: mptcp: join: rm: set backup flag
      selftests: mptcp: join: endpoints: longer transfer
      selftests: mptcp: join: userspace: longer transfer
      selftests: mptcp: join: fastclose: drop plain RST
      selftests: mptcp: connect: trunc: read all recv data

 tools/testing/selftests/net/mptcp/mptcp_connect.c  | 18 ++--
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 95 +++++++++++++---------
 3 files changed, 69 insertions(+), 46 deletions(-)
---
base-commit: b9e1acc39cbc985ca8df781775718e39e421409b
change-id: 20251029-slft-join-inst-e307faf42138

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

