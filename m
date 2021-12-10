Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777E6173
	for <mptcp@lists.linux.dev>; Fri, 10 Dec 2021 07:14:30 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id 133so7276509pgc.12
        for <mptcp@lists.linux.dev>; Thu, 09 Dec 2021 23:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oqc3Zy153WbezVayk4lPdpOs1jpGB2UlH4cKZFhAgdg=;
        b=ESFH4dsCDOXt93W4UFBDg+bQezoPqeuYXP6ri6zG2KDfyRj7cijQrO1IDIn+mxNzl6
         WDUro+fNSfo1XdWhLx9Y4WqOweqONw7ccUZvs9lZEjvL7DKDJiSxGsXjhw5un1D/ACK7
         d6GvSk16+vkJ6kWsr72Qnx96gf4B7KCuxEkSS2u8HBH/gHgK9AwWGPYLmFNxEcotCPcO
         6DSNDTAarFM4TxVjHajJ0M3QNCS8D05rkjxih+OlXKFT+FsN+l+HFcETTVEkMoP4t0Nj
         KH35FiVmHh2WkOsrzrldfgDCSSUwWqW6GPyINafg+pvHW1MMa7ORht1SS2qSnOQCnYeB
         iomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oqc3Zy153WbezVayk4lPdpOs1jpGB2UlH4cKZFhAgdg=;
        b=I3dxMqnWR6utJDnmXSFC5PVF8Nee3ApaWjBRXz9OSAWUFFiB2RwrsxYROiXB3F68R3
         lnpuGDRM//8Xu9AVCU0OEIfVHLX/45Joznj3J3zzWduCWf1arK0xB0zucffAPKpGm/dZ
         k3X0Et66UDM7hRo6/EcTQrhuT261GVyt365Idwr0CmWuJxNXbRkroLm3exwSUsMclNoV
         O42YdCJMxm1BIFZBQjLGUPOxe6HLwFMIjmUZVtJHt6OEvboIllSAAupeA7LY8wvnbRIB
         PkuQPMxI+C6Vo2qu4jX1OmuwNxuws/VK4HqkpR9AM5VF1SrYSOq1dpr5XnpzEMSOgppM
         g5Ig==
X-Gm-Message-State: AOAM533gROI2LiF9LEgkwE5Fs0u46vI5QGPGvQlpmW0lEMDU4SW/TyUg
	tpEZlBCC94CSBqSq6p8dXz8=
X-Google-Smtp-Source: ABdhPJyhrSiPeGFtLudwxHIgPIzsCoNdLVarHRG7OEqB2MpYRMnkmZ395ydC03P8t6+svdx+G6RBCQ==
X-Received: by 2002:a62:6414:0:b0:4ac:9a0f:124e with SMTP id y20-20020a626414000000b004ac9a0f124emr16761728pfb.56.1639120469970;
        Thu, 09 Dec 2021 23:14:29 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i67sm1918987pfg.189.2021.12.09.23.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 23:14:29 -0800 (PST)
From: cgel.zte@gmail.com
X-Google-Original-From: ye.guojin@zte.com.cn
To: mathew.j.martineau@linux.intel.com
Cc: matthieu.baerts@tessares.net,
	davem@davemloft.net,
	kuba@kernel.org,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ye Guojin <ye.guojin@zte.com.cn>,
	ZealRobot <zealci@zte.com.cn>
Subject: [PATCH] selftests: mptcp: remove duplicate include in mptcp_inq.c
Date: Fri, 10 Dec 2021 07:14:24 +0000
Message-Id: <20211210071424.425773-1-ye.guojin@zte.com.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ye Guojin <ye.guojin@zte.com.cn>

'sys/ioctl.h' included in 'mptcp_inq.c' is duplicated.

Reported-by: ZealRobot <zealci@zte.com.cn>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_inq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_inq.c b/tools/testing/selftests/net/mptcp/mptcp_inq.c
index b8debd4fb5ed..29f75e2a1116 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_inq.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_inq.c
@@ -17,7 +17,6 @@
 #include <unistd.h>
 #include <time.h>
 
-#include <sys/ioctl.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 #include <sys/types.h>
-- 
2.25.1

