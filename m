Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE7D2459DD
	for <mptcp@lists.linux.dev>; Sat, 25 Jul 2026 13:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784985257; cv=none; b=YMMiIIoGdMSYXWi76ObpgdRc4+z4VCc3V5/oaz0pBoiL7behErIuyEaH7KulmCqeuh2Na7ssTsLhtYf5dyo97mqFtJqQvTKeFAAVxzklmM7YfjvneBrovEst7RysWto1cOfdrDFQkKNbFEZWD4RuGzGm04nqwJzsK+wkZ8LAXx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784985257; c=relaxed/simple;
	bh=YOM5MjXboZK1nLzWp3OsjphcndpHvkkZZUgVWgt1nBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feyQnq888WWUQhnrXmVEKjAk8vue8TnM+R5iRJJNnuATUpZpn6BghxYJuLxjBkL+rSohfBaXkfetxeYkJP5zYJ2fe14+eShw0p6C/8gvC+FodUGWWf2LG25z7y9S62R4mgcjBcL7izWtkXE+R8iXx6MepN/b8Er2tMXdtRZbMAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOrorQsn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOrorQsn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6581B1F000E9;
	Sat, 25 Jul 2026 13:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784985255;
	bh=Cl9pTw0HjAbY0gvvuGYcQeZqNEak9Xi4elcNPT35Efs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nOrorQsnAY/3DBX8lMs6Qdv7QWndTrjmL98Q2yPTZVBS7llIQSu2S1FIiZa2WCkmY
	 FN+uEI/TBRddCeFhR9tKgmbWtTRGM87fNq0gOEe0TohmeRlPTBMJu9gpgpSczo+QfD
	 f/GjgNvjdXEuA4XIGYLDr4bxflm4MWObcdHy/qC2HHWlIWChppP4PzKgVs9gZCbIs4
	 lD89ujTBYwT2KizlWobD42hALrZOLaQ/TpoRoEVZPk1gvrV+/v4850QKdtLfVxcYhq
	 AMbx+E6hGFs57RI8ZImJXvtSlwxZ/36Ro+HuEXC1oUZZkdRu6b0XUfhCJXLrjO/zdM
	 oPCOtBuemEmUQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 4/6] mptcp: handle TCP_MAXSEG getsockopt in common case
Date: Sat, 25 Jul 2026 21:13:41 +0800
Message-ID: <ebade3eaaf58fafb9e54e644e5eb8f29d2af533f.1784985085.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784985085.git.tanggeliang@kylinos.cn>
References: <cover.1784985085.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The TCP_MAXSEG getsockopt() case was a tail-clause returning
mptcp_getsockopt_first_sf_only() while every other "first subflow
only" option (TCP_FASTOPEN_*) was already grouped in the common
case. Move it next to its peers so the dispatch reads uniformly.

No behavioural change; the lookup still returns the cached MSS
on the first subflow.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 594ce3b4b707..e40a5a23d1c9 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1424,6 +1424,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_FASTOPEN_CONNECT:
 	case TCP_FASTOPEN_KEY:
 	case TCP_FASTOPEN_NO_COOKIE:
+	case TCP_MAXSEG:
 		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
 						      optval, optlen);
 	case TCP_INQ:
@@ -1448,9 +1449,6 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return mptcp_put_int_option(msk, optval, optlen, msk->notsent_lowat);
 	case TCP_IS_MPTCP:
 		return mptcp_put_int_option(msk, optval, optlen, 1);
-	case TCP_MAXSEG:
-		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
-						      optval, optlen);
 	}
 	return -EOPNOTSUPP;
 }
-- 
2.53.0

