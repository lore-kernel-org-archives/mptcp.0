Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6BD2E4257
	for <mptcp@lists.linux.dev>; Thu,  9 Apr 2026 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775767938; cv=none; b=jRdKYB0IbX9P+H8p6H//iVZjYMd0PaX2v/dcXA2rzcJYUbrvHxoTbmduy9Hzxbtax7kjJjCPydziZ6DXEIJJ71rduQPj8TDiyCrSqOQYHbEEwltwRXprL6oVc4fycukZd9bnKKAZ64GQdkS255rw3eaJHz064oJegLSwgX+MryQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775767938; c=relaxed/simple;
	bh=TVCvyopYES9xmr99hgxNq+W0C9O0oVBp81sFTYfc0NA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fFTovpUmwTOn2JWIa6rE5t5SIC6Snv8CpBdRFWUDtXNzS0O0ps5OJO/SrrP9y9TmymAxLxIfZa5QqMh03xBBQhvlxkwD9YUceZS6aXKYXtN2QLue9KEcxmPsPFYbGfNexY26uR/J/MUoDo0vlnM1tnjqGDW22Sn2bv9pP0DNkOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qp9a7U/r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qp9a7U/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FA1C2BCAF;
	Thu,  9 Apr 2026 20:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775767937;
	bh=TVCvyopYES9xmr99hgxNq+W0C9O0oVBp81sFTYfc0NA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qp9a7U/rUO8K4iu6r56QkHDFG/FrZj1uPkF1m9tjjY/AAL4B0JcoMMiT6QekOs31M
	 niKejAF2C5FR5fdIpxEJCHUv1LgL6HDeZEtBSOQOQPCuOAkuw1B3l5gYASGaGAiPi3
	 hAFwt5aXIdKMS6nEys1Ny7Ey1gXgAiQmc4/qKi9w0GxOSonP2r+PNWIsVgsjQQjttd
	 hg3F4nIz25bchoRO0F6q5srkv6rpeqKQEsnu/k7Y2huSNz9vJOrDN2gOafzwQWaJW9
	 kcDEn0TwJNswRoPnMk1s6YagEfdiIW1u9cdhal4eElktrvIPb8tST05u6vEGvrj+Ug
	 FvL9jQ4BSI7Yw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 09 Apr 2026 22:51:47 +0200
Subject: [PATCH mptcp-next 07/16] mptcp: pm: prio: skip closed subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-mptcp-inc-limits-v1-7-0e45fa30d914@kernel.org>
References: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
In-Reply-To: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=967; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TVCvyopYES9xmr99hgxNq+W0C9O0oVBp81sFTYfc0NA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvCJbIGx64c3mlO+OctXdEpH/9uJkuJ9Z3xs52IaPlh
 ee7Zt+/01HKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRM8sYGW5o5+rOsZgtpduz
 oGb1Lyvzyc5G96d7GFtk7Dq99p76zlxGhpU72C16Jseu/rBY8sL0bzzv16zmETYL7S5Kf6SvLLz
 mGTcA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When sending an MP_PRIO, closed subflows needs to be skipped.

This fixes the case where the initial subflow got closed, re-opened
later, then an MP_PRIO is needed for the same local address.

Fixes: 067065422fcd ("mptcp: add the outgoing MP_PRIO support")
Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index beb06213585a..e1dbc64134bf 100644
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

