Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B68F1B65
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 13:56:49 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id m3so2927333eda.10
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 05:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IM3ezoKqlGUT30t3MQnIKM93Q8CPZvsnhdW5dqzlcpQ=;
        b=ng9DymuCjDd1mDIa41a0Ti7zGlvqdzg9ZuuCqhW+Qcre4xeQXzP36RiHEHLPlX1gln
         yjzvt1ef5aN9qghls8Vgu27Wh2orpvyJLxToHBBKqgR5b7VeCpnr1Rq+67xvWXt1MW8D
         LcVv3oETHuLrFSrRE/q8vFPoUYn8jxeIYIQXSpV0qX5Fwjq3tiG+WueWZn7LGclpy+x/
         mwOuxXdRBtxVUW/aqSYbr2gB9YOxfF2VPaaln4lO1zRz86jJZrJVNYWDm4trZDUd10fe
         LfeXpH+2GN25ADTvMegOKXw75wtVsV/Q0NPVd7GnLUo8Mp2AtOmy9mMBhiLfcJXiFkeN
         pTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IM3ezoKqlGUT30t3MQnIKM93Q8CPZvsnhdW5dqzlcpQ=;
        b=j7k9nnkJYHaNTzD/qdPWbZyFGBPGEFS5O6U67oZd2fF6WhamiLdlLHNdDdo7wfBrAF
         liT/4Sa9pNutvCs68eD0e5+PS1Kmb7ZIGmH7QOSdl+i0MlkBasa3FSLg3q+2wWTSd+gd
         UG1NJzu8wbJw2zQc0dz3fkMRxE/S1WOXg5Lyu9wshyE3iDKz3zS9gop9+sWg/yxsf3SX
         ftynpADb//cVoVTwyko9pUW7m3oAp7xzpk4Z3j1K/XQPHLTwONRp9/Pq61DtyQA+jGJb
         lWnDXPOGUBBdaYsS7rvsyKdcugny89QvCEfxu23qhaYwxNt1A4z3SzJM1mBQQR5PRotp
         9QoQ==
X-Gm-Message-State: AOAM531SRK1HcvegKBXLk77fd1/cX4uw7SxhX+MhMOe6ea3adHJdUo1S
	RkSnakcPcyouBWpSdWdIBb8eKhA8rn8FhZSCEKs=
X-Google-Smtp-Source: ABdhPJz/bJFFRQZ07kzxM87b8IQ7aEsEzpvOhgsElSw2zd/oBC3Jbk1O/5s9Sayk2k9m0+EDI6b1wQ==
X-Received: by 2002:a05:6402:35c9:b0:413:1602:2c46 with SMTP id z9-20020a05640235c900b0041316022c46mr2477689edc.222.1645711007464;
        Thu, 24 Feb 2022 05:56:47 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id 7sm1360733edw.37.2022.02.24.05.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 05:56:47 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v3 04/12] selftests: mptcp: join: define tests groups once
Date: Thu, 24 Feb 2022 14:56:11 +0100
Message-Id: <20220224135619.2523272-5-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224135619.2523272-1-matthieu.baerts@tessares.net>
References: <20220224135619.2523272-1-matthieu.baerts@tessares.net>
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

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 153 ++++++------------
 1 file changed, 49 insertions(+), 104 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 231bd8322415..9d14851f9732 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -19,6 +19,7 @@ check_invert=0
 validate_checksum=0
 init=0
 
+declare -A all_tests
 TEST_COUNT=0
 nr_blank=40
 
@@ -2570,29 +2571,6 @@ implicit_tests()
 	wait
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
-	fastclose_tests
-	fail_tests
-	userspace_tests
-	implicit_tests
-}
-
 # [$1: error message]
 usage()
 {
@@ -2602,25 +2580,12 @@ usage()
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
-	echo "  -z fastclose_tests"
-	echo "  -F fail_tests"
-	echo "  -u userspace_tests"
-	echo "  -I implicit_tests"
+
+	local key
+	for key in "${!all_tests[@]}"; do
+		echo "  -${key} ${all_tests[${key}]}"
+	done
+
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -i use ip mptcp"
@@ -2630,65 +2595,45 @@ usage()
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
+	z@fastclose_tests
+	F@fail_tests
+	u@userspace_tests
+	I@implicit_tests
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
-while getopts 'fesltra64bpkdmchzuFICSi' opt; do
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
-		z)
-			tests+=(fastclose_tests)
-			;;
-		F)
-			tests+=(fail_tests)
-			;;
-		u)
-			tests+=(userspace_tests)
-			;;
-		I)
-			tests+=(implicit_tests)
+		["${all_tests_args}"])
+			tests+=("${all_tests[${opt}]}")
 			;;
 		c)
 			capture=1
@@ -2709,11 +2654,11 @@ while getopts 'fesltra64bpkdmchzuFICSi' opt; do
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

