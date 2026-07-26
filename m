Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48381E4BE
	for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785055442; cv=none; b=HeQBN8ek82PRxGkOD72V4aWFN0D7DmvCiBNbJl3YMh4U5Vanwe7lcUZI8B3IjTX9tYPttj5kkiW/62cXjax/OPfJCHeNERbIO70Y3UXA3Lku5cik5f8RxQ/HfVxA4qVQOj+7vKkjD9Ic9lBrvq4cAqyObOSBmbEDj21Pr33rMq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785055442; c=relaxed/simple;
	bh=VWnl9tXEVCx1Bqkhm0JTrDCOofPtTlO4d0/wdbJAF/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AykiC1zBSdF4UdbaYq2kYGEVSOBJo/n2JiI9U7rPKiRTnWZraXVA2agYsNpaLPHdhi9zdSlfxY+9bVKIMEaJKOdWM4TWPNT5AFbyRFZR0n5yKb6ftd+9er3fINg+7ef1rMUd0qIsxY60cLNq3r1qld/ixGYY21Yd661eVgj2j+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtw4j0P5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtw4j0P5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EB21F00A3A;
	Sun, 26 Jul 2026 08:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785055441;
	bh=pBHOcvVQYqhwDeKM+joklINVvMONYLtj+TdMspLA5vE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jtw4j0P5UU8y060cwQD3WImXTWFHyd2kbfBM0WorVW5yM7fzju0CTrZZsoD/Eg2Gf
	 PWnKNrmawaQvjCuQtvFbXbcJ7PKc2lupq5bN26GRNkAF1wx/H3ZBg4k1bLWIYyo6fY
	 yrCEb3g4NTg88mxdhFAvXoPY6NanaeVU1J4EKjh3OoXih6OByv9rET/LriUiPV74ez
	 YyduWVz3VNSKhnqWDOjZ809JgipFSx1wHya0/Epxu1/C9OWR85ZnekTRpUkO7LOY8G
	 97BnJg2wCXKyhrfwyDLGzAL3WjfOeerAzn93aXgygnlcuSiQ3zykv7LGIle5YlNPmW
	 CPHCQzGj620xQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 4/5] mptcp: handle TCP_MAXSEG getsockopt in common case
Date: Sun, 26 Jul 2026 16:43:43 +0800
Message-ID: <3b1dc667970694cd28872829e7643e796913568b.1785054808.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785054808.git.tanggeliang@kylinos.cn>
References: <cover.1785054808.git.tanggeliang@kylinos.cn>
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
index 37e65923f544..34f6cd9c7967 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1425,6 +1425,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_FASTOPEN_CONNECT:
 	case TCP_FASTOPEN_KEY:
 	case TCP_FASTOPEN_NO_COOKIE:
+	case TCP_MAXSEG:
 		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
 						      optval, optlen);
 	case TCP_INQ:
@@ -1449,9 +1450,6 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
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

