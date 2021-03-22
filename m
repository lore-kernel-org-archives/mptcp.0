Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727E570
	for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 16:21:53 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id bx7so20060582edb.12
        for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 09:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DC+koeXj12o1HVjJM/IuLVLGUSPZ6EaQ2Za3c6x/wrU=;
        b=IR+ZaL7Vm7FLpFM7VBV7X9+g5UYPcfp+g2lNNykR6ijgTXqhxfk1hky1MWwmny43Yf
         Ej+osGD5jzhaogswfI8VBUXbRzNRCXJ+j68yRBf+HajDZdBWR7hbrwvNX7M7yf8HGnUf
         XJM2gbr3LHoItSzAYPhuGU5+knXovMfvBsUdoiz/RUc8K+OnNN5w2UHCn/dtqdmUwAGN
         jSilWOMLj1uomj57UT1BArRvic0YQjYu8TMuMihrAW7MUMRFTtn9WTK2NImatAUMQI0i
         XT+ZvD/PZbEoHlMnl04V6+t0Xmpj1enchpVD5h80Q6cafbYSddj9EYAysGpRf7IgQBL9
         i96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DC+koeXj12o1HVjJM/IuLVLGUSPZ6EaQ2Za3c6x/wrU=;
        b=QE9eREmunALEEzb8xioT0dyxx+XnsgY+pgh4vCEn+/Jtw/eqMd7eGLSjDP96I/AQT7
         bdYqNkfzBWcZnHIxhqvHji9LPObuwb2gXO94+O1rXcFsx3/Ss2FiDVyIBNu2wCTB0uCB
         jwxDiPNlIxULsLQLuvdwpwBmb2i8llbcGKT7jpakWfZSwyqNd8+sVJe192BMm8Yv+/jC
         sFdvwfjj4FR8kvmpE0G8OU8PzBNOBpHCijoKhaSQF2xCBeePycTBNl4LZ9hXUp9nq0a8
         tJeIGrB4PLAWj2kf3nkcm/9So2viXlywQonXbSLgd51W1CV52YK6DtKaznMRNNSgothw
         +2ow==
X-Gm-Message-State: AOAM532zlqznhOt991ftNmoz8GiOhJ1GTyNLL9tMo6+oL9TsLY4IhAcp
	JohbMLzvkw9dEMFnKpJ5LlmT9jHWplomv2my
X-Google-Smtp-Source: ABdhPJxgQiCnBhFggAwvQL/ExAUUDcqnXQdQLqaBpfhav+J7uWMDgi1FcQyjmMbdN+3KyWQPlYQlsg==
X-Received: by 2002:a05:6402:10c9:: with SMTP id p9mr389019edu.268.1616430111869;
        Mon, 22 Mar 2021 09:21:51 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id wr20sm5694136ejb.111.2021.03.22.09.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 09:21:51 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev,
	mptcp@lists.01.org
Cc: Geliang Tang <geliangtang@gmail.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 3/3] Squash to "mptcp: drop MPTCP_ADDR_IPVERSION_4/6"
Date: Mon, 22 Mar 2021 17:21:32 +0100
Message-Id: <20210322162132.2471823-3-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210322162132.2471823-1-matthieu.baerts@tessares.net>
References: <20210322162132.2471823-1-matthieu.baerts@tessares.net>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix issues reported by sparse because we are doing non explicit casting
from __be16 to integer.

  net/mptcp/options.c:604:24: warning: restricted __be16 degrades to integer
  net/mptcp/options.c:605:24: warning: restricted __be16 degrades to integer

Before the mentioned commit, we were using port in u16 given in argument
of add_addr_generate_hmac function, everything was OK.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/options.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 071b446aa2c9..d9e5f864d774 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -586,6 +586,7 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 static u64 add_addr_generate_hmac(u64 key1, u64 key2,
 				  struct mptcp_addr_info *addr)
 {
+	u16 port = be16_to_cpu(addr->port);
 	u8 hmac[SHA256_DIGEST_SIZE];
 	u8 msg[19];
 	int i = 0;
@@ -601,8 +602,8 @@ static u64 add_addr_generate_hmac(u64 key1, u64 key2,
 		i += 16;
 	}
 #endif
-	msg[i++] = addr->port >> 8;
-	msg[i++] = addr->port & 0xFF;
+	msg[i++] = port >> 8;
+	msg[i++] = port & 0xFF;
 
 	mptcp_crypto_hmac_sha(key1, key2, msg, i, hmac);
 
-- 
2.30.2

