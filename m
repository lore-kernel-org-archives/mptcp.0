Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8D61B0435
	for <mptcp@lists.linux.dev>; Thu, 24 Apr 2025 07:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745478837; cv=none; b=CBxoMyqJ45/DxekHJmn184+B14unSGSucE0G++8LOjvwaMhjMjx5oZGNa87Qc1YoPzjlrfGpvc/BbMUBlyvml6cNf2XxvtB0b9iNubrTe79oLWAW8OnWVfo5zQIbjlePXjvF4rryoimH6ylfZ3c8042xMsvrJUXQbL9qKFcpF24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745478837; c=relaxed/simple;
	bh=XbcgEnfhXlHpkqrFi24Q/gauMD/Ia1DjUzvzGWOIXSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oht04pZ+fxIdV2wGQu82+9z3P7lz457c8iOZfEqJvQ8/YjroB/P+Z2rFE5ophS+Rfq3atI8ZdC3ome279vctrDMTyUtrvHNgRjn9odNh6qDsfffP/MtDJiB/zlfpfBhydxL1t4g5z+t7mnL6E5HWu5EYBonGRTpjJuC0x3Gpl0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzvI2Kdx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzvI2Kdx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893FBC4CEE3;
	Thu, 24 Apr 2025 07:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745478836;
	bh=XbcgEnfhXlHpkqrFi24Q/gauMD/Ia1DjUzvzGWOIXSo=;
	h=From:To:Cc:Subject:Date:From;
	b=IzvI2KdxIB5hj78VkX1Ht+uqTYtsX5Vfc9cAofQTkg/h92pOsUcbhqIRMfqatVghx
	 FBLqwOWdTb7Uo9mll69lqbJMsA7NgtKdVUDVj3L6wNY3vor7JnVaVq8rWfuIgzoaAj
	 wXOZdDbgW+ZBs+VHhF+qgQXdngsDAGdRAjFyhTsRBlL/E6haytFYczQ+qFEQfqltle
	 HhBedfRExorZWcXGbn+GUttDfs74tzmncxWDklXpsnqt8xxqWtK3qUB3Ui8bZDw6c9
	 RO51cT0w2sFFkrnlro+Bt73+ibNfokTCAvzPDKHqNtM81VxRK5jSYaEQtSy/d8Mr8t
	 Ad/orWZmrZmHg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] mptcp: sockopt: drop redundant tcp_getsockopt
Date: Thu, 24 Apr 2025 15:13:14 +0800
Message-ID: <2fffe8798ad6d171110d5677b02579dab9f4cecc.1745478757.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

tcp_getsockopt() is called twice in mptcp_getsockopt_first_sf_only(), which
makes the code a bit redundant. The first call to tcp_getsockopt() when the
first subflow exists can be replaced by going to a new label "get" before
the second call.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 3caa0a9d3b38..afa54fba51e2 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -914,10 +914,8 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 
 	lock_sock(sk);
 	ssk = msk->first;
-	if (ssk) {
-		ret = tcp_getsockopt(ssk, level, optname, optval, optlen);
-		goto out;
-	}
+	if (ssk)
+		goto get;
 
 	ssk = __mptcp_nmpc_sk(msk);
 	if (IS_ERR(ssk)) {
@@ -925,6 +923,7 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 		goto out;
 	}
 
+get:
 	ret = tcp_getsockopt(ssk, level, optname, optval, optlen);
 
 out:
-- 
2.43.0

