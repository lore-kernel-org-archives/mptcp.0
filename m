Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B7533F8A4
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876048; cv=none; b=ZeN4E1UfmdqK9svfAnNHgyunXRpWTz8aWQ3qfUas/Jens1Sv3cLf/wtb8gxj9mx5GAGZTE2sDxP51UDHOMpfl1aDsGXNT8iOtTfZtAYxzaEohdv1QJuKfHrulhuelmfpPwPrqD3RBGbAkklb5sWh4hpfROrbKTzfhbR9x4+AOHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876048; c=relaxed/simple;
	bh=iJoP4vKVO48G2P6KgonaMravUGh31g+oVT+0EV2qXV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jjWKwgSiyjfLtrlNwg5bYw50GtIItDUgGhV2Z0Jp1loOLYkMhGPiqGBO2JHmJkE11o3TVUFm31NZOP6KdTXa9VMCpyMMQ7GoZJfNvWNqIEsbQfzZDW7/yLYWozAq86+VBLruJ2qPNcNzjTaM+s69xVId4Pv1nFimBTE87N+PVEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmSAZod7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmSAZod7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FC5C2BCB2;
	Wed, 22 Apr 2026 16:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776876048;
	bh=iJoP4vKVO48G2P6KgonaMravUGh31g+oVT+0EV2qXV8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hmSAZod7WR2I5bAx8SInfEbY7rIRLch4nHIEg8LnDVbpFpmkcLGeIrawh15DT8GDp
	 qUc6xL0fB9a7e1JVAuH//mz6huAD2G3ZiCz8aNdNBplYa13r0Qdryskv3jtaVyRDpe
	 o8xBre4YCmRZ3lrUl348m3niGWJjtOr9Xymhk1tJFxsREo5iG5giOkJ7FebTjF5iqK
	 SF/USUa/MgextySXQXMBu3PwgYp+NN/GwHOT45rlo3AyPPrzAvb/NevKjFRzjLv+wi
	 5M5Cqmxa2fxYcb6XRCg4VAxif/1ff/py6yuJYNtPIKnMG94cuz/xiiYVUauz7nrM/r
	 ud1In3R53W2yw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 Apr 2026 18:40:23 +0200
Subject: [PATCH mptcp-net v6 09/19] mptcp: pm: prio: skip closed subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-mptcp-inc-limits-v6-9-903181771530@kernel.org>
References: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
In-Reply-To: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1076; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=iJoP4vKVO48G2P6KgonaMravUGh31g+oVT+0EV2qXV8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJf/GLkPuJzu3rBvZyvIkEv3m0xDq8tcq+d7aW16qfl5
 jVp7ifVOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbiIsLwP23FLf28ouBzC+N5
 +zKPMsczLehIeHL+2/qzhqlr2IsebGJk6G5yWHag/nW32L0jUz9s/3Hj+wuVR651a3P//D9ckZX
 3lgEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When sending an MP_PRIO, closed subflows need to be skipped.

This fixes the case where the initial subflow got closed, re-opened
later, then an MP_PRIO is needed for the same local address.

Note that explicit MP_PRIO cannot be sent during the 3WHS, so it is fine
to use __mptcp_subflow_active().

Fixes: 067065422fcd ("mptcp: add the outgoing MP_PRIO support")
Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index a75889f3dac7..10df7c0aef38 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -284,6 +284,9 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct mptcp_addr_info local, remote;
 
+		if (!__mptcp_subflow_active(subflow))
+			continue;
+
 		mptcp_local_address((struct sock_common *)ssk, &local);
 		if (!mptcp_addresses_equal(&local, addr, addr->port))
 			continue;

-- 
2.53.0

