Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8862222C5
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773738830; cv=none; b=cLFtUCetExixQroRLINkClogCtICOOe+v3SWEBtjXBO2jgJkXbR4eKgkvIrLG4HyP2dhdJiBYoARwm6KgNgVfPK+qvWqA6JUR85I2Hw2MlrYN6DU1DRaiqUPg7I1jZrqr16pvTOqRGo6tXAkDd6Je2mXqdIi1xy3qd4p4j1ZCpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773738830; c=relaxed/simple;
	bh=/LebqvnknnL06basaKBFF0yShgEpaL6raWlnbLgcSj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ts0g/HEgh0xev0DaAGeB8MyTxJoOBRldLXLJ5ahkDicGtx1QGR4rz9BWw8YcyLzsbi1xxABursvrr57Ov+Qxs/tzjEn7cGMAs/WormYGNrF9ZcLLqg7ONnXx/IaMjyCnoxpWXFl5mgUBpitA2GF0snBmrbJ1NGhtNeC7MwFh6Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWbG4r8G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWbG4r8G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC901C19425;
	Tue, 17 Mar 2026 09:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773738829;
	bh=/LebqvnknnL06basaKBFF0yShgEpaL6raWlnbLgcSj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sWbG4r8GWzrH+nR464Jzkf2vrD8ELnDD3SNApWycjQRl69lPJchGt79+pcXr60C93
	 ETQuYTRzBIp3KWEGcofJkzRYHUAy2XvXcXw6tSn/50v0xkHaTwnNAYFnD7IWLMOqjO
	 t1vj3//bYLbF/W86EJ5QgP+P3lU3h2+TIRQFz5DVH/bf6Zg0QJZdgvcQN/kVBNxZhZ
	 ajkqZTkfdmbhhr0UOhEIrtBiQUCXT1fOSUmgarejgBOgj7LRzn9PazdcY3F/MQrc5r
	 S2eGfoMWYX55enEETtEjMJZYmw6g12iCOPjxJY3PSgBR9+iVHg+sCm8FuO4xo8eRsf
	 iZDOWSPRyppXg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v10 10/14] selftests: mptcp: connect: use espintcp for ULP test
Date: Tue, 17 Mar 2026 17:12:46 +0800
Message-ID: <c07cf621c996c5ef73dbd1b7102b49edb6f60289.1773737371.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773737371.git.tanggeliang@kylinos.cn>
References: <cover.1773737371.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

With KTLS being implemented, "tls" should no longer be used in
sock_test_tcpulp(), it breaks mptcp_connect.sh tests. Another ULP
name, "espintcp", is set instead in this patch.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/config          | 1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 59051ee2a986..18bd29ac5b24 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -34,3 +34,4 @@ CONFIG_NFT_SOCKET=m
 CONFIG_NFT_TPROXY=m
 CONFIG_SYN_COOKIES=y
 CONFIG_VETH=y
+CONFIG_TLS=y
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index cbe573c4ab3a..0d4a944c4269 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -289,7 +289,7 @@ static void sock_test_tcpulp(int sock, int proto, unsigned int line)
 		if (ret == 0)
 			X("setsockopt");
 	} else if (proto == IPPROTO_MPTCP) {
-		ret = do_ulp_so(sock, "tls");
+		ret = do_ulp_so(sock, "espintcp");
 		if (ret != -1)
 			X("setsockopt");
 	}
-- 
2.53.0

