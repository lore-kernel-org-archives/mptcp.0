Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E8914A81
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:27 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f6077660c6so6714635e9.0
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773505; x=1687365505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0ei76i35q+o+nzUQpSan8v+cX9LImprp1hU5M2lz48=;
        b=kXXbxA9vas2xE49Vz6zgFzLT1e8P0eqeeOY6mu2PQPhorvWnlNFZjfJZAGo2DeGXXK
         UkZsn1PFyztkkAgLY+DY40sHTXFRoPK3C3W4LdH8nYViDJd76MxBbxM5exrbeyrk/Vni
         E9LAFVbI6nQ01aii2Wje/NDu+cu/2G4ou2iZLhZffkgzO+2ynNjwhMaEbjc2d7Sme7qK
         6DePa1GMAdh9rsAiFC6Uos7U3B8m0lcHcEAv07fBBHbD+pnO4gZUTR12hzP3/RgNK6Cj
         DgstwnMeFvyLqcAmIZUAPQ00QbH2kgIMGF5WNE83cE91TaBgtR6A8g2K0Y8Z8lYAf3Ta
         8IpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773505; x=1687365505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0ei76i35q+o+nzUQpSan8v+cX9LImprp1hU5M2lz48=;
        b=i6olN0NeLQ1ea/KMQ18uzsDl71lMA3KKBkPDRuVSrzOh5sUm87sisdXPS/lQaCxKxg
         qGPFVmYn2ojXWZNHOMyViPK4olmyZeWjB7C6n8jSRW4G3l2KFnUAv0Dck28CO3RrB856
         AJTgxrhYqJC2LeypzJgv0tG6ymiqM40jn/90QOwHYnPrmeD4+ZXyn8qxOlNitRYWdyUP
         VlmtYOkShIjofZUQkKVlaaSc1qqU41CR9acC3qjvRs0s+SR5Zm/kgZLUawyH0Fabeqqm
         4yVpUUOwfIyQHa6RLuczMCW07B1iwNnJIWddZ39IYf6qi+E+6d4cTZ9004ftZmo5eZH7
         6xSQ==
X-Gm-Message-State: AC+VfDwRUScjIlXnoy7VGiWSgqXDZLvsUFqtGZwvdrtCmrbjk9OTYUP5
	yjNzoZvAnyZQPcrq+6HD8ueL9EXGBKCgKaJ2UVN/AA==
X-Google-Smtp-Source: ACHHUZ4Kt7N94+8kAJUUrp0MoFCs3ZDUDpFiW5IJtS9Pj+dKsodebSeBOXcQIR88WsXxwYkX9OFZ6A==
X-Received: by 2002:adf:f049:0:b0:309:3d00:7d4f with SMTP id t9-20020adff049000000b003093d007d4fmr8107698wro.28.1684773505236;
        Mon, 22 May 2023 09:38:25 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:24 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:52 +0200
Subject: [PATCH mptcp-net v2 20/37] selftests: mptcp: userspace pm: skip if
 'ip' tool is unavailable
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-20-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=946;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=xTK/VWv7eqgePWxueOI9iC20Wx6RmAiAnEOlv8Am34o=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pw4/fZHMTa9z7PhaNamrIXYR9u6vr8EjMxV
 /8gGrwy5nqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacAAKCRD2t4JPQmmg
 cxPxD/9qbdZ4epQ1ouMrYWuDA1FLbMF2AmzCCvLTb1j0zI6LGbkTW7ecir8ko9kEj3pXTP07DGd
 +6pWxShaBELnL0cl/TQRw//TWx997zlweC5bUPGUlU9pHkoetoDWlpyRxuZvjaeRAWisY5sYS/k
 8vq5QuuGqu3G2Y75xlEJT0kpMRaHs01BN5Htfidyw2ZCewCKwJ1yM5VlnvlQRtYsGEKsbABky4p
 PHYY50SlM9TsCqeQWMJSzrB4QBY8s0bTg5LPffPJkmFWRrxVVZd3HOwR8+KX6/lsPbhFEK0nlMi
 wWqPUgS2UYn53KaRV5S6eUZp75p1fwrGwmULCVx2RKH4kp5UuImJQGzsZpjBMyaqKJ6kIBXJ0gm
 DePCC6NpLqaQ9nfttFHgVvr2J6F+LEwriDKHjse66wrCjLtDjbLxjeP2wDK1eARMnCWLk5o3cQ2
 hktxmz4z4HaQIEjs5fxvrUPI7OITV704v0kkOYlZz7LP29XmCzyof4sQ9tAu3knY48njmSM6ZQ2
 F6VunLRQuJmqiR0nc0FndxDQHqlWJJba9Nq/JLm+EbpvCdt7jqlldUBo60iX73DMrGzUpXz9W7E
 SG1BIVRp4bIKusRBq9gTY74LmbjojdYML5qrE3GUoZoQBwANJhd5wjDbEhgmA3wpqpmwy+QmAf3
 AWaB+KgVF1k1E5A==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When a required tool is missing, the return code 4 (SKIP) should be
returned instead of 1 (FAIL).

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 259a834fadda ("selftests: mptcp: functional tests for the userspace PM type")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 8092399d911f..192ab818f292 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -8,7 +8,7 @@ mptcp_lib_check_mptcp
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Cannot not run test without ip tool"
-	exit 1
+	exit ${KSFT_SKIP}
 fi
 
 ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED

-- 
2.39.2

