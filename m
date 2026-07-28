Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050973A7F48
	for <mptcp@lists.linux.dev>; Tue, 28 Jul 2026 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238819; cv=none; b=DhSLqC+hGQR/mqgkwBbaQVkhtTXEp38bNfm5iLUmUb85I6LZ9mBCvmGoE+MI1TSgBJJlUahJ+MZ0o7dgNoriGYU/u5nWWGRKkJdQ5ryUs9/LiaWyfgQsFgvYprxYWrB0VKhwcOWr7EA9bmOIZRlYU1FtQOB/9fyCGGVvZ32mve0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238819; c=relaxed/simple;
	bh=I/0vubeE2HrX2ECAE/GU4FDUuSWbA7qingLtTsYGrW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0DuzOSYhQC49xq2VUe/nJAk6wxFIgE4Zt7NyTPFTodxAiyFRfqJbWdZp2Hq2wOI69NiKT/x4F0jFghp9pGwONYWagc7+pU6I6v311o8Z+bFlqM4tSStZZhX/YuBE62jW8W/ZzPaa1wyx+HmlRlLxdAQdmCmcB/Nl1rhCjGrLmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVt4/dpX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVt4/dpX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFF61F00A3A;
	Tue, 28 Jul 2026 11:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785238817;
	bh=69BG0JqQaPbbXDTdxHpX8V2YRTLLlGpOkzXIpdKhaS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DVt4/dpXq11byya23GrcDMgBMeQuxQSdQq1oZc6IwBYT3+2PQPMSNPE+5m7CE8Szf
	 nh/s4JqIagrA1tuzUNAxmcUWiEdb1Buvx9LbQegwck7bYNfn0EOrko4cbEp+0CXmCG
	 Pbwe2n2royPzYB7ttlEm8hRJrgBhSiu+T5mwepZMjXAYFMcs9hJo7le/aMxOoq/21t
	 nzVKZr88ihgXg6y8MqWywupswOj9c8mND45bWAnY8ZfbG4ErWIjMs32//aNKAArgEs
	 eKf7XjcxsxWdVtQ18QQUsB3K7F8Snsl5luS6TFvernWs6B/c9lsKD5OYzPlpjmfb/d
	 EVuUbGXD7R09g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 3/9] mptcp: add TCP_SYNCNT setsockopt/getsockopt
Date: Tue, 28 Jul 2026 19:39:36 +0800
Message-ID: <771e3596a04c47fb824823dc194332bea72faf41.1785238723.git.tanggeliang@kylinos.cn>
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
index 34f6cd9c7967..dbfae244a731 100644
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
+			tcp_sock_set_syncnt(sk, val);
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

