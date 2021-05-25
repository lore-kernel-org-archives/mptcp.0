Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0281D70
	for <mptcp@lists.linux.dev>; Tue, 25 May 2021 09:17:20 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id e17so12516529pfl.5
        for <mptcp@lists.linux.dev>; Tue, 25 May 2021 02:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EYGMIxB7FtEIvW6MTDb+8whnN0GeDuVFPW3zXqBjsCo=;
        b=ECzfMVR8EQuFlgBOhlScFzjSVFvwHcClEJBGHPDxw85ViPjZ7SmrmYEGyD11Hw5c30
         6hNL3PuD9uRAZgOSixmvHSWdqbOPK7TF5mBAgEMeHwQhlcIFX7nrHMmlXC5xGSWKYDvy
         ycJBNXfKA8JsfPW0e2DVkab2fiolhz5JbPIRr7llQIKpfwVJRq1Vb3vejK/8oLM4+6IE
         x5UdiJqHdfXOTSdeXSq8YdEhM1uKa5lfTvdomrn7PmMdpX7QuFWVLQswwT8epXUU5qCB
         /y1VVBrmW2UXmZSrk9ts86l/Opzbmz+zzy91JRru7GICugMI+qOUEypBHoAzTWIzSifV
         yQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EYGMIxB7FtEIvW6MTDb+8whnN0GeDuVFPW3zXqBjsCo=;
        b=U5D1VncYo3EbyO3xPZhJJwTMAMltrfKqinZ87oJxux4ffKtwk5TQe49JC/R4QJyWYX
         AiSugUf/V5i0t4+Ih/HUl+JoI7SDl5casrzTL4jTOVIm2TtqBpS/UMZ+uIqxksDmbxBz
         pJrgHyqp60EVi2A0NaL6wwRf9jRsM0JT76cxlmBzyNccUHYPGVtDLkdS/5nGf2M1rter
         JCsiMY7NILWqVOVNLA/QLAm3h0VmDW+x5z1rFi2XroLO/ABdBNQxairrDsWMqny6YywI
         95sjmW5ymH62xvFQH3U5LDpHuCpgxA6J5EnMFE/oNyGO1f/HGjplhJbCM+xfiyl0iAV+
         S2mA==
X-Gm-Message-State: AOAM530uYfKGU2KYs02vHKsMKl3HmZLuxfPB42vXiIB2JCNeCwfd9YqT
	/yEMZvM2wIIJ0VSp/3LkLYArtn5D1g56yA==
X-Google-Smtp-Source: ABdhPJwwFeSEcZbgkJXFiHXP1vTkD9c+6f3u4YF6aBhzMNmLIeEfGnL2ijI/pUB+GD2LQC3sYfJIHg==
X-Received: by 2002:a63:ee10:: with SMTP id e16mr18219224pgi.135.1621934240411;
        Tue, 25 May 2021 02:17:20 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id q24sm13613153pgk.32.2021.05.25.02.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 02:17:20 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v8 mptcp-next 4/4] selftests: mptcp: add deny_join_id0 testcases
Date: Tue, 25 May 2021 17:17:06 +0800
Message-Id: <067cd82f6acb01eec6fa44f3e9acdeb12e79dcf8.1621933974.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <5111dfce361c87c83e5355e78e55b6f593bac55b.1621933974.git.geliangtang@gmail.com>
References: <cover.1621933974.git.geliangtang@gmail.com> <b7f8df04d7b08026ee10cf2a784afda85e8cf6df.1621933974.git.geliangtang@gmail.com> <57e35b700b797c875966ae26252ae07316853837.1621933974.git.geliangtang@gmail.com> <5111dfce361c87c83e5355e78e55b6f593bac55b.1621933974.git.geliangtang@gmail.com>
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
 .../testing/selftests/net/mptcp/mptcp_join.sh | 75 ++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 523c7797f30a..9a191c1a5de8 100755
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
@@ -1462,6 +1473,63 @@ checksum_tests()
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
+	# signal address allow join id0 ns1
+	# ADD_ADDRs are not affected by allow_join_id0 value.
+	reset_with_allow_join_id0 1 0
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "signal address allow join id0 ns1" 1 1 1
+	chk_add_nr 1 1
+
+	# signal address allow join id0 ns2
+	# ADD_ADDRs are not affected by allow_join_id0 value.
+	reset_with_allow_join_id0 0 1
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "signal address allow join id0 ns2" 1 1 1
+	chk_add_nr 1 1
+
+	# subflow and address allow join id0 ns1
+	reset_with_allow_join_id0 1 0
+	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "subflow and address allow join id0 1" 2 2 2
+
+	# subflow and address allow join id0 ns2
+	reset_with_allow_join_id0 0 1
+	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "subflow and address allow join id0 2" 1 1 1
+}
+
 all_tests()
 {
 	subflows_tests
@@ -1476,6 +1544,7 @@ all_tests()
 	add_addr_ports_tests
 	syncookies_tests
 	checksum_tests
+	deny_join_id0_tests
 }
 
 usage()
@@ -1493,6 +1562,7 @@ usage()
 	echo "  -p add_addr_ports_tests"
 	echo "  -k syncookies_tests"
 	echo "  -S checksum_tests"
+	echo "  -d deny_join_id0_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -h help"
@@ -1528,7 +1598,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
 
-while getopts 'fsltra64bpkchCS' opt; do
+while getopts 'fsltra64bpkdchCS' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -1566,6 +1636,9 @@ while getopts 'fsltra64bpkchCS' opt; do
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

