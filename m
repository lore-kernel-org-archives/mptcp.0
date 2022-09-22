Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEE83C2F
	for <mptcp@lists.linux.dev>; Thu, 22 Sep 2022 13:56:36 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id n12so15654912wrx.9
        for <mptcp@lists.linux.dev>; Thu, 22 Sep 2022 06:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=m+4EL+V9F08z3c08xBzYaGa4a0MyGPdJ/MhJQ9u3gjs=;
        b=SgHAsn42lOdDe9drrfZaJUBWupsWV+7vQAtzGZ6CcW8G5+C56BSJfejjlNRRsLHa+l
         BQSKSTm2bE+r97r1hMpQsCjZ+O8xtK+mDoi+C25toUHsL8+Fl4w9lEjo/LkRwb1hMEYv
         NWqgCB0dHGDyb4U8sig00bVWe7MnkTaR5MaWCiE+lOEd8rEAJI0iKW30wEqTgJOk6ecq
         tLyoVMIC0wuRMUvRZxA5fmjifrArdKbARb+2OKp1f9KdIp8f7JJF3WfKrbQHw+sfvpRL
         eFRwMAr6vGoD7CRjOV/DdDxORdz5RewHD6B+Q391x0T/X2s+1HEWF0mfVcEI0lOZyiU7
         vf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=m+4EL+V9F08z3c08xBzYaGa4a0MyGPdJ/MhJQ9u3gjs=;
        b=1BthQFP5MZV6sddwf5GMbY7WKrC3i65QemRCaLisZvv4X97hCKJJTHCsR4y/I8qO3H
         XbkQhMBBc6HHV2xh+g3MPcku01wGz9b1w6MAAetLoIcLgOJXuXnt854xbZkL/aHRXX5q
         /xlCHoV3iYHB9aMBxFjCVcoxW0W6VzdbjD0P8gtlD0FGx88rdWjXnYsG5BHP9BsRhxx+
         s65ckIbtZOpqbymcnVd8c18Z4KFTwtjkvkrgzQgjki7te9vlo1YMpqSz0s33YnKXgIWe
         g++oN6CFzRT6D1mhKjCCkj93Uc6J1tr4R6VeOZ96WU0oONgfAB3dLb9KV+focGql3M9f
         TphA==
X-Gm-Message-State: ACrzQf2uF4eLuUTYteqZAWcOEECsm7IruQqVlzN4KgarNrrXQgYMmC2O
	6uIlGAv5bRcerzpxTg1Qb6PY8YP3kL4zTuKFZuJ6VAqRc9y17V5bPHncLqw2w/PlQzNcjMwZf25
	rzyEjJIRIWEoCRBIJSMcp9A==
X-Google-Smtp-Source: AMsMyM4U/4ixscaP2okpxbHzG9xlbcX5cUHhZCmcQtphBA1nJyQfH6NMr+cFlRiMrhsfFrm3hXVAPQ==
X-Received: by 2002:a05:6000:243:b0:226:d241:11e6 with SMTP id m3-20020a056000024300b00226d24111e6mr2106715wrz.187.1663854994161;
        Thu, 22 Sep 2022 06:56:34 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id d9-20020a05600c34c900b003a844885f88sm6577053wmq.22.2022.09.22.06.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 06:56:33 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Subject: [PATCH mptcp-next v2 1/4] mptcp: add TCP_FASTOPEN_CONNECT socket option
Date: Thu, 22 Sep 2022 15:56:24 +0200
Message-Id: <20220922135627.2019807-2-benjamin.hesmans@tessares.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922135627.2019807-1-benjamin.hesmans@tessares.net>
References: <20220922135627.2019807-1-benjamin.hesmans@tessares.net>
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


