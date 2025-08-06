Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AA428AB16
	for <mptcp@lists.linux.dev>; Wed,  6 Aug 2025 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754490134; cv=none; b=W9TNUN5Fc10dV+X9Y9up+qnAMgryHroWNepDyxpsUoXZ2PiDJ2sJLub44oougD6aRQYf7JH680/v2I2+U23GFJ9k3m7VnOsM3f9L1ewRJi5WiCwh51e4kn2e0wDnno4P0tvVVfMgfbocVYQOtIePE9iDfaPIZQqUBbPI3efNadw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754490134; c=relaxed/simple;
	bh=FG0fohuDBdkuwV8G0p+9G0Ul0rpMDNPDEXKemx85jxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U/reVgmFcIU8sT3LT8+feaFJ4DhgKd4a3zJrdR6RTnjyYUbIM4j7Rj28W7qWbiOmA6Ufy+0qPCrcpJRyLygqRh2p8SoUqtp4kKW+Pd6h4a7NMHiDp7mm4MxuR1NIfU9K/e2Dga5ee4kYbp3FBuEYUPlm0umKXjyT5veV/Fi16Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihJYKmSD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihJYKmSD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491AFC4CEEB;
	Wed,  6 Aug 2025 14:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754490133;
	bh=FG0fohuDBdkuwV8G0p+9G0Ul0rpMDNPDEXKemx85jxE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ihJYKmSDZk7SGMmHXGxjLo8+enwjbwzbRSdGVrTASlhZ3KsNIIfaX7w8C1GW+8lEV
	 BTHpWJHD7eP0Eq74EuVFXETfjsek6rdM7M+bLZT3fQM9YTUVHyVk92Prug6soFmch2
	 98oaRAB1SaN+ZnTftp4W8Ejcere4/TvPNeUNEyf3XjCCz3bXSN2NQY2bxXaUSdkPVF
	 S5QuUrhdVaX6KoAznaSUWIrxP6+0DhRZGuPHoacPlmp4h4p0ZSrUyDzxAOTQ4L7X2A
	 KuyxpHwonGnacZO2VBO6ldcAN4kJTZcGOwfUNXgaGHKtGyJjdLdXFOuIs17L05SmVS
	 ulo51kECiaIpw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 06 Aug 2025 16:22:06 +0200
Subject: [PATCH mptcp-net 1/2] mptcp: pm: kernel: flush: do not reset
 ADD_ADDR limit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-mptcp-pm-flush-limit-v1-1-9f83699e0863@kernel.org>
References: <20250806-mptcp-pm-flush-limit-v1-0-9f83699e0863@kernel.org>
In-Reply-To: <20250806-mptcp-pm-flush-limit-v1-0-9f83699e0863@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Thomas Dreibholz <dreibh@simula.no>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FG0fohuDBdkuwV8G0p+9G0Ul0rpMDNPDEXKemx85jxE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDImpwrHL5P3evmgK1+X7eT2xqrlZ5Vu64tqnhXlV/nFa
 mG6QVG+o5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCL78hj+5x9Z/3n7Q6bLD1zm
 tRr5GK1bcF8iqXarbp97wR+/SXeLihn+h4Vea2zlvsreur9JvcdA7RjPjpW2BasPnlyYq7xB1Jm
 XCwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A flush of the MPTCP endpoints should not affect the MPTCP limits. In
other words, 'ip mptcp endpoint flush' should not change 'ip mptcp
limits'.

But it was the case: the MPTCP_PM_ATTR_RCV_ADD_ADDRS (add_addr_accepted)
limit was reset by accident. Removing the reset of this counter during a
flush fixes this issue.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Reported-by: Thomas Dreibholz <dreibh@simula.no>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/579
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 7ec81d5195d412b850dcb550f91384f75b11b347..f30df8e884a0b3de9fb092e5774cafe08f6350ce 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1086,7 +1086,6 @@ static void __flush_addrs(struct list_head *list)
 static void __reset_counters(struct pm_nl_pernet *pernet)
 {
 	WRITE_ONCE(pernet->add_addr_signal_max, 0);
-	WRITE_ONCE(pernet->add_addr_accept_max, 0);
 	WRITE_ONCE(pernet->local_addr_max, 0);
 	pernet->addrs = 0;
 }

-- 
2.50.0

