Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7CF72
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 07:58:34 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso3757281pjo.1
        for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 00:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VHqxrqWce8Ff+8g7YaCTOBsDy47DahovPrZhAjoSsBQ=;
        b=UnXkIjnDWLI2zJFgZa0QBC/Uaqj9IEh9jQhAyVfyQVNZkGBwhSGzs+DKAl5mbRy0Kq
         1q0GRfZ5FKOowCtM9C1jXLE0n5NvxcxAVFbaxt66hjUB6ZWBQ//dEZBSbDgPMs3fL0/c
         fke5Ug4jwlFgo6am9n/+PIB3aB/zRwyf3Z2CV22XfLYdBpoOzn+3Hzq7Zk+SLVVHnaZV
         V1u0NaxIGSluJNytfK2jNDND1rLn6tx528ADrlADrcOxWUhzsJhX61pcjyLoHYlkUQKc
         CwuHjlRoYw9XX6hVCh2I2eZZgPODvTuL2yurN5XEDoailPHHCBczARPxRXnSiFjvZvo0
         2eZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VHqxrqWce8Ff+8g7YaCTOBsDy47DahovPrZhAjoSsBQ=;
        b=m+RAlRc/rGlcYRvxPT19k+fhd+U+F9X+8Zg9hEAY2vGsCa3dpPCskKLEaMu+JEQzTb
         i/JOCIV1+hNQxsALLQCDcCcdi/rqPJj6p6of99229sqMCoRNapvbLeDmy3Fu1oT5lviC
         nR65zOO3AlaSoOdsMRODTIR7uuIPwIGNLctZinOgyk2LiaJ2jrHGn89QWbjRm4aaOaiD
         CKDqtu25KVAWlF3FvKQqBfhVd2FWFpNPYg6h0KLg/JbjDNzyEXu3Z8Q45mDWIw7ecj2Q
         9r0PfkWqQH1b+0nkTEpEL5uwlxt+5gJR5R17wNCrbeewLc6inK/D3Pjt1sKPS0ho4Qdg
         XvjA==
X-Gm-Message-State: AOAM532JVln4+TvC3G8VZBk+6QP5771PBXERAUW/zp5RgOzbrb6z+B4A
	MsJ+suJY2V2sIMCTcUcCp2tPvIyleF4=
X-Google-Smtp-Source: ABdhPJyzLp8ZlGMeLZ0+YgIyJrczdUOOetoCVwluo0IZQPktD6ATHlbph9FaKxVL4HgS69q/wgzunQ==
X-Received: by 2002:aa7:9e1b:0:b029:384:1d00:738 with SMTP id y27-20020aa79e1b0000b02903841d000738mr18013620pfq.71.1627372714325;
        Tue, 27 Jul 2021 00:58:34 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id v9sm2544537pfn.22.2021.07.27.00.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 00:58:34 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v5 mptcp-next 3/5] selftests: mptcp: set and print the fullmesh flag
Date: Tue, 27 Jul 2021 15:58:20 +0800
Message-Id: <69eb44fdf9899ec5eab342fa1f3b62d12ab2598e.1627372396.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <bde1048019780ecc5f2e553bbb4eb21213f76ba7.1627372396.git.geliangtang@xiaomi.com>
References: <cover.1627372396.git.geliangtang@xiaomi.com> <b8af3a77da2fcd8e16e8b5d6b63c7c8386abcbac.1627372396.git.geliangtang@xiaomi.com> <bde1048019780ecc5f2e553bbb4eb21213f76ba7.1627372396.git.geliangtang@xiaomi.com>
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

