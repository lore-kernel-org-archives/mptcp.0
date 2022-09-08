Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD503224
	for <mptcp@lists.linux.dev>; Thu,  8 Sep 2022 13:38:47 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso1784796wmr.3
        for <mptcp@lists.linux.dev>; Thu, 08 Sep 2022 06:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=MucUSLBYQgaqEZzouRlEu+Sv92psSBaTorLTjbyK/Es=;
        b=xia2diYJogSLaVTYPb1jhYGSjxhCukqA+D2iVEdKqm7nCM1nw2mQ41NtZix2OdRnbj
         XNnU0JAR777bg3j2o60umI3KguMidw4sRCTgQMx2UFTq2JE1ZgO9uA1XDzwb8rD+QU/r
         muooXU4BEbkZQhF28nJEGWJM+fJQ0yyigB66FVWZq96TL7Blq6u5n7RHlQi8guLx8LPt
         ZWSZ8gpdi7cMJOc46Gmrf2su+tez92jKcnTh6eoDKjTHWJHDjy6uF2y32hSxBgu7Bm30
         pj/r0LjGUk7IsfPK67JHULSNZ4rgDrWJbH8fyZXwTCRl2/5pLfriowCbPV5tHNOSQ+CL
         r9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=MucUSLBYQgaqEZzouRlEu+Sv92psSBaTorLTjbyK/Es=;
        b=FL9STHrWW7TWvxirEgqFopuoJbUpwB7Fv47A7Yr5r2OPsXPF8CbVyQ3pIi4tCiamKj
         BmqgD4LAJ7rb1ZjuNIyvW21zZ65z3Ir9qKx5zwRtnXhFhBTyD39BRmkjg8M5Ru9f/HKJ
         a8+Ab7GdGAkCuMm5h0riu4RSd4h2DlsAVg9EdwcIxm+2ELRpgmRF+LtkSaCQy8b2dSoO
         ppwulyXsC/1JwF5jNa2F0ArKo6pV8o4aGfnXWt33BeBmMEbbMP7NEDmzPi4Td18teBtB
         lmwdZcnpq+mXdkXUsbW8/ha7H1FaDBxSMBjw6zyR8ZBkJ8xxJqxJrhIbY3a9ALTRC+4c
         rU0Q==
X-Gm-Message-State: ACgBeo0yQ5CwNYIBr9Rkoh4InYfvkE7xIm+XWf6gae0WH5xLTdEfePVo
	0fgc0A6lhtqjT6b30qZI8G52vf4GXVPULuZWkOvGP/4/ZXkJ/CMqpkTaPnNyCyK05hIIALTW4yi
	K45AID7bsqRVfRJPcZ+Chtg==
X-Google-Smtp-Source: AA6agR4A+nxTqK3AdEs4PMHB3Lh5wvFh5UB+qf0ZOsMogu7WDtL3O6t4MWSaU3z1IyBkUwtuY8M54Q==
X-Received: by 2002:a7b:c451:0:b0:3a6:829a:6102 with SMTP id l17-20020a7bc451000000b003a6829a6102mr2358465wmi.12.1662644325996;
        Thu, 08 Sep 2022 06:38:45 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id fc15-20020a05600c524f00b003a5260b8392sm3100822wmb.23.2022.09.08.06.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 06:38:45 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Subject: [PATCH RFC mptcp-next 01/10] mptcp: add TCP_FASTOPEN_CONNECT socket option
Date: Thu,  8 Sep 2022 15:38:20 +0200
Message-Id: <20220908133829.3410092-2-benjamin.hesmans@tessares.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908133829.3410092-1-benjamin.hesmans@tessares.net>
References: <20220908133829.3410092-1-benjamin.hesmans@tessares.net>
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
    This patch only consider TCP_FASTOPEN_CONNECT, for TCP_FASTOPEN, Dmytro SHYTYI
    has proposed a different set of patches.

 net/mptcp/sockopt.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 423d3826ca1e..03bd57aef987 100644
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
+	/* Limit to first subflow, maybe msk->first could be used here? */
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
-- 
2.25.1


-- 


Disclaimer: https://www.tessares.net/mail-disclaimer/ 
<https://www.tessares.net/mail-disclaimer/>


