Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303638487
	for <mptcp@lists.linux.dev>; Tue, 21 Feb 2023 17:54:58 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id l6so3848691wms.3
        for <mptcp@lists.linux.dev>; Tue, 21 Feb 2023 09:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41ep6C1xypsS2k7qZ/c4mrPG0BOLEnQSouO8HX/u5pE=;
        b=GRjKBbLEZu95EMl3fZ7gxxREl8cQjHaKWPiE76PNumy42QZVHbYPKK0fUioPWLFN6f
         q6jYMGr/Vi50BXYHa51QyHOo8kkQDiIj5cieGgl/aGe0ejp3RQfJlCw7Zuscbqew2cZJ
         loy0arLd6N76V9ip7+E2px9DwRVpM8VAOMUOFbwFYxB/bW1v0aMRc/y8IgzlHiHzCiOx
         GZdsb9A3M1JWZZPV9I7X2slumiXaFrkBN3ENW+DxpkJk1SeeQyJPjBJD0bIzAdMlWAaz
         3z9v5G/sFae1UqLgIjG60pdxxIrA2xA36y0xffNXlB0Oz77IUABaYJrfywah8G+QTjV+
         9dmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41ep6C1xypsS2k7qZ/c4mrPG0BOLEnQSouO8HX/u5pE=;
        b=l9bVurtbbHWO1WagGyDC0UUTcs54Fg2LwLuAfiVRRdigKRSZRQkOvD/0aRVn423PWr
         YY7YU8Yy4A9gyueclseD9hzDelCsppfHufMawEz1+2j3zHTquAR3eSu/kYxT44BVNzmK
         kZCJaxfLmY/7TfDbhG23ukkRx3ZLVbURe+U/iG8Opi4TF1jBhIoBUEUv2F8t2zhxHoBv
         bI6ZBuJ6DlCYbs7p+zcmg9LjzF4LGm3PIYkMyb7hVgRiP18bREACuipJRRUEJ2Te7vuM
         TWBzcDb6qat1+TPU4E1zNN+afzh3H9uT2V6ZI75z1hJxpTbc9bzJTQxwWtzDGKDQQw5N
         UFDw==
X-Gm-Message-State: AO0yUKXWk6jgvV3poh1vXaHVAyt7zWLMQmsh8MY/8rfhJ9I7x3lUxuBU
	3qp9axPivTmbj6YDJC0Xe+SEJjQNpyPboKradCPNLg==
X-Google-Smtp-Source: AK7set8z6xxaNDvw/WutVAeJHzeA22peYpjhFOTeQWowo5cHUzdj8PptEe9DM/Eq3E/OA1bl8iDAog==
X-Received: by 2002:a05:600c:755:b0:3da:fd06:a6f1 with SMTP id j21-20020a05600c075500b003dafd06a6f1mr10363942wmn.31.1677002096825;
        Tue, 21 Feb 2023 09:54:56 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id t23-20020a05600c2f9700b003dc521f336esm4780228wmn.14.2023.02.21.09.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 09:54:56 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 21 Feb 2023 18:54:40 +0100
Subject: [PATCH mptcp-net 2/2] Squash-to: DO-NOT-MERGE: mptcp: use kmalloc
 on kasan build
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230221-mptcp-warn-tcp-done-close-v1-2-d248242b29b6@tessares.net>
References: <20230221-mptcp-warn-tcp-done-close-v1-0-d248242b29b6@tessares.net>
In-Reply-To: <20230221-mptcp-warn-tcp-done-close-v1-0-d248242b29b6@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=h8hW0VVGQ1OroTNQmzLv0XD4d15Hu4iijlgAWaEDsvE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBj9QVuW9fToGILn1RTCe+YvDMIbbOp+mVsgvBXn
 jjV54390CeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY/UFbgAKCRD2t4JPQmmg
 c2vhD/9UaRt2hgnOM2ImKdv47YyNSQYq2i/+qMKJNJnQTfjM6ABAa5oMF30qy4/AOpCCwixUA0k
 kEW3jQZ6wg5obwYUknza8FvhyJEQqyv6veyAN+e3kEZ8fj+ueoQ7Tl1XSiMtiJBgwpXy7QrzrZ2
 RcUtQQVxRfb20XlcWFd9XvGbFm6pxb05tWlcDXHC3F92i/EqVTxYPjqMrM+OKQZLfXn6K2XIiNB
 ekSgyjRbCtGBLbzOXk7/45YvhAj4OR9wPhewv62E2eB6Aoq6zytJ7obK78BLumytpfYF9AcdxOB
 fJ8rbX6h1Og4G8x5IJ9+nafr/NmZQ+Y/pRtN2FHlEwMpYc/77ExcKN47r5V2X0edb66/s8N9ulI
 RSIlPpGuxqXusqzPiBRoGu8Knj/h5PO+HYMz5wUKgQrtie7TWD48P1RUWHBMDakW+ltqPk2jK2n
 R8Z6kWTBr/rjHInepdenil+nMPhj8RYCPg7kgk0wXB3mbifF9OIPzQJtPINzl5adziBJo4Uh1Hz
 9YEvgsZSTSo1uCZX4+oociPQhQVA3OuNYfuUvh8YNMlyjJCpQ5FmlGnsdBjaWl2nXT886dfSJWK
 GoRLH14cXRgL/tP8PC4LqH+u5v3C1UaqE84VFV1DLF34veoJlF+4Z7YZTCW+2SJTI46DDqMG/ZM
 lLI0pAjSuVhBGmA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This is an extra check mainly for the CIs: to make sure we don't call
tcp_done() on an already closed socket as it happened in the past. If we
do such call, better to catch the error earlier.

This is not really related to the Squash-to patch (mptcp: use kmalloc on
kasan build) but it is just not to create yet another specific commit
for the CI added to both export and export-net branches. This commit can
also be renamed to something like:

  DO-NOT-MERGE: mptcp: improve code coverage for CI

WDYT?

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/362
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/ipv4/tcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 33f559f491c8..d21ec9bdd453 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4639,6 +4639,8 @@ void tcp_done(struct sock *sk)
 	 */
 	req = rcu_dereference_protected(tcp_sk(sk)->fastopen_rsk, 1);
 
+	WARN_ON_ONCE(sk->sk_state == TCP_CLOSE);
+
 	if (sk->sk_state == TCP_SYN_SENT || sk->sk_state == TCP_SYN_RECV)
 		TCP_INC_STATS(sock_net(sk), TCP_MIB_ATTEMPTFAILS);
 

-- 
2.38.1

