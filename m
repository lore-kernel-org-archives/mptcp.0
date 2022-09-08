Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B693236
	for <mptcp@lists.linux.dev>; Thu,  8 Sep 2022 13:38:50 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id ay12so10871171wmb.1
        for <mptcp@lists.linux.dev>; Thu, 08 Sep 2022 06:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=t2/YaAxgyy/OOZOJQPeEbBb47g9kLxiWAoD8s2+msRM=;
        b=Z7nlX548AX1G6qLtSntbec+ub3PGcVAIjvO0umIa8e+M7eD4powsPkVdH1Wz4NoG5f
         1zSNgj6GZXtB1HqjFjyXWUgQ/4ELi1Q3d68Usw+Tjsu3Dta/Jk2eFVEUhYQ1veDXr75Q
         5563TjQwmGtiBqupxvMCFRodHW98ZsU0DYfYyWSmpup6lTG4emruC82laF1ppdDoo8Kj
         WHQV+jbeYRa7wR1gnaNE65RZ8Df1qMpsvpbiUZDmwqSIcNKb4tIOk7bT0fH+n/nuCXSG
         4uYPevUQMExCGhtRloWS/hVWFc2eMRYbDfiLATeX0XDWKcdnubjAakoUNRJQZm3SMjip
         vbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=t2/YaAxgyy/OOZOJQPeEbBb47g9kLxiWAoD8s2+msRM=;
        b=OiUUkJUsLNf9AcF3b1oPuTT/W3EAgoJn6jgp46DssgzmlQLJw9h+OP+BiYPJsqpEW6
         l7A0GP5DmLsOc8H7oiscgMAaR9QNPbgY4Vgv02zSpBhzhDiO3UNmUyyVb2eOLVG4XdbD
         kW17tsL8usnFdCEnc8GoyANfj6dnLFUdPxyzJYbBlXF65vHFIuUkbSph1Gq+WsIeSRWu
         q5llK5BQJbaSZrTpXdcIqvWdnP7J2hbpAuZSJC2xx2SVzkOLAL4Fw8YEIiR+rRLx2i71
         bm1G8WjujdjXdpkA0/YuCtqw8ME5eWvXhfydXznR+4aVpF3rOiqvZ136RT1Ay9Ss9hkc
         H8lA==
X-Gm-Message-State: ACgBeo0sY/jX9RWLiIYTkZ6lscwG3WVF+SNT0tcWhjvHJ9p/pqbaEFYO
	Q83tImjhGZxJNQg7fQbrtmNUiSMSNtIRoyueoUPxwWMhU4cTvhNJFtruqEHxn1/2gXlGJkWf4Dc
	QiASe5MZofzJMqYQf8acm9Q==
X-Google-Smtp-Source: AA6agR4la1muqizlPRZy/sezaazm0zGq64w8/sEhwYLUWi+qDggQd2canD8QPzAgU4nBBKYu+I2kIQ==
X-Received: by 2002:a1c:790b:0:b0:3a7:b69a:da24 with SMTP id l11-20020a1c790b000000b003a7b69ada24mr2317946wme.135.1662644328884;
        Thu, 08 Sep 2022 06:38:48 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id fc15-20020a05600c524f00b003a5260b8392sm3100822wmb.23.2022.09.08.06.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 06:38:48 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Subject: [PATCH RFC mptcp-next 05/10] mptcp: delay mptcp data_ack calculation
Date: Thu,  8 Sep 2022 15:38:24 +0200
Message-Id: <20220908133829.3410092-6-benjamin.hesmans@tessares.net>
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

On the listener side, with TFO (and mptcp v1), the socket is created
earlier when the stack does not have the remote key yet. If the full
socket is created when SYN+data is received, avoid this calculation that
would be incorrect.

Signed-off-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
---
 net/mptcp/options.c  | 1 +
 net/mptcp/protocol.c | 2 +-
 net/mptcp/protocol.h | 3 ++-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 30d289044e71..79f83236aa6f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -91,6 +91,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			ptr += 8;
 		}
 		if (opsize >= TCPOLEN_MPTCP_MPC_ACK) {
+			mp_opt->mpc_ack = 1;
 			mp_opt->rcvr_key = get_unaligned_be64(ptr);
 			ptr += 8;
 		}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c249ce632c5f..f5a0dd589ad5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2975,7 +2975,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
 	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
 
-	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
+	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC && !mp_opt->mpc_ack) {
 		msk->can_ack = true;
 		msk->remote_key = mp_opt->sndr_key;
 		mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1bc9f6e77ddd..afb2f0ce9311 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -155,7 +155,8 @@ struct mptcp_options_received {
 		echo:1,
 		backup:1,
 		deny_join_id0:1,
-		__unused:2;
+		mpc_ack:1,
+		__unused:1;
 	u8	join_id;
 	u64	thmac;
 	u8	hmac[MPTCPOPT_HMAC_LEN];
-- 
2.25.1


-- 


Disclaimer: https://www.tessares.net/mail-disclaimer/ 
<https://www.tessares.net/mail-disclaimer/>


