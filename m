Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9940AED2
	for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 07:51:54 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so8098001pjm.2
        for <mptcp@lists.linux.dev>; Sun, 18 Dec 2022 23:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRCLrOsnQv07IXKjODW+I7y37LWMYDrzNA1WfJvP1nQ=;
        b=aFr5rZujt1sXwrZgxD4tNKDjdGWwr+C6YyhxLNvsqhfDHI+SYYlRc2gkj3gYAjXQkz
         cgQSLAg2fso0ko8QiHp0coehhdAK9VycDGmeXcayPLngNCvjzzAUH0YSCI7a/D+9vOkZ
         ZeulcxyuKkvf7pti3gGAt7tEK7qMccQqFelOorJdKo3Bi5EaSHxriuKp7uA04oej34AP
         YvLqQPK/QoyaRE7w3ncvKgUZbRU19fcb8ZpLg4x3IwOO6Aymls4iTwtEO85KrOBzktyu
         rodGZLP3UqTdKMMh+/aDU85PWPcySgto7Glj4FZWakwgiTJxC5hhESUyJMlel13jjWhO
         40Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRCLrOsnQv07IXKjODW+I7y37LWMYDrzNA1WfJvP1nQ=;
        b=opBHL1UzzU4qm0wsdNAKOOYaaNVI+AIcm7+3klCRd/XWlRiQI13Hf4+xfniyBS7oBh
         VNAdSdO/jS/VFuQu9LSkwljXxM4Q+53aG6AGGzTBQTomiuW68Arc9MIqCcy3SRre4HR2
         YeuIKb32fVg/dEeGRdsPAmbyZpY1b6HQoDfsDg1/i9KrWFPti/BBbRLDE51YzFCrnK31
         n4zQSFyvJRlM6uQUR0ke/pbMfk/32/Ih3oW1+0kx+X0bWXBU4p6h5LYGJ8b9fBnbHQQF
         XXZGPpS/7j3XWCBSfOMgA+liT46/0Gkyv9R+5Oc94r08IVhMMiitN0OALGURnEti2nhr
         ASyg==
X-Gm-Message-State: AFqh2kpsMuSoI08OdBwVUtjJgbfs76Kgh+SkhB8JHSxB5fO5MWVB91AK
	SPxtWGl7M5DC+qDrr7ER/i0=
X-Google-Smtp-Source: AMrXdXvWPtdF00rydtboidd9lSqgiFmRaDt/0tc4WGgpZPSFtRBY8dLyt6JtZSwCcMlxy9TZKO5Lgw==
X-Received: by 2002:a17:902:b48e:b0:191:1729:d7e7 with SMTP id y14-20020a170902b48e00b001911729d7e7mr7207780plr.67.1671436314339;
        Sun, 18 Dec 2022 23:51:54 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.21])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e84900b001888cadf8f6sm6366673plg.49.2022.12.18.23.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 23:51:54 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v9 5/6] selftest: mptcp: exit from copyfd_io_poll() when receive SIGUSR1
Date: Mon, 19 Dec 2022 15:50:47 +0800
Message-Id: <20221219075048.255811-6-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221219075048.255811-1-imagedong@tencent.com>
References: <20221219075048.255811-1-imagedong@tencent.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <imagedong@tencent.com>

For now, mptcp_connect won't exit after receiving the 'SIGUSR1' signal
if '-r' is set. Fix this by skipping poll and sleep in copyfd_io_poll()
if 'quit' is set.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 8a8266957bc5..b25a31445ded 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -627,7 +627,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 		char rbuf[8192];
 		ssize_t len;
 
-		if (fds.events == 0)
+		if (fds.events == 0 || quit)
 			break;
 
 		switch (poll(&fds, 1, poll_timeout)) {
@@ -733,7 +733,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 	}
 
 	/* leave some time for late join/announce */
-	if (cfg_remove)
+	if (cfg_remove && !quit)
 		usleep(cfg_wait);
 
 	return 0;
-- 
2.37.2

