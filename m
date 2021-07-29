Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8505872
	for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 07:21:08 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id d17so5885686plh.10
        for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 00:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VHqxrqWce8Ff+8g7YaCTOBsDy47DahovPrZhAjoSsBQ=;
        b=cf9V9CDQhnOnmFI1tofQnmltkKzQ3rZIGuq77s4uiWgEjxEK88vsmyaEsSAqjYmr8m
         ujUFbFr3WqS/skmPR9rYrKmx0VJ12UPkbJBlLgEZgvMnNlZLEWP8fY+8jgXzDcWxS/Ee
         vpgXypaqe/pAXgLuRl6AvK3x+KAzfJ9/JxwVQMxzm+MZZX36/AhKbqkF/OjzoMLyPhPI
         CGN/MRAP01+WUoZEEcXWbBJtK5wEdhIuZspz9MXQ/tb6wBCvbKHFFTAYR3rjbGJMbHJ9
         hY1G5EytdbqCNgWSPDhM5b46//5RXDrF74Tnoj5sSIjN5XHrqY2w3b8cJ33Enl0W1HGE
         PIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VHqxrqWce8Ff+8g7YaCTOBsDy47DahovPrZhAjoSsBQ=;
        b=HEW64iyAhPukKgpEEvUCn64Ys7rTHfzMwW/2xIw5OSBkaPKu2CjuvYPjFJl/pCnoHQ
         P0pnGfHACOrhvJ1BpBgJEEgNohak9Mvpv53lXEveuLqN7oN+8I4GhQ5WngN6kQXelp9u
         Nali8kck25vSsAYDNL3QFjfjUGgyjrzKvy5SuJFDTTBnf/8MCw9/fyS3XAjxx3nx1wcG
         HLSyqgX12TqfWggDiYZ9RWtr26b8FBNKuVUPlHTb+sQc8CwmEByuambiIHoEL9NcaFs0
         Tot28HbPpM3d93XQ0WoSKw5TaTdCyswxUCsEIjhccrjpebymeFy3US4WdOiluf0EayLV
         FpHg==
X-Gm-Message-State: AOAM533EtgsuFfaJKGRi1/K4bMFkgQ367etK2aUBOprWomshCCR1D7NW
	Gai64CVA3+yV6jFs2IbQF1L2K6UL1iQ=
X-Google-Smtp-Source: ABdhPJx4xISORQ31tioMhIlvcen3YGy5nAwzXgddVZOVTqXEpqW9DyD25x7TTSMteZB+SIT6xFLhNA==
X-Received: by 2002:a17:90b:378e:: with SMTP id mz14mr3854272pjb.204.1627543268096;
        Thu, 29 Jul 2021 00:21:08 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id p17sm2211550pfh.33.2021.07.29.00.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 00:21:07 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v7 mptcp-next 4/6] selftests: mptcp: set and print the fullmesh flag
Date: Thu, 29 Jul 2021 15:20:53 +0800
Message-Id: <ae4edd8c446c94e57b981c16498f4f407d6b3e78.1627543032.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <349c97cf4d1091f28aa62e8200ebfe4fa0f5f2d5.1627543032.git.geliangtang@xiaomi.com>
References: <cover.1627543032.git.geliangtang@xiaomi.com> <1244ff06f1715f714ccc21bb164c6c082e8a26f5.1627543032.git.geliangtang@xiaomi.com> <af7def3b48c96f1f0c68360326d2e9cfe2500826.1627543032.git.geliangtang@xiaomi.com> <349c97cf4d1091f28aa62e8200ebfe4fa0f5f2d5.1627543032.git.geliangtang@xiaomi.com>
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

