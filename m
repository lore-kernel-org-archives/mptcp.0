Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8843C35
	for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 12:19:40 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id t7so20114612wrm.10
        for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 05:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=m+4EL+V9F08z3c08xBzYaGa4a0MyGPdJ/MhJQ9u3gjs=;
        b=WOPJtPXMb9Ive+iThxjyZ/53oRwhcvi17WtUOkoD1cXTr89SGzBCyolkPO10UYHvG5
         59gsC7SDMU+sNeiTxm7Pld3m2QISIvDsPEgz8uZRvtt9gLmkuzZI4S2N6CLHx7tIfzXv
         sTE2Wljl0HAb80u91tLjWgACKn59LHgPuun+zhzrHWes1UAi3Wtar+5Cszj7t6fxijjI
         6vuIinH7nPRmBKuF9kRRHLZTKp0I5sgSA4mK9t+AJ6gd1+Y9Dgc0mQcgWhhRcnsNpLjF
         OlHdUgL87AsBHrNxLRon2k2YeBqpJXpy5EdkS5WZAWO8rqGXH8jXS70lVd+oZuB8+ZOq
         WVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=m+4EL+V9F08z3c08xBzYaGa4a0MyGPdJ/MhJQ9u3gjs=;
        b=aK4Ep+XZSdzoyciPOqlIaesy2DD+UI3f7gBcyf6ZROTDhWpyGJoMSqVQIA6CAOBrW1
         n4hvYNmDwxlpMaP4oJV3d++FGZlIgcYUI0ZQUEzuUzvDepftZC6j2s+RDBb8q0ya+x17
         Pm7F8VKxWKfiDT3fYP9XjbeZwGjDB/wH0piLXTNQJiB2nOh3/xV/YkPPTALIgkTdo1dr
         19DjVN2hk3DsNb1mSSOivoc1Q1CFMzjsorPEzT9/uSZ6pDld2vs3+DdiB7b1cxOIUgMD
         Tp6mBArDvAZ2SCyUySFwx5WGpAFknFbkpHrdm+RxLxrSGK8CrjyNxC7IFfQ5jfQrkZK3
         kkAA==
X-Gm-Message-State: ACrzQf3AcfaM2oU/DG1YH1NSxZbhjyPPB8cdySGj68sA+Ea47hXdL8FM
	kIBM913lcwBxu7MDRaz/obXiVW6dq8uVMAzWfcwHDBfeQzd8Qs2kYZdNNj9tS4cbdLOwVsUuVFF
	pYQY8mpAd8rcW8Cb/7GM=
X-Google-Smtp-Source: AMsMyM72x2KNpeuQSc9fcBVn5eBCIMpONy4GRP2u7gMVuSNmBznP80TYYG86AThGuwscsbiXPfZNFg==
X-Received: by 2002:a5d:6c6b:0:b0:225:dde:ab40 with SMTP id r11-20020a5d6c6b000000b002250ddeab40mr5118864wrz.690.1663935578764;
        Fri, 23 Sep 2022 05:19:38 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bj1-20020a0560001e0100b0022b0214cfa6sm8939309wrb.45.2022.09.23.05.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 05:19:38 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Subject: [PATCH mptcp-next v3 1/4] mptcp: add TCP_FASTOPEN_CONNECT socket option
Date: Fri, 23 Sep 2022 14:19:10 +0200
Message-Id: <20220923121913.2135229-2-benjamin.hesmans@tessares.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220923121913.2135229-1-benjamin.hesmans@tessares.net>
References: <20220923121913.2135229-1-benjamin.hesmans@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

Set the option for the first subflow only. For the other subflows TFO
can't be used because a mapping would be needed to cover the data in the
SYN.

Signed-off-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
---

Notes:
    v1:
    - also support getsockopt() for TCP_FASTOPEN_CONNECT
    - remove comment about msk->first. __mptcp_nmpc_socket() should be good here

 net/mptcp/sockopt.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 423d3826ca1e..c7cb68c725b2 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -559,6 +559,7 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		case TCP_NOTSENT_LOWAT:
 		case TCP_TX_DELAY:
 		case TCP_INQ:
+		case TCP_FASTOPEN_CONNECT:
 			return true;
 		}
 
@@ -567,7 +568,7 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		/* TCP_REPAIR, TCP_REPAIR_QUEUE, TCP_QUEUE_SEQ, TCP_REPAIR_OPTIONS,
 		 * TCP_REPAIR_WINDOW are not supported, better avoid this mess
 		 */
-		/* TCP_FASTOPEN_KEY, TCP_FASTOPEN TCP_FASTOPEN_CONNECT, TCP_FASTOPEN_NO_COOKIE,
+		/* TCP_FASTOPEN_KEY, TCP_FASTOPEN, TCP_FASTOPEN_NO_COOKIE,
 		 * are not supported fastopen is currently unsupported
 		 */
 	}
@@ -768,6 +769,19 @@ static int mptcp_setsockopt_sol_tcp_defer(struct mptcp_sock *msk, sockptr_t optv
 	return tcp_setsockopt(listener->sk, SOL_TCP, TCP_DEFER_ACCEPT, optval, optlen);
 }
 
+static int mptcp_setsockopt_sol_tcp_fastopen_connect(struct mptcp_sock *msk, sockptr_t optval,
+						     unsigned int optlen)
+{
+	struct socket *sock;
+
+	/* Limit to first subflow */
+	sock = __mptcp_nmpc_socket(msk);
+	if (!sock)
+		return -EINVAL;
+
+	return tcp_setsockopt(sock->sk, SOL_TCP, TCP_FASTOPEN_CONNECT, optval, optlen);
+}
+
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    sockptr_t optval, unsigned int optlen)
 {
@@ -796,6 +810,8 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return mptcp_setsockopt_sol_tcp_nodelay(msk, optval, optlen);
 	case TCP_DEFER_ACCEPT:
 		return mptcp_setsockopt_sol_tcp_defer(msk, optval, optlen);
+	case TCP_FASTOPEN_CONNECT:
+		return mptcp_setsockopt_sol_tcp_fastopen_connect(msk, optval, optlen);
 	}
 
 	return -EOPNOTSUPP;
@@ -1157,6 +1173,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_INFO:
 	case TCP_CC_INFO:
 	case TCP_DEFER_ACCEPT:
+	case TCP_FASTOPEN_CONNECT:
 		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
 						      optval, optlen);
 	case TCP_INQ:
-- 
2.25.1


-- 


Disclaimer: https://www.tessares.net/mail-disclaimer/ 
<https://www.tessares.net/mail-disclaimer/>


