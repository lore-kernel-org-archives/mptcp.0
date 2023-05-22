Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F1D14A92
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:35 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3f606a80d34so7027325e9.0
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773515; x=1687365515;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nu4wUabgHajGuWXoEhcu0ezc3UP43/rVTxkuH5+IyKQ=;
        b=eH7LWUB59AYvg/5ND9UDizjn31fJFk/Hw1oCNlErHfTkZ6w0IvXCE7wQ8pgvz5eCbE
         J5dvMdPhOfDEQFEgLWS5qDO5z/olUK8rbBglC3ZDuSdXJD73SIotZLpvyy3hjsQh33pQ
         gaWjhVp+quamkZ6v8Vb/9dVekXkpBpWKNpmKLKga1QFVD44+hJf81VLxcAHUa8x1pX7+
         cr22EYQKOeV4SzQbIoiaG2TOeK7So32r3x//sFyiA1hSkbTJlhXSC9W4uinZT/e9Z8Kv
         2JgLekKQndBxkqNYElpCxtMzzGiokT7r2qsT0vcQcQ6gH1Z5MoD0hd2Zb+OLlvEwB+sO
         faRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773515; x=1687365515;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nu4wUabgHajGuWXoEhcu0ezc3UP43/rVTxkuH5+IyKQ=;
        b=Gj46ec39BAngTyduIIRwQjoisqMZLjLoD1k5SJYYJhOdznvxiFLzgKqjAcYr5yOqMc
         sVf17KzkPLtC5uYeEB/8/9jjmD4ltLZR56eR//6R8+rfxrwUXi9pnzzSZeoHiTUErb0B
         e3bkGewYngHA/ScU4kDrqv/hT1TPz5t7VDPw42dknGobThGV35eWPiR35VWtczomGlNp
         YHSazFybn23vcBVr0GHf+vHBWd86IqcEJ4Ctkn3x4U8OXEkQ9pO4TmweqJt7x7z/C1fP
         otjFjkbkvWeFQeDx/bE16k6de3zukFD0FHu+vLYZaE+13M9iFImLLswuf06hq50fj55S
         AkJg==
X-Gm-Message-State: AC+VfDyPRhp/TDqnQNsM69dpAh9Ilm3OqexNdl9XIbrZvCMGJiZYpdLE
	NbUH11rDLZPeqGY+GOICwfhzwQ/xw1Jl4srvZ1mrkw==
X-Google-Smtp-Source: ACHHUZ7VpmdHJt3H5/1ueMJugY8d+QxAn0c9G53MirsecONVstul1bj64SLs/YCATDHWIUa20JHDDw==
X-Received: by 2002:a05:600c:294b:b0:3f4:2d22:536a with SMTP id n11-20020a05600c294b00b003f42d22536amr7933995wmd.19.1684773515272;
        Mon, 22 May 2023 09:38:35 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:34 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:38:07 +0200
Subject: [PATCH mptcp-net v2 35/37] selftests: mptcp: join: skip MPC
 backups tests if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-35-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2515;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=X5EfQHStA839zkiwchX6/aDU7EM0ro/sWdF+pLiKPzw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pxsJ/T6aWT75uEt8PgJ/S2Xl7a29pCTaw50
 qHybDeYZISJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacQAKCRD2t4JPQmmg
 c/KAEACp6Ry5zdoWCR90TlYlNm8Ghp3Q1VRStV7J4+04sDEhg25n1NPlehkSGFKoofim4y0AUFm
 x2wGGIYS7TNUFbZfXbt+dWbZw7tHvnE/STl6DhyYhkG2hpEu6PCvge3lg+jI6d7s/jyyuHY3XYI
 lHhh8c1j4S4gehj0CSDto/Ag0cKB/WeoCLA9gDm6kl4mnRcGniN1eekwICOhUu/3WY6HZIBjZid
 ZU7qiQ0UYjg1Zk2pmGZs5Hncb57+yR0eMvqWp0fB/W02q7o5DA1pFdAD7IsV6LsoTAr163vfE4D
 BFonchREwUXa6X5FJ5ZBsGdgW1KvsBODsZxLpQ3NCuujQ61VSQenunR15rcJnX+7xQVD1twaWf/
 2tFSeS8JUTuT2wFVVnhMy4LA/uiVti+nBi62LMqygqoVXeULVW0sHdKsVVoO1roH5O7IflP48lK
 F5pqBlrubuW92UttM5NBICviH/dgUDFvAVfyh7OqoliF+vIr/MsOVRN0HygDRrx1PXXjmyhi4WC
 gp5sM34/GmF5mSTmRFz9e8OYDCfIgDI/RVRRokQKAKJ9QTCPrMcwcxsaxDZBiB+9Bs4T8uiSmq7
 iKmtSptg9vzWKXQ128vTun2CxwLYrrCE4LWNXjwfJ6rnwz7LuLJJJZgQfQ5MIFuKVA/XZ1ZwW0P
 wGubpaQFml8gAWg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of sending an MP_PRIO signal for the initial
subflow, introduced by commit c157bbe776b7 ("mptcp: allow the in kernel
PM to set MPC subflow priority").

It is possible to look for "mptcp_subflow_send_ack" in kallsyms because
it was needed to introduce the mentioned feature. So we can know in
advance if the feature is supported instead of trying and accepting any
results.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 914f6a59b10f ("selftests: mptcp: add MPC backup tests")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 37554287eb89..dd8633e98185 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2771,14 +2771,16 @@ backup_tests()
 		chk_prio_nr 1 1
 	fi
 
-	if reset "mpc backup"; then
+	if reset "mpc backup" &&
+	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
 
-	if reset "mpc backup both sides"; then
+	if reset "mpc backup both sides" &&
+	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
@@ -2786,14 +2788,16 @@ backup_tests()
 		chk_prio_nr 1 1
 	fi
 
-	if reset "mpc switch to backup"; then
+	if reset "mpc switch to backup" &&
+	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
 
-	if reset "mpc switch to backup both sides"; then
+	if reset "mpc switch to backup both sides" &&
+	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup

-- 
2.39.2

