Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32E9481DD
	for <mptcp@lists.linux.dev>; Sat, 22 Nov 2025 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763801140; cv=none; b=uV8+lSWYq6jyLbsse9xXjg99eLH24iLQzZwNYPLYX+B0gPI4T+CK0E4npj9gSMbGfiOUOXipKJEiisWKgntmawBow0GD7cFLnBGxCKN+SMXYAH6DJFCN+/JgA/ln8GYHcq+Q3NKtQDUvlYSsX4V5B/GPnkRcRQUz/JR9CLIekTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763801140; c=relaxed/simple;
	bh=tqQxCtBYZEYSb0VBK/bDrbQYT/Rsb0f9OomcFxC4SKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4Mu1IYIHgKe7SefuatLxOGuGpalCkNWBLBswx/aoneBS6XMPPEHgYCv7E8ei1zn8Wp2qQukFeJu4+Q3Is0R2uLcQtpKjogJQqtunqu1dn8KrzYlk2nM9DOPq8wjcGyGT+RLNFWTbvtqT0tMuQz031Wxv1hlI1LObL+7znfl/JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvDsOETE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvDsOETE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907FEC4CEFB;
	Sat, 22 Nov 2025 08:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763801140;
	bh=tqQxCtBYZEYSb0VBK/bDrbQYT/Rsb0f9OomcFxC4SKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rvDsOETEt+3/uO3nhYRKwQ2jodu2ecJgq8bfY4Ay/NIJ1tYwg7tV43ZFgE1S5Gcti
	 Vk1nVit4cIbkHc8DTMKfzz/42M0vAJ4TsWSXCUloigotgv10tNYxRQuVUX9v8w5MOi
	 HfPYFBGpQ6VWcEoW37DNjA1RdcdFAiKS9i3Nob+0CgD2sIZKZ+NWzbt+HW07JKrg0Z
	 y48zRilk8CH4OYra6tXJIFmtflS7azht6P1F+gmq2137C0tu2adtHTwnTCeOVvOx5U
	 ujHZF1Y3lfOZar+aCIPyj0Cb7K3yK4h75/xM4JQ0xXQ2MrBlPgTo4LBzBbkkF0LaRi
	 AgSAPZOCtqqwg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v3 5/8] mptcp: update ULP getsockopt
Date: Sat, 22 Nov 2025 16:45:24 +0800
Message-ID: <1cc7652f6caedbf0029355caec2970071ce3fc99.1763800601.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763800601.git.tanggeliang@kylinos.cn>
References: <cover.1763800601.git.tanggeliang@kylinos.cn>
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
index de90a2897d2d..f3db4f2e8f81 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1393,6 +1393,17 @@ static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
 	return 0;
 }
 
+static int mptcp_getsockopt_msk(struct sock *sk, int level, int optname,
+				char __user *optval, int __user *optlen)
+{
+	int ret;
+
+	lock_sock(sk);
+	ret = tcp_getsockopt(sk, level, optname, optval, optlen);
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
+		return mptcp_getsockopt_msk(sk, SOL_TCP, optname, optval, optlen);
 	case TCP_CONGESTION:
 	case TCP_INFO:
 	case TCP_CC_INFO:
-- 
2.51.0

