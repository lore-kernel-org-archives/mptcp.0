Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF38D3B28
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 17:43:48 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id e3so10409565wra.0
        for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 09:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mcPQk60y1wnComOsrwBV7cevVzWVwvGsoZkxSvr9jnA=;
        b=hVGLukYR3HREwz7FRC16mX4t5UgqGg/7xbuG4VVZ78qKtbx2oQUckJxbfKr5zh51zR
         bOyAMvMLyH01UtH4SfRloHJxwhJLbAQvaiYM0f8AK9k1Iw640Kj+z0stHzG1L7shYPhE
         RnrlnkKB6+C7azMTVg0hvk9P0cBdIUYTb+6OAlQSx1B7LlXybRuRcJeYUNzYkm8lpf1w
         Ut/tkWVCpdCFCsO4rsaYdHjjs/0N2CDYRTRa4NSxTs3RXid5SIt6DSuEe5vQ1RUk72Lg
         TzvxgP9Dav+w/n04/rDEWi6VBmwCbAqhDNdx1gZWRwC9DVJ+t5b7hkw1xevwYt2HDbBv
         g9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mcPQk60y1wnComOsrwBV7cevVzWVwvGsoZkxSvr9jnA=;
        b=kvQ6tAWF/SSQ84SVnPwDNOuNgzSsAjSf8BiXQxVhFNmg8IPyZx8vJpJboaBZdtbrVb
         /4pLki9C1PzlLFv2tb2Q/51Eug7btXrnMJPBefTlFPXS72eLi+E8ONxer2Xt3tMZWYXZ
         X/zk8vx4TMqTIQR/j8eRpUUrT8x8qvlQzGZzih8/oUC9FtSl0sULEFt7uiClDbro+62u
         61TcehNl0TU9Z+hcLCola3q7SmhRObNkq+Sa0TZoXnyrOHLOC1WGztiKMQNVWEqDcWJD
         r5DFN04gkl+sch7wcW7vZRDIafz1hAPUVIEdkVcZON9SwWBs5h31ZyK6Sle9owonwEup
         IScg==
X-Gm-Message-State: AOAM532G2PiUtwI1WczWF6IMNggK087/ndVvgDGYf4uElMpFlouAmlGa
	plG5gaCtf4bsUyOh0qBLHpRyQFmnYuur3sIR
X-Google-Smtp-Source: ABdhPJx5eAYGy8xFa6OA0kYlujfuqZj3oBlsliLsvc+wQH3C7IyltSIE+6BBoM7OLUIqxHTNHUnSQg==
X-Received: by 2002:adf:e185:0:b0:1e2:6421:f2d0 with SMTP id az5-20020adfe185000000b001e26421f2d0mr3193408wrb.703.1645119826982;
        Thu, 17 Feb 2022 09:43:46 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id 7sm23060203wrb.43.2022.02.17.09.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 09:43:46 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2 2/9] selftests: mptcp: join: define tests groups once
Date: Thu, 17 Feb 2022 18:43:22 +0100
Message-Id: <20220217174329.826430-3-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217174329.826430-1-matthieu.baerts@tessares.net>
References: <20220217174329.826430-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When defining a new tests group, it has to be define in multiple places:

- in the all_tests() function
- in the 'usage()' function
- in the getopts: short option + what to do when the option is used

Because it is easy to forget one of them, it is useful to have to define
them only once.

Note: only using an associative array would simplify the code but the
entries are stored in a hashtable and iterating over the different items
doesn't give the same order as the one used in the declaration of this
array. Because we want to run these tests in the same order as before, a
"simple" array is used first.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 135 ++++++------------
 1 file changed, 46 insertions(+), 89 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 13f78d4434d2..747dd6d887ea 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -19,6 +19,7 @@ ip_mptcp=0
 check_invert=0
 init=0
 
+declare -A all_tests
 TEST_COUNT=0
 nr_blank=40
 
@@ -2202,26 +2203,6 @@ userspace_tests()
 	chk_rm_nr 0 0
 }
 
