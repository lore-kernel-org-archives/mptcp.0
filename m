Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B502919
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 17:43:47 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id x5so5495421wrg.13
        for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 09:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6JQXqTksDQ607hiJa8fdh+bw90iV+R0cmwcysOxQ2jE=;
        b=k6PZLHJAXQy+LcgkpUcXM6PndptGNVJx3ku8jIxD9/hSS0AAycjNE4eHJQ179pNxxP
         PBLp+3PWHwQvNFMcvQaMA8DZGwXxh2UBkYOuR2oz1DgQ3Lh2jrX6/5Cz/eTS5lZnkSEJ
         acmlyaFIzFc4EJJOcJ84K1MaWkow5tiY2jx44jFHd5Woj94rlmwWk4NN4P9Pcz82icBL
         wskuR2tOjBValcMewiTLHIARyyi46ZneRTmloJZSe1nyFZmoP2glTIEZJOdaaXoeEul2
         bz96sQ7T2t0qXgQLu0ZEoFTrOpWGLOoqQXRlbQ3KMTcaLow3aJumdw6OiYwJYCf0YGi9
         r1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6JQXqTksDQ607hiJa8fdh+bw90iV+R0cmwcysOxQ2jE=;
        b=w6MsUxE7GrJz0WG9tgydb+cLDZvOE9qZOLNmQ7flLxOiyMTls1RMjGhjxFHWSLmCaS
         3opVBm3N7LwkQh14fPtDWx41cpNcApXxuuH15TxJZYGXOKGoDf8z7cD1SsfCwrw/mByq
         LSkLA94cmJ2h6fqB0x/h1/m8xYT5Gbv6/HO5G1gBayvZ9qEGave2tUU4UwNocCkdggqc
         n9k+gdBmYt0JbC5aBQknAKGc+vo049r+dyMG+zWVKpxz6WqGiixfkFgRlNG3Z91IRrln
         h55bxdRFRvpAD9liCDjKm9jX2rpkJRvuCDrt8U5IoJhxoFiB4pey9+UPKVntjEOYoQQx
         49mA==
X-Gm-Message-State: AOAM5338mLpd50ERm66I1ao8Ehx1NERU6wC1qoEQgszrx8jq+38gCwGX
	2gu3nzAxJPVVSWFlt0Zr92UyHiqN/ZGDxXwh
X-Google-Smtp-Source: ABdhPJyyOeQUUB/8wn5aUt6coD9xX8BJBatDQ8VpAENbsA9PlsQE/lHUKDWx0EflKTakjEwHeskaoA==
X-Received: by 2002:a05:6000:1ac8:b0:1e8:4a0c:d260 with SMTP id i8-20020a0560001ac800b001e84a0cd260mr3034013wry.294.1645119825976;
        Thu, 17 Feb 2022 09:43:45 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id 7sm23060203wrb.43.2022.02.17.09.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 09:43:45 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2 1/9] Squash to "selftests: mptcp: join: allow running -cCi"
Date: Thu, 17 Feb 2022 18:43:21 +0100
Message-Id: <20220217174329.826430-2-matthieu.baerts@tessares.net>
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

The recommended way with getopt is first parse all options and then act.

This allows to do some actions in priority, e.g. display the help menu
and stop.

But also some global variables changing the behaviour of this selftests
-- like the ones behind -cCi options -- can be set before running the
different tests. By doing that, we can also avoid long and unreadable
regex.

This can be squashed in "selftests: mptcp: join: allow running -cCi" and
the commit message can be appended with what is above.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    to be squashed in "selftests: mptcp: join: allow running -cCi"

 .../testing/selftests/net/mptcp/mptcp_join.sh | 67 ++++++++-----------
 1 file changed, 28 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b48b11714817..13f78d4434d2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -17,7 +17,6 @@ capture=0
 checksum=0
 ip_mptcp=0
 check_invert=0
-do_all_tests=1
 init=0
 
 TEST_COUNT=0
@@ -2256,84 +2255,66 @@ usage()
 	exit ${ret}
 }
 
-for arg in "$@"; do
-	# check for "capture/checksum" args before launching tests
-	if [[ "${arg}" =~ ^"-"[0-9a-zA-Z]*"c"[0-9a-zA-Z]*$ ]]; then
-		capture=1
-	fi
-	if [[ "${arg}" =~ ^"-"[0-9a-zA-Z]*"C"[0-9a-zA-Z]*$ ]]; then
-		checksum=1
-	fi
-	if [[ "${arg}" =~ ^"-"[0-9a-zA-Z]*"i"[0-9a-zA-Z]*$ ]]; then
-		ip_mptcp=1
-	fi
-
-	# exception for the capture/checksum/ip_mptcp options, the rest means: a part of the tests
-	if ! [[ "${arg}" =~ ^"-"[cCi]+$ ]]; then
-		do_all_tests=0
-	fi
-done
-
-if [ $do_all_tests -eq 1 ]; then
-	all_tests
-	exit $ret
-fi
 
+tests=()
 while getopts 'fesltra64bpkdmuchCSi' opt; do
 	case $opt in
 		f)
-			subflows_tests
+			tests+=(subflows_tests)
 			;;
 		e)
-			subflows_error_tests
+			tests+=(subflows_error_tests)
 			;;
 		s)
-			signal_address_tests
+			tests+=(signal_address_tests)
 			;;
 		l)
-			link_failure_tests
+			tests+=(link_failure_tests)
 			;;
 		t)
-			add_addr_timeout_tests
+			tests+=(add_addr_timeout_tests)
 			;;
 		r)
-			remove_tests
+			tests+=(remove_tests)
 			;;
 		a)
-			add_tests
+			tests+=(add_tests)
 			;;
 		6)
-			ipv6_tests
+			tests+=(ipv6_tests)
 			;;
 		4)
-			v4mapped_tests
+			tests+=(v4mapped_tests)
 			;;
 		b)
-			backup_tests
+			tests+=(backup_tests)
 			;;
 		p)
-			add_addr_ports_tests
+			tests+=(add_addr_ports_tests)
 			;;
 		k)
-			syncookies_tests
+			tests+=(syncookies_tests)
 			;;
 		S)
-			checksum_tests
+			tests+=(checksum_tests)
 			;;
 		d)
-			deny_join_id0_tests
+			tests+=(deny_join_id0_tests)
 			;;
 		m)
-			fullmesh_tests
+			tests+=(fullmesh_tests)
 			;;
 		u)
-			userspace_tests
+			tests+=(userspace_tests)
 			;;
 		c)
+			capture=1
 			;;
 		C)
+			checksum=1
 			;;
 		i)
+			ip_mptcp=1
 			;;
 		h)
 			usage
@@ -2344,4 +2325,12 @@ while getopts 'fesltra64bpkdmuchCSi' opt; do
 	esac
 done
 
+if [ ${#tests[@]} -eq 0 ]; then
+	all_tests
+else
+	for subtests in "${tests[@]}"; do
+		"${subtests}"
+	done
+fi
+
 exit $ret
-- 
2.34.1

