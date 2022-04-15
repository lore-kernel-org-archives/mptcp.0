Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA8433C5
	for <mptcp@lists.linux.dev>; Fri, 15 Apr 2022 16:28:10 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id x18so3359198wrc.0
        for <mptcp@lists.linux.dev>; Fri, 15 Apr 2022 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HluGETYzh5ckqPujucCJ5GuiEXbvqm3HY6UXh/FX4gw=;
        b=vDqIPiKnpsD+dj4c/U/WFlyPQyctFJ3WUyZxNUxAEAoKdWz8biZWzr7qGZE9vARxex
         H7rgVjxAYwtyTjImapmI5oZuYtki6lMPQurSMUIiiWvCE+WdsRCjqDtE8DheWBNQv5JE
         QMtudM6RJ41zQBOe45RHCc+BTSWB3aotQ9xtMHktREvJIpCDsKpncbw5XaE8sCOHYymj
         RktvF9Z4kVhr/2CLB+pX2Fsjma23Wq9HM7pkL9wo70x445NzuzGcZcqCGfS2tVCKxopG
         qBDTeoica1fHv78jbM5YH4ioSZjrreGhmP+Ip7sMQESQw7fi/SPbQoKZsylWUBdW/yDJ
         L4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HluGETYzh5ckqPujucCJ5GuiEXbvqm3HY6UXh/FX4gw=;
        b=mNbxPkuDn0vKO45B/PrcJvixJ8o0tJ/ZnvWyzxHKmFdKDrG9sMne1vFeS1VTm7WUxh
         I9C3+jEN2PM0DpxnkezqZdrJ0zG05p5KNhJ0tSyufpFHqbqjLL+WWEbDa5N4knQjxV4T
         3RALa/lIchuHXdUlYYIrqI4nJrhM3MThI7flDaU6jGDIFF3mitCXHU2FaXZ2z5VnPvja
         ZuMl1AFcyJiY4myEYuk0Oc3JF6veuavu2qWzOMhN66yhas2b1dAk7doUNu+4GXmNIq0x
         pLLiB8yo0THKjeM+yVjkMBlx6pet1x9/e7hRI8QVWCLvsu5sXb7eHMJ0QrIGIvKICNRN
         Z/hg==
X-Gm-Message-State: AOAM532SNAvvVTjSn+2gtRv1oTMXwHLXKZWHtxXpkPiHMi56mON6D9Db
	ES5gFRDDhyTgm2I5QDf7he/B6u8WWGRxkcqV
X-Google-Smtp-Source: ABdhPJxzSoEKj6entb9UwefXO2RLiHl7q6ej8y68FyqVvqM1v/eKrxhwBLiHgzs5b7y1n3QYNAwJ/Q==
X-Received: by 2002:a5d:64e7:0:b0:204:b62:94c3 with SMTP id g7-20020a5d64e7000000b002040b6294c3mr13601wri.243.1650040088757;
        Fri, 15 Apr 2022 09:28:08 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id m188-20020a1c26c5000000b0039187bb7e9asm2210630wmm.6.2022.04.15.09.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 09:28:08 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next] Squash to "mptcp: netlink: allow userspace-driven subflow establishment"
Date: Fri, 15 Apr 2022 18:28:01 +0200
Message-Id: <20220415162801.1675860-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a compilation warning without CONFIG_IPV6 but with CONFIG_MPTCP:

  net/mptcp/pm_userspace.c: In function 'mptcp_nl_find_ssk':
  net/mptcp/pm_userspace.c:309:28: error: unused variable 'pinfo' [-Werror=unused-variable]
    309 |   const struct ipv6_pinfo *pinfo;
        |                            ^~~~~

Reported by the CI:

  https://github.com/multipath-tcp/mptcp_net-next/runs/6039191808?check_suite_focus=true#step%3A6%3A10367=

That's a shame these warnings were ignored :)

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    to be squashed in "mptcp: netlink: allow userspace-driven subflow establishment"

 net/mptcp/pm_userspace.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 735ff7ff71af..fce61530fe9e 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -306,7 +306,6 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 	lock_sock(sk);
 
 	mptcp_for_each_subflow(msk, subflow) {
-		const struct ipv6_pinfo *pinfo;
 		const struct inet_sock *issk;
 		struct sock *ssk;
 
@@ -324,12 +323,14 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 				continue;
 			break;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-		case AF_INET6:
-			pinfo = inet6_sk(ssk);
+		case AF_INET6: {
+			const struct ipv6_pinfo *pinfo = inet6_sk(ssk);
+
 			if (!ipv6_addr_equal(&local->addr6, &pinfo->saddr) ||
 			    !ipv6_addr_equal(&remote->addr6, &ssk->sk_v6_daddr))
 				continue;
 			break;
+		}
 #endif
 		default:
 			continue;
-- 
2.34.1

