Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC3A3A7189
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172931; cv=none; b=rmUwQzOL4Jini3r1P8kCrtUvbUQmCVpy5WAGr8CjjtOtx0gbQ+2a2n0/rMFmjMsvJo+29DTbuDLg/0B8s4UJ2Fb6Zp9pRxO4WMCNjGlcTUFK3nhRcJU78dvctzLN9vV9ShOw51jj4b8q5Av2WlplQ2Iy6D7OruwHGl7B+Uv4UCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172931; c=relaxed/simple;
	bh=VvQwBZNfTJqRyB0TDep/PGRyH5Lmtewz/dhez4cVesg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U0b/OKpkUgaFkgADRndXTHwH+KusX7Tj4nRTjkToEkPbBBllYlmUtuM3YWHtGJ9pyHX0Dnj3fuseVjCmqDz9dsUb3CrHJf5g/6J6oxRoWM0Gru3ljJ+nRD9kvNow0occuoyexNqY4qnM9FFhjpkhIul8EVk6JWkwEo3cXHlRcK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0hxmAql; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0hxmAql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA971F000E9;
	Mon, 27 Jul 2026 17:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785172929;
	bh=a4sjSE4Nud3bNYx5kqbZOYTA7Ca2X8/W+kgXVVVRN9o=;
	h=From:Subject:Date:To:Cc;
	b=o0hxmAqlEJU6FMTtVlKsgA1w3wh/jkJ72DIIjj3be4Zdc5IpxHrDSn0JHWoCQcNGz
	 UDporiS12JyyNB1Vsa49GgT24BdPu0kXiwdA1RvPtMOnH4Pgaw2DVtP9Rhs4aa4LmL
	 vDzGYSfXnnmqPQYaFh3lq//L6/oKNF2ObMcIfJCM13PjGSWYfo70JL+16tlTLR9y2i
	 EuOAJm+utbZ28gLJMcw/28B94jk7OIWdfCTNsdbm8TX3kK9tcE2vs25m5wFGYy+DEJ
	 Patw9U/jbu8gv9Kec+kY0LlvQlY4OQJQ+xGrf8zk+mchePQC5QlW07vvnagq/byuS/
	 N0A0nq7WQu/BA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/6] mptcp: pm: userspace: properly deal with the
 ID0 case
Date: Mon, 27 Jul 2026 19:21:49 +0200
Message-Id: <20260727-mptcp-pm-userspace-id0-case-v1-0-9877f02a9bae@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMAxFf2Xk2UAtpRN/RXyoMdUIq6HpRBj7d
 zv3eLj3nAWMq7DBeVig8kdM3qXD8TAAPVN5MMq9M3jnoxt9wEkbKeqEczdNE20Ph5SMMbsx5Bh
 CjHSCXtDKWb7/+gV2sXCD6z7ZfHsxta0O6/oD591K4YoAAAA=
X-Change-ID: 20260724-mptcp-pm-userspace-id0-case-f074f64466c8
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1711; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=VvQwBZNfTJqRyB0TDep/PGRyH5Lmtewz/dhez4cVesg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLSJ287U35DaXq32SE+zuPPm2J1PrRGvEq+V3ZkA/ehy
 h/bsyNiOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACayrJThD0fC3jse0i1e60JY
 XP6rphw8wu1W8PnPiYh1N/33JEyLsGRkePqG5e7fdyqMV+XO1Z9zk/I847qjv3jjQs3Ja/9atk4
 9xgwA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In MPTCP, the local address and port used by the initial subflow has the
ID "0". It means that when this address and port are used for some
operations -- e.g. creating a new subflow -- they should be linked to
the ID0, and no other addresses and ports can get this special ID while
the initial IP address and port is used.

Instead of dealing with the ID0 case as an exception, add it to the
local addr list, and deal with it like the others, with minor
exceptions. That way, it seems easier to maintain instead of adding new
exceptions at a few places, at the cost of a few more bytes, which seems
OK in this mode.

The first patch modifies add the initial address to the list, and the
others remove exceptions, and validate that in the selftests.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (6):
      mptcp: pm: userspace: properly handle the ID0 case
      mptcp: pm: userspace: allow announcing ID0 addr
      mptcp: pm: userspace: no ID0 exception for RM_ADDR
      mptcp: pm: userspace: don't dump initial ID0
      selftests: mptcp: join: new ID0 subflow from the right IP
      mptcp: pm: restrict in-kernel worker actions to this PM

 net/mptcp/pm.c                                  |  8 ++-
 net/mptcp/pm_userspace.c                        | 69 +++++++++----------------
 net/mptcp/protocol.h                            |  1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  7 +--
 4 files changed, 37 insertions(+), 48 deletions(-)
---
base-commit: ddf9f880a057486230f16d6a4a8cab7e41c40da1
change-id: 20260724-mptcp-pm-userspace-id0-case-f074f64466c8

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

