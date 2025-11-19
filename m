Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CC1274B2E
	for <mptcp@lists.linux.dev>; Wed, 19 Nov 2025 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546736; cv=none; b=eCGpJTak0yJHC+iQvlwPgp9XzG+PsqH7yeRH4V7nNK5Mkr9zL/H19rt9af+7ufo/rNjZfUjDK6y6uvSboCCkXVWpN31A8AA5eCtQ51QGQHdAqO1pWmxlupO0OOs4AYJwLL7NPdYTzbaFiLo29vgWSqTd1ekSQoVmxPF55083bvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546736; c=relaxed/simple;
	bh=CXIEd2zkZciP19HeuLiQcf2rhqR3ifkT7q2ezeX0Z/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UE4iOlE+7iptdonGlFCs5vdnHa1gqQ4XnuyXh0QQqvmjTXH7MXvE33jgH06iAEjNY9WegQIUht6ayBGvLmvU2h9vEChhne97R5+HkTwH2Dwq+nPT3QCQaYvSdSZ3ehewUCI6MjctNjssetAMnhVRjuljJBBuBE2QZYZReyflqes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfqDXL1M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfqDXL1M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBD3C19421;
	Wed, 19 Nov 2025 10:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763546735;
	bh=CXIEd2zkZciP19HeuLiQcf2rhqR3ifkT7q2ezeX0Z/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sfqDXL1MtPbzDZ6J8q5Uj4uozUPQSYlo5pwf6yqmi8OKxQXMuzfqqgbTf5N6UjoYX
	 Q9sQHpE+XeaorJDokXxB8a/7SAVNxAGRJW89AFgX/z11hL3liYWrG/U1MUI+6+p3Yr
	 GTHg2OJUwkOn4Osx0S0Bmv+u4ELJxLEsbuRb2C58JxFtulQdJ3Sluc7Ec3LFz6rX4t
	 95bQyxgkTw10dkjKpNXqjJk3LJ1shoqjr+jWHwO9Mi09PC5eX/Oj7AaZ36VcWD2e0F
	 FavxTTRrCJDohkN0g9TI+J9jn3tsnG5OcGTX0pXUxo1Irw0ECQRwx80p4LusBGmgwz
	 noKDaceyDg0BQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org,
	hare@suse.com
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v2 3/8] mptcp: update ULP getsockopt
Date: Wed, 19 Nov 2025 18:05:02 +0800
Message-ID: <397d591df64c3d1c9267c99a2c9d4255490beff6.1763546473.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763546473.git.tanggeliang@kylinos.cn>
References: <cover.1763546473.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 54ad674da151..52ff75702404 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1409,6 +1409,17 @@ static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
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
@@ -1416,6 +1427,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case TCP_ULP:
+		return mptcp_getsockopt_msk(sk, SOL_TCP, optname, optval, optlen);
 	case TCP_CONGESTION:
 	case TCP_INFO:
 	case TCP_CC_INFO:
-- 
2.51.0

