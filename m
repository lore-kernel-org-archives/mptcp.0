Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A5C4C6C
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 15:26:20 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id n10so10409831wrw.12
        for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 08:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=m+4EL+V9F08z3c08xBzYaGa4a0MyGPdJ/MhJQ9u3gjs=;
        b=fOTQ2OP2kuQ01lpDSEmO84syJ2PKMyOPaRZOUAAdprEgmrvNUSszZrp6+3haquzHGM
         1V/2niZwPpgrx/7gSJlNAjxEWb0XeZ0UjRdn0KFwkYQmJItUD/ZG4TtwIG656ov9LEoC
         vos9zokNGQUn+g0oim+i+cWVrsF5lYycoPW7+uQ+Q+M8hufhZ01m8F/nYjUuiplQq2hW
         TrK6M7aDMyPfoVnZHEK0m+Mf1yHvWbV8+IHaU4+c5b5qfVhvcpkMrKe70FfHDbLlpTZ3
         KO7F+MXaTR5yoWSTSgjjZ4aONRp8gemZnOzi9avYmhO35RyDOupBF4WEO9un9lvtwTrW
         wEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=m+4EL+V9F08z3c08xBzYaGa4a0MyGPdJ/MhJQ9u3gjs=;
        b=w0l1hyOr+BXt+yIECSRIcA6tBAszwtyUzWtY2nk+yGBux62j+uzep3aiaehejtw7S3
         KOq+wKyJ7wz11LhBZFFwcnvKuf57BA7BSoHZg3ljVLx2PgD8050Jw5YdTCCwU8QpKgfS
         zT4Wst0dgx6pxW+DlUTt4x3ZFUPI1ZAkc7Tm4G/mL5ILS3wElZydleV2Mx90Z9rEts7F
         lvABfNG3OJjyKxFzOmR/Uu5K9yQOJoZj4R/K2CwXdfijsdg//AmRVN8O25hZ6DFuLJ7B
         B6i8UDCYliYj2nTJUBcNYrkt6eGau4UTpIyMR7iae+uRMZtP9IdB89wtiimi8ina03ew
         Jd8A==
X-Gm-Message-State: ACrzQf0XO2AwxFpUtsnewlisffDpVEVtM46bzgTwgTV1lxGzZWJ0g8w4
	Y5uvyUhCFBAcSFR3mfEAreKOlqde61nom+Scu3W/nFFxwcFmgJWlYPQaKlGltR5+V4blk72BMxg
	0nlahvEU004d6TR2iwfM=
X-Google-Smtp-Source: AMsMyM5s6k5ZFm6VZg4GBI3x79g0o2Zxdv2FucgogqsPcm8PR7FetW1kwkRX2jUHCqVWAAUS7whpRA==
X-Received: by 2002:a5d:64c4:0:b0:228:e143:ddb8 with SMTP id f4-20020a5d64c4000000b00228e143ddb8mr17177223wri.148.1663773978915;
        Wed, 21 Sep 2022 08:26:18 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c358400b003b4935f04a4sm3994435wmq.5.2022.09.21.08.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:26:18 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Subject: [PATCH mptcp-next v1 1/5] mptcp: add TCP_FASTOPEN_CONNECT socket option
Date: Wed, 21 Sep 2022 17:25:35 +0200
Message-Id: <20220921152539.1851441-2-benjamin.hesmans@tessares.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921152539.1851441-1-benjamin.hesmans@tessares.net>
References: <20220921152539.1851441-1-benjamin.hesmans@tessares.net>
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


