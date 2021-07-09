Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C9572
	for <mptcp@lists.linux.dev>; Fri,  9 Jul 2021 11:04:58 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id k20so2618315pgg.7
        for <mptcp@lists.linux.dev>; Fri, 09 Jul 2021 04:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2/W/5a/Ym+laR9TTr/4bn5WMw8xEK8oJVbNcAg05QWs=;
        b=Fb4jnw12rJLaOVtbKgAutIQVMBmlhKstYigsE68SMxA4pNe5j6lSIdLmHtOpCmDwvv
         iWS33lswUiO+3ymoqlKASYrnM9a39++mzFO2vlap9RIRwetwIxxJbiciAM67xiG2OioB
         afvQEo0cTg1y/Gp0QuNecuu6ge5YJJpLjgxZMmmtHm9/qHm9y0tUbXusRdNcPOijvD2M
         aRJMT44CVOV+ASpyEC4/bd7BWZ+QJuB6f4QR146ppa8yevJZz14rRYtH2eufB2IaHOOB
         j9gjbwb10WFhc8xRG/XNbCgfuRpGldsY5g8Maz2JDSYEvpuTSO6I/bEhbyqK3dK5SBhc
         emKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2/W/5a/Ym+laR9TTr/4bn5WMw8xEK8oJVbNcAg05QWs=;
        b=nv+60vbVoJMbiL7VAyko5/RFlMroqLCoO3o5tb+3fRna+MfLcyFU+M8GYXyeuW+w54
         +XzEz4FeDTaDUkSe8c2EAveN+uUgqByNg4wXxp2a1lFFb6zWqygr/h04dB2dVoWSailR
         cznLClRtuDnCRbqhmHcashrx9rESxF65lb8JpJfJtGf33+Epa4+FIhyogsnIQUriaL1B
         fQ5/oWeeKTm63wfrCXejCH8rqhP5dIBV/opplOtesHceQ9ZKDNiPZ+HxwieLg5915Io6
         u3sSRHJp9yhPe/+xQ9rZznUMUsNV2njY5k2UCrkwoIzmSW6OlrvtegRe50XYpOVMcGbv
         bR+w==
X-Gm-Message-State: AOAM533TOE2K1gRHxquNvoyMUr7d5oWelhQjfHdQj8KScQQGjIuBqLHT
	uzkKlbq9lVl2biWquBzsOPw4g8HLHqoMew==
X-Google-Smtp-Source: ABdhPJzDu3fHJsB9uiycVWDkGv4bf5tWQJ6EYNxX+WC2oo1Ctr7l7jKa+bkMvBnIq20yNCZmbB04lw==
X-Received: by 2002:a65:5b0f:: with SMTP id y15mr37709788pgq.263.1625828695767;
        Fri, 09 Jul 2021 04:04:55 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id s15sm6247902pfu.97.2021.07.09.04.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 04:04:55 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 9/9] selftests: mptcp: add fullmesh testcases
Date: Fri,  9 Jul 2021 19:04:36 +0800
Message-Id: <60971e66e90fc5816949f1501b851a3203d2e5b0.1625825505.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cac9bd939a1d5ef71627de0c3cdad94431a73016.1625825505.git.geliangtang@gmail.com>
References: <cover.1625825505.git.geliangtang@gmail.com> <974215e2c4ec6e953bd28882820507b0638c3a8a.1625825505.git.geliangtang@gmail.com> <b699c90050c80f3c79b5fa42d1d9c18c46a21014.1625825505.git.geliangtang@gmail.com> <8b000137623aa94ab4f7c6b883c2003d91f3d147.1625825505.git.geliangtang@gmail.com> <3a4cae1a5964f864bc7cb74d311c014cda279a2a.1625825505.git.geliangtang@gmail.com> <f4ea9c590e22735421bf6a4f11628bbbb493da16.1625825505.git.geliangtang@gmail.com> <077d3ff80fa785e602669724bb4fed9789a98e70.1625825505.git.geliangtang@gmail.com> <9761e92041968743463b3e3836cc54d063e296b6.1625825505.git.geliangtang@gmail.com> <cac9bd939a1d5ef71627de0c3cdad94431a73016.1625825505.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added the net device UP and DOWN testcases for the fullmesh
path manager.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 66 ++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f02f4de2f3a0..7e3fd0d94343 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -150,6 +150,14 @@ reset_with_allow_join_id0()
 	ip netns exec $ns2 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns2_enable
 }
 
