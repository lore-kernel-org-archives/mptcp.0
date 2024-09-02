Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BB7185B62
	for <mptcp@lists.linux.dev>; Mon,  2 Sep 2024 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268159; cv=none; b=Kk4LXed43ITroV3VMUI7wxMiqQrHxbYPNtKanUZU2oKCqfOvxZxhh7iNj1ybMH4OhJ7GDwcVAIYFUo8Bmm5bK3XRFyul8eDhwcoPswp0WfaiZDUvlOVLGwELmLEuVl+GiMPwhrwp97GjrdQ+3iWjTjrRo08k01KhEesoBLPlOvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268159; c=relaxed/simple;
	bh=j5HNPjUT4j6LBm5yMb7DWXkF8m/Sfqh4JGL68nEXR+U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nj+1Cm6VP53z3upxes5s1Q+gFLssL50+5eH5dUrs+wF1jP7tf5qD+eDPjYkd0hhGEz3jI2fjy+QN+8yNibUuVoRJtRnBBWHiySekvyjjIT2GUhjiOeDQylPM5D5EV+qcT6gYtNAxzr6+5ebaRvX3cZqx8vLX2Oasfl82Ih9fQ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAin7oRN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAin7oRN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0FCC4CEC2;
	Mon,  2 Sep 2024 09:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725268159;
	bh=j5HNPjUT4j6LBm5yMb7DWXkF8m/Sfqh4JGL68nEXR+U=;
	h=From:Subject:Date:To:Cc:From;
	b=CAin7oRNZdnLPfx8WDnEfIOyRgS3tPWKEC4Ixj7FCw48uoPkFK7V4B333obN0kQGw
	 uRIACFAYICdT8CDFiIRapr7IQ0Tux5LNdDS0yeSDHLKVjSIzc/5GKZ3nX2HboxS0Ss
	 2B1YvDvqeoKbXeeHuD65qtX+21dA9/S2pY7cZSAP6Zt+hutDt0zGSYkGVV09tqi/dJ
	 dSEBwiUCrxs2ehhfk/BGXmD5vbYfi8/ztil8bnhzkgafNanqJ+4cIszkJepEaLV5xc
	 vGIVkb56u7kHNv8XhKr0Te+KU6kUmUSvKU0y8lRsmKtjMZySjIHy+Zwq1KygL9/kxa
	 ACwKpPhxQy9Xg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/3] mptcp: fallback to TCP after 3 MPC drop +
 cache
Date: Mon, 02 Sep 2024 11:09:07 +0200
Message-Id: <20240902-mptcp-fallback-x-mpc-v1-0-86d9170ddff7@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALOA1WYC/yWMWwqAIBAArxL73ULZg+oq0YfaVktlohFCdPekP
 mdg5gZPjslDl9zg6GLPh4mQpwnoRZqZkMfIIDJRZo0QuNtTW5zktimpVwxRaCzbXKmikg3VNcT
 UOpo4fNse/sJQOGF4nheHWeiZcgAAAA==
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2639; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=j5HNPjUT4j6LBm5yMb7DWXkF8m/Sfqh4JGL68nEXR+U=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1YC+ga6H7Xj47IpzBMtOlWQBQ3+Jj9Vkvs1H8
 cNq5vr3q5yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtWAvgAKCRD2t4JPQmmg
 c68bEACN/kZvBfqGGPYsxznM7xvcCWYhfVdzKLPOFJc1Ay/Bn305waZj+KzMZfgiwmKZDhHuirC
 9IUwg6kOyS60n9ruAUIHAPP0uSHgbIGxRHxlyQ0NptuOPegOv2BA4izw5wn2j54OV0YPDei3oEc
 hfRaB9Y6+ePmnIHbeLY49iuQSst71hCe6AuIDP9LdqInuL2U3LJU547TVh65Uu+1vbybJQZqKd7
 S2fAx0XzidmxS4UYg84dU7QoOMSrmSRywmvTx4P5CaiJkiNP8HZp/Elwnq/GoIyvoECppvTx4Fm
 EC6tIcAljxZxvvDnegRgRzPDqIRp+qfmNPLjXN/8q5XkzREk25y7w1D3QRvtRAniHbP0qPMt/aY
 ZM3MZOThbwc+gIc/p6ln6DsE5JnsLKoSEcKYeH5NaazohZSYmRsWtNu/IicjzaaX2zzjcDV5Ha6
 Dy/Z7n6gOY0i7UO/HYFRZIh2/4Q3JG5PFicvASUGyErZrLzJR457LFFHrJcjXHmPTov864y38sh
 U/2gTEYmVhR2/TvXwO30l5X0eWBTe8pyQtqvql3to92lJIJVS2Z41wnpRWozrS1KbyttH+pCTSD
 kqVxQonUa6IAK0XjUkne+4CvUrN8iItIH87ClLcGSVEY3XZUz6t/3Rps1MPiq2CV8B/nFpLb3Gh
 SfCv4FEjy728ZBQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The SYN + MPTCP_CAPABLE packets could be explicitly dropped by firewall
somewhere in the network, e.g. with:

  iptables -t filter -A FORWARD -p tcp --tcp-option 30 -j DROP

The idea of this series is to fallback to TCP after 3 SYN+MPC drop
(patch 2). If the connection succeeds after the fallback, it very likely
means a blackhole has been detected. In this case (patch 3), MPTCP can
be disabled for a certain period of time, 1h by default. If after this
period, MPTCP is still blocked, the period is doubled.

This should help applications which want to use MPTCP by default on the
client side if available.

This series has been validated by a new packetdrill test:

  https://github.com/multipath-tcp/packetdrill/pull/156

Some questions:

- Should we let the user changes the number of retransmissions (2)
  before falling back to TCP? For TFO, the data are never retransmitted
  in a SYN. Maybe that's different here? A sysctl knob could always be
  added later on.
- Should we globally disable all MPTCP connections if any retransmission
  after the fallback is a success instead of only the first one? I guess
  we reduce risks of accidents by only looking at the following
  retransmission after the fallback.
- Is one hour a good time for the fallback?

For later:

- The restriction could be done per oif (sk_dst_get(ssk)->dev), but we
  would need to store it somehow, or per MPTCP entrypoint. Or let the PM
  calling mptcp_active_enable() when a new endpoint is added.
- Other cases could trigger mptcp_active_disable(): e.g. some fallbacks
  or corruptions in the middle of the connections.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (3):
      mptcp: export mptcp_subflow_early_fallback()
      mptcp: fallback to TCP after SYN+MPC drops
      mptcp: disable active MPTCP in case of blackhole

 Documentation/networking/mptcp-sysctl.rst |  11 +++
 include/net/mptcp.h                       |   4 +
 net/ipv4/tcp_timer.c                      |   1 +
 net/mptcp/ctrl.c                          | 133 ++++++++++++++++++++++++++++++
 net/mptcp/mib.c                           |   3 +
 net/mptcp/mib.h                           |   3 +
 net/mptcp/protocol.c                      |  18 ++--
 net/mptcp/protocol.h                      |  16 +++-
 net/mptcp/subflow.c                       |   4 +
 9 files changed, 182 insertions(+), 11 deletions(-)
---
base-commit: 44106bc7908a7c9e461983032567a918e1d62b91
change-id: 20240822-mptcp-fallback-x-mpc-491bb35a8e66

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

