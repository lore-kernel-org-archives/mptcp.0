Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234DC37E5F2
	for <mptcp@lists.linux.dev>; Sat,  8 Aug 2026 03:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786160481; cv=none; b=b2pqFwniqZYXmIjUOZONklzf3P2jaKzPioX5z2PIAhyK0i1OZtbwx0S+u6/m+rh2hFgf8O6AIPUZ/TEr7iap81DizKWnlOWGqG617295gNlSk5RVVFHB/LtHL195pWsB8y5SczgcC3P0V2Y7+Ke/RDwjFuG15bUAXEN9fLIFGmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786160481; c=relaxed/simple;
	bh=12+apjuioBC8N62eTgEHwNuUizgwxX00zkAyPACTVRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4SpiDHZHIUnFntcaV1vVblIfo5D19va5kziYSaaIjRD0TcH/5W64u807EFqZP+X9l2CwkEKTPJFQKN+wwy0ypaWmcOmLjmisfT58hoUa244L2D2rhMI/fIju8AnStnr6UJf2h5HThidRGp1hx/7IujgIhhhedZZg4M5CV1zuPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0IAib7+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0IAib7+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972481F000E9;
	Sat,  8 Aug 2026 03:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786160479;
	bh=HSIVj8uxv01MAdlABgCTwQ/hQsJ3+MOdestkgSTkj7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h0IAib7+ExmPfq0f2AWWAYOUqhlJvZ+Dm+43bUrKBIkXaTj9vK3seB499MYrFKOX6
	 EW5FY1bxkGudF0ZxmpUEFTAYFsILJcH9EhsN9ITsA3Oz6Uv8DhrCnt5jIlMQnyYyTc
	 XQCWijLHt3D5U7TmyuKyRKI/il1VwFDWPeB+qNrUtXOJUH5M2QvLMjjmOm+czCS3vo
	 ZzZxyDQnT4sPIS6EoI0yM6Bby5vgfPshzkXXyXe3ZnidvE0fXWAKSaZJYIsExC35yx
	 ctJBqHi5bHMcsii8JxvHLJv4njfFll+H1sVg7v/q/5GG2gYOcNXEuPSTLutLnCjfk6
	 9RHDUlMjREdbA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v5 02/11] mptcp: take TCP_MAXSEG handling into setsockopt_set_val
Date: Sat,  8 Aug 2026 11:40:32 +0800
Message-ID: <7098d1c0ba657fd29963f0a5bc1e4931875494bf.1786159812.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786159812.git.tanggeliang@kylinos.cn>
References: <cover.1786159812.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

Replace mptcp_setsockopt_all_sf() with __mptcp_setsockopt_set_val()
for TCP_MAXSEG option handling. This aligns the implementation with
other socket options that use the same helper and simplifies the code.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/sockopt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 2c1eaf66202a..5de371e29721 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -968,9 +968,9 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 						 val);
 		break;
 	case TCP_MAXSEG:
-		msk->maxseg = val;
-		ret = mptcp_setsockopt_all_sf(msk, SOL_TCP, optname, optval,
-					      optlen);
+		ret = __mptcp_setsockopt_set_val(msk, MAX_TCP_WINDOW,
+						 &tcp_sock_set_maxseg,
+						 &msk->maxseg, val);
 		break;
 	default:
 		ret = -ENOPROTOOPT;
-- 
2.53.0

