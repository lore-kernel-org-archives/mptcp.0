Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B3F37E5F2
	for <mptcp@lists.linux.dev>; Sat,  8 Aug 2026 03:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786160479; cv=none; b=keQ1VtZw6z5bM5BRji9fZBNkATQFlIsuCwwoc/NMe93buWMd+4RtQJbCAo1JqYR/U4WJf2B9GskBMETHY9UzSmosf02SiZ1twtrltXXwjshadIFaRywaiV8sLiNuQzn1lGdiDacAOFPwQigH7VetMLRfGycN/e5FaNVjrB1nVbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786160479; c=relaxed/simple;
	bh=Lo/luMwGvhUXzB0lM5mpPl2mhqNVI54+T8/eMm3zDA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIYYViz6lBKPyp7yf3SnaxohWf7hE3uGyLHp3hav9IEP9JvUdHxbJo1eaP02DtoWrIZmoQQtS6Aji5NenX70EycIQ+fR9Xa4plWW/qgVEQ5tZLSRVBHYKA64uiB1nAtpsy1JOq4cTxKSmgJ+n5ZifZWcQBVdDQh1xAR864i5c0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PI0+02Ev; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PI0+02Ev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE441F00A3A;
	Sat,  8 Aug 2026 03:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786160478;
	bh=vO8H1WhN7OHYWalQwbdJxYUxmWafoBJbqxlYf63qE8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PI0+02EvRzvL/AuEfSh50KfFArpsyZABH/KkxmE9EGVGPItjRtQaxVDIMctsOv+Sg
	 ebeDzcMWDu1sfYCgzpj8RE9to/RGef/tBfrbX4JQs8TyYp2Nu/lZu2C+uW08fCT8R/
	 es3SS9T9looNXnTfxEI4ajiKpJmp4A7cuwBgpscBKNDcYY3eP0vKx9KXPh2ZdZTyl2
	 Tw2QH8y3KOYNMftMO1A+aGB4CImEIyt0xLWa3MXPWWshiyf6PPdfcXK+9g0Xp0Q4BW
	 eLlN8z2rajxqa1vYE6u4FZVCRc+ZkWYjuYI6tQhxzfdcCOVbL4ODbL2T9hC8aCTmkn
	 fLIwMnBxM6LFA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 01/11] mptcp: handle TCP_MAXSEG getsockopt in common case
Date: Sat,  8 Aug 2026 11:40:31 +0800
Message-ID: <657c875f689e7d3249f0cdcfa6a840fa026ffc4d.1786159812.git.tanggeliang@kylinos.cn>
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

From: Geliang Tang <tanggeliang@kylinos.cn>

Move TCP_MAXSEG from a tail-clause into the common case alongside other
"first subflow only" options (TCP_FASTOPEN_*), making the dispatch logic
more uniform.

No behavioural change.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 922f6ae5c80c..2c1eaf66202a 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1499,6 +1499,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_FASTOPEN_CONNECT:
 	case TCP_FASTOPEN_KEY:
 	case TCP_FASTOPEN_NO_COOKIE:
+	case TCP_MAXSEG:
 		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
 						      optval, optlen);
 	case TCP_INQ:
@@ -1523,9 +1524,6 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
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

