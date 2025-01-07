Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C967018B463
	for <mptcp@lists.linux.dev>; Tue,  7 Jan 2025 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269787; cv=none; b=DFca1b1qVGKF+wqwsavcrFrWDaoQkNwAkaYtmAhQ9wN3hJg6/F3oqOoVwoLP19YS6ATFiSkBb7a7RIYeuajd6JRdYad1yK839rtU5F2hC043UpsUL2dCCIgsiPeH+H5PiefDebzb7QI/LrowdEicg2r+fNQCO4OPTRFNf0K5J8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269787; c=relaxed/simple;
	bh=fFV2Pfkb2Q9IstJcaGWoSiVfjzFrTDPTYJqu0E8GICI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LDixKXOoGfBs65D42jOTgcR1LS3ivQh9CWXr4peDm4YWr3l8G+4tSx1v2DbizXg9oRUO/a85C3gmKzn1rhHA2AQ0wuYnDSRPEU/qw8IBPzvRVKDr0vycu8YEWmcPFE5VafEX1E+q24/38/0aVNWd8nYBmhapajP9nJsX9ORjeZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPkdetbo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPkdetbo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B59CC4CEE0;
	Tue,  7 Jan 2025 17:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736269787;
	bh=fFV2Pfkb2Q9IstJcaGWoSiVfjzFrTDPTYJqu0E8GICI=;
	h=From:Subject:Date:To:Cc:From;
	b=mPkdetbojwf/8ZY5TDaq2ZObDjnazvBhWIOVp0O6dO7Z/A0o5Y1Hvu2IHdkWMwb6H
	 A4wPkNy5bGmB0Zbe8HhblhCkI/iOMgUnsrTqJDx0VA4dQLHY3ntrw6SY+tCf9lJ6ki
	 lOQarbgdubmID2Aqc11LuQyD0laY8SOafh3e/GGDzczoxyPSBhANmR4RKymBwycrGd
	 VuCgIyevMb6rBB/umY1FgzUbPaL/J517luthcVOjQ+BgXGgoID5++0x1S8oumAoXrw
	 oa9bf3RtahObQvxzR7m16M14Xl3JL/noaEqg8S2vAr0H+QrdXsY2rJ8fMRMpHpgxfJ
	 mlSUUDg4tuTfA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/9] net: sysctl: avoid using current->nsproxy
Date: Tue, 07 Jan 2025 18:09:24 +0100
Message-Id: <20250107-mptcp-sysfs-netns-v1-0-2fa7075d9970@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMRffWcC/yWMQQ5AMBAAvyJ7tklbGuIr4lAs9qCarggRf9dwn
 GRmbhCKTAJNdkOkg4U3n0DnGQyL8zMhj4nBKGOVVhbXsA8B5ZJJ0NPuBU1RmaJ3tS2VhtSFSBO
 f37OFX08idM/zAouMz7JuAAAA
X-Change-ID: 20250105-mptcp-sysfs-netns-23723ba85401
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2440; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=fFV2Pfkb2Q9IstJcaGWoSiVfjzFrTDPTYJqu0E8GICI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnfV/a3IkMqGCoiHq8cUxkcUBrK7RQOsZArQIcy
 e3KqFj9DV6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ31f2gAKCRD2t4JPQmmg
 c/UkEACJCVCcs6NEcG8EUZc+S5ilaop3pr96GbEIvbUeIjM+ZjatGqYTr7etFzAaNn0EY/bH1nP
 yjQ1fDZGXXjYH1LiYDinfOtL6tmpK/RnRhqSoZeLJTYC7gRyqkv5UG9tmrfoGQLX6Oxv+cRWfoL
 VCmwQLSLZkxI3O5MhSBVEQpJL9+EQrWxuP6WqfSzqolqShXcV4AAi8YTh4PaV8pUxDxVPAG8hGM
 Zr+oMuRap1nWIZSJsFRerXCiyzT/SmLOnINlPus97wccVrgE9Jr+EtN52E1jJWJL2+vj2EuTo/3
 Iw3irwsb2xFusOmCbSjJuZp8yyZnzURDZo9DFLCySjV1rGebJ36l+UL4uLV2fZq4undQb6+WI8a
 KEhIqSlorcwMRnoQbDDXh+3zyJvThwDNjkx+FKzwY4KkdyMiGdzAVsP2jaUMqV15k9YWKaDv8Jb
 cUrBrHXA32K0UOhh54eQunfmIJ7w/KGgulSVTZDbGXZ/D2It0qqXkMseJSOMmAcubND7QBrsI08
 QgeCTCTAvh9jILtZp+LtYKKiKZ/pOm/P4pGsL5B7kxDwIxuYWKLYkQwqdFs2IKAiPgDOw/sQLP0
 NWobVuiPAx3oUJOb4arBNoQ7GscpWv7wFCSdrhimM/9Wn88kHvNhiCXsIf/Jnagc3ExqGnrFJJM
 FqJR0B5fAqNjOAQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

As pointed out by Al Viro and Eric Dumazet in [1], using the 'net'
structure via 'current' is not recommended for different reasons:

- Inconsistency: getting info from the reader's/writer's netns vs only
  from the opener's netns.

- current->nsproxy can be NULL in some cases, resulting in an 'Oops'
  (null-ptr-deref), e.g. when the current task is exiting, as spotted by
  syzbot [1] using acct(2).

The 'net' or 'pernet' structure can be obtained from the table->data
using container_of().

Note that table->data could also be used directly in more places, but
that would increase the size of this fix to replace all accesses via
'net'.

Patches 2-9 remove access of net via current->nsproxy in sysfs handlers
in MPTCP, SCTP and RDS. There are multiple patches to ease the
backports.

Patch 1 is not directly linked to this, but it is a small fix for MPTCP
available_schedulers sysctl knob to explicitly mark it as read-only.

Please note that this series does not address Al's comment [2]. In SCTP,
some sysctl knobs set other sysfs-exposed variables for the min/max: two
processes could then write two linked values at the same time, resulting
in new values being outside the new boundaries.

Link: https://lore.kernel.org/67769ecb.050a0220.3a8527.003f.GAE@google.com [1]
Link: https://lore.kernel.org/netdev/20250105211158.GL1977892@ZenIV/ [2]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (9):
      mptcp: sysctl: avail sched: remove write access
      mptcp: sysctl: sched: avoid using current->nsproxy
      mptcp: sysctl: blackhole timeout: avoid using current->nsproxy
      sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy
      sctp: sysctl: rto_min/max: avoid using current->nsproxy
      sctp: sysctl: auth_enable: avoid using current->nsproxy
      sctp: sysctl: udp_port: avoid using current->nsproxy
      sctp: sysctl: plpmtud_probe_interval: avoid using current->nsproxy
      rds: sysctl: rds_tcp_{rcv,snd}buf: avoid using current->nsproxy

 net/mptcp/ctrl.c  | 17 +++++++++--------
 net/rds/tcp.c     | 39 ++++++++++++++++++++++++++++++++-------
 net/sctp/sysctl.c | 14 ++++++++------
 3 files changed, 49 insertions(+), 21 deletions(-)
---
base-commit: 474ab61b2b3a9a0c31267efe807c4fed12d66d28
change-id: 20250105-mptcp-sysfs-netns-23723ba85401

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

