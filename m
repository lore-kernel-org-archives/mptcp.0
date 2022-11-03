Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0CC2F21
	for <mptcp@lists.linux.dev>; Thu,  3 Nov 2022 11:07:48 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id h193so1335890pgc.10
        for <mptcp@lists.linux.dev>; Thu, 03 Nov 2022 04:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddvDW/MDUtgM+qsmGJtiTql+jw6vfIq1S7pyop6Cv2k=;
        b=j70pXe6qtRTH6IJ5tGQVynFQMEQiZy8JLmYwYmGgO+8gMkxty4hsXQ0aDjS3xEU2tA
         6R/YrUXkfV2U2ANOKsAm/Y0HhpipfvSEpsNigV3e2oc2EN0yxoxHlWA536Hwzz9eBwbs
         sN6bJ6/gQUDID/TjrxLYS6GBTL5lkqcVKPXQhvOWU9SuFJC54YOJup4W6XjCQl66Jf8e
         wwxx2a+3v6QN4kI7deqmAe3OTAzSa+sKMegVnIyFSVpZ6o09vdtmMQgB1RiKM6f18WQe
         r3M7fDg1UOSFnO0WluRfe1sXV6t2VpnWh+nRUq+2/bu95deGS6HBjQm+f85PF1nPRSfC
         Hpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddvDW/MDUtgM+qsmGJtiTql+jw6vfIq1S7pyop6Cv2k=;
        b=p2SLr07k6cDgWhQNIkp15IL7bhHHfZf9lsvpWVfvJpCI2s1qvALG2Lic1qOfo8C8A7
         hOgCngaqLYT6F1gxNjDE5OKeDGdCkOkqzyFOSAqoihutv6+m7RQdbIuwIdtt5HmIYMn/
         M4eyydcPrYkIWcjfapAB+CjCdUF/m0HuM+FL7gb/zV88YHPQFlImpAezdNzBmpzLNNPF
         z6S7HXkfLcFuHm+Vsu99ZKWoHBxA9w9L0F5w8u+pSnO/nf8Yn1utHVHqNHcqS/h2HLjP
         +JjN8Uxutod5c4G0H5qS7SksR0N+5sYdsP9Bh6Eo0o9Zv9Wtuj5LzcIUTfkWynCdXH3n
         ThjQ==
X-Gm-Message-State: ACrzQf3SYskmuxnnnsjwYB33Q1/WkBr9zr0xQT1sIm0bpSYtdOyUd/lO
	szqeN8tGxiuhr3bp1OJIkKQ=
X-Google-Smtp-Source: AMsMyM4PqTmKTbRZvvZmbUCfjs1bsulazQJSaviUNERRsyaeu2SqRynuIysWy2RA9mP1qprfp6ucIA==
X-Received: by 2002:a65:4909:0:b0:46b:2752:e4ab with SMTP id p9-20020a654909000000b0046b2752e4abmr25964529pgs.293.1667473668123;
        Thu, 03 Nov 2022 04:07:48 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.83])
        by smtp.gmail.com with ESMTPSA id w14-20020a627b0e000000b0056bd4ec964csm450555pfc.194.2022.11.03.04.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 04:07:47 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v6 3/4] selftest: mptcp: exit from copyfd_io_poll() when receive SIGUSR1
Date: Thu,  3 Nov 2022 19:06:48 +0800
Message-Id: <20221103110649.299284-4-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221103110649.299284-1-imagedong@tencent.com>
References: <20221103110649.299284-1-imagedong@tencent.com>
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
index e54653ea2ed4..518c6d653c0e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -586,7 +586,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after
 		char rbuf[8192];
 		ssize_t len;
 
-		if (fds.events == 0)
+		if (fds.events == 0 || quit)
 			break;
 
 		switch (poll(&fds, 1, poll_timeout)) {
@@ -692,7 +692,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after
 	}
 
 	/* leave some time for late join/announce */
-	if (cfg_remove)
+	if (cfg_remove && !quit)
 		usleep(cfg_wait);
 
 	return 0;
-- 
2.37.2

