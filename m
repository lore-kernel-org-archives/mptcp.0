Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD252E8DE3
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 03:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786939044; cv=none; b=KgdSXJ1uuvYWsL7T8sNNKTbD+HdNvt1LekZEwOMzmh3RG70ElF+KIq7fp4WrGOXd9qfaDWUYWHiZf/ttGHN9kpKYvx4gPCU9nhVOabhJD08vEzgt6sgXTg9kUOnewpOjvt4NAeG8SLWP7xOLycmGzIIUtGpT5qlLSNZ1LekIZQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786939044; c=relaxed/simple;
	bh=12+apjuioBC8N62eTgEHwNuUizgwxX00zkAyPACTVRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDpkB3iZU60miz5h8wftEsmaskfeD3juTBsXLSysSjFhab2+9dn/4foyoNg7ZRb4mXXiPyt/hNc28izjtEW5G0DcaA2bWMKAEZ5JfhzoTloT2eDa9CI7vq7vSPhCGU4YKnBnKYKH9n/FPyNku+JrdVlAeSmj93euP/dEWiVVz4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMYCtC0a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMYCtC0a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358211F00A3A;
	Mon, 17 Aug 2026 03:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786939043;
	bh=HSIVj8uxv01MAdlABgCTwQ/hQsJ3+MOdestkgSTkj7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CMYCtC0a4dfBIIVmNJAuWdr2Fi+UJRpLe0sCxOGRe8Sp6X+wo700eZha2vTKuTHed
	 kMx21M6vha6mrKKdlADJJpExu2KjgwKsWxZ2I3EXwkAspT7mdwUHV5i9o2YvbpDkKD
	 A2hqWCdpkd2U7VCS5jrl9UeW9ezWBfC3jAUf+qLw3HJ59uvBFh45lSNpJ+oOtudda9
	 qWlIHNQq5EE4+om3q3A8Rh930Tzq4/26AJwc1Z18ZjqKrqkxvFtfvk0VMVc5HtS/AP
	 1qtmshJE1Z6+0LNDcBRvqqjgeogAbvVtlUScOv6lyBOTPNuyfU7EVp4bDNbI6soP+B
	 eDwjDiHCEbxTg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v6 2/6] mptcp: take TCP_MAXSEG handling into setsockopt_set_val
Date: Mon, 17 Aug 2026 11:57:09 +0800
Message-ID: <24bc4215f264b6800070d5b7e75553b2c7e79da9.1786938892.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786938892.git.tanggeliang@kylinos.cn>
References: <cover.1786938892.git.tanggeliang@kylinos.cn>
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