-all_tests()
-{
-	subflows_tests
-	subflows_error_tests
-	signal_address_tests
-	link_failure_tests
-	add_addr_timeout_tests
-	remove_tests
-	add_tests
-	ipv6_tests
-	v4mapped_tests
-	backup_tests
-	add_addr_ports_tests
-	syncookies_tests
-	checksum_tests
-	deny_join_id0_tests
-	fullmesh_tests
-	userspace_tests
-}
-
 # [$1: error message]
 usage()
 {
@@ -2231,22 +2212,12 @@ usage()
 	fi
 
 	echo "mptcp_join usage:"
-	echo "  -f subflows_tests"
-	echo "  -e subflows_error_tests"
-	echo "  -s signal_address_tests"
-	echo "  -l link_failure_tests"
-	echo "  -t add_addr_timeout_tests"
-	echo "  -r remove_tests"
-	echo "  -a add_tests"
-	echo "  -6 ipv6_tests"
-	echo "  -4 v4mapped_tests"
-	echo "  -b backup_tests"
-	echo "  -p add_addr_ports_tests"
-	echo "  -k syncookies_tests"
-	echo "  -S checksum_tests"
-	echo "  -d deny_join_id0_tests"
-	echo "  -m fullmesh_tests"
-	echo "  -u userspace_tests"
+
+	local key
+	for key in "${!all_tests[@]}"; do
+		echo "  -${key} ${all_tests[${key}]}"
+	done
+
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -i use ip mptcp"
@@ -2256,56 +2227,42 @@ usage()
 }
 
 
+# Use a "simple" array to force an specific order we cannot have with an associative one
+all_tests_sorted=(
+	f@subflows_tests
+	e@subflows_error_tests
+	s@signal_address_tests
+	l@link_failure_tests
+	t@add_addr_timeout_tests
+	r@remove_tests
+	a@add_tests
+	6@ipv6_tests
+	4@v4mapped_tests
+	b@backup_tests
+	p@add_addr_ports_tests
+	k@syncookies_tests
+	S@checksum_tests
+	d@deny_join_id0_tests
+	m@fullmesh_tests
+	u@userspace_tests
+)
+
+all_tests_args=""
+all_tests_names=()
+for subtests in "${all_tests_sorted[@]}"; do
+	key="${subtests%@*}"
+	value="${subtests#*@}"
+
+	all_tests_args+="${key}"
+	all_tests_names+=("${value}")
+	all_tests[${key}]="${value}"
+done
+
 tests=()
-while getopts 'fesltra64bpkdmuchCSi' opt; do
+while getopts "${all_tests_args}cCih" opt; do
 	case $opt in
-		f)
-			tests+=(subflows_tests)
-			;;
-		e)
-			tests+=(subflows_error_tests)
-			;;
-		s)
-			tests+=(signal_address_tests)
-			;;
-		l)
-			tests+=(link_failure_tests)
-			;;
-		t)
-			tests+=(add_addr_timeout_tests)
-			;;
-		r)
-			tests+=(remove_tests)
-			;;
-		a)
-			tests+=(add_tests)
-			;;
-		6)
-			tests+=(ipv6_tests)
-			;;
-		4)
-			tests+=(v4mapped_tests)
-			;;
-		b)
-			tests+=(backup_tests)
-			;;
-		p)
-			tests+=(add_addr_ports_tests)
-			;;
-		k)
-			tests+=(syncookies_tests)
-			;;
-		S)
-			tests+=(checksum_tests)
-			;;
-		d)
-			tests+=(deny_join_id0_tests)
-			;;
-		m)
-			tests+=(fullmesh_tests)
-			;;
-		u)
-			tests+=(userspace_tests)
+		["${all_tests_args}"])
+			tests+=("${all_tests[${opt}]}")
 			;;
 		c)
 			capture=1
@@ -2326,11 +2283,11 @@ while getopts 'fesltra64bpkdmuchCSi' opt; do
 done
 
 if [ ${#tests[@]} -eq 0 ]; then
-	all_tests
-else
-	for subtests in "${tests[@]}"; do
-		"${subtests}"
-	done
+	tests=("${all_tests_names[@]}")
 fi
 
+for subtests in "${tests[@]}"; do
+	"${subtests}"
+done
+
 exit $ret
-- 
2.34.1

