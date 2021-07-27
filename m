Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACCB72
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 13:24:44 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id q17-20020a17090a2e11b02901757deaf2c8so4877542pjd.0
        for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 06:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VHqxrqWce8Ff+8g7YaCTOBsDy47DahovPrZhAjoSsBQ=;
        b=RiOWrU0eT0ymaSVMfbMrSGt9eeQcgp7Yl649AAsgigV5/E0+xRVrSDUhNvJmjdxS3+
         /ulBB5+h4oaGSuAO9FWvkol64maswFla50lJlpnWo18zY85Us/4J9wRJe7/uNz2wxLlc
         phUHeAslO8xIHLNLP9rQ6DLFqljb/0hCxsccxlHpj5grr5OQTuH8JGfxTItUe+e46P5F
         XEY9YuyCzr/TE/SzR6WY49Mnb9Hf6AmyYIvGShtgEbNCBApRNkf2kxl5TYKBzm0NtrfA
         pcB2+l48y0QylnLkIICjJ6ijGIJkk9aeDVG+l8R0N2mVd6pQow6tYoHc9Y+sMV0gh+vk
         3Tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VHqxrqWce8Ff+8g7YaCTOBsDy47DahovPrZhAjoSsBQ=;
        b=pcgPdOIMV6wTTB50kDHJYJ3/KOoIPYpGqrJD1w6zbW1MsrfW9UIHlpAxygl8rH3RIE
         Oc1Q8CfwdGd/R7efpw9Gci4S2T/Fh1s9XGJ1v0YIWOO9//E9fMw8pd8OTjdm9tSl2qe/
         /oOq9jW6Y9cX2TupMfc2wb4eI1uFEnYYFAGNAIh+BlkW1R6OeWvqOvOcl8hP1xOxMehi
         NKTX0ck3u3EA0QJZ5u4AZetx+znpVCHFOdHYejmoptUJ3fqmOTWw0is2W9ALf661Nv9J
         W1wxyplo6yUhprYPMGPpInW/Y4ayJvRXjyQ8QILJSlD/SWUugw6meZU52+Y2ti0Rt93T
         QGEA==
X-Gm-Message-State: AOAM530gKWkEbMLzMd27dQF5a7l13bjzeHAcIosIS2NshU7TjHGK2M6q
	rB2LxVIzo6tZWSN4sS8Fns5l74QeSBI=
X-Google-Smtp-Source: ABdhPJyC2RRz+DGAAkoQGfBDloseJW31OWgCo9rM4c3iH3qQqS6zuLPtc1087dDPCtuBEz2BRg7Saw==
X-Received: by 2002:a17:90b:1d0b:: with SMTP id on11mr22471049pjb.94.1627392284194;
        Tue, 27 Jul 2021 06:24:44 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id j13sm3511066pjl.1.2021.07.27.06.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 06:24:43 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v6 mptcp-next 3/5] selftests: mptcp: set and print the fullmesh flag
Date: Tue, 27 Jul 2021 21:24:31 +0800
Message-Id: <10a327d0ce8f917d17166ae7de561a8b2af23ff3.1627391588.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <87310b54d3987e94138953e171bad7b081b63df5.1627391588.git.geliangtang@xiaomi.com>
References: <cover.1627391588.git.geliangtang@xiaomi.com> <703a40cb47f2f4c0ddb25bb61f97cfb4b973dc5e.1627391588.git.geliangtang@xiaomi.com> <87310b54d3987e94138953e171bad7b081b63df5.1627391588.git.geliangtang@xiaomi.com>
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

