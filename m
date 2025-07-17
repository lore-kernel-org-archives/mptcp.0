Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D779383
	for <mptcp@lists.linux.dev>; Thu, 17 Jul 2025 02:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752717917; cv=none; b=I3UGnkXa6X1PuUTzOWr/mBgP7gE5gpl/L1zY2jakK/uWETWp6Aqch6YVm/u0HRhUeX8dQHnC90BRrp+q40ZzQ3nF3Mtumersl6L+oqAIgfudvBY/qvss3VxVYzc3ajddSsftpZJyUMFp2XfJIz2k3EY+b8QdZTnF9JO7QnBIZZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752717917; c=relaxed/simple;
	bh=db7SWR/v9PLgR2dMzZKyogv75Tf80/EtOGZbAj25BR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jq4ioRZ3SzTqulmDCT0zNP5PY0SDBT4+/KUITR6pRHIWT88hGrOqrx3N4hpxNmUhLkihX/vAUeKV4uDZ6TUT93vMN4e1aWDsukGWAvUqeDym7BDfhjNFMetU3KFMvWPM62u0w2WHENsUspJrNxYvVELI8lhDH3qgFLaZolRGDj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQR4Rx5z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQR4Rx5z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386B6C4CEE7;
	Thu, 17 Jul 2025 02:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752717916;
	bh=db7SWR/v9PLgR2dMzZKyogv75Tf80/EtOGZbAj25BR0=;
	h=From:To:Cc:Subject:Date:From;
	b=LQR4Rx5z/hC7J0a7LaRidCuo534piTF3+pw01/vOkKvo6AfugJ0Kn/YTtWC7LwuFy
	 0tgZfeTZLxYM+x1AOdCOjpIeks8HqxfLuV3YI/y+5yOtkwGGYRI6TUXAFeugYNeU7+
	 mpUTlK2S2B6WTTbbc7wklGDgaZWAQDfs8LxHtYbiPGC55rJWFzORPeGnoudVp7IVNQ
	 eXZJRWKhb/3rMvg+2sMURHTGr2hRyw9yMvQHZSrT6obhJKByRtVVG6+wEcCXzlvzkv
	 Lvv/nSEGXxHPaJuNQG6N0lpwhtsRRGXrxeBF+Sq/Xz0Rxgi7eMJX9+fTqkO6vYwtTE
	 1NrwF1oRcUVYA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "mptcp: add TCP_MAXSEG sockopt support"
Date: Thu, 17 Jul 2025 10:05:11 +0800
Message-ID: <ba6be90c7ee54384bc8e3ee5b35e3b0166d03aff.1752717857.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

A cleanup for mptcp_setsockopt_all_sf(), to make it return once only.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 379a02a46b7b..2c267aff95be 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -803,16 +803,16 @@ static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
 				   unsigned int optlen)
 {
 	struct mptcp_subflow_context *subflow;
+	int ret = 0;
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		int ret = 0;
 
 		ret = tcp_setsockopt(ssk, level, optname, optval, optlen);
 		if (ret)
-			return ret;
+			break;
 	}
-	return 0;
+	return ret;
 }
 
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
-- 
2.48.1

