Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5A971
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 10:38:06 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id m12so7565191eja.2
        for <mptcp@lists.linux.dev>; Thu, 06 May 2021 03:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4+vffMCL0zwLHN+KbG8GOAVJ/8MzFakj6qwlUujSFPU=;
        b=OhkZdcc5JzgxENzEluH8NUTzN0NOaVpoGfduEfyw4H0sXxCUVj9bIs5DCbUxT0u5gf
         vJ7Y9k9vwd+gJxwJB+FOmz/N7JUoF34ADIQvtBhXKdvFbXb4/8ilg2jGt33qF6kTfCOp
         naaBjT89A7FMtaaDswyMkH+42cE43cn2ysAV8nx8cds9c0xjIzbjhEi5NIvhgrPAWEeN
         N7zTsPJ792Qao2QgtKoidLQLBNkKDdYfJKblWty4k8gI8Jr7ogEjcbio7+Dks1tik8HX
         ZuMOJhEs0Xcs6txu33dFeDd3bCub8y9ALZ2mIslFIPQWrFPmOx2zmiNt0HcEdPVfJh0N
         8iNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4+vffMCL0zwLHN+KbG8GOAVJ/8MzFakj6qwlUujSFPU=;
        b=gFX2FgFW+tO8j9jpYdv9rpT1mXp5FEPvW9kaK6I5qrEf4HMnlyIeVuXj858HeE9N+M
         3yi35WlcakZR9+bsniqawvkY1zbNH3yPA1qFoX6MiYSViYGTV3VFJSHVuqVqEyEYDj0g
         JfARSpKOkUsALSg7il867p2vHaGVrMLG4ktlcX2Fb9qD8vBF6JnONyKmLUvSMrTSCn0a
         qsG6IiXDn7SGnnHvAlAfTJYw2+UBmPJi6HdKQvVY3NH3YPRUJTgfO6FT+cyKd1PPszEk
         U4FNIuPhPRtti5DO92oXY0E8g4eY1oE28VN+OLYw0b4uYQioXzcnnLNcqyHXLJOJnj/T
         NGuQ==
X-Gm-Message-State: AOAM533xSm5gyWfXR5VfD61q2cvRvtzNEPh3CHzvo6ufzhzbXQ6HytHz
	hlnANsitetnntFn6R6RPe5bsmj2zateTyKtswaw=
X-Google-Smtp-Source: ABdhPJxQVI27aDu13z86/WMo4vM125H+RKN0xbJhAQeujf4nZtJL8GBMP7nG+5yp16LWpx2kXD3g6g==
X-Received: by 2002:a17:906:6544:: with SMTP id u4mr3628555ejn.455.1620297484414;
        Thu, 06 May 2021 03:38:04 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id d5sm1334510edt.49.2021.05.06.03.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 03:38:03 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next] Squash to "mptcp: add a new sysctl checksum_enabled"
Date: Thu,  6 May 2021 12:37:34 +0200
Message-Id: <20210506103734.3845725-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.30.2
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a compilation error without CONFIG_SYSCTL:

  ld: net/mptcp/protocol.o: in function `__mptcp_init_sock':
  protocol.c:(.text+0x43e): undefined reference to `mptcp_is_checksum_enabled'
  ld: net/mptcp/subflow.o: in function `subflow_v6_route_req':
  subflow.c:(.text+0xa0a): undefined reference to `mptcp_is_checksum_enabled'
  ld: net/mptcp/subflow.o: in function `subflow_v4_route_req':
  subflow.c:(.text+0xabd): undefined reference to `mptcp_is_checksum_enabled'
  ld: net/mptcp/subflow.o: in function `mptcp_subflow_init_cookie_req':
  subflow.c:(.text+0xb74): undefined reference to `mptcp_is_checksum_enabled'
  ld: net/mptcp/options.o: in function `mptcp_syn_options':
  options.c:(.text+0x68a): undefined reference to `mptcp_is_checksum_enabled'

Simply moved this function outside CONFIG_SYSCTL with the other ones.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    to be squashed in "mptcp: add a new sysctl checksum_enabled"

 net/mptcp/ctrl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 014752c481d0..603e0c851d2d 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -41,6 +41,11 @@ unsigned int mptcp_get_add_addr_timeout(struct net *net)
 	return mptcp_get_pernet(net)->add_addr_timeout;
 }
 
+int mptcp_is_checksum_enabled(struct net *net)
+{
+	return mptcp_get_pernet(net)->checksum_enabled;
+}
+
 static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled = 1;
@@ -49,11 +54,6 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 }
 
 #ifdef CONFIG_SYSCTL
-int mptcp_is_checksum_enabled(struct net *net)
-{
-	return mptcp_get_pernet(net)->checksum_enabled;
-}
-
 static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "enabled",
-- 
2.30.2

