Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB121B63
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 13:56:48 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id w3so2940812edu.8
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 05:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cFHBvb0vnFY6A8dNFnbvb6YKKqLhSBV8luPX/Q0H2Q4=;
        b=5Le2O2Ay5LngzgMRsKmMBzlujdsgtz5tfhMzW9Zbz7nZKyJETrIR19dlvGhglJYziL
         NE6O3gI7zA6H6eGRMptioaoNKY+qqPdtnU8JXBei4k4Aiy14SRd41cioLad+j2cFo/vK
         9gB0MA4EwpYJ8dB6BAbjMZUI/FyaBE2YNkeQHlE6b+SdOe4zeTfJ0qazxRe/lPuLxN/N
         CwUMu45EneJNnzsQgWC+Vsjw1GEp5YUNoHmIuxvLCi7b8ernDKVUwmZmKtzqqsYrr6ww
         REc5Gnh8I8hsGb03zwY3JVVs//YZYSyeoA/IXJFlB6cnxEPPRJYSiY+NOoKkre1Cy1AQ
         L6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cFHBvb0vnFY6A8dNFnbvb6YKKqLhSBV8luPX/Q0H2Q4=;
        b=c6+pYwY6shZdSC5pXvExmAIviANfvAVUmqkwsYvaaPcKjMHHYKTO3XzfcBWehcl401
         FaaaA4SPxRP5dbbkb/GxcC24KL/MxD6FE3UDVMbyGkGRFa1ro4VGDN33fxgzx3cXOg1t
         EOXny06eEkt34jLVHIF9qxZEezE/viO7V4F4OnKPexmUOstI4g9BxX3uxYXAuhkresDM
         9PAEhfFzXWEDDqhKkXHCWCBRsUJeU50aCYIlb6M9P/PlG3WJAAyc995OasgXU0sNUIk3
         4lOn+DK32xDkrkm7u94dLuB7eyV3YO/3yEaANRftRj0xOBgSbZ3lOvFjS0xNCaaAnnYc
         2LLA==
X-Gm-Message-State: AOAM533D16DF1vogbwIqETmb31DSgRiRSzylHMWus7jt7v9FUEo1Wm1L
	Nc4flLvunxFka0TAS07YjNfzovUkqfzwgbfTJEs=
X-Google-Smtp-Source: ABdhPJyXeEST7k5G/BGUnD34u+4Yop1KxhEu3AbnNHQ8eVjh1ruhTOdDHXQeXb/GR5WhUnXnjceMtg==
X-Received: by 2002:aa7:d2da:0:b0:410:b9f1:ff35 with SMTP id k26-20020aa7d2da000000b00410b9f1ff35mr2439956edr.217.1645711006245;
        Thu, 24 Feb 2022 05:56:46 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id 7sm1360733edw.37.2022.02.24.05.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 05:56:45 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v3 02/12] Squash to "selftests: mptcp: join: allow running -cCi"
Date: Thu, 24 Feb 2022 14:56:09 +0100
Message-Id: <20220224135619.2523272-3-matthieu.baerts@tessares.net>
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

The recommended way with getopt is first parse all options and then act.

This allows to do some actions in priority, e.g. display the help menu
and stop.

But also some global variables changing the behaviour of this selftests
-- like the ones behind -cCi options -- can be set before running the
different tests. By doing that, we can also avoid long and unreadable
regex.

This can be squashed in "selftests: mptcp: join: allow running -cCi" and
the commit message can be appended with what is above.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    to be squashed in "selftests: mptcp: join: allow running -cCi"

 .../testing/selftests/net/mptcp/mptcp_join.sh | 73 ++++++++-----------
 1 file changed, 31 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e2d56a5bcaf4..02ae2692f7fc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -17,7 +17,6 @@ checksum=0
 ip_mptcp=0
 check_invert=0
 validate_checksum=0
-do_all_tests=1
 init=0
 
 TEST_COUNT=0
@@ -2630,93 +2629,75 @@ usage()
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
 while getopts 'fesltra64bpkdmchzuFICSi' opt; do
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
 		z)
-			fastclose_tests
+			tests+=(fastclose_tests)
 			;;
 		F)
-			fail_tests
+			tests+=(fail_tests)
 			;;
 		u)
-			userspace_tests
+			tests+=(userspace_tests)
 			;;
 		I)
-			implicit_tests
+			tests+=(implicit_tests)
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
@@ -2727,4 +2708,12 @@ while getopts 'fesltra64bpkdmchzuFICSi' opt; do
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

