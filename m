Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F208D27E
	for <mptcp@lists.linux.dev>; Sat,  1 Nov 2025 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761988500; cv=none; b=Ug4vke292Lxkjct+fNzPNVprAOehEIGbRprEx+BZmVQIX1HmqmbJjRJRadXON0pZ8o9xxeSnO9Wbr0XRzS4QWwMwyuyh6mN12ZfXe8xic18Nx8rfJsI9V+GJcZGd7vKxPMjDu1VYt+5Ou+AY5le71NBLbZkWLyttG1gUt6sP6H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761988500; c=relaxed/simple;
	bh=8XZwEjuhGPuBz0zac5oMBKbcAUGCjnwrOR8FrDuC2tU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RNMK/k8czww0fP6yYlSjwc5Fs7/wRdYAkRC3FdeiDiUIY8jhldunjVGTKN9aNVCsJ3QLSw+hPXHZtH7+JQT3VImhhjwTC6I+GyH9e6Lvq/JDr633szWHgM3mNFfz4LrTse6iLw3YPmbrnhKs0b9NNAEhLtuEA1BecBmKyJQVCtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzai8aSS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzai8aSS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A31C4CEF1;
	Sat,  1 Nov 2025 09:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761988500;
	bh=8XZwEjuhGPuBz0zac5oMBKbcAUGCjnwrOR8FrDuC2tU=;
	h=From:Subject:Date:To:Cc:From;
	b=nzai8aSS9ozsZDDu9bTCxU5hIxWySOz7RBvWeAJMsCsj4WYMbd8t+l/P11JAW0AYN
	 MlBLPEwDc/TPZopl0gabUeATG4NpN/WPXFvChwwF+WtHp9gMlJnuPH26gw2fWEpDcj
	 k9pU6zsHea8ZLKwVlA03l6BzrZXVmUj11BcevBEClIKf/paqbAdTWJFyY2TbqAUsFF
	 XYHcxU3tj6RhJBZT/NaHNEC09iYWRb5m/63U92nfaAKKob5NPZYaMpTCesVit+W2Z/
	 XorkpXVyHW3nwYsRd1b+9KlfkPppqeN974TyYbzHZw+ZjjNojzEbIBRAJHAVyklO3F
	 fWGvHNuUKZzbQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/6] selftests: mptcp: join: fix flaky tests
Date: Sat, 01 Nov 2025 10:14:41 +0100
Message-Id: <20251101-slft-join-inst-v1-0-10572512a0b2@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIHPBWkC/x3MTQqEMAxA4atI1hNoq+LPVQYXoqlGZmJpigji3
 S0uv8V7FyhFJoW+uCDSwcq7ZNhPAdM6ykLIczY442prXIf68wm3nQVZNCGVpvGjr5wtW8hRiOT
 5fIdf+Ic0BRRKMNz3AzX84jVrAAAA
X-Change-ID: 20251029-slft-join-inst-e307faf42138
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1548; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8XZwEjuhGPuBz0zac5oMBKbcAUGCjnwrOR8FrDuC2tU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJZz3fpH97Z/PyxhnyKpPEnpZ1x+4/6Zl6f6bxqQ435O
 qGiKx2KHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABOZzcrIcK1PbAe7x7PHdlYH
 fGbc92pLdNz+3cEz07El48CBgu4wb4b/9Vs9rM+2v9jANDHjsZhgVSNXWI/RmXmL49h2/TM6lH2
 AGQA=
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
Matthieu Baerts (NGI0) (6):
      selftests: mptcp: connect: fix fallback note due to OoO
      selftests: mptcp: join: rm: set backup flag
      selftests: mptcp: join: endpoints: longer transfer
      selftests: mptcp: join: userspace: longer transfer
      selftests: mptcp: join: fastclose: drop plain RST
      selftests: mptcp: connect: trunc: read all recv data

 tools/testing/selftests/net/mptcp/mptcp_connect.c  | 14 +++-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 95 +++++++++++++---------
 3 files changed, 66 insertions(+), 45 deletions(-)
---
base-commit: b9e1acc39cbc985ca8df781775718e39e421409b
change-id: 20251029-slft-join-inst-e307faf42138

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

