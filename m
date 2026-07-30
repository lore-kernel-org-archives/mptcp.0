Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE533769FD
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 02:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380059; cv=none; b=A3WAbai6r2qU0CX7SBWAUO6aAKD/2sVipYMxRNS1+s5060KGYuDwXsd7dmz/rPQd1F7SqOdI6gK/0CaBOHRwWAZe0J+SYHc+H4tA4iKeewiaHCnxxotCVkbP5zWTij2WvPUN2drcZ8JZc489ZEu7L4+j/H7uEdXCRxf7Su87NKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380059; c=relaxed/simple;
	bh=kk0D3Cu9w0/3UuowOtQsb7momeqoPNl2h1YDokcuBlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSBkQputXz5sEQ0yjLGYhlDu61Zmr/JPgtaSo6reH+e1Q98wTcV3aKGhVRbvFkJICKAr9YFeW8bf5CJu6rLJw7N3Xcjq1vi84ebUXs2Nf8+0IIATsOoxFRqlOoJhvPVNaVhl+y90UOlgqF1Xyu4z6qsNhRzl4O+v44zPukpQ7Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBU4P58l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBU4P58l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3641A1F00A3A;
	Thu, 30 Jul 2026 02:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785380058;
	bh=E1ea4hOszjWN+JFqnbAEFVGA8MgKCluidESeC82tVFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZBU4P58lPeT3HDjLdD1XCd7vncVUfd36lEhCJCKZsZeL/Yh0fs7F3VwyqHWKmaYTN
	 /EB9/E1SRI0KQVOXPco22Ki4+0nM+8CG2iSA9zDoA8lfTItcRLbt7wDJNv1xFv35jk
	 b7DicVtWFFXhq4BtN5o7Dy3qyi6t1NXW6RwVLAqLdDKBLBSfp1Ds2dm1IV4vT7YU4l
	 J3jAsks/1n/A23OatgmiWKvrk/3DrBauQCDWnMIxxsRpCvivxftZLh+U3Tq3qwRZc+
	 WDzBcD89SGE4a9LWoCadFMrLEsWxbOPKdgcFVKiyRH0Lo1gHW8Kym/4Af2h/5obPYp
	 CBPALlR6XZ9ZQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 03/10] mptcp: handle TCP_MAXSEG getsockopt in common case
Date: Thu, 30 Jul 2026 10:53:56 +0800
Message-ID: <bbfa975b1699a11633d6325e6c6f3687b7fb05fd.1785378180.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785378180.git.tanggeliang@kylinos.cn>
References: <cover.1785378180.git.tanggeliang@kylinos.cn>
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

