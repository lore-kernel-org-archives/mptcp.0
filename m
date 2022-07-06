Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FD67C
	for <mptcp@lists.linux.dev>; Wed,  6 Jul 2022 09:17:34 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so8770765wme.0
        for <mptcp@lists.linux.dev>; Wed, 06 Jul 2022 02:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B7oQiS8Lnoza4U/14BrG9OyLKJjszVTNkC9ZjxChhsU=;
        b=RUFsKCH5HPYLKzhr/9mfAlKtsasFMWT5Pcfmj1muzEjRra7mGxxzm3IT2hBz54qPFj
         O9jLLV649w/wKLTabBykVkKOmtpWOqNEmfEYV+SGS/9akqg5tbHyoqSJFouVlxKfr5OP
         8MHfKVknC8Uo9/Da/EWGNTBcJ15ZTda5KpgDS1npZx7gJ8QFHDc5yklKwOgyRB/8L9p7
         SfIwWp52NkpCX7F4YEn+ct/fHfGyqRliErX1KZcAHrlPSGxFmGXTAjiKJNa508t8AMeN
         4G9DVYOXXuex6TSkyCzOVFG9oRkb+hyDf2Dk3CnqwZZv7RZVrlU3/mpSvgAzV1eSWLEo
         beYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B7oQiS8Lnoza4U/14BrG9OyLKJjszVTNkC9ZjxChhsU=;
        b=vv5S4XnBLUiRpwCFODJdzAYp1MfX2pp2+Yofqssr2CCNLcb5NBQgvYvPhvTsC8Cp4T
         SzaHPDxlwPsOyxuZLIW8Huc83dxFEnb4YLVsBpI2GfJXJYdGh7cZ7UxLWIZvvhIYtkjX
         ZwClybUY9aXdnHIxHib927lmVFhn5nIL2cGFccJUnWi7V8BF3eli+rPy70X/9yPwubuj
         QqMYDmWrLCnpig6hi3pl3FDdGNJ4lXO5iCJsw6z7jRPEOpMsVuV5N4Pif8qUoZSQx7Fj
         5C+vwd9xGSOEG4eJ62HAe/BWutBI8KEcAClV34aB1CD5PuuLN/AzGwkg8HLPfPZ2eUOi
         /+1A==
X-Gm-Message-State: AJIora9oVYAgE0DKugGe/Uifdb2dbwgxVtgQWqdpzqDlSbIHpQXKpNXv
	/GhtFoWRXBp27Xy1xb2DXuclpygjFcrh6OZh
X-Google-Smtp-Source: AGRyM1sjipvReAXInwd33Yl+cmF3afLKHC+/y37e2f+SF2kCaoWbRoevxAli1AdDVCrWou6Xq9FMJw==
X-Received: by 2002:a05:600c:40d5:b0:3a1:8d0f:db47 with SMTP id m21-20020a05600c40d500b003a18d0fdb47mr28113039wmh.138.1657099053154;
        Wed, 06 Jul 2022 02:17:33 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id l34-20020a05600c1d2200b003a03e63e428sm27725529wms.36.2022.07.06.02.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 02:17:32 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next] selftests: mptcp: validate userspace PM tests by default
Date: Wed,  6 Jul 2022 11:17:06 +0200
Message-Id: <20220706091706.2679400-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new script was not listed in the programs to test.

By concequence, some CIs running MPTCP selftests were not validating
these new tests. Note that MPTCP CI was validating it as it executes all
.sh scripts from 'tools/testing/selftests/net/mptcp' directory.

Fixes: 259a834fadda ("selftests: mptcp: functional tests for the userspace PM type")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index f905d5358e68..48a99e1453e1 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -6,7 +6,7 @@ KSFT_KHDR_INSTALL := 1
 CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
 
 TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
-	      simult_flows.sh mptcp_sockopt.sh
+	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
 
 TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq
 
-- 
2.36.1

