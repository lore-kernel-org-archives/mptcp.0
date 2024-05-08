Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BBE548F1
	for <mptcp@lists.linux.dev>; Wed,  8 May 2024 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161503; cv=none; b=upEfmEKA10XB9L3kflmCl4AGunDKEK815uI0++twHp15bNq3cxM7XAek6vkEPCigQHUiaDFTm423utf8HYI/ciK5KIEdMQvJ/BnoRytx8Zq69ezDSzn+NJkc14q0w8tFh0JzafLMj+KT6CBVfGZDdc7VhUc5s+zYE7a4Yzvq+YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161503; c=relaxed/simple;
	bh=l3MdJu72Q019WCRCg5hsxvWTYaRFlkaSPHG4yOfbwFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=By2BNLe5IzO6ThGCpdKdnZgAd0QMIgAFyyv6z0+Q/peINjchJFDHvW/xplAKjR9rtX0VUOrt5oPADlOwdzlhiuQY548/W3AUKnTPNW5q4509ZiUvNcgJFOR37vHlrkpMV617AYb9fEvIIh59DHRsPZNv1R178PmINJQF5jho+Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ypzb4WeS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ypzb4WeS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E1FC4AF17;
	Wed,  8 May 2024 09:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715161502;
	bh=l3MdJu72Q019WCRCg5hsxvWTYaRFlkaSPHG4yOfbwFc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ypzb4WeSh85aD+1zQG1ywWK7YP6G7b85iE/YMrfyoOxjbsiYukELOEx4FMnaExFCP
	 ShZ+fA14vf/hhdMNKzAJ7KC73IFzf96pGCFn/dACBnPVcDVN0TrFAwCiRXgMD3Y4Ji
	 A6g7gVs5IrftRDe53UFV1Rl334lSIzXISisE8+1B3kpzy3N3+EX/g6XSfqwZqrb7gW
	 XhycXeqC8wKO1nIqAfIURjZRsarHBJpiSk38zJ+P+AsjNWo7y+fpv49dfrWBPqF4Q/
	 oSlO/yI3Ww+Oz9SGlxfhbnbFtllPXzicHTsRoDS7rWHcHtpGUQ4IR5K/TA/JIOaaQH
	 lTusfiBg3w+rg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 08 May 2024 11:44:55 +0200
Subject: [PATCH mptcp-net 1/2] mptcp: SO_KEEPALIVE: fix getsockopt support
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-mptcp-tcp-keepalive-sockopts-v1-1-fdf7e03e14c4@kernel.org>
References: <20240508-mptcp-tcp-keepalive-sockopts-v1-0-fdf7e03e14c4@kernel.org>
In-Reply-To: <20240508-mptcp-tcp-keepalive-sockopts-v1-0-fdf7e03e14c4@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1455; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=l3MdJu72Q019WCRCg5hsxvWTYaRFlkaSPHG4yOfbwFc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmO0mcDO0nMyetySLSFeDRZDUQLlcqX3LF8QU9R
 WvEQ4sBj/KJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZjtJnAAKCRD2t4JPQmmg
 c47ZEAC//EksaT5LX841RO1SnEM2X4hY0cxxeGHCQVE4PGRWpVqVi/PR6HErM8P2JczOqWQwlPi
 f+0FgY5NQh/R62gyU4bdO+kTTben+vz08SuMWcpIWX/o7yxd15Pt1RL6EmDduGQ/L1DpS2DeByk
 LSXzz8BEgNOH1vaGWTpZvi+M5FBfcwXHpXRT1M4wmDUQGevOuHufrUlbQYdByEEcK3IAuQH+SXu
 LYp2cyXNlVgZC7tdOSim9SKYx6BRuFYw9XT5HZFDgc8bx7h7/wZRVePFLWeVjFRCEIla22wWDpu
 413KhEOUyMibERKBYSVy+DSEoxghHp8PQFCGtiwv57Qsqde9WL5KrBkc04FDuCk3jDneHRrhXij
 8y3RIKEgjkRbFJCh+HhlubzPFsmvTDBaAt3VBtykNzJM4RiPBlifxlKr8squVpq+gkscYHQCw0z
 WwCo8eMzujWeXKVwtM7OYlnLSmoEcBI2ceIDME6NXjjHlFyjWAFKRPvseijL/pOt8stQ4PORLoL
 vaeqNq4C78EzG6UO9ESdvB1AolXHejwrp51wyi4Rmigv9plDxZvBdvQ+ldC34wQxqrFueHZkXvB
 PqgkLr1LZt6yv5oDOkYelDyz2l8QL1s9gbTJYdDBIkeyqHXGMHDKBzu5EvXRyq4JfJ6dIdetm7L
 DcykuQcvEigS54A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

SO_KEEPALIVE support has to be set on each subflow: on each TCP socket,
where sk_prot->keepalive is defined. Technically, nothing has to be done
on the MPTCP socket. That's why mptcp_sol_socket_sync_intval() was
called instead of mptcp_sol_socket_intval().

Except that when nothing is done on the MPTCP socket, the
getsockopt(SO_KEEPALIVE), handled in net/core/sock.c:sk_getsockopt(),
will not know if SO_KEEPALIVE has been set on the different subflows or
not.

The fix is simple: simply call mptcp_sol_socket_intval() which will end
up calling net/core/sock.c:sk_setsockopt() where the SOCK_KEEPOPEN flag
will be set, the one used in sk_getsockopt().

So now, getsockopt(SO_KEEPALIVE) on an MPTCP socket will return the same
value as the one previously set with setsockopt(SO_KEEPALIVE).

Fixes: 1b3e7ede1365 ("mptcp: setsockopt: handle SO_KEEPALIVE and SO_PRIORITY")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 2edaf1a16005..d9f0d36e24ad 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -181,8 +181,6 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case SO_KEEPALIVE:
-		mptcp_sol_socket_sync_intval(msk, optname, val);
-		return 0;
 	case SO_DEBUG:
 	case SO_MARK:
 	case SO_PRIORITY:

-- 
2.43.0

