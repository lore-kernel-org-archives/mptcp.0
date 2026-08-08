Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEB037E5F2
	for <mptcp@lists.linux.dev>; Sat,  8 Aug 2026 03:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786160484; cv=none; b=ULsALDgcULNH9v+H+7Bx+rRZdeKd0BSWcs3kOQheMznZp2TavtlXSLKt4dIr3d0IcxhnwSZnfDNh/NW37fgMS7NldPrSVeUD6+OMAjk26d+k9RTBVrSOEdlsSUbIx+x+jRUhj02QVy852ucbB6FnkMTx1JId9mR6LKDx6tR6qcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786160484; c=relaxed/simple;
	bh=KsayPQyy3JkDykZxbp8I+EG2Wn/U605aW48cDfRJakE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AcvwR/2AqmlkNFbNsBhonaXWrPcUxFrLxr95+80asneDXPMPPf/UrcJCk3cc4WgJsNdfNiQOxRwWihkmfXpFHBaNXqq5M6KgTcgzgGjL+CVuvx8dUPLniKZFZZNNybUPi6j4Vb7ZyWWlPHuQ4zWDCaCrvWrYT5J8MNkJNRixg1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wt6fHVxT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wt6fHVxT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D261F000E9;
	Sat,  8 Aug 2026 03:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786160483;
	bh=nMiYk/3i44vwtUMiX4It2n7H7sh19n2cyGT9in1iBZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wt6fHVxTl7HIX/NOdDySA/BVyh0NkKLZvbOd7R7T9ipS8xtYtyGVZIX+cJYPFlK7z
	 f4lX+vk246tJQ9/guWEcY2XEtzUNa5+TThSZpejzAnvGRHv0jYR+V8bWdA3PrVbNN1
	 5gDDcc+EaJRMaNU90Z8CffJwzJt3BhQ/8RJqaFlsrZhhG2DrsusTduanMRROiLss9L
	 0K4KT0wAGhOBcyt9/18SMb11pO5rNg6aP4ezsgEJzeaCD0WS3+vnGdB1qFRiyE8vuE
	 uefHG9PGHU+95FQrPce0lhh08mqSZz3CIcSkBR+fsCOikQOq+wXWXJtNz66SNfDAJZ
	 i9Him7WwlqKRA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 04/11] mptcp: add TCP_SYNCNT setsockopt/getsockopt
Date: Sat,  8 Aug 2026 11:40:34 +0800
Message-ID: <41d5b746f9b2b557a8de3a0d0f0def412cef905e.1786159812.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786159812.git.tanggeliang@kylinos.cn>
References: <cover.1786159812.git.tanggeliang@kylinos.cn>
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
index d79139eb5b8a..71a4a2aaa838 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -974,6 +974,13 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 						 &tcp_sock_set_maxseg,
 						 &msk->maxseg, val);
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
@@ -1526,6 +1533,10 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
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
@@ -1646,6 +1657,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	struct sock *sk = (struct sock *)msk;
 	unsigned long src;
 	bool keep_open;
+	int syncnt;
 	int b;
 
 	keep_open = sock_flag(sk, SOCK_KEEPOPEN);
@@ -1709,6 +1721,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 
 	ssk->sk_reuse = sk->sk_reuse;
 	ssk->sk_reuseport = sk->sk_reuseport;
+	syncnt = READ_ONCE(inet_csk(sk)->icsk_syn_retries);
+	if (syncnt > 0 && tcp_sock_set_syncnt(ssk, syncnt))
+		pr_warn("Failed to sync TCP_SYNCNT=%u to subflow\n", syncnt);
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
-- 
2.53.0

