Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365EF31282E
	for <mptcp@lists.linux.dev>; Fri, 12 Sep 2025 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686850; cv=none; b=hAznPSrbWLe2Fvaqlgf6d5KKHflSzHM8Dik0nkdR79Cq0Zc1majh/G7TK/QZ2eUq7MJo9HHKd6xWVd8yPGJgmfeQpLYBcU0NI1LFrn1KQK4eSooBYtuz04z7VR1IXQGJPgUV8VKkwVDGLU7cGu8fTStg/q8G9EWaQDJgOVjzso0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686850; c=relaxed/simple;
	bh=dLbxOzixE6Z6pyxUAfcPVjvDp+p5KIIzCtkK8diuUEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ka+38r4rm8cDudyDW93WL//GVwiUAaXO4pEqptwc9fBXi8G+ct6Gtst45oADqAKPyqcU3JORkOJW7FBmsOcSrt9tlemaFlRgscRpzuxY8EnwmHvcamTDf1K1k90I+9wGF+5pRVjbsO3HxaTbCvnC2iBYkBhueJiHEl5XelTDDF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1RCC7/f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1RCC7/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01716C4CEF4;
	Fri, 12 Sep 2025 14:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757686849;
	bh=dLbxOzixE6Z6pyxUAfcPVjvDp+p5KIIzCtkK8diuUEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y1RCC7/fpBKSqmiokVn2e6It+C2OtpftPyIXByiQWdjlaRaB7LgTx8fluGfGWORj2
	 mXOY9sfiFn5D8M6qKtgsKQciGqcoZdNsJXgsFO/Lz+B7GD6stG1153EvNHSvKy/aR2
	 3IzLkqYLaPAnTH4ozSOLcY1++BHfgu50qdYbD4yhAfrqL6wBOOGbuZ5aNm4G9sQhID
	 DAq+OFpE1qqmCxEVK5CcdxPMYNI4ehvQIgTkSv+hFtz8Dmy46Zl0Jtnw5l6lu+1CbY
	 jHwYkH2XwyRkog1zHr2+8ZIngdJp8yl6Bq/wwWvgVs60j9DHeeSOQIX9yt+yOpWHWZ
	 NwV1Vgli148MA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 5/9] selftests: mptcp: sockopt: set TCP_INQ sockopt
Date: Fri, 12 Sep 2025 22:19:52 +0800
Message-ID: <0281880585ac76bb8efe55c9b1c42ba5a81fb314.1757686538.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1757686538.git.tanggeliang@kylinos.cn>
References: <cover.1757686538.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add a helper to conditionally set TCP_INQ sockopt on accepted sockets
when running in inq mode. This ensures proper testing of TCP_CM_INQ
functionality by enabling the required socket option on both ends of
the connection. This setup is necessary for validating TCP_CM_INQ
behavior during TCP_INQ-specific tests.

These codes are from mptcp_inq.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 776a017577ce..aadef8b0aea4 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -726,6 +726,14 @@ static int xaccept(int s)
 	return fd;
 }
 
+static void do_setsockopt_inq(int fd)
+{
+	int on = 1;
+
+	if (-1 == setsockopt(fd, IPPROTO_TCP, TCP_INQ, &on, sizeof(on)))
+		die_perror("setsockopt(TCP_INQ)");
+}
+
 static int server(int ipcfd)
 {
 	int fd = -1, r;
@@ -748,6 +756,9 @@ static int server(int ipcfd)
 	alarm(15);
 	r = xaccept(fd);
 
+	if (inq)
+		do_setsockopt_inq(r);
+
 	process_one_client(r, ipcfd);
 
 	close(fd);
-- 
2.48.1

