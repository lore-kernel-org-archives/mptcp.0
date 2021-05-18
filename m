Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21AC6D0E
	for <mptcp@lists.linux.dev>; Tue, 18 May 2021 10:05:20 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso1470550pjx.1
        for <mptcp@lists.linux.dev>; Tue, 18 May 2021 03:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MK3PBH0Og7yDYXKZi4YvD3++L5S1+LxFrSwKE4rNBFE=;
        b=h92N+NS8LqGjaYEOUP+n9c59ucKFrHQ2xqYIcea+fCpKUqhTbtEyFqhAaw52ImoOWZ
         woizjhLFrVljz0KHyleDMJmGXzxGrks7wihpGySDty5Qpz0t9JfHXXLxz3PvrPuh49ep
         B+LIlBj94ZsyAGvAYgiRtpClVwNJTx1DDSJ+BQNhfxK5l0O8DLK5vQQH+gYFY2phupGy
         F2j2XFaFFyBH4G3ZIXiamlGgJGiXw0PSSteMTXxFtrmkg9RD1xipByKTgnNg6kS8+3RX
         ZUxaXzwnePM05ad9+TOqAF+fNe6xcmVfwi4jgVwl7Z5ZDRrD9Vpbaia7WlEsN+4eCujE
         ayZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MK3PBH0Og7yDYXKZi4YvD3++L5S1+LxFrSwKE4rNBFE=;
        b=H4jRqbhFI4RhI2F21muqvZBHcEOiszwMYcVfyYxDTA43GybiJ/72BY6d8j5ZBku/uZ
         2L8D9XDfL8uq2MXmc3R+mwuuWmDK3oy/3nElwhXSLwM5+0vB1Yi90yKOVM1wlDKHRMe/
         +E+Q2jte44Wp6RVhHgx58319hUId0kNnfDBAcyN7XB9DoBfc0au8NuB5BDGue9C5phUX
         3k+npuftSTVPG8OOikqZSNEPmQDHHvvf2rHa6T2cjpNI5yL0rEUTUuoB99P2lTCMwQuV
         cVzDFPVQ2BOF7l1YxylvYoUgr0ks/La0CYOaSgH4uYxRHQGnf26vNj5C3PM8WaEiizA6
         4E7Q==
X-Gm-Message-State: AOAM531lmdqkwsYwEUKjSd9Si3sQT0AyjgzHW/1r2JaVLeRkHZB2mz5d
	2kS/kJ7ATXcYMzfDS7j5Y4jSk6azlX8=
X-Google-Smtp-Source: ABdhPJyVm3EEeRpU6Xp7Qtl8m30+DWpWSLF7hwS3M0b6MvE0/+GyGVO+Pk5dAh1PuC/HzamQEQBqBw==
X-Received: by 2002:a17:903:31c9:b029:ed:6f56:9d1e with SMTP id v9-20020a17090331c9b02900ed6f569d1emr3715743ple.46.1621332320335;
        Tue, 18 May 2021 03:05:20 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id t13sm1699195pjo.54.2021.05.18.03.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 03:05:20 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next] Squash to "selftests: mptcp: add deny_join_id0 testcases"
Date: Tue, 18 May 2021 18:05:14 +0800
Message-Id: <192d32dcf9dc61f93efb4d31c46a4a509f3a9f0f.1621332213.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <b49f8eb27abe177f54ea8d7b746ba02003d49682.1621332197.git.geliangtang@gmail.com>
References: <b49f8eb27abe177f54ea8d7b746ba02003d49682.1621332197.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the testcases.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 35 ++++++++++++++-----
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 17b385f011d2..fe46d666b18c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1491,24 +1491,41 @@ deny_join_id0_tests()
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow allow join id0 ns2" 0 0 0
 
-	# subflow and address allow join id0
+	# signal address allow join id0 ns1
+	reset_with_allow_join_id0 1 0
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "signal address allow join id0 ns1" 1 1 0
+	chk_add_nr 1 1
+
+	# signal address allow join id0 ns2
+	reset_with_allow_join_id0 0 1
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "signal address allow join id0 ns2" 1 1 1
+	chk_add_nr 1 1
+
+	# subflow and address allow join id0 ns1
 	reset_with_allow_join_id0 0 1
 	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
 	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
-	chk_join_nr "subflow and address allow join id0" 2 2 2
+	chk_join_nr "subflow and address allow join id0 1" 2 2 2
 
-	# signal address allow join id0
-	# ADD_ADDRs are not affected by allow_join_id0 value.
-	reset_with_allow_join_id0 0 0
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	# subflow and address allow join id0 ns2
+	reset_with_allow_join_id0 1 0
+	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
-	chk_join_nr "signal address allow join id0" 1 1 1
-	chk_add_nr 1 1
+	chk_join_nr "subflow and address allow join id0 2" 2 2 1
 }
 
 all_tests()
-- 
2.31.1

