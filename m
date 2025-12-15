Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FFA25D527
	for <mptcp@lists.linux.dev>; Mon, 15 Dec 2025 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765819848; cv=none; b=LSPX2vr14tReSilqh6OxC137F66C9VcB9mH0+s2E6QZSse6AWXGa3e+eYOYu9X1QQQlGwFjDXTuc7o+TtLWT4LBBVDPFA0+vBzaJG2lblAzWACK0OvQw+0Uo8Ya3bQtl4LXntKeD5+r4n2tasK+JDKoL6oGxZrkARKjpYrx9xIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765819848; c=relaxed/simple;
	bh=+iavQ4cPqLRLhBQntbTLDkq2QJ36UeUIfeW1vBeBLKQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sq30NuBWdbNrMN5eSGfahfxf/bbwRlKn+YKH5zREDo/lNu6N7hckMiP4ZPWogxkqqN/OTiGqnumm518CnByZR0R3phYpNuOAVdzKxRcjviMCpgxQXJu/6gLjh2LgBm3ETomRuBAi8YlZWuYroxDDr3122nMbIpnC2QEs6aFFrDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSAbE8+1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSAbE8+1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF34C4CEF5;
	Mon, 15 Dec 2025 17:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765819848;
	bh=+iavQ4cPqLRLhBQntbTLDkq2QJ36UeUIfeW1vBeBLKQ=;
	h=From:Subject:Date:To:Cc:From;
	b=tSAbE8+1IX9b7DAcJD++rSUzpdrBzspNtfSZ1Hwzn5vCb/Q1P4NLuuAA4g369oEXZ
	 mNq8EeyKsDBMwJGk6o01Yj1DmhQNbu5+0UCQdbrTD3BgB3lh3jl/IvWl1x8l4nTLxL
	 3YS8tmkpHyMOzm7ogoTT9O1sOyR/2tlDoVVNh6f6m2RYcH4OBL3fETSrOsUuhbXmGl
	 vz4tyMU7yN7HNNGrJVP3qEA8nXTx+Q0B6x8P4qCu577SHM+rPArXdb/M8kjWKRFK4j
	 2toC/N+xOBgQGe8Od/BFxyOQOJB6McQne2UOn54ILBD+PeJ+gwXa8VphqEF1LONop4
	 UcEKuB6Sk0kHw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/2] mptcp: pm: in-kernel: fix issue 606
Date: Mon, 15 Dec 2025 18:30:17 +0100
Message-Id: <20251215-issue-606-mark-subflow-endp-avail-v1-0-2f1b36da8993@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKlFQGkC/x3NwQqDMAyA4VeRnBdoI5OxVxk7dDHdwrSWRp0gv
 rtlx+/y/zuYFBWDe7NDkVVNp1ThLw3wJ6S3oPbVQI6unjyhmi2CnetwDOWLtrziMP1QUp8xrEE
 HZOa2JYrx5hzUTi4Sdfs/HjDmmTMmmeF5HCfwWPlofgAAAA==
X-Change-ID: 20251212-issue-606-mark-subflow-endp-avail-ccc3322ff800
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 syzbot+f56f7d56e2c6e11a01b6@syzkaller.appspotmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=627; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+iavQ4cPqLRLhBQntbTLDkq2QJ36UeUIfeW1vBeBLKQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIdXI8u4z6xqdOx7effJFWv+NKoB/9vhTtU10bMZRe/x
 /eaY4V0RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwEQUVBkZ7vwr3mS2pnmJRqfQ
 ozLGyumzzhu7PDfTC/w4fensdUwLpRgZbj5exX+IcXH2j2fLWFuups1xmco9e/MUn0ybI7Ubj6e
 kcwIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The first patch fixes it, the other one clarify the code. I think both
can go to -net.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      mptcp: pm: in-kernel: always set as unavail when removing addr
      mptcp: pm: in-kernel: clarify mptcp_pm_remove_anno_addr()

 net/mptcp/pm_kernel.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)
---
base-commit: 6be713e13dde6d9eb7f5b738db8643a9c9440ac5
change-id: 20251212-issue-606-mark-subflow-endp-avail-ccc3322ff800

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

