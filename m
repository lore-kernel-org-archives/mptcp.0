Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E2C72
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 04:12:40 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so17860367pja.5
        for <mptcp@lists.linux.dev>; Sun, 25 Jul 2021 21:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tDJjOePcAKT3ZmH4Y+KhB8wLwEieD74o+4k7ONXVg1Q=;
        b=et+3pJGhHfq7y7iLli3mGaGfBP+g3ow4w49iGuzbcLUkOmjDkOqN63JDhYu97KIrvX
         jXF+alddA7pMMhUp/CjP9H32VslcTZYdhcBMbIpoG5t8nYDTL6wK3nheIYDIRbsq6gPU
         791dOBuLSJ4NgaK3VFxw3nBsoKrxVbohSpx+pmLyIz6erIDh3rbeJrWp/Kn1RAVTXtwq
         TwuCvdPwfFpdIkf7wkF19TgNN56phlKSNQ5V2BgvzmoZKD33Bzgix3eByAA83wLxdF8G
         rLq6SU5+q5R+EHhgGIBkzKJMEyJLlvuceMXjO9AYYnIoemBS56EWv8CRX9jEXxqlb7Zq
         H53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tDJjOePcAKT3ZmH4Y+KhB8wLwEieD74o+4k7ONXVg1Q=;
        b=sznJlC0ja5sxZjXKAX9d17fXvi45eV2BkJ8Y1ntoeTS2+/xK7/miJ0l+aQ8lIZO9JX
         hCtE51r5TbT8fAZ6FjAXuebV57u3HfKYpUP4qLev8oztqPpD2q7Vea00q+YZ0Bc6m7UZ
         PC7a0vBSvyj/8tzfk+6xR272urgpH1hPd4AI+WkBjbNqsOFTjnnrvrxORsMQ+VANSWFt
         9uZL78yRuIIYjQwaetHuEnWv1KwGjunY/2ab+szPyKz/Rt3TEdzGY8bJSdF4kdGdlsVi
         jlj91eDaMxR0M0dnRGxNQ4zy+PFWAamaZjD7UpKvAJ4OSCl+5oNfPsUXpyvKrygamGRc
         tN/A==
X-Gm-Message-State: AOAM530MdeEzm5s6fpLxlaM853L174QT54cv0OiT6m9UDIjJjdK72yCm
	t6grVVpZC3rsyi1hmdL/wZBGBw1eqJ/lyg==
X-Google-Smtp-Source: ABdhPJxAw79A50786AXt7aBD25norEBXt+uQaC3QLKoXbjlrnjToaYjuc6mWEMlCbvX54QrAA/dpvg==
X-Received: by 2002:a63:5b09:: with SMTP id p9mr16741887pgb.287.1627272759775;
        Sun, 25 Jul 2021 21:12:39 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id f3sm2608543pfe.123.2021.07.25.21.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 21:12:39 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v3 mptcp-next 3/5] selftests: mptcp: set and print the fullmesh flag
Date: Mon, 26 Jul 2021 12:12:26 +0800
Message-Id: <3e4690d0d33f8285465e54870410266e22208acc.1627272435.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <043ce3b46a70bd59ae7aaa53ed1afdf44b7f3ad2.1627272435.git.geliangtang@xiaomi.com>
References: <cover.1627272435.git.geliangtang@xiaomi.com> <6f7aa2fec63dcaa337c7b78184a73a90d58b580f.1627272435.git.geliangtang@xiaomi.com> <043ce3b46a70bd59ae7aaa53ed1afdf44b7f3ad2.1627272435.git.geliangtang@xiaomi.com>
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
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 115decfdc1ef..9a5a3b3d20f6 100644
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
@@ -236,6 +236,8 @@ int add_addr(int fd, int pm_family, int argc, char *argv[])
 					flags |= MPTCP_PM_ADDR_FLAG_SIGNAL;
 				else if (!strcmp(tok, "backup"))
 					flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
+				else if (!strcmp(tok, "fullmesh"))
+					flags |= MPTCP_PM_ADDR_FLAG_FULLMESH;
 				else
 					error(1, errno,
 					      "unknown flag %s", argv[arg]);
@@ -422,6 +424,13 @@ static void print_addr(struct rtattr *attrs, int len)
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

