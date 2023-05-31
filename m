Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB9116405
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:58 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f606a80d34so44192075e9.0
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542618; x=1688134618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nkliXrGlEkbd2nGEs0WX0uf3NskNxDlMByWx5UCB1xI=;
        b=zYy/NsGFRsrkc+IG8ZETLrtf8sJwyIqJjMRdDjB4noqXDdnfRfFfiOipHqG8XbOb4s
         VUq2D/9AgQjoZ53NHO7J714dEhexE1wS8Gm25RlOT5Qfe2e3RVC5vgpWpPyGvRNv3DhN
         BLLua1gnZuLiJAedSyC+3DybX8MTqFmh40FxRE++g2/CNikzYG5r7WcrUm9OywhY/XXr
         ejl1xeVd/+uFSytsi8YitjL+epNiMcA8Ig7bYlxQ7uWKbrc558dj5DJ9t9qYQ4JkIj+g
         EkeJ7Tpdxk8LAPxb+G9zW982UqzK0yn2TLx6pexb274D+vSlrM0zjlhafY14AaKgoaFb
         Hw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542618; x=1688134618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkliXrGlEkbd2nGEs0WX0uf3NskNxDlMByWx5UCB1xI=;
        b=Ph7xgQu3X/xfCoSeCz8Ay6FyhRlAHmv5rFPUAEb6/dyhMEJA9RAE+ITFYy51mvQyvn
         ng6IOwgWM0j0mHK5JHvq8p9niRZJidBuOgdP+YiKycKx4sNvBfAwzeZ/P9dH/wrnD2xo
         Y1l6SvLHp54YkDsFHlkyafGXn6Bc83ypTO01Re7cQCE2BzsNZgS/SqtzMDh0wSXq94Fh
         QxH/hDCUHh3AHDyXpkDSfsXlreAcKNcgVHdFKS+AWhWnloMEyT+2GOam5Yg+wUAX89rD
         g+EOIo9e2+KNrxmNAhfe2WbaBFp/3RgTIR6p1N3DM4OaQrIXUO4gHYzKCLrmVm4egsfJ
         cJKw==
X-Gm-Message-State: AC+VfDy8TLaY1GgyBE8xi7/Tto+2hSOnIBZtgSo9RjwbfobyUM0yAf2H
	NJua/yYAPy0Orzkx0Cgz7b4qIhPiWYtov3++OCvrERZZ
X-Google-Smtp-Source: ACHHUZ74yhbQDmv/od6TPW97n79akbpcc1wAnR8xyiqHKG4C0uASfpRD3hOf92P9RpZDsyXuCD85Ug==
X-Received: by 2002:a7b:c408:0:b0:3f6:536:a4b2 with SMTP id k8-20020a7bc408000000b003f60536a4b2mr3883707wmi.27.1685542617995;
        Wed, 31 May 2023 07:16:57 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:57 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:48 +0200
Subject: [PATCH mptcp-net v3 28/32] selftests: mptcp: join: skip MPC
 backups tests if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-28-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2515;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=60UlleYz4v0Cs/djZJRZxyieRd3RMczJUatQ4PGz/pM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bErluC+9+nZtf/1BFXo9Re7sVyX9JHvachp
 Y2IyJBsmaGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWxAAKCRD2t4JPQmmg
 c4ovEACL3kVR4wOG0szF674MxEUxKxGoy9oACwTL+tMBlot1RY7FiECmLlWKdKKFRfWVaQRG3UZ
 utqyOp7YPQ43HAXw9/eyjklMk0ls9lV66J/emzADA0UUKtLEoWGkVaxAYQhD+H++ybWj6eymnTF
 S7HG3I8o/NG6JEVMUmc5lCjx6oGzQdxzAqddfcIQKWMZK0lhXdk2oXCRzV3LnZ7+FI6NtQcdIlW
 WYw8tKia9e7EYrfGOeEoUpCJ5sOnvvCNLiReECPPtkMqO0e+892qorLKgmflSuV5jQfRbJIcVGy
 hKUEmfUhi6UIB2ZwHs7x/GImbXvc78gFJhU+drzvdvkFytT0uDU6qMOp3c0gwip9iHwZ7Al+/ra
 SkPpl3y/kvCei4tStzWhTI+w4fQrDVlITbQhJ7VxWrqIhlSyY0Afr0yeAugdG8Z643qkhZFBDFt
 W3jYhP2Eltk0vtOF+XtNXpp70bm2AhMy+BOQpCKXlYpZ9Ci74WijDk3gtJWen0dKT6v9Y7mccKA
 s8HZWXaGSNqyYOiQ4PmfpuryD19lAzNczFwUlNoqxP2cg6yGDgnx+FID609L2lY13g1NuS9xlTN
 Rsg4of1xBQkeXetwgt3xtEIf0LgCwMpcM23oVoh5NFvOxYRM7gLS0ym1AELJ9UPBVO1gN4hUEoh
 GnKM+fJQ1DqWtPA==
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
index 0ad8cce088d8..82281d59ac10 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2722,14 +2722,16 @@ backup_tests()
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
@@ -2737,14 +2739,16 @@ backup_tests()
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

