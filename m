Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0CA6955
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 21:35:02 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id w3so4719386edu.8
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 13:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/oQaPOfnTnuFuHqIo8lac/qxpBondR7NAkvdA5GtZI4=;
        b=xmg3u/rmfNHSJ15YFr7ND/F/dB4RPukBOi2Av1gPZba15zdO+MPv+FcjCsIyhqLabE
         n38QwgT9gUPEcGxkMFpoKJ3BTtThHnMb9J2AkA3qmnDVoE5Uy2oOwhdOCJ+L8WtGRB74
         3QqkQ+d5RRy4wWszQVlsbas4iZsc4Tl2r8PFRPJmoslP0s/PKqaMfvKl9BDasTIxj68D
         s7RE9lElMw1p7olGJRpWwsukAl4JdZLMcyhQc6xpDW9OgugJYmjuAnvHAhSj7W0xH1pA
         TnjUGGqP0wkDzMRJSxL9jWEGCYQ0coRu0aS0U0uVPtMM9qFgjRcj+Tk66Vq5SrHoES9t
         GwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/oQaPOfnTnuFuHqIo8lac/qxpBondR7NAkvdA5GtZI4=;
        b=Q76IZ7smk9+hDGT71bkAxq50rudKMe+ikwf+1OtV83I3XRAdzft/YsYkQf64UxY0a3
         RxSlFzHoT1Poqdv47Hu1WqKJLJ1Cuxbblx1MdqgwxnQDxPC/amg5s+zO/AwtIX/i6JsT
         hiq9M7DWZ6mZnjTeTq8CvsZ2TOkhKR2tQwMaKI6R9Gm3w9BGit3J7bUypJqbhAu1crZw
         ciLNBBhZBKEGuxvRUPCouqDKG5dPM+miE+5yUWiAwILdbCSMdPeGiojKBsVC9j/BfFK5
         Dg+JCe2Au7cgTyxDCBCsCLqjLVFNmA8Mha+eDXQC3UZVc1APenvjCg3iYgoynwJjD2nl
         zQ4g==
X-Gm-Message-State: AOAM531Sw/t7PPqzGMNWd9JWG9DfKO6Yw7GxAOiB0rmnTPh1lexLapfy
	qCg+iAwKn1SjSsCaqmoXhi+JCDmyIhB32GSUQqA=
X-Google-Smtp-Source: ABdhPJxBmxMbz/CC98HBb3TQPUXdKm1vHPa2DqpuDGugeCdKX0IEOPwMigpVfw69O8fICPv1XCZbnA==
X-Received: by 2002:a05:6402:f04:b0:410:f0a5:5b02 with SMTP id i4-20020a0564020f0400b00410f0a55b02mr4293305eda.209.1645738500258;
        Thu, 24 Feb 2022 13:35:00 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id z22-20020a17090655d600b006d229436793sm175195ejp.223.2022.02.24.13.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 13:34:59 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v4 04/12] selftests: mptcp: join: define tests groups once
Date: Thu, 24 Feb 2022 22:33:58 +0100
Message-Id: <20220224213406.3127061-5-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224213406.3127061-1-matthieu.baerts@tessares.net>
References: <20220224213406.3127061-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When adding a new tests group, it has to be defined in multiple places:

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
index d3985b9cf380..aa68aeac328a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -19,6 +19,7 @@ check_invert=0
 validate_checksum=0
 init=0
 
+declare -A all_tests
 TEST_COUNT=0
 nr_blank=40
 
@@ -2575,29 +2576,6 @@ implicit_tests()
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
@@ -2607,25 +2585,12 @@ usage()
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
@@ -2635,65 +2600,45 @@ usage()
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
@@ -2714,11 +2659,11 @@ while getopts 'fesltra64bpkdmchzuFICSi' opt; do
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

