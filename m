Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AE53A7F48
	for <mptcp@lists.linux.dev>; Tue, 28 Jul 2026 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238820; cv=none; b=E3c3AqUl43JUy8CpJqpF7DQtuf/ou2nqntQKJKMMNQlfa9W531YYmRmN184fXZAndXDuIDkVrOWS6MYUak1jFm0Npz4cPYJquomGT8pJnyMWLOZsdb7giKbaMPmJqIaqUWUBODcNvVj70f/ns5rGWI0hsExQcWuvgm9NC8CwRoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238820; c=relaxed/simple;
	bh=+3ZNqam3OgUK37tg0PLIbX89PhrMlhLhapjyCXRT0Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mr6thVRLSF6ZTRXYI2yeWuhfnw63rS7MKcthwhp2STbkdGIMycp0peTzIOeUoHbZY+ef95pnLzvhVNTxHnFTS9s6lNuVsuQBeuJWI5Mjbo+4Y2ydEEOEsQxhSWixRhcIinv89I2KQFM3S0Cw3dVMtUkIWTyeSoJ1f+F0OiDEmfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJ8ufj6C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJ8ufj6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B6C1F000E9;
	Tue, 28 Jul 2026 11:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785238819;
	bh=z4kGRJVHSIpKTzNFTx6fMaPZ2H4yswBG6fbwV1OtduE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LJ8ufj6Cd34Dcy1hMVPjmu6r7f7y+6dc88gyonW/otMkyjwqnW23zBAa+Ddv296gT
	 5l5zesvzKI53kmJMvfKa4HKJUE7rbFOeJaTxOjzFkVzzODewP90PmpszJgLQQoDEnl
	 qKgiG9UdjLbGmSzduvRvGmohzFIGbeph0ZcScD8L590EDjMZajJLxxDWXlBRnALiqG
	 KOOaTrlYtMo2EmTh8btJILhcj0rH/q2Yp3uJgcyC5/HWdQTDIVGkONCMu7GcRuyJY0
	 7tUZAXtp3cYUb7pJvZg0juEhRiFCfzoCDiMHMhCWM0HsFNM/oh36ykV6Lz679yDOT8
	 bpQRDjnXzx10Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 4/9] ipv6: extract and export ip6_sock_set_tclass helper
Date: Tue, 28 Jul 2026 19:39:37 +0800
Message-ID: <ce416904b164cafd77f6d6259256abbb843091d1.1785238723.git.tanggeliang@kylinos.cn>
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

The IPV6_TCLASS case in do_ipv6_setsockopt() inlined the same ECN mask
handling and inet6_sk(sk)->tclass write that callers need to do when
propagating a tclass value onto a freshly created socket.

Pull this into a small helper exported via <net/ipv6.h>, so external
modules (e.g. nvme-tcp, nvmet-tcp) can apply IPV6_TCLASS without
duplicating the ECN handling.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/ipv6.h       |  2 ++
 net/ipv6/ipv6_sockglue.c | 31 +++++++++++++++++++++++--------
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 3de07e738538..d61ccb48b5a5 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1252,6 +1252,8 @@ static inline void ip6_sock_set_recverr(struct sock *sk)
 	inet6_set_bit(RECVERR6, sk);
 }
 
+void ip6_sock_set_tclass(struct sock *sk, int val);
+
 #define IPV6_PREFER_SRC_MASK (IPV6_PREFER_SRC_TMP | IPV6_PREFER_SRC_PUBLIC | \
 			      IPV6_PREFER_SRC_COA)
 
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index b4c977434c2e..34a25583942f 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -373,6 +373,28 @@ static int ipv6_set_opt_hdr(struct sock *sk, int optname, sockptr_t optval,
 	return err;
 }
 
+static void __ip6_sock_set_tclass(struct sock *sk, int val)
+{
+	u8 old_tclass = inet6_sk(sk)->tclass;
+
+	if (sk->sk_type == SOCK_STREAM) {
+		val &= ~INET_ECN_MASK;
+		val |= old_tclass & INET_ECN_MASK;
+	}
+	if (old_tclass != val) {
+		WRITE_ONCE(inet6_sk(sk)->tclass, val);
+		sk_dst_reset(sk);
+	}
+}
+
+void ip6_sock_set_tclass(struct sock *sk, int val)
+{
+	sockopt_lock_sock(sk);
+	__ip6_sock_set_tclass(sk, val);
+	sockopt_release_sock(sk);
+}
+EXPORT_SYMBOL(ip6_sock_set_tclass);
+
 int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		       sockptr_t optval, unsigned int optlen)
 {
@@ -713,14 +735,7 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		/* RFC 3542, 6.5: default traffic class of 0x0 */
 		if (val == -1)
 			val = 0;
-		if (sk->sk_type == SOCK_STREAM) {
-			val &= ~INET_ECN_MASK;
-			val |= np->tclass & INET_ECN_MASK;
-		}
-		if (np->tclass != val) {
-			np->tclass = val;
-			sk_dst_reset(sk);
-		}
+		__ip6_sock_set_tclass(sk, val);
 		retv = 0;
 		break;
 
-- 
2.53.0

