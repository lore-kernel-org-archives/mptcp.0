Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CB2225788
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 02:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380061; cv=none; b=kW484UZUeG9wNwSvkdkLh1flkQD6W9GmjsgwZupPHOEL980YSOUFGP4DttPAR90u9mFQDymqyu2KwgbSgwlCZsLKzYitTSaGboC+sNyf6vm+hI3Y8EVsKecO+ZUzrWYS/y7OiVNun8JKzIRqlN6svXMRWEpWOE2O17AjtnaRXog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380061; c=relaxed/simple;
	bh=wQp5VfFJvA13PPKqsWv11I5ieA+l3DUXfmDNCAjoJ98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMHNDkyF3/93yw5jwA5DX4E2vC2r1QVT3OB3IFtdMMkdM/KRQ47v33gZtcxpMzwYUCgBbFt4UtoiZiRcB2mvdFyam9tIVMlJBCQ2XG5oPm3uHDLPAzNI18kL0Z7pkynL+bv3Ay01TKYIKP1/J4vS6z7T2OjjoXZVYv2eGK9boHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WV4coaGY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WV4coaGY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04021F000E9;
	Thu, 30 Jul 2026 02:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785380059;
	bh=Zu8IQTFEIODpEKubo3ZwbUzbx/lCT8l9GOiU21sr7Bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WV4coaGYEnMeCvItvk+usIXZDGD5G2OClaCKA9IyAC7eU1FDh2T+wDuLskxGGbU9D
	 VhrLC9QEBGIvrxBYQ163YUc9hA8z30W+hlbCMMyNmHDyCf67LEYE8ypGmmBJYJC5gP
	 M9yTOnY0lhk6E1o6F8r2Q+Q/xQoy8aKcxIIAGp/g8hEk8MhvPhas+mo6h9lDKgp0F5
	 PQhk4/2CkDFISOroII5jldcnW5h2KuwtJSJeW+4CT+UBpbk7t+Xz8voauakaC9eB53
	 uIvTvZGLvEAjt8xtIogquR76LW/iCwgf6iMB9mbIEAQ6NCUjeXy1UVfiY+qju8qmDr
	 MBkCgK2way2GQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 04/10] mptcp: add TCP_SYNCNT setsockopt/getsockopt
Date: Thu, 30 Jul 2026 10:53:57 +0800
Message-ID: <9cb37d4c246b79fd35f439c5bf9b60c5e18280c9.1785378180.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785378180.git.tanggeliang@kylinos.cn>
References: <cover.1785378180.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds TCP_SYNCNT support on the MPTCP socket.

The setsockopt() path stores the value in inet_csk(sk)->icsk_syn_retries
on the msk and all subflow sockets. The getsockopt() path reads the same
field back from the master socket.

A newly created subflow picks up the master socket's syn_retries through
sync_socket_options(), so the setting takes effect for outgoing SYNs
without further plumbing.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 34f6cd9c7967..3dbf8d27005c 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -898,6 +898,13 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		ret = mptcp_setsockopt_all_sf(msk, SOL_TCP, optname, optval,
 					      optlen);
 		break;
+	case TCP_SYNCNT:
+		ret = __mptcp_setsockopt_set_val(msk, MAX_TCP_SYNCNT,
+						 &tcp_sock_set_syncnt,
+						 &val, val);
+		if (ret == 0)
+			ret = tcp_sock_set_syncnt(sk, val);
+		break;
 	default:
 		ret = -ENOPROTOOPT;
 	}
@@ -1450,6 +1457,10 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return mptcp_put_int_option(msk, optval, optlen, msk->notsent_lowat);
 	case TCP_IS_MPTCP:
 		return mptcp_put_int_option(msk, optval, optlen, 1);
+	case TCP_SYNCNT:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    READ_ONCE(inet_csk(sk)->icsk_syn_retries) ? :
+					    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_syn_retries));
 	}
 	return -EOPNOTSUPP;
 }
@@ -1552,6 +1563,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
 	struct sock *sk = (struct sock *)msk;
 	bool keep_open;
+	int syncnt;
 
 	keep_open = sock_flag(sk, SOCK_KEEPOPEN);
 	if (ssk->sk_prot->keepalive)
@@ -1604,6 +1616,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 
 	ssk->sk_reuse = sk->sk_reuse;
 	ssk->sk_reuseport = sk->sk_reuseport;
+	syncnt = READ_ONCE(inet_csk(sk)->icsk_syn_retries);
+	if (syncnt > 0 && tcp_sock_set_syncnt(ssk, syncnt))
+		pr_warn("Failed to sync TCP_SYNCNT=%u to subflow\n", syncnt);
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
-- 
2.53.0

