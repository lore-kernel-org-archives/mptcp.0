Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C3172
	for <mptcp@lists.linux.dev>; Fri,  7 May 2021 01:12:52 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id m12so5980144pgr.9
        for <mptcp@lists.linux.dev>; Thu, 06 May 2021 18:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WWoCcbO20WtqWseWINCbKemXG4nu8tp4G+fbOhGxUs8=;
        b=jJnbVDpWMqgxcHAVIGgruFzmAq6VuWeHvns7tRq9yWTH/3VXxgt57NlYq12bXw3XC7
         CLyPyr142YP8ZCld2VDLEIHspYa3bH8KyM8eKrPyegPilx3O+Iakcnfaa3CndiedPrHQ
         lcmt4D+aE72cLobGOulA4aOdY8ME+LvX8LDpI0wULUsZ0KA2dS1f+i8Zq4PF4TroCewo
         xTf47RkOIbaFsxMb1hO4xYS+ZhC5GKrdlAIpr2UxKaH1mA14Tu26wwIN4BRaPnXm2+zZ
         4eKrljY3u8ziHSWvJEKHSjjnUCwY4+w3BOl5c6dEecBISnOBd9dHxk5zXvoLRykoS2A3
         LS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WWoCcbO20WtqWseWINCbKemXG4nu8tp4G+fbOhGxUs8=;
        b=bhwpV6AKRKKNZ5uYg7q9ZkUFHiv1S5R+Z8OJlmDge39KlJbrnKd+m1XFo1Qqp5yYRh
         bBv6owsScGt8L7ZzgnjrEIFsnY3WWmHipnDghKlY2XEfkZlZaV0AXgPGi3K4D/RxbTcU
         s8/yFz6oJAf8JL2kHQUsXe+gADXRRP3iGf/pdsWfkgriUqPlbMb5up/xqFSjbxY2DOE7
         L8ARgocuQH7izZzJGamf44kBqh948lb0RUBlr8zGIIUUq41TAgPl5toVYnpgu84uHY0F
         zpwPFQMhJTKFRAQE7xykB/76Jyo9x36SOWnBYYXZb+cDMWAdI80VZc43xOGTvqxn7OED
         dBdg==
X-Gm-Message-State: AOAM530fS75Fsa3FKIX2tZEXPuyqnV8OWq6tp60T7RV4d6+ixIz82zTK
	kt9uMwpgHaE2e8g7R0X002gGWAKoVLs=
X-Google-Smtp-Source: ABdhPJy7dfL8yr0Sj4KIFNQYlAHdLAefoKOakhOn4mFd6ud4olSi0ATRAqKr0EgDhWMuPr4CFwdjlQ==
X-Received: by 2002:a05:6a00:2b5:b029:28e:9c4b:b8b4 with SMTP id q21-20020a056a0002b5b029028e9c4bb8b4mr7449856pfs.22.1620349972484;
        Thu, 06 May 2021 18:12:52 -0700 (PDT)
Received: from localhost ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id 187sm3142800pff.139.2021.05.06.18.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 18:12:52 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next] Squash to "mptcp: add sk parameter for mptcp_parse_option"
Date: Fri,  7 May 2021 09:12:47 +0800
Message-Id: <f3808e3bfccf51a4a41e8ff3c793a464d8c3ae61.1620349748.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep mptcp_parse_option unchanged.

Please update the commit log too:

'''
mptcp: add sk parameter for mptcp_get_options

This patch added a new parameter name sk in mptcp_get_options().
'''

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8f768c517586..1d360639ca91 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -20,8 +20,7 @@ static bool mptcp_cap_flag_sha256(u8 flags)
 	return (flags & MPTCP_CAP_FLAG_MASK) == MPTCP_CAP_HMAC_SHA256;
 }
 
-static void mptcp_parse_option(const struct sock *sk,
-			       const struct sk_buff *skb,
+static void mptcp_parse_option(const struct sk_buff *skb,
 			       const unsigned char *ptr, int opsize,
 			       struct mptcp_options_received *mp_opt)
 {
@@ -365,7 +364,7 @@ void mptcp_get_options(const struct sock *sk,
 			if (opsize > length)
 				return;	/* don't parse partial options */
 			if (opcode == TCPOPT_MPTCP)
-				mptcp_parse_option(sk, skb, ptr, opsize, mp_opt);
+				mptcp_parse_option(skb, ptr, opsize, mp_opt);
 			ptr += opsize - 2;
 			length -= opsize;
 		}
-- 
2.31.1

