Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D6672
	for <mptcp@lists.linux.dev>; Sat,  8 May 2021 10:34:19 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id t4so6505852plc.6
        for <mptcp@lists.linux.dev>; Sat, 08 May 2021 03:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vCAtB47EYneB9xZ3pqNAlLvPbgQtyyLLAKTR5G44eUA=;
        b=AH95Dgy0/xiRVmfq+NO3c2pDDi3I0Mr7BKcbbYpq3FsvB3hvUPIZ9gMj/pURRxGAjf
         fufxz3wLeJCBKi5PqPPggcDR3f93EYRATKsXxptYenlex3RilEoeLx0wdVyphX0reaHi
         +X0VyhAOpGGh1NkLYwZljQZfd1PHFJxUUhgj/JAdfiURNpdny6MjVSxRYRrIo6ryc56y
         1tHqCl97oAme+2z1DEnXmGfOPl2Rqns6eVBJm7ZXi91rI3YsaqKK5POknq9B0LvUoUFi
         JuBDvuZKFewjk7K7BVZjQUs5RxT86EnzcCQnAzD02hgJ75q3YpgRSNziesVXyX7wYGy0
         unGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vCAtB47EYneB9xZ3pqNAlLvPbgQtyyLLAKTR5G44eUA=;
        b=R4jBrbJ5MQQbAo8HyQYdUe6gSlcWuqP6tu002iBCdd5eIO29PnRghkDvC0C3aVGVTp
         nnJXCdZOVu7fKP8gYRn+pl5pn82mc804Lk5flJSr7d9tuCUoXwcRc3TOe7x8ltTVtqCF
         gQIVSezxMRmR0acj7v1iylAnUSWzND1GcGAkZcHBxceusd5jKXMc0Vv3/1KOiMufTOlR
         0e0Ec4qQbqh1nOOduklomdDa5yUFCqrPFNcWxLX2r9LCWG0BusQeNrDHfX06ZS3D7WMt
         FeT6CYG7PeY197sIQ+i4/D5zdAiRmqNtyWY27VirYEgxqFKskPY0Uqp2VB4iy+jYozbc
         jwVg==
X-Gm-Message-State: AOAM53070mbTtDlHHDFVmbldG6GfGcx3QdAjkyx8UodO1spakbjHyYRS
	veWD7uuAjMusGPKhqa69AjIVFh94rKc=
X-Google-Smtp-Source: ABdhPJzgZXMUkFusHgAQCVDKo8ksW4MhVbjrBJHvwPS8tj2xJZQMdhJ9bmClbXniAk6R9cKmYzW3hA==
X-Received: by 2002:a17:90a:c218:: with SMTP id e24mr11378079pjt.180.1620470058672;
        Sat, 08 May 2021 03:34:18 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id c13sm8390355pjc.43.2021.05.08.03.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 03:34:18 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v5 mptcp-next 5/5] selftests: mptcp: add deny_join_id0 testcases
Date: Sat,  8 May 2021 18:33:28 +0800
Message-Id: <af0b82307d5ebab93a3bc10090a1eb71c94bdcc1.1620469774.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <c9966a080be92cc508bfdeece2085cfaca7dbe2a.1620469774.git.geliangtang@gmail.com>
References: <cover.1620469774.git.geliangtang@gmail.com> <0edd6a3ad45c1f67a350356298ed4333fc42dac3.1620469774.git.geliangtang@gmail.com> <04612972cea357bc84aa01e145ac689a8397f466.1620469774.git.geliangtang@gmail.com> <b2a2ef7d225e72395055f34445968d25939b6b0f.1620469774.git.geliangtang@gmail.com> <c9966a080be92cc508bfdeece2085cfaca7dbe2a.1620469774.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new argument '-d' for mptcp_join.sh script, to invoke
the testcases for the MP_CAPABLE 'C' flag.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 56 ++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 523c7797f30a..17b385f011d2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -139,6 +139,17 @@ reset_with_checksum()
 	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=$ns2_enable
 }
 
+reset_with_allow_join_id0()
+{
+	local ns1_enable=$1
+	local ns2_enable=$2
+
+	reset
+
+	ip netns exec $ns1 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns1_enable
+	ip netns exec $ns2 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns2_enable
+}
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
@@ -1462,6 +1473,44 @@ checksum_tests()
 	chk_csum_nr "checksum test 1 0"
 }
 
+deny_join_id0_tests()
+{
+	# subflow allow join id0 ns1
+	reset_with_allow_join_id0 1 0
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "single subflow allow join id0 ns1" 1 1 1
+
+	# subflow allow join id0 ns2
+	reset_with_allow_join_id0 0 1
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "single subflow allow join id0 ns2" 0 0 0
+
+	# subflow and address allow join id0
+	reset_with_allow_join_id0 0 1
+	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "subflow and address allow join id0" 2 2 2
+
+	# signal address allow join id0
+	# ADD_ADDRs are not affected by allow_join_id0 value.
+	reset_with_allow_join_id0 0 0
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "signal address allow join id0" 1 1 1
+	chk_add_nr 1 1
+}
+
 all_tests()
 {
 	subflows_tests
@@ -1476,6 +1525,7 @@ all_tests()
 	add_addr_ports_tests
 	syncookies_tests
 	checksum_tests
+	deny_join_id0_tests
 }
 
 usage()
@@ -1493,6 +1543,7 @@ usage()
 	echo "  -p add_addr_ports_tests"
 	echo "  -k syncookies_tests"
 	echo "  -S checksum_tests"
+	echo "  -d deny_join_id0_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -h help"
@@ -1528,7 +1579,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
 
-while getopts 'fsltra64bpkchCS' opt; do
+while getopts 'fsltra64bpkdchCS' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -1566,6 +1617,9 @@ while getopts 'fsltra64bpkchCS' opt; do
 		S)
 			checksum_tests
 			;;
+		d)
+			deny_join_id0_tests
+			;;
 		c)
 			;;
 		C)
-- 
2.31.1

