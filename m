Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6D83A8736
	for <mptcp@lists.linux.dev>; Tue,  2 Jun 2026 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384465; cv=none; b=g53b6ylY0W2XMOtnYSqFT4vlxmwANjNcgQzkfE2EUnqQCXJ2rrPp+O5cYK3MpZdHFF1ZlzvZcS/0Bm/T5JdcjH9IjYTcShZ8LmYzV9iIYuwVSHz0sLGirt08ZEZu53epiDDN9HFeroM7NF1EePIZ2VIDLvy3rWm33bjxq6XgdMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384465; c=relaxed/simple;
	bh=WmdVKmMoL2PF7dA/R9PF3C85+SBZoHJguTE778HWdp4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WLGitjdJgpSuP8waJ13DG97gvN+iPfkDmLV+qaHJ04F0VIdSs547/HtxapHacSguHXUZBylaOJJmBxn8j0TOf02brnmj+WcQHLZWQtK5snK7ppcg6g75JMXQSNkKgvMmQfXDpKKpswgJEQvmC0J3lTcqlqQyILl37MvpJ23Hbew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQaw51NZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQaw51NZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E011F00898;
	Tue,  2 Jun 2026 07:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780384462;
	bh=2lACZ1iB08fCUddzkWMoxiAi76x5KB9AJzaMlJXNZZs=;
	h=From:Subject:Date:To:Cc;
	b=GQaw51NZVtRxxZWoWS3Bi8/rz+kg/6yILGmihVSV1nLqcrE174rDOJ4JarQhecZua
	 fCTeDXnkfaoD7txboqby/AdvN8SXzdPpNG8MoGLcu4asb0e12yvZQ88tqMe/xaFh02
	 7d7edtmGGwOby67oKISBy7sz703UJ2wV1IX90PV3jtYetM+UASAfK3jYsz/8iknUcb
	 HsknL3w8UY3CWXg02wDLzBov37f9Sc2xggyVRxE+FQtdcXwuqK1/TyBSjOTukqvOAM
	 CNTB+nuoRWhnAGUTI/ETfFk8hrByOZAnARq0zRssuveRK/zqDX25/8RtSr0cv/kg1c
	 O9UKz+wQXksog==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/2] mptcp: add-addr: always drop other
 suboptions + unused param
Date: Tue, 02 Jun 2026 17:12:36 +1000
Message-Id: <20260602-mptcp-add-addr-always-drop-subopt-v1-0-4cb4b5f446c2@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNzQrDIBCEXyXsuQvWgGBfpfRgdW23tLqo/Qkh7
 x7THObwMXwzM1QqTBVOwwyFPlw5pw7HwwD+7tKNkENn0EobZZTGlzQv6ELYUtA9v26qGEoWrO9
 rlobRumhGZb0dA/QdKRT59/84w64nanDZqy49yLftA5ZlBX3VnUaQAAAA
X-Change-ID: 20260602-mptcp-add-addr-always-drop-subopt-f9af6309c93d
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=925; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=WmdVKmMoL2PF7dA/R9PF3C85+SBZoHJguTE778HWdp4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHoLNJgzLzWaZvjWxqIxVr81WOVQFJr8plF0By
 kAgUxdXC4yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah6CzQAKCRD2t4JPQmmg
 cxs9EADBQJzLKB0pDZNIEUoJcrntYZwzq6lLpFkEaoBALnnxeVh9AkSTDvNNpHGzSfhAOuZts7m
 se7VsR3PyN+cv26OrT6lm4JGKC2sD5TG2NVJaw6W79L+2psfWztZrpxCIlCNHmcbpTAdHRClvIE
 M+wV5A9lmQuX5aIcXjbDzA2kdYuvIhSVqY6wQWR2pwTz301jojLAvn3Y4g+FUOtvovqkRBTmc2M
 7DQ4ce4nLEPsZ4CO9ZhJTFL1+14Lx1K2A3i5Vh+SwxtooP78VmCAi+cpSbaqNZtZsPq3g3SsO6i
 rPoJAdXr3dbnR7TX1cYsa6lhv0eQEcceJCaRCv6p7DHvDAi0wppqNgJQAHbl8mR8WHrNCUjeXkC
 KJREpcU7U9SjN92XSEbm5am7FoYHsSmU0oQsjy8mV38DUjmAE7ZkAiCe94/F0BxeB0jv9vQLtoW
 ycMtq7USguWKzGtJDms80FmtvF5c+EbEIDq0sYSvk6Jza6KFtvP3aofTD0J3IdARtUnOg4Gr21G
 Vyekir9Bv+jsDn/HLHbvLCeWZDSf3ijARe+HnwBWAzff7p900oivPpBZfw5AT8HjvQoZvtpMRIt
 BlJI7EEMFau1OvskMMn4jDDCKwUcz8/bximXkfkP8q1SWXT2yEu/hTBtAk7J8TIIB5owBX1DwHD
 yIp6XOEFT4Vn7sw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here is a fix for an issue linked to something spot by Sashiko [1], even
if there was an issue even after the recent modification in how the out
options are initialised.

And another small fix, for net-next.

Link: https://sashiko.dev/#/patchset/20260601-mptcp-add-addr6-port-ts-fixes-v2-v1-0-d7c842e80446%40kernel.org?part=3 [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      mptcp: add-addr: always drop other suboptions
      mptcp: options: rst: drop unused skb parameter

 net/mptcp/options.c  | 31 ++++++++-----------------------
 net/mptcp/pm.c       | 13 +++----------
 net/mptcp/protocol.h |  5 ++---
 3 files changed, 13 insertions(+), 36 deletions(-)
---
base-commit: 39cfd0474a57e23ae279c4e9227c1608693b858a
change-id: 20260602-mptcp-add-addr-always-drop-subopt-f9af6309c93d

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

