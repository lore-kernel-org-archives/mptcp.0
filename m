Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462C26F
	for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 16:21:52 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id l18so11881349edc.9
        for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 09:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ivbpaTVVBL4MEMu0vTeFeHFl9GFbfW0NHTnFMqxMujk=;
        b=aYdtj9iscXf8uci93ZtaCCivwjIHwc7M2wnO6k4iyTt9u9o7I6vhXHo4+Tuuc7fQ7k
         K55hrpLqCoqiew8HG/P9nDmpzSUgfgHkCOZUSZN3upRlr3jdlZLw9akwv/tjG5d9NEo6
         XDF1D3o4Zy9IVns/FLIlQfDkzDawzgIkLkTnEC9JjXEc/KFJAbYQeO6e+mJ5z7e5ZSJ6
         OmEbJsoOJeVkaNXOEB6Wpo/X/2RItsHZiZj6178tHGqQap4zkgodcs6uEZXKuavhgEyM
         Zu+mQJr/skgcopYjXF7Pnl1KrxZhFdPAt/wm7aBUUlJmDDHWwfhtSzOF6fbIq2miAJYn
         ccTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ivbpaTVVBL4MEMu0vTeFeHFl9GFbfW0NHTnFMqxMujk=;
        b=eEsvee5IVc5fSSIL6uA2mWnnnKtvUT1l8qOMSlx8d5BPayjUBBmw4tWX8m1AZ6SgAS
         mEIbnuc9JL9NOXfSHFI8CEgeT2GTUOSrWk625YlcFGzW83hiYEJus9y6HOR85sEBjgWO
         DFtT/CWG9wC7g9+sDBZUWOSOFIEwjb9zYgiup+FaS6o4g0BV/6XDxjXWJr/NHNiSPOa7
         OjtMSQfYtofOqqIa/qOsAdh+f2Izn4ZOXtZABQEbb9iCi3uq+dGwSKztBhakALaQWgMO
         Xz+QOdkVQeHJHFVAU4viSRJkIpBSISFIRFdn58UEpEgzCM7F+rMn2zdBpcPiPjKBsetl
         lJ4A==
X-Gm-Message-State: AOAM531oJxQpWe4Oa1mlHDCfTrD8Amcdot6J2nbNewEpZuuTycWX9rqA
	it+PLkvwC+QYccJ6AMxGLMyDsqnm3LTzYAnb
X-Google-Smtp-Source: ABdhPJwiuvXEL9eKjBSo3Xc3vrpyYjknfEsd6XH0rv0a8SdIjhU1ZZcxcNOXUUH16UH1++CbM0VMxA==
X-Received: by 2002:aa7:d9c8:: with SMTP id v8mr357850eds.9.1616430111242;
        Mon, 22 Mar 2021 09:21:51 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id wr20sm5694136ejb.111.2021.03.22.09.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 09:21:50 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev,
	mptcp@lists.01.org
Cc: Geliang Tang <geliangtang@gmail.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 2/3] Squash to "mptcp: use mptcp_addr_info in mptcp_options_received"
Date: Mon, 22 Mar 2021 17:21:31 +0100
Message-Id: <20210322162132.2471823-2-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210322162132.2471823-1-matthieu.baerts@tessares.net>
References: <20210322162132.2471823-1-matthieu.baerts@tessares.net>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix issues reported by sparse because we were doing non explicit casting
from __be16 to u16 and the opposite.

  net/mptcp/options.c:251:51: warning: incorrect type in assignment (different base types)
  net/mptcp/options.c:251:51:    expected restricted __be16 [usertype] port
  net/mptcp/options.c:251:51:    got unsigned short
  net/mptcp/options.c:261:51: warning: incorrect type in assignment (different base types)
  net/mptcp/options.c:261:51:    expected restricted __be16 [usertype] port
  net/mptcp/options.c:261:51:    got unsigned short
  net/mptcp/options.c:998:59: warning: incorrect type in argument 5 (different base types)
  net/mptcp/options.c:998:59:    expected unsigned short [usertype] port
  net/mptcp/options.c:998:59:    got restricted __be16 [usertype] port
  net/mptcp/options.c:1004:60: warning: incorrect type in argument 5 (different base types)
  net/mptcp/options.c:1004:60:    expected unsigned short [usertype] port
  net/mptcp/options.c:1004:60:    got restricted __be16 [usertype] port

Before the mentioned commit, we were using port in u16 in
mptcp_options_received, everything was OK.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/options.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 7fd40512df7f..43b85f2a5be1 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -248,7 +248,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			ptr += 4;
 			if (opsize == TCPOLEN_MPTCP_ADD_ADDR_PORT ||
 			    opsize == TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT) {
-				mp_opt->addr.port = get_unaligned_be16(ptr);
+				mp_opt->addr.port = cpu_to_be16(get_unaligned_be16(ptr));
 				ptr += 2;
 			}
 		}
@@ -258,7 +258,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			ptr += 16;
 			if (opsize == TCPOLEN_MPTCP_ADD_ADDR6_PORT ||
 			    opsize == TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT) {
-				mp_opt->addr.port = get_unaligned_be16(ptr);
+				mp_opt->addr.port = cpu_to_be16(get_unaligned_be16(ptr));
 				ptr += 2;
 			}
 		}
@@ -995,13 +995,13 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 		hmac = add_addr_generate_hmac(msk->remote_key,
 					      msk->local_key,
 					      mp_opt->addr.id, &mp_opt->addr.addr,
-					      mp_opt->addr.port);
+					      be16_to_cpu(mp_opt->addr.port));
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	else
 		hmac = add_addr6_generate_hmac(msk->remote_key,
 					       msk->local_key,
 					       mp_opt->addr.id, &mp_opt->addr.addr6,
-					       mp_opt->addr.port);
+					       be16_to_cpu(mp_opt->addr.port));
 #endif
 
 	pr_debug("msk=%p, ahmac=%llu, mp_opt->ahmac=%llu\n",
-- 
2.30.2

