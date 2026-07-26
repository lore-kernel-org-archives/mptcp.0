Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F19A1E4BE
	for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785055444; cv=none; b=EMkqTIFchG5y5PVMLxSjKkm1BxRGEonIoU3dNWx+WAG572mHLAoY18jGXZWHQqMwKW/pbUl1Bhwe6A2tc74Sd13k0V1cvlCaT+wumyOOhed74GtOhuRxlCi4jqpqTMzrF16g3/8kapWxfvaOnH5u0k7b7+SWiQGq+KTRm9gBW3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785055444; c=relaxed/simple;
	bh=N/iL1qLsyw0M/bFA5RvGTUxBR7YGSADuZPL7VhUoUTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aaBI8jaEmyT7hbPUw0+gISHr7053w2m2lszCQ0QGm0Dv1rN7+OpG5uNRMismoqeE9jdX/Un+xaL+2MTWLfwAStTYmV826YzLUcs8+DJy68BePeFQolN2/KM8mO9O7VBwgHT8xZIg1XppBwVF1FUd7jmbcMhXf2y4Q/DOF7tCTwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbBhOx41; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbBhOx41"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0FA1F000E9;
	Sun, 26 Jul 2026 08:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785055443;
	bh=Sm6aDRPWiPNVWJxHPvSb+6Fu3H63njI2hWyWxESrdJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cbBhOx41K83WrQtxr/JWYr/P0t2cA7Y9/hb7F8lRDYRdCKHmbNCwKUEk52n9i7PY1
	 0HulXigssMrDSTqTLpBxE3Z+V+4UO3R9kzzg069ojbwGLgmXKyuC83IweLw+L6Thpy
	 tMihBNxdeg42yLUoG7mfukdtbR08/JIVx/upoqRzy4wrcD7rsHie/HwzHhlMV5YufJ
	 OcFulOxY3LG9yLXGr0GK71DqoFy6IS8yc176KRIgfXiGCy1Vrlu8CPQnWT1Tm1l8Lp
	 VnvDAKEv7oY1eyY8XgL6dNeW5qWemqXw1rdF+ltBBIK05DYficz9km3Imys7sm3xq0
	 NIAyMgcM21cYg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 5/5] mptcp: add TCP_SYNCNT setsockopt/getsockopt
Date: Sun, 26 Jul 2026 16:43:44 +0800
Message-ID: <eafc0fe4728acbfb17f1fabe5945af17d60ad558.1785054808.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785054808.git.tanggeliang@kylinos.cn>
References: <cover.1785054808.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Surface TCP_SYNCNT to userspace on the MPTCP master socket.

setsockopt(TCP_SYNCNT) validates the value via __mptcp_setsockopt_set_val()
and stores it in inet_csk(sk)->icsk_syn_retries on the msk. getsockopt()
reads the same field back.

A newly created subflow picks up the master socket's syn_retries through
sync_socket_options(), so the setting takes effect for outgoing SYNs
without further plumbing.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 34f6cd9c7967..6e4c5b5314af 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -898,6 +898,23 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		ret = mptcp_setsockopt_all_sf(msk, SOL_TCP, optname, optval,
 					      optlen);
 		break;
+	case TCP_SYNCNT: {
+		int syncnt;
+
+		if (val < 1 || val > MAX_TCP_SYNCNT) {
+			ret = -EINVAL;
+			break;
+		}
+
+		syncnt = val;
+		ret = __mptcp_setsockopt_set_val(msk, MAX_TCP_SYNCNT,
+						 &tcp_sock_set_syncnt,
+						 &syncnt,
+						 val);
+		if (ret == 0)
+			inet_csk(sk)->icsk_syn_retries = syncnt;
+		break;
+	}
 	default:
 		ret = -ENOPROTOOPT;
 	}
@@ -1450,6 +1467,10 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return mptcp_put_int_option(msk, optval, optlen, msk->notsent_lowat);
 	case TCP_IS_MPTCP:
 		return mptcp_put_int_option(msk, optval, optlen, 1);
+	case TCP_SYNCNT:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet_csk(sk)->icsk_syn_retries ? :
+					    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_syn_retries));
 	}
 	return -EOPNOTSUPP;
 }
@@ -1604,6 +1625,11 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 
 	ssk->sk_reuse = sk->sk_reuse;
 	ssk->sk_reuseport = sk->sk_reuseport;
+	if (inet_csk(sk)->icsk_syn_retries > 0) {
+		if (tcp_sock_set_syncnt(ssk, inet_csk(sk)->icsk_syn_retries))
+			pr_warn("Failed to sync TCP_SYNCNT=%u to subflow\n",
+				inet_csk(sk)->icsk_syn_retries);
+	}
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
-- 
2.53.0

