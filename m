Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F26072
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 07:58:36 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so2938305pja.5
        for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 00:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9uVkT+m7WPLMhw9sVvKma6vPeDedSq1FQRGC1Jx73GA=;
        b=oIHDZZrcoJDiIrBLnJjkqGKcdh7Hqx7tDvGnGzvEX+3oB6ElsEJ9cgaqKfCz3Emh8K
         TBO7BVgWtHyeeUmjD5gUXNXwELYdOg3Lropbxb+RJENrPw95H+chDHW+gMFNZ9QDWGHQ
         N2mSyKjn0NkLjYDUGTeF3dEFVLsxLE6MRdD4+nq2rC5izy5gXsfkG+tDrZ+6roIVhrBC
         Fk6LGAeFY+znEMmekqwF/KD/c+ORP8jBpkMlrJwUPi/0KFFgxF57iZIlGG3WWT79Ryko
         jhq12OnGbnXV7V5L/9RseaPcAcQ1uWzo9ptr/Om2vlxyHZmgll/+eksV/Ml7wg86YOcx
         D99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9uVkT+m7WPLMhw9sVvKma6vPeDedSq1FQRGC1Jx73GA=;
        b=msQeRofZ1ncgn5HF0YNfBaKnOKL3C+gsj7Rpr+creYgcP561mxFUCyJONiilKibpkm
         huA2kCPsMj7+FKGQ4qdgn6/j38JjMWmgGzs1wp0KiO6tdWLe+NfhbCGDmfCAneEnMlpV
         FIW4YiXVYR5sX4NLRhcz0debFhIMWY4c6oQ+25EZEinPn16wHpw7rew7ScpGnkk8pJIi
         BQ+bK7SMrHM+FcHagHl82e3yexFQANXEOG7zSX2jHSPBdh4HZtlEY5y5EmeFDD/TrhqR
         cnd6XYAcK49eCLZRbeK6yezAwGSkr/GJA+UCx1RxrGcgWE9RB94ROYvAsA+2UOqanPhf
         /ABw==
X-Gm-Message-State: AOAM533mL2R4mwBUojG9S4GrL1A4pNlANfsX80A+v+nk8pe+wCqRvRJa
	5OqW4RFJLv3S2Ad/PX6Owm36L9UTsa0=
X-Google-Smtp-Source: ABdhPJwGqtpqVhLy6mVHIloLX6EOPYc5/5Q6Lqep7MUiOx44kWWXnTlXgw9Y0qNq7Bm4oqMyN6Zjxw==
X-Received: by 2002:a63:5815:: with SMTP id m21mr19458044pgb.363.1627372716172;
        Tue, 27 Jul 2021 00:58:36 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id v9sm2544537pfn.22.2021.07.27.00.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 00:58:35 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v5 mptcp-next 4/5] selftests: mptcp: add fullmesh testcases
Date: Tue, 27 Jul 2021 15:58:21 +0800
Message-Id: <78d86feae19ea4efd7061a9e92b81475ed035323.1627372396.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <69eb44fdf9899ec5eab342fa1f3b62d12ab2598e.1627372396.git.geliangtang@xiaomi.com>
References: <cover.1627372396.git.geliangtang@xiaomi.com> <b8af3a77da2fcd8e16e8b5d6b63c7c8386abcbac.1627372396.git.geliangtang@xiaomi.com> <bde1048019780ecc5f2e553bbb4eb21213f76ba7.1627372396.git.geliangtang@xiaomi.com> <69eb44fdf9899ec5eab342fa1f3b62d12ab2598e.1627372396.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

This patch added the testcases for the fullmesh address flag of the path
manager.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 57 ++++++++++++++++++-
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 937e861e9490..ca19762b9c6e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -367,7 +367,13 @@ do_transfer()
 	fi
 
 	if [ $addr_nr_ns2 -gt 0 ]; then
-		let add_nr_ns2=addr_nr_ns2
+		if [ $addr_nr_ns2 -gt 10 ]; then
+			let add_nr_ns2=addr_nr_ns2-10
+			flags=subflow,fullmesh
+		else
+			let add_nr_ns2=addr_nr_ns2
+			flags=subflow
+		fi
 		counter=3
 		sleep 1
 		while [ $add_nr_ns2 -gt 0 ]; do
@@ -377,7 +383,7 @@ do_transfer()
 			else
 				addr="10.0.$counter.2"
 			fi
-			ip netns exec $ns2 ./pm_nl_ctl add $addr flags subflow
+			ip netns exec $ns2 ./pm_nl_ctl add $addr flags $flags
 			let counter+=1
 			let add_nr_ns2-=1
 		done
@@ -1697,6 +1703,46 @@ deny_join_id0_tests()
 	chk_join_nr "subflow and address allow join id0 2" 1 1 1
 }
 
+fullmesh_tests()
+{
+	# fullmesh 1
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 8 8
+	ip netns exec $ns2 ./pm_nl_ctl limits 8 8
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,fullmesh
+	run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
+	chk_join_nr "fullmesh test 1" 2 2 2
+	chk_add_nr 1 1
+
+	# fullmesh 2
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 8 8
+	ip netns exec $ns2 ./pm_nl_ctl limits 8 8
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow,fullmesh
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,fullmesh
+	run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
+	chk_join_nr "fullmesh test 2" 4 4 4
+	chk_add_nr 1 1
+
+	# fullmesh 3
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 8 8
+	ip netns exec $ns2 ./pm_nl_ctl limits 8 8
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1 0 0 11 slow
+	chk_join_nr "fullmesh test 3" 3 3 3
+	chk_add_nr 1 1
+
+	# fullmesh 4
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 8 8
+	ip netns exec $ns2 ./pm_nl_ctl limits 8 8
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1 0 0 12 slow
+	chk_join_nr "fullmesh test 4" 5 5 5
+	chk_add_nr 1 1
+}
+
 all_tests()
 {
 	subflows_tests
@@ -1712,6 +1758,7 @@ all_tests()
 	syncookies_tests
 	checksum_tests
 	deny_join_id0_tests
+	fullmesh_tests
 }
 
 usage()
@@ -1730,6 +1777,7 @@ usage()
 	echo "  -k syncookies_tests"
 	echo "  -S checksum_tests"
 	echo "  -d deny_join_id0_tests"
+	echo "  -m fullmesh_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -h help"
@@ -1765,7 +1813,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
 
-while getopts 'fsltra64bpkdchCS' opt; do
+while getopts 'fsltra64bpkdmchCS' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -1806,6 +1854,9 @@ while getopts 'fsltra64bpkdchCS' opt; do
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

