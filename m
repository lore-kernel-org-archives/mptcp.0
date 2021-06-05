Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C78770
	for <mptcp@lists.linux.dev>; Sat,  5 Jun 2021 08:52:19 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id h24so18173529ejy.2
        for <mptcp@lists.linux.dev>; Sat, 05 Jun 2021 01:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=37fRM5rQtiBaT4bmAZ2ozA4PooE0w5OCWcQXtr9E5cU=;
        b=16gwbRPtKbqqbpNuYnd+xEJNGMBz2UH0Whdemnclz1/TSDY1VolGqtXbMH9G/2pJSW
         7qUKs7mKTKEbiI00TeTmUh7Nex+l4xfvNxFXO3kppHdSpxV3eFNP4j0XK5umvOsuWhL3
         DnCM/m8g6DDfATkIS3KdOUofUgMS8oPg9Gb/8+ytL3Xf5+Cqg4zNJ9UM/sIaP/nlYe7O
         nwuaMRRh7oDoyfNRM7c2wYrQwut+4b52QNXwum0zjrytgOngy+kGbZ/i5twGUsUrgTlK
         rdcfUaui0rweJm2jvv43QIL4ZhTMEiPkP2vUQgIuzRjoe1WpWli9U+lRFvmSjjSvLFZq
         fimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=37fRM5rQtiBaT4bmAZ2ozA4PooE0w5OCWcQXtr9E5cU=;
        b=RZLCZOwmT6fYmRBJ3BH7PZvEfD4HJAlo62f+A39HB32k8vhsNs+IIa9jOBFTnCRtb/
         gZkZ2kxBuFWL3+7WvOvzkH6JBAl2PO2HhqHSeIuQ+ngWDRojrKxj3FzAteBDNIkJSYio
         hoC6eTcBn0GpfqkytqjhPgua9J5RAWj5Adsl63Iz+t9Alvrg8pN7wObcDTLA9aP5yYH2
         zWm3DChGnwcECdf0Imrth1/i/s9n1dGqPfWnnypjF2JeaZwqAOmSbqPVhxfdr3iyPCIS
         rhbWCZIoJaFHsFdAulnKyu9z3NxRUc19E7jAfAsI34h5+WCrYX/GYrF3uuvR89kmmbhJ
         QsXw==
X-Gm-Message-State: AOAM533waP7uovRdoL/Sf/AFmP5j4YW+80pA1aRLHSmCPZmOXv34f4Db
	m6o7lUVE/qhvhidG0gwZ+mNjhF+li4nwvpDF
X-Google-Smtp-Source: ABdhPJxxZnU6p0DoCYZ0aMNt83vovQCt/JaHvW7R5DCC/DJRGGOYr6rVLaUkxHUlzseJsz03oqza8g==
X-Received: by 2002:a17:906:6c88:: with SMTP id s8mr8321132ejr.129.1622883138292;
        Sat, 05 Jun 2021 01:52:18 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id y10sm3828154ejm.76.2021.06.05.01.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 01:52:17 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next] selftests: mptcp: display proper reason to abort tests
Date: Sat,  5 Jun 2021 10:51:55 +0200
Message-Id: <20210605085155.3548173-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without this modification, we were often displaying this error messages:

  FAIL: Could not even run loopback test

But $ret could have been set to a non 0 value in many different cases:

- net.mptcp.enabled=0 is not working as expected
- setsockopt(..., TCP_ULP, "mptcp", ...) is allowed
- ping between each netns are failing
- tests between ns1 as a receiver and ns>1 are failing
- other tests not involving ns1 as a receiver are failing

So not only for the loopback test.

Now a clearer message, including the time it took to run all tests, is
displayed.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    Do we want this in -net?
    
    Because it seems also valid to add:
    
      Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")

 .../selftests/net/mptcp/mptcp_connect.sh      | 52 +++++++++++++------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 2484fb6a9a8d..559173a8e387 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -680,6 +680,25 @@ run_tests_peekmode()
 	run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1 "-P ${peekmode}"
 }
 
+display_time()
+{
+	time_end=$(date +%s)
+	time_run=$((time_end-time_start))
+
+	echo "Time: ${time_run} seconds"
+}
+
+stop_if_error()
+{
+	local msg="$1"
+
+	if [ ${ret} -ne 0 ]; then
+		echo "FAIL: ${msg}" 1>&2
+		display_time
+		exit ${ret}
+	fi
+}
+
 make_file "$cin" "client"
 make_file "$sin" "server"
 
@@ -687,6 +706,8 @@ check_mptcp_disabled
 
 check_mptcp_ulp_setsockopt
 
+stop_if_error "The kernel configuration is not valid for MPTCP"
+
 echo "INFO: validating network environment with pings"
 for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
 	do_ping "$ns1" $sender 10.0.1.1
@@ -706,6 +727,8 @@ for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
 	do_ping "$ns4" $sender dead:beef:3::1
 done
 
+stop_if_error "Could not even run ping tests"
+
 [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
 echo -n "INFO: Using loss of $tc_loss "
 test "$tc_delay" -gt 0 && echo -n "delay $tc_delay ms "
@@ -733,18 +756,13 @@ echo "on ns3eth4"
 
 tc -net "$ns3" qdisc add dev ns3eth4 root netem delay ${reorder_delay}ms $tc_reorder
 
-for sender in $ns1 $ns2 $ns3 $ns4;do
-	run_tests_lo "$ns1" "$sender" 10.0.1.1 1
-	if [ $ret -ne 0 ] ;then
-		echo "FAIL: Could not even run loopback test" 1>&2
-		exit $ret
-	fi
-	run_tests_lo "$ns1" $sender dead:beef:1::1 1
-	if [ $ret -ne 0 ] ;then
-		echo "FAIL: Could not even run loopback v6 test" 2>&1
-		exit $ret
-	fi
+run_tests_lo "$ns1" "$ns1" 10.0.1.1 1
+stop_if_error "Could not even run loopback test"
+
+run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1
+stop_if_error "Could not even run loopback v6 test"
 
+for sender in $ns1 $ns2 $ns3 $ns4;do
 	# ns1<->ns2 is not subject to reordering/tc delays. Use it to test
 	# mptcp syncookie support.
 	if [ $sender = $ns1 ]; then
@@ -753,6 +771,9 @@ for sender in $ns1 $ns2 $ns3 $ns4;do
 		ip netns exec "$ns2" sysctl -q net.ipv4.tcp_syncookies=1
 	fi
 
+	run_tests "$ns1" $sender 10.0.1.1
+	run_tests "$ns1" $sender dead:beef:1::1
+
 	run_tests "$ns2" $sender 10.0.1.2
 	run_tests "$ns2" $sender dead:beef:1::2
 	run_tests "$ns2" $sender 10.0.2.1
@@ -765,14 +786,13 @@ for sender in $ns1 $ns2 $ns3 $ns4;do
 
 	run_tests "$ns4" $sender 10.0.3.1
 	run_tests "$ns4" $sender dead:beef:3::1
+
+	stop_if_error "Tests with $sender as a sender have failed"
 done
 
 run_tests_peekmode "saveWithPeek"
 run_tests_peekmode "saveAfterPeek"
+stop_if_error "Tests with peek mode have failed"
 
-time_end=$(date +%s)
-time_run=$((time_end-time_start))
-
-echo "Time: ${time_run} seconds"
-
+display_time
 exit $ret
-- 
2.31.1

