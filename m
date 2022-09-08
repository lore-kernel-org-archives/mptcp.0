Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5F4322B
	for <mptcp@lists.linux.dev>; Thu,  8 Sep 2022 13:38:53 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id n17-20020a05600c3b9100b003b3235574dbso1344321wms.2
        for <mptcp@lists.linux.dev>; Thu, 08 Sep 2022 06:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=fQErWLix5lykv/59ThKYcc1uUrv70Mw0NixnLuT+mRE=;
        b=eK3GJsTfiwpr9RquTeRCoJ9y8eOyqhMdI9Ljgn/u1S0PGI1FFDr/mGvmy6i7Q2/6u7
         c8dOCJfQXiMCUb0I6bNh2i1MqsMdD/NMECdiesTXF1mILQ7S2qgU9DycS2fH0KtcLOpU
         G4rxUk9zs2iDScP2dhmTQtkeEgXerryIjDYlJQeDMH5em+9nNsA/Hv7gxZHuxEDHSoaT
         rVyos51aT11uN9IFS3eibEeD3eSPDYRnWPdVb+/NRpNrW0MvxVdi3h6d2Rh5/Fw3HC9P
         i+a4JLUQaxV8xt2gFKTQN21S0vEFaGuBPX2z4wlIqk8sPrDP+eUa2D1pjMIX9PbS+vbT
         ZoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=fQErWLix5lykv/59ThKYcc1uUrv70Mw0NixnLuT+mRE=;
        b=isPW3QLmwBbS86HIi7KZKAIoEqgkt3t1R2I1fu1+ey4wso56coRn/TijT8jyRM2yDE
         P51QkGnOIcqIWYOSAwL9tRUb1r+9chxqB8HPxIv9EU2wN4vm+u2Krw6UoPIDYeecpv8K
         0d5vH3NfpToOUGccq65wxDvn4NG9VROd0X1jOD3YAuBb5ubAERbAz1DYUI0vkergrn83
         SXVU/usP2f8xdj5G629qaIHi8S2HcsZ4uaPyyUW4ruyM37DOi6cdnRS89EWwLU/06kIt
         QvbCeLcxispqeQZYcU7FApXatP8x4Bdg8NISE28eJK2oBzwaXMFdVbyStLiQV/dQxOeC
         gFvA==
X-Gm-Message-State: ACgBeo08dkwWJlVXXcULHRZ3ctRhwWFSNEKUhmg6K63PQdQ1RGBS44ko
	MU3hEHD3edsk4UR5EvpZYGXyI1tKejfJMbRzbwAYJnTU3HXuTAKSTlUZ/jtlqptQtyA8h7ILuMu
	LstZe69/CiqngyTESHLyL3Q==
X-Google-Smtp-Source: AA6agR6qJ7hIBcmJjaGFbVb1g1h6mKpgxAPBpfoJfZ0HKQCVkzxufYjec3wFZSAMKL79QSopwP4VMg==
X-Received: by 2002:a05:600c:601f:b0:3a6:28e:be81 with SMTP id az31-20020a05600c601f00b003a6028ebe81mr2312754wmb.35.1662644331959;
        Thu, 08 Sep 2022 06:38:51 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id fc15-20020a05600c524f00b003a5260b8392sm3100822wmb.23.2022.09.08.06.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 06:38:51 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Subject: [PATCH RFC mptcp-next 08/10] mptcp: allow data that can not be DATA_ACKed
Date: Thu,  8 Sep 2022 15:38:27 +0200
Message-Id: <20220908133829.3410092-9-benjamin.hesmans@tessares.net>
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

With TFO, this first bytes are out of the regular MTPCP seq numbers,
hence they can't be DATA_ACKed. The data ack validation can then be
skipped in this case.

Signed-off-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
---
 net/mptcp/subflow.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c2d1ba21c8c2..ca5b9853eca3 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1221,6 +1221,14 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		if (WARN_ON_ONCE(!skb))
 			goto no_data;
 
+		/* with TFO, we can have data, but we don't not yet the data ack
+		 * because its not part of the MTPCP seq number.
+		 */
+		if (unlikely(!READ_ONCE(msk->can_ack)) && TCP_SKB_CB(skb)->is_tfo) {
+			pr_err("%s (%i): can't ack yet, but already got data\n", __func__, __LINE__);
+			goto valid_data;
+		}
+
 		/* if msk lacks the remote key, this subflow must provide an
 		 * MP_CAPABLE-based mapping
 		 */
@@ -1240,7 +1248,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			mptcp_subflow_discard_data(ssk, skb, old_ack - ack_seq);
 			continue;
 		}
-
+valid_data:
 		WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_DATA_AVAIL);
 		break;
 	}
-- 
2.25.1


-- 


Disclaimer: https://www.tessares.net/mail-disclaimer/ 
<https://www.tessares.net/mail-disclaimer/>


