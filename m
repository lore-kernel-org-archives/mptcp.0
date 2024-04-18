Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B5C16ABC1
	for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456757; cv=none; b=gdjU0MAbk7O0tF5ZJH7k2N4DioA15PQW3IgIx+axEMkXO2pmOqbvYjpGUbRx5NFwnWHXVfn7mVmp4E2wSby8UHeqahdrZt/oWUs1ptd4dPr5EAQgU3ItQ24dNvobe5rvUAFHfbIsfbMaJ8MPKsOMITVNWXlBzhqDg2N/TfpqIAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456757; c=relaxed/simple;
	bh=moGoG86hLTl5v743Q2wLCEOvtuEzroJiMAIJHdgmBS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fJXWgvGAUcvc+1dD/pdajSLpISUKG+T4aQtzhN0lC10w6F35aQpSsOqD6kKFi9ukxxy+ivs+kpL8IcV9x/HojrPwmWTMcO6fCLnirUDEA49aImFW+OD0ubSXpal0BpQTHK2NmW7gZlu3GFrVTZF+btiWBLL9xSKx/psxQ4GD8kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JinkJkqx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JinkJkqx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1A8C113CC;
	Thu, 18 Apr 2024 16:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713456757;
	bh=moGoG86hLTl5v743Q2wLCEOvtuEzroJiMAIJHdgmBS8=;
	h=From:Date:Subject:To:Cc:From;
	b=JinkJkqxnAwQiXAk+nhEFbA4WYr/0R8NfLeNcQPE+VbVtIXtUXJ9mKdBcU6g/hQGC
	 pyTXZt2KITTDmP1JzhitJoeggsR0iNQL69yYqdQExjUjPkpMCSyMjsfdimRiV4lROa
	 7rkybXNJmvRds6Pxuv6OX51Tg6CKGUA8m7j9ydThGkRYrMUepSkR6SgPuSvep6TNeu
	 DIR4zLhCKl6FOigmaxACRWukQp6NJsx1q/Ar9Na8f+OuN/EEn64xuyYwl2PI8TRhr7
	 qisgQB16+4OGSRkUMJhAqtIVX5rtV3AfgG4fVBL0pj+k7yVv8O0NraI3VSlidtrojK
	 M3dzjZ8zykPaw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Apr 2024 18:12:28 +0200
Subject: [PATCH mptcp-next] mptcp: sockopt: info: stop early if no buffer
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-mptcp-getsockopt-info-opti-v1-1-7138a96eb50c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGtGIWYC/yWMQQqAIBAAvxJ7bqE1oegr0aFsqyVSUYkg+ntSt
 5nDzA2Rg3CErrgh8ClRnM1CZQFmG+3KKHN2UJXSlaYWD5+Mx5VTdGZ3PqHYxWEGQVK1ImqnSVM
 DeeADL3J98x7+zvKVYHieF8lhq6B4AAAA
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1627; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=moGoG86hLTl5v743Q2wLCEOvtuEzroJiMAIJHdgmBS8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmIUZ0XANh5+hheRKOXKtg088mhAXgPGBbwh56D
 zRxr/oys+WJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZiFGdAAKCRD2t4JPQmmg
 c+KuEADd3PlFMc3Lo8Jd4e9HKoOcAprltgRND+bKNLa68WJT1GhyH06zbuKmMCNLsYR8Ie7QYCn
 hN5Bc5t26GUGyezS3olDXTvQvMPT5ogDHTslFTzUw7bHnEOlpxR6OlTKunWIqtxlv5R2RsgjVNx
 G3uYy4F9o3NKZEeO8rWQaYtK/NrAgSdtKidcpkL8OjZnZWU5fS3BoQb+3WMhdbfAO2txskVlWCE
 Ci2yEqqkDO7Yy9iP7uTRiKVKmDb3FxT03+aMWpMRhztAaPl6YeTfszSq+/eTIwGWLLqQIxCOvEk
 Hj24cV4uYkUdRU0HzBxX28cUjaiyTyze2wrjjE1LPfP36FUz2nILvo/9AOZUDQt6E8rlF9V1E2I
 q19CysZmqJMvMfqyfS0svt6DdwMuwDrA1SWLf3/hTMvniDq2oMRalV9L0ueKlOixo6I2H4UVbEH
 dO4lZr84QxRCRsJxrwGlbXnQJjlmEBJTVbhXtsTa2+mY0uG1FKTtGYTFGsr2jWviU8esu4TVcDW
 RPCkMxcnVATviiKI0fg7vJ9OTYWPEGE41kUZ4+Gv35rOolvbW5r9pc2uiO57Z5uqQMjYqzFXacj
 pU7aDUPTMRpNoKZCvpHCrZ2kXeQx9lGlxZGILdk8Cyi58HafrULzrB80Xifo0wnun3XxKokTzK2
 UQhOwJesdeByk7g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Up to recently, it has been recommended to use getsockopt(MPTCP_INFO) on
an 'accept'ed socket, for a server app to check if the client requested
to use MPTCP.

In this case, the userspace app is only interested by the returned value
of the getsocktop() call, and can then give 0 for the option lenght, and
NULL for the buffer address. An easy optimisation is then to stop early,
and avoid filling a local buffer -- which now requires two different
locks -- if it is not needed.

Note that userspace apps should use getsockopt(SO_PROTOCOL) in such case
instead: it looks less like a workaround, and it works with any kernel
versions, while the MPTCP_INFO method requires kernels >= v5.16.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 1fea43f5b6f3..b0d1dc4df0c1 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -960,6 +960,12 @@ static int mptcp_getsockopt_info(struct mptcp_sock *msk, char __user *optval, in
 	if (get_user(len, optlen))
 		return -EFAULT;
 
+	/* Opti when used to check if a fallback to TCP happened on an 'accept'
+	 * socket. Userspace apps should use getsockopt(SO_PROTOCOL) instead.
+	 */
+	if (len == 0)
+		return 0;
+
 	len = min_t(unsigned int, len, sizeof(struct mptcp_info));
 
 	mptcp_diag_fill_info(msk, &m_info);

---
base-commit: 69582b96be671a6d87ab1e96e86c26225f1ec12a
change-id: 20240418-mptcp-getsockopt-info-opti-1232118bb417

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

