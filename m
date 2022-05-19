Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B3F28EE
	for <mptcp@lists.linux.dev>; Thu, 19 May 2022 15:40:30 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id v10so5393540pgl.11
        for <mptcp@lists.linux.dev>; Thu, 19 May 2022 08:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pKLKo70g6togMlHkHAmjaaA5K8/SPp6HD60y+EHKvNo=;
        b=EKiH9Z2mcioa6mklctNjLc089L3WMMovMh+ARzDQQxF5Q5oJTAUhvI/qvq6EW6DHAi
         ggdq8OSkyXEz41KTHGRit/1Bjsfqria3WAwDoSWcsZ5hUVORMO8l9MP2eZdAk+MBGrmz
         Y7Dhx7gAPqiQpgEHXn1J6NLCs8ww0WsdEUTFLPyV3g2fB/lDzTBpnaOASezCr2yFr98t
         /XNm+b592F09u+Xdj0GKTXT4FF3UAd1S+egvCe06/ieUbl+sVv4/zMiVjY7alvU2belg
         JelsbXXCcdlrYajoiwF+wf4q9MxVAMAEm0xyxEt4YL2OF3W0oC5S8ra9KChqCANeHjA5
         pHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pKLKo70g6togMlHkHAmjaaA5K8/SPp6HD60y+EHKvNo=;
        b=sdmuQ2n9IEdK/rTLPWolbis8NLl/C0q6/Jq8D1ExHRJs4FCc4yH0olpAmSDbQWJveb
         0DlfFRlssvHl7Lt12fMmnyYOpi+3AhvYL5ZORRwEfYCfUdPAlFp7foI0vdoHxCf61W53
         m40mD4p6Jyz4ZIYL3zQKerjdHLW0jA4TjesTEraVMVMCoP3C2p6QjBOgOk4dkr1HZ+dr
         M6KZ2ici+k/zDlwd1jgiJ0xQ+sZvh9mVR1GZqk6Ex5+0CvhVPc++49h5vUZOULSbxEuE
         XEGlvqESz5D+GzB5L72/xoqIEAyxGhgSka+TUD8JOghMo85114ki+WkwoErVqpRsbHTT
         dJ9w==
X-Gm-Message-State: AOAM532MtZqWamECPcZTd+6ZxIjSxEbCfyuIRnWCdX2pwp1dBaYCRmEA
	4/s+etsiRKI8pXNsvbyZRTO4LVRU6Bpr/Q==
X-Google-Smtp-Source: ABdhPJwKt4hwvulSIV3BYhU4Yf3HdaOTlzwJMM9C+3zR22uMyH4zB2cUEg/BONryPyJnomfWktYQRw==
X-Received: by 2002:a05:6a00:170a:b0:50d:3e40:9e0 with SMTP id h10-20020a056a00170a00b0050d3e4009e0mr5263151pfc.48.1652974829908;
        Thu, 19 May 2022 08:40:29 -0700 (PDT)
Received: from hydra.localdomain ([50.45.159.39])
        by smtp.gmail.com with ESMTPSA id c22-20020a170902c2d600b0015e8d4eb2cdsm3976008pla.279.2022.05.19.08.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 08:40:29 -0700 (PDT)
From: Ossama Othman <ossama.othman@gmail.com>
X-Google-Original-From: Ossama Othman <ossama.othman@intel.com>
To: mptcp@lists.linux.dev
Cc: Ossama Othman <ossama.othman@intel.com>
Subject: [PATCH mptcp-next] mptcp: fix conflict with <netinet/in.h>
Date: Thu, 19 May 2022 08:39:29 -0700
Message-Id: <20220519153929.214331-1-ossama.othman@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Including <linux/mptcp.h> before the C library <netinet/in.h> header
causes symbol redefinition errors at compile-time due to duplicate
declarations and definitions in the <linux/in.h> header included by
<linux/mptcp.h>.

Explicitly include <netinet/in.h> before <linux/in.h> in
<linux/mptcp.h> when __KERNEL__ is not defined so that the C library
compatibility logic in <linux/libc-compat.h> is enabled when including
<linux/mptcp.h> in user space code.

Signed-off-by: Ossama Othman <ossama.othman@intel.com>
---
 include/uapi/linux/mptcp.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 921963589904..dfe19bf13f4c 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -2,16 +2,17 @@
 #ifndef _UAPI_MPTCP_H
 #define _UAPI_MPTCP_H
 
+#ifndef __KERNEL__
+#include <netinet/in.h>		/* for sockaddr_in and sockaddr_in6	*/
+#include <sys/socket.h>		/* for struct sockaddr			*/
+#endif
+
 #include <linux/const.h>
 #include <linux/types.h>
 #include <linux/in.h>		/* for sockaddr_in			*/
 #include <linux/in6.h>		/* for sockaddr_in6			*/
 #include <linux/socket.h>	/* for sockaddr_storage and sa_family	*/
 
-#ifndef __KERNEL__
-#include <sys/socket.h>		/* for struct sockaddr			*/
-#endif
-
 #define MPTCP_SUBFLOW_FLAG_MCAP_REM		_BITUL(0)
 #define MPTCP_SUBFLOW_FLAG_MCAP_LOC		_BITUL(1)
 #define MPTCP_SUBFLOW_FLAG_JOIN_REM		_BITUL(2)
-- 
2.34.1

