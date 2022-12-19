Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8804E10FF
	for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 10:24:31 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id w26so5889808pfj.6
        for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 02:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRCLrOsnQv07IXKjODW+I7y37LWMYDrzNA1WfJvP1nQ=;
        b=Jvk1x1BhKaUvF6PLpojnkc52n1tuqblkDYiR6D0LU4ZUcvm9MptJxHs/zcTSU57CLB
         jLMm+ygiDNJYT/9ShBjHKnevt+NwquRfGH+mMN/N5wGG7ZVocCJIa1ZoZJy735Sc493V
         ASXTBaLa9oqwr44UULeyCyjufQwmfAEh4n0bZP+x9FYYCajHkPrXhbt9nlc60qrzgSMH
         9n39RR9X/Z+EBclNoq/Csswh6zBU7FS9uy8TnCdZnYinAm36CCSpJLUKHz0TxDsHJtwB
         LlnwZyEOVwoxujQ2fcXwP03PPihWVhL+Q8bDSDLDBdAEzukj4KoY7iJnrpJJ+UC792Ji
         pkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRCLrOsnQv07IXKjODW+I7y37LWMYDrzNA1WfJvP1nQ=;
        b=54RTb9RGLfKB9s7kEL2mhJ7eo+CBi8u+HCBb8iC9ps1oLANk9PA5hAqi5OmtWfX6uw
         2u91bSTcZSK1uhnRLXXO0WyCe580PS6hGoaD2bFW/qnLOiCl3FTTP/AL6f2izwZ16b9i
         G29mSMFEdZ4gao2JCy+OmIaD+OMgMGLzKlI1wEqG9GABssUJQyzL3WCB9gU38Zrjm5EX
         luBNjPJMbypnLp1QeNdFbI6flMFaDL2SaS3EtenZhMAcOW+C7Oi7LrsKM9cTjBlExJcr
         JqTE1+kCSKquWsik0KPA346E+qsvbztW2uBo0ifUKlFtDiV3Pc7e/rfyGOeyuRXjX4ni
         D6Eg==
X-Gm-Message-State: ANoB5pnwFs4R9J3Ov91Q9YYtiTcaxQOvbSzMbTztxYV1ZHdtTd+j0LS5
	g/LfNCMwGbPD58kuCG1l9/E=
X-Google-Smtp-Source: AA0mqf7QvUWZGzTRHymf1G+xspmXJ+pvwe5pCttFCyiPPj7co2Qm9Fjzl9mcgWFdSCLI6ChXVTKVHg==
X-Received: by 2002:a62:640f:0:b0:574:f1bc:bbee with SMTP id y15-20020a62640f000000b00574f1bcbbeemr39385825pfb.31.1671445471045;
        Mon, 19 Dec 2022 02:24:31 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.23])
        by smtp.gmail.com with ESMTPSA id n5-20020a056a00212500b005775c52dbc4sm6206517pfj.167.2022.12.19.02.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:24:30 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v10 5/6] selftest: mptcp: exit from copyfd_io_poll() when receive SIGUSR1
Date: Mon, 19 Dec 2022 18:23:15 +0800
Message-Id: <20221219102316.627491-6-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221219102316.627491-1-imagedong@tencent.com>
References: <20221219102316.627491-1-imagedong@tencent.com>
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

