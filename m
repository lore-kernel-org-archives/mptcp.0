Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBAA62C
	for <mptcp@lists.linux.dev>; Thu,  8 Dec 2022 02:46:42 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id a9so225417pld.7
        for <mptcp@lists.linux.dev>; Wed, 07 Dec 2022 18:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRCLrOsnQv07IXKjODW+I7y37LWMYDrzNA1WfJvP1nQ=;
        b=N/CkSZHjQMiVTSlkUTS2f5BzDh54vRh707coeYceXRQLquIu0RYosqVTyptHU3eW9B
         2j1/Ko4Pm8DWJGuIIwJBI7xQnPaEmeyItxUQDoejljH8ItoDq3C3LDdtJDzjOU+ATUIy
         C9ZATqm41hRhiLBwC0mOmgP500k5KbDeEccCNnj4SwYy6vaCA5kmxqszJvSXhuCwfc4f
         dh55edgVMbwMUHQhhuco2Ot6kwa8jmizfKLdn1BtxNP9Vt1RvmlXo38x7PeKNDHqPVW2
         rrDpeLmCgb5iEHD4fM0Uy8Rxs/FFrsR7XQkHd7fIikItI6u5Psr/mnY4xAfKou1BZx3O
         aAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRCLrOsnQv07IXKjODW+I7y37LWMYDrzNA1WfJvP1nQ=;
        b=3oFiYV4bF+dPmJOEhTNvo3ffsmZgiso/UDH3ZyVhm+KmUy6X6kV4FjomY1dXGMIpx5
         eRmesXkMfdmUR4JNsJCDj/Cqy1PBHKJBSeexXcJP37s/EFssmMrGJwJzNpUoldLzaumk
         82E9KTY7GwgnqIUdQWsoK5dGQI2s9rwR4IIJtSyygVOmyeF/IHlbAxAjYFMMcZDzPAVw
         lRtJHphugRDTpQig0ZKnUHmQzYDl7ZLg5d+iAkARmWZU1GCLlg8yJ1IMEQ2k07IBtDoa
         3VDK98ku/HLIIhub3UeQhjmJMS9gBq4kBZQmU1CQsScG528w08J2fZDAu8b9Tzwuc17O
         SD+A==
X-Gm-Message-State: ANoB5pnqesW6weN2qcw18C22/9DX18xNjHa5ek627zTUpM8qh19a8/pS
	m8urMyKCuiTmHz+fD4BotdU=
X-Google-Smtp-Source: AA0mqf4kWe7QD3KmlgWyvl/xvRsHf5PkLNy2Mtvy+6P1plQ1fJCPO0yRJEy1ZtLjaKuXbYAUBHHh8Q==
X-Received: by 2002:a17:90a:bd85:b0:219:8198:c121 with SMTP id z5-20020a17090abd8500b002198198c121mr32903022pjr.139.1670467602160;
        Wed, 07 Dec 2022 18:46:42 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.17])
        by smtp.gmail.com with ESMTPSA id a26-20020aa78e9a000000b005769cee6735sm8606394pfr.43.2022.12.07.18.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 18:46:41 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v8 3/4] selftest: mptcp: exit from copyfd_io_poll() when receive SIGUSR1
Date: Thu,  8 Dec 2022 10:45:42 +0800
Message-Id: <20221208024543.113633-4-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221208024543.113633-1-imagedong@tencent.com>
References: <20221208024543.113633-1-imagedong@tencent.com>
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

