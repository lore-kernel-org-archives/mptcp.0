Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A155CDDC3
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986656; cv=none; b=Q6I129oZQMPd9pkERB8JF65U2kH6lXLGD3r9at2Wd4WiEy8gKsIfVlaCacWwcir5uRV8Auuk+XQsbQuFlUPnzz7Xuj8ooM0xO71Ppjuj5KZsFlcozkm2lgb1UmjEsQkvtUaqJVhyb2nlJWHw9AY7tqZh2xanc/9npI1jsq/ncAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986656; c=relaxed/simple;
	bh=XoNKFj5uh2lsRdEfD8Oe+JTzHeeQgy9hKO6Rd5YiA30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRWDXDr5y8tmCP8xJPNITr5RSD/AknXE8Ss/BA3mxg53+Tvj5ZwjFuunTlGOvdyRCF+Kfd0ba7DDmA5AokkjjDFFLLWgBhHJG1S7/KCgBsXF12wX/bZ6Vr5/0j4KkPxIAin8ekCcTfKOLrPRlqulhFMQple1R1zULzkIRWJcMkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2RiVn3Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2RiVn3Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA2BC4CEF0;
	Tue, 12 Aug 2025 08:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754986654;
	bh=XoNKFj5uh2lsRdEfD8Oe+JTzHeeQgy9hKO6Rd5YiA30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y2RiVn3QoBY1hDO5E0gChmsBClxbGMU1KAxYnTRI61aPsU6fYp5INjqHVAHh6H8Cr
	 4WYsuC1RPpuv3olc8BWrQl+yEkBfkddXGlk+l9pwG4WaKHHiZt2R7sZHBTcF02UIrK
	 BGJCiZwTb+zwxwZPD+DbH0RRjQ0hKJzdjc+Dgc3WobY0DbaF+QnNqWXySr+YtVXXkW
	 DbF2dJpAV3bmD7JgozyiRqHOMZxmFVZGqXw4Gxcn19PwAio8r7J1/quUqYAPC+vRLu
	 IRlcIADKkBN46klHqkfJT2HTB0E2B7mTlLx0WE7bNiEqn9cwnNfQmJoJxSR/G+4wdB
	 vadkZgD2zE8KA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/6] mptcp: handle SOL_SOCKET options on first subflow only
Date: Tue, 12 Aug 2025 16:17:17 +0800
Message-ID: <d9a30d38ac9551161c5f674360db52ce9924ff05.1754986557.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754986557.git.tanggeliang@kylinos.cn>
References: <cover.1754986557.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Refactor SOL_SOCKET option handling using the common handler
mptcp_setsockopt_sol_socket_first_sf_only(). This helper applies socket
options (SO_REUSEPORT, SO_REUSEADDR, SO_BINDTODEVICE, SO_BINDTOIFINDEX)
to the first subflow and synchronizes values back to the MPTCP socket.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 64 +++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 6cc073fab17c..8017cbad0597 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -17,6 +17,10 @@
 #define MIN_INFO_OPTLEN_SIZE		16
 #define MIN_FULL_INFO_OPTLEN_SIZE	40
 
+static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level,
+					  int optname, sockptr_t optval,
+					  unsigned int optlen);
+
 static struct sock *__mptcp_tcp_fallback(struct mptcp_sock *msk)
 {
 	msk_owned_by_me(msk);
@@ -287,38 +291,51 @@ static int mptcp_setsockopt_sol_socket_linger(struct mptcp_sock *msk, sockptr_t
 	return 0;
 }
 
-static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
-				       sockptr_t optval, unsigned int optlen)
+static int mptcp_setsockopt_sol_socket_first_sf_only(struct mptcp_sock *msk, int optname,
+						     sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct sock *ssk;
 	int ret;
 
+	if (optname != SO_REUSEPORT && optname != SO_REUSEADDR &&
+	    optname != SO_BINDTODEVICE && optname != SO_BINDTOIFINDEX)
+		return -EOPNOTSUPP;
+
+	lock_sock(sk);
+	ssk = __mptcp_nmpc_sk(msk);
+	if (IS_ERR(ssk)) {
+		release_sock(sk);
+		return PTR_ERR(ssk);
+	}
+
+	ret = sk_setsockopt(ssk, SOL_SOCKET, optname, optval, optlen);
+	if (ret == 0) {
+		if (optname == SO_REUSEPORT)
+			sk->sk_reuseport = ssk->sk_reuseport;
+		else if (optname == SO_REUSEADDR)
+			sk->sk_reuse = ssk->sk_reuse;
+		else if (optname == SO_BINDTODEVICE)
+			sk->sk_bound_dev_if = ssk->sk_bound_dev_if;
+		else if (optname == SO_BINDTOIFINDEX)
+			sk->sk_bound_dev_if = ssk->sk_bound_dev_if;
+	}
+	release_sock(sk);
+	return ret;
+}
+
+static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
+				       sockptr_t optval, unsigned int optlen)
+{
+	struct sock *sk = (struct sock *)msk;
+
 	switch (optname) {
 	case SO_REUSEPORT:
 	case SO_REUSEADDR:
 	case SO_BINDTODEVICE:
 	case SO_BINDTOIFINDEX:
-		lock_sock(sk);
-		ssk = __mptcp_nmpc_sk(msk);
-		if (IS_ERR(ssk)) {
-			release_sock(sk);
-			return PTR_ERR(ssk);
-		}
-
-		ret = sk_setsockopt(ssk, SOL_SOCKET, optname, optval, optlen);
-		if (ret == 0) {
-			if (optname == SO_REUSEPORT)
-				sk->sk_reuseport = ssk->sk_reuseport;
-			else if (optname == SO_REUSEADDR)
-				sk->sk_reuse = ssk->sk_reuse;
-			else if (optname == SO_BINDTODEVICE)
-				sk->sk_bound_dev_if = ssk->sk_bound_dev_if;
-			else if (optname == SO_BINDTOIFINDEX)
-				sk->sk_bound_dev_if = ssk->sk_bound_dev_if;
-		}
-		release_sock(sk);
-		return ret;
+		return mptcp_setsockopt_first_sf_only(msk, SOL_SOCKET, optname,
+						      optval, optlen);
 	case SO_KEEPALIVE:
 	case SO_PRIORITY:
 	case SO_SNDBUF:
@@ -806,6 +823,9 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level,
 	case SOL_TCP:
 		return mptcp_setsockopt_sol_tcp_first_sf_only(msk, optname,
 							      optval, optlen);
+	case SOL_SOCKET:
+		return mptcp_setsockopt_sol_socket_first_sf_only(msk, optname,
+								 optval, optlen);
 	}
 
 	return -EOPNOTSUPP;
-- 
2.48.1

