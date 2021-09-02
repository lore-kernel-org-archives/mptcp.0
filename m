Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BF13FC1
	for <mptcp@lists.linux.dev>; Thu,  2 Sep 2021 07:01:42 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so777597pjq.1
        for <mptcp@lists.linux.dev>; Thu, 02 Sep 2021 00:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8XwKyRAUDGY4JUeaDKAMif9csc/nwuvAGPGqLT6WPGM=;
        b=GzKdwTN3MI06Yy6Uoq35pVjrvuttjdOyjw604EgibJ7i2F2HoUIiJzWzKkfzk2v/kz
         hKTw8/0YDeCT4Wsp3sIylO7au9Xhb6n9pkNPi8txtKIn20Etji2IlDKUsTWYQzxCwi4q
         js4BGvjh1xvNeAhTLRi4mPQEA3FVeobQn2L/oL5qk78WX9sFIDgs8zR73rnCl39Mq6BP
         ovHMMR8p1AGin9Uew1X1dku8EmWodg3Hn9Fkg0/3lvZmS5PyxciIDaQby0uaels3NWjp
         lo7IuL5x8sDo1VE/Q4XZLXTGLS7Jv0mh1Nbtjhq3tHwZe1Gu1/f8RP6W/+ZqM81xwAI6
         8Rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8XwKyRAUDGY4JUeaDKAMif9csc/nwuvAGPGqLT6WPGM=;
        b=Fj0zwKm+cjzOKxEzt8BODGyZHO/3OpctYah/R7YUbrJdRQNy/a37mFRZ4arE6c9ZUN
         kFAGmCbte+t/BW79KoVApNflhTsML7grFntmYbCWS9mhvKEs9k1F/Z1KYqq0m2vDzN+Y
         n1UaUT02mOUU9+MekL5bvIDloSe5DNGlMXaslWLcrftwVDzvQpExSU28hBiEcPsN7MeK
         XSDKwRe2TqME71rbmUN64DiB+E3H2k+p2fwOcuchuhQzbon+HGv031qDFKKADhFGeshy
         1HkyfRcTZkoWQTQKyZR2uX4+iq2pHG4c0PB+C3G80o06H5CTa8Mnv2K2M/qL9ky9g/gm
         oC/g==
X-Gm-Message-State: AOAM532A7Vd751Z/58WlkWx1Adki5CDLBMaKDsZPz39ncimRxf5Eo53b
	K5sggDmHNBDuHo0RkaruUrGiG/SOHQk=
X-Google-Smtp-Source: ABdhPJyuBUYvsG8R6qNtkyjIUtdCvfkMa5pXuJCqTZSav2vxg/DHVUSWYwl1jRYtRj6raqfVRa5Qew==
X-Received: by 2002:a17:90a:fb96:: with SMTP id cp22mr2278745pjb.211.1630566101828;
        Thu, 02 Sep 2021 00:01:41 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id o1sm1101503pjk.1.2021.09.02.00.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 00:01:41 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH mptcp-next] mptcp: use OPTIONS_MPTCP_MPC
Date: Thu,  2 Sep 2021 15:00:19 +0800
Message-Id: <213e62f81b8daf3309039a0679a6925c5122b0b2.1630565830.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

Since OPTIONS_MPTCP_MPC has been defined, use it instead of open-coding.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/options.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1ec6529c4326..cf4ef11916c9 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -749,8 +749,7 @@ static bool mptcp_established_options_mp_prio(struct sock *sk,
 	 * 'backup'. Also it makes no sense at all
 	 */
 	if (!subflow->send_mp_prio ||
-	    ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
-	      OPTION_MPTCP_MPC_ACK) & opts->suboptions))
+	    (OPTIONS_MPTCP_MPC & opts->suboptions))
 		return false;
 
 	/* account for the trailing 'nop' option */
@@ -1327,8 +1326,7 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
 			}
 		}
-	} else if ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
-		    OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
+	} else if (OPTIONS_MPTCP_MPC & opts->suboptions) {
 		u8 len, flag = MPTCP_CAP_HMAC_SHA256;
 
 		if (OPTION_MPTCP_MPC_SYN & opts->suboptions) {
-- 
2.31.1

