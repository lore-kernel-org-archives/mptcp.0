Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71339168
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 11:08:37 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so3332873pjb.3
        for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 04:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VHqxrqWce8Ff+8g7YaCTOBsDy47DahovPrZhAjoSsBQ=;
        b=nCNeO4iGv6LMRU/+PV4LkofE5p5hmVMb5lF4JO4QpKsRwL06ZG5LDZ2KEvli6V5TBG
         0Se66O3oovvnrZSf8xai0HOHEPMd03UrphOKw4ubS5H8ipT6btUOQoK2hbph6Knq1E/k
         4EaGcGf58m3klUhxKCjBpFHx0WpK4fK1Hwofx99v81V54KTN34YhtpiobUlwN5Kj9PuM
         Swx5nZP4bA6xIL4tCtv/BCVLbgGo2eFYqfUJM9mY4v0JLQKiFMD98AEZcQbz0PoRIFOH
         11Sc0ZeI7r8SQQJbD5lhpf/WMftLKDzoLpMTQYa8sa15LlcJqPzbPwppm/ON8AB/g7aY
         DRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VHqxrqWce8Ff+8g7YaCTOBsDy47DahovPrZhAjoSsBQ=;
        b=ovNzh/bDquV/MYYLVxcXhjsVstqxyI+ipnH1I9LnmeQxBh7lr1ld2e9k3L6DbCg0Vs
         6f/Is3NvfijP1xmbb25+pmZjmbFAuDr36ILtVqcmN1uMOWn9bYtzdwiKPnamrU0pBDzk
         UnGfNMizpxzYcITgt2OHJY4Nrzi6opyvgva3yTQxxgqOlC4VMdsim6POrCKpPaxJ0auN
         2Dfvytwq/BYAtw2UNnRtf0tYBRPtkQz44ES3EVtuVZOgWH/qSSnzEhs6BwHVRYN6wNe1
         7hnap0o9/1fBNy7IeVM1pui8NwmR6s+dJvGoPcxCf7XfJWAOsSq9KoidsZVDnLknGcAG
         Sbhg==
X-Gm-Message-State: AOAM532wTOXgypEsdn3zsa1DgVde82hb4sJx/nFitYxq2D4fWYvMzzxX
	VcwMgTjnF7tm08ljmziSyviPQ55sQMFvlw==
X-Google-Smtp-Source: ABdhPJznGqpO85R0CAa6lGjgfp5WaaBbEERBSv6/VT6wsSn/urXx9bEYI+Zl+7aZEtBsGT25PKLG9A==
X-Received: by 2002:a17:90b:1e10:: with SMTP id pg16mr16930016pjb.87.1627297716987;
        Mon, 26 Jul 2021 04:08:36 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id e30sm50282700pga.63.2021.07.26.04.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 04:08:36 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v4 mptcp-next 3/5] selftests: mptcp: set and print the fullmesh flag
Date: Mon, 26 Jul 2021 19:08:24 +0800
Message-Id: <0c40709e5ccf24e810c5a5b073a47baa0946f41a.1627297096.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <afc79f9b4d6b8afb6492a52e9c1ccdc780fcca90.1627297096.git.geliangtang@xiaomi.com>
References: <cover.1627297096.git.geliangtang@xiaomi.com> <457db25d2c745babb98b8f29c6d2ace3d6348ff5.1627297096.git.geliangtang@xiaomi.com> <afc79f9b4d6b8afb6492a52e9c1ccdc780fcca90.1627297096.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

This patch dealt with the MPTCP_PM_ADDR_FLAG_FULLMESH flag in add_addr()
and print_addr(), to set and print out the fullmesh flag.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 115decfdc1ef..354784512748 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -25,7 +25,7 @@
 static void syntax(char *argv[])
 {
 	fprintf(stderr, "%s add|get|set|del|flush|dump|accept [<args>]\n", argv[0]);
-	fprintf(stderr, "\tadd [flags signal|subflow|backup] [id <nr>] [dev <name>] <ip>\n");
+	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [dev <name>] <ip>\n");
 	fprintf(stderr, "\tdel <id> [<ip>]\n");
 	fprintf(stderr, "\tget <id>\n");
 	fprintf(stderr, "\tset <ip> [flags backup|nobackup]\n");
@@ -236,11 +236,18 @@ int add_addr(int fd, int pm_family, int argc, char *argv[])
 					flags |= MPTCP_PM_ADDR_FLAG_SIGNAL;
 				else if (!strcmp(tok, "backup"))
 					flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
+				else if (!strcmp(tok, "fullmesh"))
+					flags |= MPTCP_PM_ADDR_FLAG_FULLMESH;
 				else
 					error(1, errno,
 					      "unknown flag %s", argv[arg]);
 			}
 
+			if (flags & MPTCP_PM_ADDR_FLAG_SIGNAL &&
+			    flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
+				error(1, errno, "error flag fullmesh");
+			}
+
 			rta = (void *)(data + off);
 			rta->rta_type = MPTCP_PM_ADDR_ATTR_FLAGS;
 			rta->rta_len = RTA_LENGTH(4);
@@ -422,6 +429,13 @@ static void print_addr(struct rtattr *attrs, int len)
 					printf(",");
 			}
 
+			if (flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
+				printf("fullmesh");
+				flags &= ~MPTCP_PM_ADDR_FLAG_FULLMESH;
+				if (flags)
+					printf(",");
+			}
+
 			/* bump unknown flags, if any */
 			if (flags)
 				printf("0x%x", flags);
-- 
2.31.1

