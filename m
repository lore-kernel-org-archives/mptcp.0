Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A4D22F772
	for <mptcp@lists.linux.dev>; Sun,  4 Jan 2026 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767519327; cv=none; b=W6oMohgKU+YIBC+o0x3ESpTNPi/fsj/WvNp3wXfif3p+LBiRWL3SkfmVfa20kuLetRAM1E55q64gGvVoSLkLAzquNQzdN+VGZoThYglj1g13uTGno9WF6tehzK5ILNzvRL6UmiblffCQ2rcQ6OnUTNIRgrJI4WG2QSU2dMBM39s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767519327; c=relaxed/simple;
	bh=4oauVhKzuKU+hQA0Uk5WLPAvFYM6MFS2TtqTIXtIEUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJ6kfVck9c+20JoScfpLqdK9noDv6NWPpp/StB6VrVqNANAuKbOIjoAotmyU6qeNvEMq7RhZ4+niOKwZWH3UKEX3Rkc88JPzhHlKGTESvmbR8ubcrQBJ7tYut6TgCCg1CM3KV5U/eksfcQvWrfB5nPpPqFfuO4YtySpsppSZfEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I13IFIk9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I13IFIk9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341E5C4CEF7;
	Sun,  4 Jan 2026 09:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767519326;
	bh=4oauVhKzuKU+hQA0Uk5WLPAvFYM6MFS2TtqTIXtIEUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I13IFIk9bjNC0Wtb0GaT792OHQrb/YxoTCNeRYwcjLkNNliRhgbEaTgNeHe9epk6y
	 KnzUn/zvB9MqrYly8a7NUo1PUTeJU9mvdDr/D6RLO+lgQ5+F4XbE7zRFMoHsjBgKwN
	 YNe3CYPdRPUYROmPvgqQQSU13r311iFs7i77gw0Udvcyjw+Dor/A0qRjtzXQ+C4pe2
	 js6QoKsJPLElBZMqOYUltno3mO2F97Gj0zF0xUyanQJBZ1mH+K1Xb0uhmZt77/BPG6
	 6ULDUEc05jmqBLfHDfJJ25NWusBORtF6anOKpxCsaNGq8Pbg5u3YCH7wcSP/EEbNgL
	 boX3S+pXl8mGg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v6 05/10] mptcp: update ULP getsockopt
Date: Sun,  4 Jan 2026 17:35:06 +0800
Message-ID: <1334df7f5af5b86909c8e05ea882e2528534d563.1767518836.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1767518836.git.tanggeliang@kylinos.cn>
References: <cover.1767518836.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

TCP_ULP was obtained by calling mptcp_getsockopt_first_sf_only() to get
the ULP of the first subflow. Now that the mechanism has changed, a new
helper needs to be implemented to get the ULP of the msk.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index de90a2897d2d..a6230f7910fd 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1393,6 +1393,17 @@ static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
 	return 0;
 }
 
+static int mptcp_getsockopt_tcp_ulp(struct sock *sk, char __user *optval,
+				    int __user *optlen)
+{
+	int ret;
+
+	lock_sock(sk);
+	ret = tcp_sock_get_ulp(sk, USER_SOCKPTR(optval), USER_SOCKPTR(optlen));
+	release_sock(sk);
+	return ret;
+}
+
 static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    char __user *optval, int __user *optlen)
 {
@@ -1400,6 +1411,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case TCP_ULP:
+		return mptcp_getsockopt_tcp_ulp(sk, optval, optlen);
 	case TCP_CONGESTION:
 	case TCP_INFO:
 	case TCP_CC_INFO:
-- 
2.51.0

