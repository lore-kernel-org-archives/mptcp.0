Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E8332FA21
	for <mptcp@lists.linux.dev>; Fri, 20 Feb 2026 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771586763; cv=none; b=UZAbrytqVTy3b03LCKdIcJx9Hv9KVXdtztpA/Bt0D0rNw7m0h9Vi/Eqg4QthNL/oFJS73t5a6Zxe3JIRCZ8txAtiKvYanyMplnptYzZPc5J22kEHg62MoyNhN7WSyhY/YWhW883UOG2VJCyrWCPfLJjFbp6zbN1USjoe2bKOOyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771586763; c=relaxed/simple;
	bh=9yHv6I9m4AAyY9fYg8kP6keOd5BcpwippxVuLsnhfoc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=POfDVGBzZXYyjktWVuPkvWM5rPdxRmePt1a6+BMCnGvpOp727QWGenJ53I1J+7ucVTzNLOIDyg6cjNgtBJH0KF4o0RdO4qvR7T58cyOEoqles09HAdWDuTlF+YKizZ80iGvyQ72bI5Eaqc2LfkZg20+nU7wIQdh213jFgM31mBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=go3rUhJO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="go3rUhJO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5526DC116C6;
	Fri, 20 Feb 2026 11:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771586762;
	bh=9yHv6I9m4AAyY9fYg8kP6keOd5BcpwippxVuLsnhfoc=;
	h=From:Subject:Date:To:Cc:From;
	b=go3rUhJOdZGM9yQT4Hin/dZxXB5Ha26+JkHsOtRoF9S9yXDcPZbQ5IOWrmw3FsF0B
	 bLetvMdr/3dldTfugtWmDMYBMWorsVoWOmqGiEN8LSnlXBk7XtUkceway4tb6W9U2c
	 Znu4ibc3RgerGc9vaNEZwW3RUDymZ70CGCYSoFT9ZZkZGQLhBIHL7Rb5Gln66Nbh6R
	 eRrSXBo7biraegysC5S0+i2XiI1uwnLDrKc9D7Fu7Cvog+mNOQ0q3TbXEXdU8ttnEK
	 /fIpSgRhE42F6bp9SsFl3QhKVd3VStPoUO1MHN64aeldV1bVIk9WABBPDySmQCapoK
	 7FlEZx1uQkhFA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v2 0/2] mptcp: pm: avoid sending RM_ADDR over the
 same subflow
Date: Fri, 20 Feb 2026 12:25:50 +0100
Message-Id: <20260220-mptcp-issue-612-v2-0-089684a6edcb@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL9EmGkC/3WNwQ7CIBBEf6XZs2sAFcWT/2F6MGVpNyoQqETT8
 O+SevY4mTdvFsiUmDKcuwUSFc4cfAtq08Ew3fxIyLZlUEJpoaTBZ5yHiJzzi1BLhdbshTk4Ka0
 gaKuYyPF7NV7hB3uaoW/VxHkO6bN+FbkCf7VFosDTzpAS1mhHx8udkqfHNqQR+lrrF684yLy6A
 AAA
X-Change-ID: 20260219-mptcp-issue-612-d94095f11d0e
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=998; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=9yHv6I9m4AAyY9fYg8kP6keOd5BcpwippxVuLsnhfoc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJnuJw46zddQur39xdFTTfz5J5ubrNhqU916/Z4+vT8k
 SNJHy5wd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEykcTbD/8T0qKqVgkZrfgaV
 qgnsmNH9ccIfK+Xq6+c+bb35pWe5qy8jw3fZ7SxhnPvqwh5MNT54RXb28wqO684n11r4r7r//Xj
 JLGYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This should close the issue 612 reported by Frank Lorenz:

- Patch 1: avoid sending RM_ADDR over the same subflow as the one going
  to be removed.

- Patch 2: validate that in the MPTCP Join selftest.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Patch 1: small refactoring to reduce the indentation level
- Link to v1: https://patch.msgid.link/20260219-mptcp-issue-612-v1-0-839e20d96fe7@kernel.org

---
Matthieu Baerts (NGI0) (2):
      mptcp: pm: avoid sending RM_ADDR over same subflow
      selftests: mptcp: join: check RM_ADDR not sent over same subflow

 net/mptcp/pm.c                                  | 55 +++++++++++++++++++------
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 36 ++++++++++++++++
 2 files changed, 79 insertions(+), 12 deletions(-)
---
base-commit: d81a02a671623999f5ec963b73181d845c665747
change-id: 20260219-mptcp-issue-612-d94095f11d0e

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

