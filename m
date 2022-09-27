Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E914E259A
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 15:06:08 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso9609842wmq.4
        for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 08:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=tPJ+YbHcPX058JbmlCEOE/c/LuK5QpHUacAhZwRsQac=;
        b=5efx2D0WJij3oO4u8d0crrUq/cUkfVIuc5HH/FtzhzTjhRbLSylAgeW2LntvqQ1oIS
         EWnp20ne0lraoeerlvK6snyiEHGChVXfmT6lIRt0PdXyQ58udwrA1zFYfVcU6D3F/yYG
         9rHH7EySK5dib+GC8DgvKUw9LlxsXFIo2yZkxp5G2Pp1XjPhLYno5raAqCkDfUE2g++G
         qUk+0Yv7Xk9P/gAfqZg63b23ab6H0fkkhiDg97+WDLIQ3x4pu+mH4lQG4aXkF8oX3Gj2
         0VwGRgKeGQmJIvKUcZCKfUTx6XdB7vY6p/CZRRze/9ICLL+EI5/26hu2NlCd0Ad2lFYu
         RfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tPJ+YbHcPX058JbmlCEOE/c/LuK5QpHUacAhZwRsQac=;
        b=i6A3br6DqF5aj1sAC35H0tf9kPhhGpwUjzpbkeKU8p9fRuMq5mW+qj66BNwfymdzMY
         1k7Dm52Rl6FFw0G1kH4LzQq1tOuv5FMSeZ/njUaSEobFTHKeeGN8WZvZoH2Wx5I+7nST
         sTsYnI40WSjRaPC+aKTyYAHFrshRhim0Wwoc4xl/8A7GFN+5G18faylmq/y8hTCMhPEz
         lRZYW9mPUA2Dh7L0Q1pq2EErKNM7qQkf3Va/VsgxbBdEFnvcRqfn5nBaOChtf8Qj3VWu
         l7Z+cuIicqBshgGYRVEy2EPkVaQJKwmHmhsJOdRfcn3ReO2ASjbqodI8scmHLfVgntmC
         prSQ==
X-Gm-Message-State: ACrzQf1KrrLOr/oln8Hvq3pv2kfntF3FWRVID3hQCnzim3+VTWKL1hxC
	YPZECvvdD+D/9e590sIZdfoEIfTpusZVQG8Xfp0=
X-Google-Smtp-Source: AMsMyM6VDjBVTA/tuy9pdykdQ76m1V/D13HirDfy7uAuXXPFNcT/EroKbFqBLJ7YGL19Hn2BWcQk8g==
X-Received: by 2002:a05:600c:4f06:b0:3b4:b67c:68bb with SMTP id l6-20020a05600c4f0600b003b4b67c68bbmr3152666wmq.36.1664291166856;
        Tue, 27 Sep 2022 08:06:06 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bx31-20020a5d5b1f000000b0022a2bacabbasm2101430wrb.31.2022.09.27.08.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:06:05 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 1/2] mptcp: sockopt: make 'tcp_fastopen_connect' generic
Date: Tue, 27 Sep 2022 17:03:05 +0200
Message-Id: <20220927150306.1552795-2-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220927150306.1552795-1-matthieu.baerts@tessares.net>
References: <20220927150306.1552795-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1912; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=Qk+MnnmgHd0P+np+K6XzWxyJyLBDZ7w0Jf3jJ9O3M2g=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjMw+2c9Bi8si06pmH5VN+180DSC0gJ/yhmez38lD2
 S6IhEgWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCYzMPtgAKCRD2t4JPQmmgczjtD/
 4oihsu1NZHbL3ctSyUEa4VTi8mhm3b8Wl2c1JtiTTnvTVYdy7iiitgT5rOBWg6IW0ik0izVYKP+b1Q
 P7cMZTk7bZSzVO/CIaUnEyDeFRf5rVkhoDis/GTouCil3qzAEDiLVDBQc9ZwmRtQatJnBRrA5DLpZO
 HrRMu/SPDEizpVqD7DKHDRO2RNQgPX3aa9pYqjZc3RAeNxUXAk1Wx8EGHDxtt6ee0mU5oMvLsXsMYr
 B4U/wx9uXBqv56YLccDtrCfFWX1qUy/ZNPxsprOs4UboPndJwfGNSDrAs57v+nGgKivKnSGGnoGXXb
 cIFHP/foNQLKcSPzuCctqNUgW7zB5fwdrPwvs1Bfb5D9qHnke4o7EWGSUmMzN0acANxcK28Iy0KmCz
 zZczzhcVu9iVIIijnyDjs20jXDYs727T2704qXEZbW51Oc1NzDtIWPYt8ApkIKXRfAbGEsOSyEWtfu
 0vE8H1fMnjgwZMQwLYdBDYxr6sb+H97D/jTdo2dZIkdIlXKTW2+zoh6ltf1FtPPq6BY3xTV64psX/P
 D4zXWedKRxgvBurImayXBDSnVYBdlQ2CYpwqOQN2XWqcgblUbp9vbeQ8O9IOPUvo4eCS9LJtSM3UBq
 ouzMVrWXeXOzXSzUGP+w7vMEOzxmkcXq9OrGcnZFOs4mt52C/DWcivqgcxJg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

There are other socket options that need to act only on the first
subflow, e.g. all TCP_FASTOPEN* socket options.

This is similar to the getsockopt version.

In the next commit, this new mptcp_setsockopt_first_sf_only() helper is
used by other another option.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/sockopt.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index c7cb68c725b2..8d3b09d75c3a 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -769,17 +769,17 @@ static int mptcp_setsockopt_sol_tcp_defer(struct mptcp_sock *msk, sockptr_t optv
 	return tcp_setsockopt(listener->sk, SOL_TCP, TCP_DEFER_ACCEPT, optval, optlen);
 }
 
-static int mptcp_setsockopt_sol_tcp_fastopen_connect(struct mptcp_sock *msk, sockptr_t optval,
-						     unsigned int optlen)
+static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int optname,
+					  sockptr_t optval, unsigned int optlen)
 {
 	struct socket *sock;
 
-	/* Limit to first subflow */
+	/* Limit to first subflow, before the connection establishment */
 	sock = __mptcp_nmpc_socket(msk);
 	if (!sock)
 		return -EINVAL;
 
-	return tcp_setsockopt(sock->sk, SOL_TCP, TCP_FASTOPEN_CONNECT, optval, optlen);
+	return tcp_setsockopt(sock->sk, level, optname, optval, optlen);
 }
 
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
@@ -811,7 +811,8 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_DEFER_ACCEPT:
 		return mptcp_setsockopt_sol_tcp_defer(msk, optval, optlen);
 	case TCP_FASTOPEN_CONNECT:
-		return mptcp_setsockopt_sol_tcp_fastopen_connect(msk, optval, optlen);
+		return mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname,
+						      optval, optlen);
 	}
 
 	return -EOPNOTSUPP;
-- 
2.37.2

