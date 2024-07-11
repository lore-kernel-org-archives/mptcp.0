Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2908D16B753
	for <mptcp@lists.linux.dev>; Thu, 11 Jul 2024 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712399; cv=none; b=kqtThglJyAhCoFkGglXApW8kbTXSavjqPG+Q5eB0qb0tPqj7/AiX5WA8h/D87oG69eNKmafGP34OiAmGQ7/PzxwwtmeZA/Mf+BQsQgMGtmhVjvsuxOIbB+MFWTO0uW9xviFNwj6Xg/renH/Ijo0Hgp2tN3AiPYFwQXaTusN7D+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712399; c=relaxed/simple;
	bh=el4qRlSZNNEra5/72bcgxC16DUkc+vjJu9h9eGeb9RA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mgHGmnK9Klw8D5VZPO/Hd49aDlopfOaRaOU3GPSaH+iRxd15irBKs47tLYRXeAXIfuE80918DP/y3I8z6Rw+C2f5kQtvLusOkfGVz/xld9xoHTIf/Rjw+zQSg6PA4+GaS1u3ZfggMQILXfwjdiw4VB9/ohR2mWwe6PX3oizkBT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDmgvo16; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDmgvo16"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6001C32786;
	Thu, 11 Jul 2024 15:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720712398;
	bh=el4qRlSZNNEra5/72bcgxC16DUkc+vjJu9h9eGeb9RA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BDmgvo16fsII/ds2O9GSugpsd7TD2JBmVb0Oxi2ZGOAu+/2ZOkFJ/He8NHtc+S/15
	 vckz1cjpIWWcdJq6bhffuQxzSjwrnIhtS0N1lv0WY8+szuZirk6KKmW2LdJUPr+DtY
	 cBvWw5rKP5RmX0xVpdbDLYo5ypQxDGb7zpnv9n16fvAwA+IBttPo5JjVhThHYk31FQ
	 1EK6BOZqXw4ytzVuSv4HofRz85LjwhNe3iqzj7xJ9TxYtHK8aPvHlx77+vXPIjsEOk
	 U59BK5SAa1i7pexnPbdctOKiTJaF0QrNoAtgUTBysCDc2vuEXzBsL9A8Kp6F26piTy
	 tecIztCjwo3yg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 11 Jul 2024 17:39:00 +0200
Subject: [PATCH mptcp-net 3/6] mptcp: pm: only set request_bkup flag when
 sending MP_PRIO
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-mptcp-backup-mpj-v1-3-d45506182a9e@kernel.org>
References: <20240711-mptcp-backup-mpj-v1-0-d45506182a9e@kernel.org>
In-Reply-To: <20240711-mptcp-backup-mpj-v1-0-d45506182a9e@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=780; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=el4qRlSZNNEra5/72bcgxC16DUkc+vjJu9h9eGeb9RA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmj/zIShhjpEYStI3YvQbgQ2nDRsKLCSPsCcZT4
 +lSKoR62HaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZo/8yAAKCRD2t4JPQmmg
 c/tqD/sE1Wn7U3ZVnP5qV/XVMPd6bLivWSfbchsn3MrAKCqIb/zP4G9ThO7C6+SxljMYPly4y4h
 r0NTxlr0CuOGwFLQTauROAeeAtIULnapOeyPdFFtl3L9G+aNSzDdH/NEHpi/pu09E75DoH3+LHM
 hn9vPIHDOJxS3gZ4UQ1du/OkWH/jf0FMRyhznNc+IOT5ppzkae133kAAxeeBeZ5sHVhGdkLOIqx
 UNVEpiUFMxZvnoScF2D6Fzwqhlk+ZxcP82wjjWhDPsdFi4uX5uJLudJdtFt6E5RdYagdG+5mFGG
 3l58n06VBcRxanDzsSLmP0AS3251FvwdZ3WCS9eVRmcIHy+G1bEkPwk90ANa7Glq+rSHjRay0oP
 xik5Vcwt9Y/dvz74W6XsCqO5vhg/SZjtqCIbRoqtAkvuHrf2FpezzaoiTHztdl9ZrSEhdqVLfoZ
 j1pslAde5uDaPriLq8jrskIuQEeKKw/lUTVl8MLVqUZpv3p165umxypKS3XmG5ou54KGg1mbEZ+
 9qXDakzLuIuTWJovbi/8iKBiDQzkOW9mfq3P/72V6SYXhQhf5CQ3LRrFHaQq3xjyUkh1LYHb4x/
 bGnXHKXLRyO/d3PPU1+NhZnPXuWzhJVCWJYQRWmxuEERUMnZ0/f4ZFj8GwGWuRTQa3DzLEUxJ5O
 cYGgMpfcvZrrsYQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The 'backup' flag from mptcp_subflow_context structure is supposed to be
set only when the other peer flagged a subflow as backup, not the
opposite.

Fixes: 067065422fcd ("mptcp: add the outgoing MP_PRIO support")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f65831de5c1a..7635fac91539 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -471,7 +471,6 @@ static void __mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_con
 	slow = lock_sock_fast(ssk);
 	if (prio) {
 		subflow->send_mp_prio = 1;
-		subflow->backup = backup;
 		subflow->request_bkup = backup;
 	}
 

-- 
2.45.2

