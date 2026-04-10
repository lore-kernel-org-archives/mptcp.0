Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418EA3D2FF5
	for <mptcp@lists.linux.dev>; Fri, 10 Apr 2026 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831533; cv=none; b=j/no4VNZJtiVMB39oAOFYXxy1HlO+Gu9T0GkUYhKMkdAa3Ujvqp2Vzy0fa7WAJK9u8FQwlX3DZc2pcjxrl9TGEvLPDFEmpcqLBhGguk2ZymVNeJnzZpAlX16cR/z9PALX6E6MDDZyl9tCdXkTjWTGUyMnK5vcdkF+G06UjaeBcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831533; c=relaxed/simple;
	bh=b4jstWoMKDTppuhTqzUv2XXNJoB1zjCvFPjzYGxOOGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S6bzI8e+PvPxukUIYom+lki32EBkA9Er2Uj8n0mxy3YalfoqZFMTyL2sqT/Xd5w0/SWGjSSG8XlfTuaGzd1ZALuEESc5o9I5prYQoNCk67XwGSI433fga1EvRHWyI9jF5Ui9PBRIBzQbBVTMOMczR+WyGCS3Yeur0RnxEd91fAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQYSL/Iz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQYSL/Iz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997F6C19421;
	Fri, 10 Apr 2026 14:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775831533;
	bh=b4jstWoMKDTppuhTqzUv2XXNJoB1zjCvFPjzYGxOOGc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JQYSL/IzslnJCX46Cph2anJVs7tkg+TpJCviiuPwNfZBHwQZXDNHeEQEeghsRgRUJ
	 vplYq2PyfHZ/q0xO61C0JDlAd0wVE4juxwuL6DZW4+K0YfSiMOlv6O3kJTed2qb48u
	 kwwTj7k4PiPjHhnOiVjJJFerlfv7k+VceyYaVbZNxXOp2DFU4Of2GIAQmtN5y0LWOF
	 QYHh8h96Wzj7H7NXkDp4smU7Gt5LsrFGjhEo1Veh++DJbnsLk3E1XLlJJ4IXxuO3r0
	 AWn0inXlbTEJY0BD9Wql0gMrBynIV8sNRDG99Lqx6Nmw+Z6zlpqLh//JNlxByNkPTm
	 amBXqV+M4rHuw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 Apr 2026 16:31:46 +0200
Subject: [PATCH mptcp-next v2 08/17] mptcp: pm: prio: skip closed subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-mptcp-inc-limits-v2-8-5402209f05d3@kernel.org>
References: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
In-Reply-To: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=b4jstWoMKDTppuhTqzUv2XXNJoB1zjCvFPjzYGxOOGc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvct77YZeSuOrMqavPzpX3X8yacDi/manvW8Gbi29Ti
 uK/3d2wtaOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAiCZcY/kdzzXu4M6VEbbFz
 z/S5Cys0W48tTL268XezmwrrrlPfHmQx/DP9ZfHDMHjN030nr+bzv2aQ0Zp5SvXo9FMx4o8t2wt
 4trIAAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When sending an MP_PRIO, closed subflows needs to be skipped.

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
index 6f1950462556..c7bf79a3d1da 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -283,6 +283,9 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
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

