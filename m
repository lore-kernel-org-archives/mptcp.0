Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3C96957
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 21:35:01 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id s1so4682318edd.13
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 13:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6qKdFGTaabyGfSQRaKcrY8DB6zt2H6moqludwTQ8Tzg=;
        b=CDw03D2lCXWAYLuP1WlIxdNLvR5AAqhPpiIXnWtn+I9mKhzRWkBj7FXpXIHSWzxJZ+
         p8ke6TOGbekoa3xHRmtUL2ayTCSYpz5m2XXMNn/hLOhVy+dRZ7IONq3dvep181m9SbY1
         TS6Jrn9IRz9k2Bj8NrqgI0OHaQbCDyyR2eHTVSvCJzLf8rbyEqdN8tVIxH4gg376smFd
         +oRYutTGMVNs2x0uyx3vfKK+Ce6guYMnHyI3dd3OdNk8GQnBOB0zQYWJYfCgJS3D7hon
         Xs33Ku75NXi35LweRlSje5RiKM5+ewrpFpR9QHLFYSDEtnJJUH7i3vAHw3SUsDfuFghz
         HQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6qKdFGTaabyGfSQRaKcrY8DB6zt2H6moqludwTQ8Tzg=;
        b=vuM4CIkzB94p5efXwmRzEiP+RgrIqwvtqH71cyQtw8AgoiOC6y41Tm0pBGrLu6qmEw
         Jol2PpSNrDvH7RbRXiBEpexppyBnsMyk5GJ1FIY8jxRoueW4B8M6qXA8DVycSalRC9jY
         FFOtHtGI9fJS1VcgK8CERHRoXKkRxuwTpXp1YBGFHvK69/+C4+9REV3hJ9askr/eqyP9
         57/RfQ0v3Qd7JjKx+xiRr2KWfOQTslFv+B4y2ZfinDWbXsqA+PREyH0ZPTfCo97Mp2yd
         a09Zy7+4VUwHYWVLuGP3LLGV4rOjdUAu4MPg/Uokhtz4euzivBvW3PL2iS+yZZ/q5wGP
         ZaDw==
X-Gm-Message-State: AOAM5311NN/xlkduBwMilSxCQ5RdpIMU8/oLEJ9mnydEwCMDL/F6LHWp
	tqy7ZPDbrV9rtc3BXdKR9luUx/FcwAcsiQKNXjM=
X-Google-Smtp-Source: ABdhPJyV7+bZQIh3QZ0zWYxDuY7U+1uTKSbj6OAp5pb7IAkVEwlUcu0w8W8G6kPd9qiQ+BiU/BU8UQ==
X-Received: by 2002:a05:6402:1e8f:b0:3fa:72cb:1733 with SMTP id f15-20020a0564021e8f00b003fa72cb1733mr4163045edf.24.1645738499654;
        Thu, 24 Feb 2022 13:34:59 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id z22-20020a17090655d600b006d229436793sm175195ejp.223.2022.02.24.13.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 13:34:58 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v4 03/12] Squash to "selftests: mptcp: add implicit endpoint test case"
Date: Thu, 24 Feb 2022 22:33:57 +0100
Message-Id: <20220224213406.3127061-4-matthieu.baerts@tessares.net>
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

- Move 'wait_mpj' with the other 'wait' helpers: like that, we have all
  the helpers first and then all groups of tests. It is easier to find
  patterns in the tests parts, e.g. finding if there are direct calls to
  'ip netns exec', etc.

- Do not increment the counter for each subtest: later in this series
  the counter is incremented in the reset function and thanks to that it
  is possible to skip a test before doing the real reset part. It is
  then required to have a single test per test env. All the three test
  are quick when the env is ready.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    to be squashed in "selftests: mptcp: add implicit endpoint test case"

 .../testing/selftests/net/mptcp/mptcp_join.sh | 53 ++++++++++---------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 02ae2692f7fc..d3985b9cf380 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -365,6 +365,21 @@ wait_rm_addr()
 	done
 }
 
+wait_mpj()
+{
+	local ns="${1}"
+	local cnt old_cnt
+
+	old_cnt=$(ip netns exec ${ns} nstat -as | grep MPJoinAckRx | awk '{print $2}')
+
+	local i
+	for i in $(seq 10); do
+		cnt=$(ip netns exec ${ns} nstat -as | grep MPJoinAckRx | awk '{print $2}')
+		[ "$cnt" = "${old_cnt}" ] || break
+		sleep 0.1
+	done
+}
+
 pm_nl_set_limits()
 {
 	local ns=$1
@@ -468,9 +483,10 @@ pm_nl_change_endpoint()
 pm_nl_check_endpoint()
 {
 	local line expected_line
-	local msg="$1"
-	local addr=$3
-	local ns=$2
+	local title="$1"
+	local msg="$2"
+	local ns=$3
+	local addr=$4
 	local _flags=""
 	local flags
 	local _port
@@ -479,10 +495,13 @@ pm_nl_check_endpoint()
 	local _id
 	local id
 
-	TEST_COUNT=$((TEST_COUNT + 1))
-	printf "%03u %-${nr_blank}s" "$TEST_COUNT" "$msg"
+	if [ -n "${title}" ]; then
+		printf "%03u %-36s %s" "${TEST_COUNT}" "${title}" "${msg}"
+	else
+		printf "%-${nr_blank}s %s" " " "${msg}"
+	fi
 
-	shift 3
+	shift 4
 	while [ -n "$1" ]; do
 		if [ $1 = "flags" ]; then
 			_flags=$2
@@ -2532,21 +2551,6 @@ userspace_tests()
 	chk_rm_nr 0 0
 }
 
-wait_mpj()
-{
-	local ns="${1}"
-	local cnt old_cnt
-
-	old_cnt=$(ip netns exec ${ns} nstat -as | grep MPJoinAckRx | awk '{print $2}')
-
-	local i
-	for i in $(seq 10); do
-		cnt=$(ip netns exec ${ns} nstat -as | grep MPJoinAckRx | awk '{print $2}')
-		[ "$cnt" = "${old_cnt}" ] || break
-		sleep 0.1
-	done
-}
-
 implicit_tests()
 {
 	# userspace pm type prevents add_addr
@@ -2557,15 +2561,16 @@ implicit_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
 
 	wait_mpj $ns1
-	pm_nl_check_endpoint "implicit EP creation" \
+	TEST_COUNT=$((TEST_COUNT + 1))
+	pm_nl_check_endpoint "implicit EP" "creation" \
 		$ns2 10.0.2.2 id 1 flags implicit
 
 	pm_nl_add_endpoint $ns2 10.0.2.2 id 33
-	pm_nl_check_endpoint "implicit EP ID change is prevented" \
+	pm_nl_check_endpoint "" "ID change is prevented" \
 		$ns2 10.0.2.2 id 1 flags implicit
 
 	pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
-	pm_nl_check_endpoint "implicit EP modification is allowed" \
+	pm_nl_check_endpoint "" "modif is allowed" \
 		$ns2 10.0.2.2 id 1 flags signal
 	wait
 }
-- 
2.34.1