+reset_fullmesh()
+{
+	reset
+
+	ip netns exec $ns1 sysctl -q net.mptcp.path_manager="fullmesh"
+	ip netns exec $ns2 sysctl -q net.mptcp.path_manager="fullmesh"
+}
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
@@ -342,6 +350,15 @@ do_transfer()
 		elif [ $rm_nr_ns1 -eq 9 ]; then
 			sleep 1
 			ip netns exec ${listener_ns} ./pm_nl_ctl del 0 ${connect_addr}
+		elif [ $rm_nr_ns1 -eq 10 ]; then
+			local addr
+			if is_v6 "${connect_addr}"; then
+				addr="dead:beef:3::1/64"
+			else
+				addr="10.0.3.1/24"
+			fi
+			sleep 2
+			ip -net "${listener_ns}" addr del $addr dev ns1eth3
 		fi
 	fi
 
@@ -390,6 +407,15 @@ do_transfer()
 			fi
 			sleep 1
 			ip netns exec ${connector_ns} ./pm_nl_ctl del 0 $addr
+		elif [ $rm_nr_ns2 -eq 10 ]; then
+			local addr
+			if is_v6 "${connect_addr}"; then
+				addr="dead:beef:3::2/64"
+			else
+				addr="10.0.3.2/24"
+			fi
+			sleep 2
+			ip -net "${connector_ns}" addr del $addr dev ns2eth3
 		fi
 	fi
 
@@ -1530,6 +1556,39 @@ deny_join_id0_tests()
 	chk_join_nr "subflow and address allow join id0 2" 1 1 1
 }
 
+fullmesh_tests()
+{
+	# fullmesh add
+	reset_fullmesh
+	ip netns exec $ns1 ./pm_nl_ctl limits 8 8
+	ip netns exec $ns2 ./pm_nl_ctl limits 8 8
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+	chk_join_nr "fullmesh add" 3 3 3
+
+	# fullmesh add IPv6
+	reset_fullmesh
+	ip netns exec $ns1 ./pm_nl_ctl limits 8 8
+	ip netns exec $ns2 ./pm_nl_ctl limits 8 8
+	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+	chk_join_nr "fullmesh add IPv6" 3 3 3
+
+	# fullmesh del
+	reset_fullmesh
+	ip netns exec $ns1 ./pm_nl_ctl limits 8 8
+	ip netns exec $ns2 ./pm_nl_ctl limits 8 8
+	run_tests $ns1 $ns2 10.0.1.1 0 0 -10 slow
+	chk_join_nr "fullmesh del" 3 3 3
+	chk_rm_nr 1 1
+
+	# fullmesh del IPv6
+	reset_fullmesh
+	ip netns exec $ns1 ./pm_nl_ctl limits 8 8
+	ip netns exec $ns2 ./pm_nl_ctl limits 8 8
+	run_tests $ns1 $ns2 dead:beef:1::1 0 0 -10 slow
+	chk_join_nr "fullmesh del IPv6" 3 3 3
+	chk_rm_nr 1 1
+}
+
 all_tests()
 {
 	subflows_tests
@@ -1545,6 +1604,7 @@ all_tests()
 	syncookies_tests
 	checksum_tests
 	deny_join_id0_tests
+	fullmesh_tests
 }
 
 usage()
@@ -1563,6 +1623,7 @@ usage()
 	echo "  -k syncookies_tests"
 	echo "  -S checksum_tests"
 	echo "  -d deny_join_id0_tests"
+	echo "  -m fullmesh_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -h help"
@@ -1598,7 +1659,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
 
-while getopts 'fsltra64bpkdchCS' opt; do
+while getopts 'fsltra64bpkdmchCS' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -1639,6 +1700,9 @@ while getopts 'fsltra64bpkdchCS' opt; do
 		d)
 			deny_join_id0_tests
 			;;
+		m)
+			fullmesh_tests
+			;;
 		c)
 			;;
 		C)
-- 
2.31.1

