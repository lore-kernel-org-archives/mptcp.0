Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5A73FC4
	for <mptcp@lists.linux.dev>; Mon, 30 Aug 2021 10:34:20 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id i21so30134679ejd.2
        for <mptcp@lists.linux.dev>; Mon, 30 Aug 2021 03:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n8Jdtbk+agUGLeH3NOrwWV95zhaiWjhRzD1IdFQ4PR8=;
        b=b2Psqjbd3utcZP5kmZx75VuRSOR8fPH38rGXGi5UF/1dAlJGoxJmzBCcAcbX787Mta
         MBa6hSig+zKiKHZvB+RRNXYu62BbYmEhocNaDe9ceBTUnkEoy6pEQ0428dfF4xsCJ4qF
         GS0nZKCf3dPj2NneYupy1JHB1MnweoXcaDcvriiiZE9LEFxT1ZNJOFKsPjcwQeqRGn+q
         IgAttT9anRsBg0Zb08uFBJjJx/JgjxHk2z6gdbruxb9jgqy9vBv/H0aO4+sq9jFVo5xt
         UnIhJvimIlB/MSkF8fm6luxJYeB+eYg9qUGS+L9elFuMYrYkEh+KjIrTQ9IYa6KOUgek
         cL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n8Jdtbk+agUGLeH3NOrwWV95zhaiWjhRzD1IdFQ4PR8=;
        b=i+YZzO5SKSPvhv39LJ98e0p65Gjj+inVlCvIGexJ59srfaS7SkQavge/T3ACTKF71I
         i610NqYg3moXFw/f1g9oneRWzHqcL0pRMfuEoPkTwYeOWb8eZtZ8mBbwQwSLnMh/YF7u
         aHC/gmgFnMAbMksvhS2aWcbrxD4sxmZf6RTUjrerqq8+ewxaPVx8Lh0MTOI/KBbyEMbr
         OTu7QW/4yP79cUYVTEsrHgotSbIGD0ZhSASsl0Ie8ZqAQSbxoo0BlbdUGXiM65OhCYJh
         o/18J1PmeU1aw8q2MJPRTET38cEEjGlG/rfzBbDUA7O4Q5Dq3ZhtSto/qwnwVMIEaJE4
         tY8w==
X-Gm-Message-State: AOAM532mIuok4mDMoGPB+73rmDgSfdNJc6mH85fPxfFO7Kj88zGfHk7R
	XkMETuvMm+xrzfq/Wyh3OoPfq0lB+95zCkrHHeg=
X-Google-Smtp-Source: ABdhPJzGQoch3X9QzLJeO5cBa4lZkcLOo0AZZp4VX047mRKbuAJ9sz4dRdtb5j1RInqDdNGdOx9lhQ==
X-Received: by 2002:a17:906:e1a:: with SMTP id l26mr24340471eji.45.1630319658534;
        Mon, 30 Aug 2021 03:34:18 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id p21sm3282755ejm.88.2021.08.30.03.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 03:34:18 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Geliang Tang <geliangtang@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH mptcp-next 1/2] Squash to "mptcp: add MPTCP_INFO getsockopt"
Date: Mon, 30 Aug 2021 12:33:56 +0200
Message-Id: <20210830103357.3114290-2-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210830103357.3114290-1-matthieu.baerts@tessares.net>
References: <20210830103357.3114290-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fix compilation errors reported by Geliang and Intel's 0-DAY CI
Kernel Test Service:

   ./usr/include/linux/mptcp.h:207:19: error: field has incomplete type 'struct sockaddr'
                   struct sockaddr sa_local;
                                   ^
   ./usr/include/linux/mptcp.h:209:23: error: field has incomplete type 'struct sockaddr_in6'
                   struct sockaddr_in6 sin6_local;
                                       ^
   ./usr/include/linux/mptcp.h:210:27: error: field has incomplete type 'struct sockaddr_storage'
                   struct sockaddr_storage ss_local;
                                           ^
   ./usr/include/linux/mptcp.h:213:19: error: field has incomplete type 'struct sockaddr'
                   struct sockaddr sa_remote;
                                   ^
   ./usr/include/linux/mptcp.h:215:23: error: field has incomplete type 'struct sockaddr_in6'
                   struct sockaddr_in6 sin6_remote;
                                       ^
   ./usr/include/linux/mptcp.h:216:27: error: field has incomplete type 'struct sockaddr_storage'
                   struct sockaddr_storage ss_remote;
                                           ^

Please note that socket.h should not be needed because it is included by
in.h. Here we explicitly add it but it can be removed if needed.

Also it seems we need to use __kernel_sockaddr_storage in uapi.

Reported-and-tested-by: Geliang Tang <geliangtang@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 include/uapi/linux/mptcp.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index c368c11a0ed9..c8cc46f80a16 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -4,7 +4,13 @@
 
 #include <linux/const.h>
 #include <linux/types.h>
-#include <linux/in.h>
+#include <linux/in.h>		/* for sockaddr_in			*/
+#include <linux/in6.h>		/* for sockaddr_in6			*/
+#include <linux/socket.h>	/* for sockaddr_storage and sa_family	*/
+
+#ifndef __KERNEL__
+#include <sys/socket.h>		/* for struct sockaddr			*/
+#endif
 
 #define MPTCP_SUBFLOW_FLAG_MCAP_REM		_BITUL(0)
 #define MPTCP_SUBFLOW_FLAG_MCAP_LOC		_BITUL(1)
@@ -207,13 +213,13 @@ struct mptcp_subflow_addrs {
 		struct sockaddr sa_local;
 		struct sockaddr_in sin_local;
 		struct sockaddr_in6 sin6_local;
-		struct sockaddr_storage ss_local;
+		struct __kernel_sockaddr_storage ss_local;
 	};
 	union {
 		struct sockaddr sa_remote;
 		struct sockaddr_in sin_remote;
 		struct sockaddr_in6 sin6_remote;
-		struct sockaddr_storage ss_remote;
+		struct __kernel_sockaddr_storage ss_remote;
 	};
 };
 
-- 
2.32.0

