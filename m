Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3BD3AD512
	for <mptcp@lists.linux.dev>; Tue, 28 Jul 2026 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238817; cv=none; b=aS7xOwHLxHandY/GiXiC2eLz935VDg6RL2n1pACWnuu0lxUFUT8Tn/MRA+QNiYR3yYP3uQEQVz/g3OOrspYGeQIqbqpxR1xlSbcSi1TzZ85N9aFZ5lrXYoscwJlXstsM7rjALjWLIJxRFolzh+XN8Q94b7LtIRFcpmZQv1EIi70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238817; c=relaxed/simple;
	bh=kk0D3Cu9w0/3UuowOtQsb7momeqoPNl2h1YDokcuBlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fcdv9r9NpS391VMl9xeEbDsfFA8ZikeCT5g4FBiL6jnoiThD2tzDUuir9EQnFpsxm3wxNvqVTx9fLn9myzZmLOVQsHD67hSOV+aRKHRd01wZkxbx92wSUvcqfPKY1zQg3m+NADgTbKW2+O7ovfiumU42Q0MIwSiIY2PErw86GaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaFg4tJU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaFg4tJU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE90E1F000E9;
	Tue, 28 Jul 2026 11:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785238815;
	bh=E1ea4hOszjWN+JFqnbAEFVGA8MgKCluidESeC82tVFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QaFg4tJUS32FhWmaImfVdM6Vf7yT2tESb67kaK2sg5BopejUxS9EChXMb7pZFnojq
	 Cs98RexVuwLFmoNinkdyway/XDUtvfhtE1nhuojH19sLEeFKgwBQCdEO2I6/PJoeLu
	 brxcLRyB075OsCRB5gmmoCGqjRRYeGaZ0l7ULyp/9ZtmQxQue9X0/OfiSREhZD4Xsq
	 OyFQ0CJ4c0p6tuJWoCf9Hy0W6Nw7iWb64jC9E20NjmB06YnLbHmC2LZ/nxOA01R9/W
	 UsotBlmYLZQljP5gu53c3mgPg2/EUdQj/u+wWrVl2BL6j6ABnK6MCQJNBdpNSwXUBw
	 cU3R77ywuJOdw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/9] mptcp: handle TCP_MAXSEG getsockopt in common case
Date: Tue, 28 Jul 2026 19:39:35 +0800
Message-ID: <7de71aa6c2a057b05a5d3e7f30dc73177af0592a.1785238723.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785238723.git.tanggeliang@kylinos.cn>
References: <cover.1785238723.git.tanggeliang@kylinos.cn>
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

