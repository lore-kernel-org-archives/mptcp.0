Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6F52472AF
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 03:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786939050; cv=none; b=W8x9zbVSB+DrgGz342/hcMpFIhST1Vc66A9qyOoqow2fr/v1iGXr4JEEHbwx+9Rq0oB/vP1bCpjHcOwmZFMkQnXE2k29spjHWSTf1SRLAJ6gkgqmXkwrSy06VeYtt0g1Ix1W0zvgTu1UPgXWlnNj4FVl5GqrG3ooHszXJOgcPfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786939050; c=relaxed/simple;
	bh=vqKQr8PEqIoA90fYHHiufNIcfMO4KmObUS/hUIaj6OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkDEVDdGzb9bIszEJnEP55pFrAWYp0m4vbJ0Uc84Z1fCa1X8sl5OCuVONXgRmKb4c0R2sb6Z1rLL+Ao9PuiljFkhMEu7gIaMn+BAc3OdVOYzC4CdDfBbln8ADOVUcd/MSpdB8imw2Z6xSk155nQJb7pdV4e9GKNpMPd3iUOWzfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOyTueAH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOyTueAH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1EA1F000E9;
	Mon, 17 Aug 2026 03:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786939049;
	bh=i9jKNQitH+4q4f8FwLYrLzR3zO5dBVEppfSo29wYgX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NOyTueAHPfg4r1UB2EGJq0tjpy2e4kwGTdb2XlgpBymtVrprBHfwqZqp3tCYzThVc
	 CvenJXn0IGE/qAf9YgRj3f3j/4+IiD3+/2mtLohUPyqnAZ0GeEADkASxRvpDizmFbW
	 Gm0XUDH+oVFDqZBDL8Sy6T/eo04CVxhr//UV1CL/K+T2Bc9m04Qh+BzULgRKfENxHf
	 OXrIfNPGnVKNRymaDXNmnYQiyQWdAXyxnn5jDpmVuVJ1ZqXGLTCG/6cNCMTzAIGPDp
	 cqFvHaFduSpCS/yvs8cxweju/Qpq/btkeLrCnNHcsAFDcjOFgngHlUakdobu7TMjGt
	 YiUauYoxsjhKA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: David 'equinox' Lamparter <equinox@diac24.net>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v6 5/6] mptcp: sockopt: implement IPV6_TCLASS
Date: Mon, 17 Aug 2026 11:57:12 +0800
Message-ID: <c17925172fd53c98f0ec5c0095c86e6e28cbebf4.1786938892.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786938892.git.tanggeliang@kylinos.cn>
References: <cover.1786938892.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David 'equinox' Lamparter <equinox@diac24.net>

The IPV6_TCLASS setsockopt just needs to be forwarded to the individual
TCP sockets, like IP_TOS is already handled for IPv4.

Coincidentally, ssh uses this sockopt and prints an error in the middle
of your ongoing SSH session when it doesn't work (very annoying when
doing SCP/SFTP on a multiplexed session.)

IPV6_TCLASS handling in do_ipv6_setsockopt() inlines the same ECN mask
logic and inet6_sk(sk)->tclass write that callers need when propagating
a tclass value onto a newly created socket.

Pull this into a small helper __ip6_sock_set_tclass() exported via
<net/ipv6.h>, so MPTCP can apply IPV6_TCLASS without duplicating the
ECN handling.

For setsockopt, the value is first applied to the MPTCP socket itself via
ipv6_setsockopt(), then propagated to all existing subflows using
__ip6_sock_set_tclass(). The setsockopt_seq is bumped to ensure that
subflows created later will pick up the setting through
sync_socket_options().

For getsockopt, the value is read directly from the MPTCP socket.

Also add sync_socket_options() support for IPV6_TCLASS, so that new
subflows created after the option is set inherit the correct tclass
value.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/568
Cc: Mat Martineau <martineau@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>
Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: David 'equinox' Lamparter <equinox@diac24.net>
---
 include/net/ipv6.h       |  2 ++
 net/ipv6/ipv6_sockglue.c | 23 +++++++++++-------
 net/mptcp/sockopt.c      | 52 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 8 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 3de07e738538..30fcae5ae054 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1252,6 +1252,8 @@ static inline void ip6_sock_set_recverr(struct sock *sk)
 	inet6_set_bit(RECVERR6, sk);
 }
 
+void __ip6_sock_set_tclass(struct sock *sk, int val);
+
 #define IPV6_PREFER_SRC_MASK (IPV6_PREFER_SRC_TMP | IPV6_PREFER_SRC_PUBLIC | \
 			      IPV6_PREFER_SRC_COA)
 
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index b4c977434c2e..3bc87f3e266e 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -373,6 +373,20 @@ static int ipv6_set_opt_hdr(struct sock *sk, int optname, sockptr_t optval,
 	return err;
 }
 
+void __ip6_sock_set_tclass(struct sock *sk, int val)
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
 int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		       sockptr_t optval, unsigned int optlen)
 {
@@ -713,14 +727,7 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
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
 
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 50420d332b44..442167e66c48 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -485,6 +485,42 @@ static int mptcp_setsockopt_recverr(struct mptcp_sock *msk, int level,
 	return ret;
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
+static int mptcp_setsockopt_v6_set_tclass(struct mptcp_sock *msk, int optname,
+					  sockptr_t optval, unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	int err, val;
+
+	if (sk->sk_family != AF_INET6)
+		return -EOPNOTSUPP;
+
+	err = ipv6_setsockopt(sk, SOL_IPV6, optname, optval, optlen);
+
+	if (err != 0)
+		return err;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	val = READ_ONCE(inet6_sk(sk)->tclass);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
+
+		if (ssk->sk_family != AF_INET6)
+			continue;
+
+		slow = lock_sock_fast(ssk);
+		__ip6_sock_set_tclass(ssk, val);
+		unlock_sock_fast(ssk, slow);
+	}
+	release_sock(sk);
+
+	return 0;
+}
+#endif
+
 static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
@@ -532,6 +568,11 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 		ret = mptcp_setsockopt_recverr(msk, SOL_IPV6, optname, optval,
 					       optlen);
 		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case IPV6_TCLASS:
+		return mptcp_setsockopt_v6_set_tclass(msk, optname, optval,
+						      optlen);
+#endif
 	}
 
 	return ret;
@@ -1597,6 +1638,13 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
 			return -ENOPROTOOPT;
 		return mptcp_put_int_option(msk, optval, optlen,
 					    inet6_test_bit(RECVERR6_RFC4884, sk));
+#if IS_ENABLED(CONFIG_IPV6)
+	case IPV6_TCLASS:
+		if (sk->sk_family != AF_INET6)
+			return -EOPNOTSUPP;
+		return mptcp_put_int_option(msk, optval, optlen,
+					    READ_ONCE(inet6_sk(sk)->tclass));
+#endif
 	}
 
 	return -EOPNOTSUPP;
@@ -1724,6 +1772,10 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	syncnt = READ_ONCE(inet_csk(sk)->icsk_syn_retries);
 	if (syncnt > 0 && tcp_sock_set_syncnt(ssk, syncnt))
 		pr_warn("Failed to sync TCP_SYNCNT=%u to subflow\n", syncnt);
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sk->sk_family == AF_INET6 && ssk->sk_family == AF_INET6)
+		__ip6_sock_set_tclass(ssk, READ_ONCE(inet6_sk(sk)->tclass));
+#endif
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
-- 
2.53.0

