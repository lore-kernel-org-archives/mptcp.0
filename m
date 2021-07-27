Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF9B72
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 06:45:35 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id e5so12706298pld.6
        for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 23:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ydS5u/1yhGpmI6hYL2peHkgYV+9nUkBrsY4hOaTeArM=;
        b=ebeC54Pegvy65Rh0/sTlm6kVde0vbNtESRcSOHN9IizSTXYjoK7JD8tvwcu9q009Vk
         eke2m2RSadCeZhgR8DAcTBEu+wfFRqfFykleDc+DLV4BK/+q70a4jj1LodItyEGVoHmz
         urYr0BFfpn0yi9g+IgI15k7a5az9MIYzdTwBKcU46SKtBYLLxdbj8dTPJ/AE5zfwkfpj
         cP5kNt3OCaNz+1sfs8f8CbFE2EnJJ2ok4z9gexxMKLvf2lHOFaecBYYANuBrX6wMDeKq
         T59A1nWjK7XoatkB25GRjKeZ6NtEc4a1lxDtTVnMGLyJvKdrcXh4Ccgb1Uy1H87c9Sgc
         wU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ydS5u/1yhGpmI6hYL2peHkgYV+9nUkBrsY4hOaTeArM=;
        b=QEsn4E2iPuj3ZS9HzugCfVSy/rTByNjKCRAcB+pkNQ613HjbGnIvahRd2cOcoXv+kd
         Izr0Zhn6Bm4WzPo/ShyIWt0cM2R0SIoHuBiGikPXHFna8sTU8IJFRQbp3Z8hjv6SA5lm
         oka1IWIwbwHn1D2gYcYIrXOEuwdlnnuELMtkn2iN+ns04q3Ix64KVC/+Itigx9dIivlx
         D91pyly1gx5DLi+NPxt5F05/gZA4MzYWyMTpq33EX38y532wftG6ZlBrFjdu/oIgQMTE
         qDK+52YHibu5/lHL4RcJScYYvWsc86XIQsEGLhqeXwedpCZJIW0Zl+iBjvYQvI4+Ti66
         XRMw==
X-Gm-Message-State: AOAM5336r9l8n1MhrNYpXn9YPc2nDeUgoi6DIitHsNXKI/ksAHhypwNR
	nJraLD9V1a/9MO1TAPVyMwWfYu1DUBE=
X-Google-Smtp-Source: ABdhPJwwVAGkbKn4ATMq0e2kb2y7z7BWYzit3W/thXtMuMZgjeeA+RcZWiVZDS0qgCCJz1FIgukpCg==
X-Received: by 2002:aa7:9541:0:b029:32c:cefa:123f with SMTP id w1-20020aa795410000b029032ccefa123fmr21229334pfq.24.1627368334587;
        Mon, 26 Jul 2021 23:45:34 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id ce15sm1631384pjb.48.2021.07.26.23.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 23:45:34 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH mptcp-next] Squash to "selftests: mptcp: add fullmesh testcases v4"
Date: Tue, 27 Jul 2021 14:45:29 +0800
Message-Id: <68af9775c12340a5812bb7d08fd723e13c2db43c.1627368162.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

Update testcase 1.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9ceb6052b513..d87e7364dcea 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -325,13 +325,7 @@ do_transfer()
 	cpid=$!
 
 	if [ $addr_nr_ns1 -gt 0 ]; then
-		if [ $addr_nr_ns1 -gt 10 ]; then
-			let add_nr_ns1=addr_nr_ns1-10
-			flags=signal,fullmesh
-		else
-			let add_nr_ns1=addr_nr_ns1
-			flags=signal
-		fi
+		let add_nr_ns1=addr_nr_ns1
 		counter=2
 		sleep 1
 		while [ $add_nr_ns1 -gt 0 ]; do
@@ -341,7 +335,7 @@ do_transfer()
 			else
 				addr="10.0.$counter.1"
 			fi
-			ip netns exec $ns1 ./pm_nl_ctl add $addr flags $flags
+			ip netns exec $ns1 ./pm_nl_ctl add $addr flags signal
 			let counter+=1
 			let add_nr_ns1-=1
 		done
@@ -1715,9 +1709,8 @@ fullmesh_tests()
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 8 8
 	ip netns exec $ns2 ./pm_nl_ctl limits 8 8
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,fullmesh
-	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+	run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
 	chk_join_nr "signal address fullmesh 1" 2 2 2
 	chk_add_nr 1 1
 
-- 
2.31.1

