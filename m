Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05E4173
	for <mptcp@lists.linux.dev>; Wed, 21 Jul 2021 08:56:54 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id d1so650207plg.0
        for <mptcp@lists.linux.dev>; Wed, 21 Jul 2021 01:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3rmI1hT+4WaFtENytVD4/IDDFUNvwqot5ki2bizVJUc=;
        b=Rg0R7IE/gdbgopatrli3MD5q8DiqNlRxKaIKKDhkVXGP4LWZq2QNcBZUfK03n7MGv6
         3EbEuf54B2Y2jwIij03QCSvBxHT++2py4ejzYopBYsogosuiSQaQVflDmIvkpmZtNUCM
         VWVK+HxUmwAr/0fL8yTN/H4hC3Z7flJTyxWB3LU2trKi4bgUTfCTHKOpV5tWWCYeNoYD
         934Wk/O0nt3moyo8sPBVCvN6KAR9H1z1R3DYGgxhy9jwux/WE9qQfanARGnRlNe2XFbg
         WZJBuzGsmno0LxU1xyW4ZowhmvlW8LzGjCDZToKi6zPTjr9mX9cKBmXMFu7fHFVJRozD
         XA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3rmI1hT+4WaFtENytVD4/IDDFUNvwqot5ki2bizVJUc=;
        b=m2hu201luvRiIjD1MQ5oDU0YghSc5p3CTMZj/zXQ4gDwuTvZkciUa8fQfC2Fkv8EOL
         ul+NK+zzTej8nbx9STNwfAyuPm0D9pScHy+BdWq9HUWQiqZ8b2kE55WRCUevTjcJImqj
         zGeDExz4mzAuqiZPQOH/EotQkR4TjvEEe5eZp5H9HK8fUfcGHjyjXzLv5cU8WUbuvZX6
         7EHbACX31pOaIXgih6lCfL38p66At9IoEFck747iWH4k4ZIWQqN9IsEhZvsRIzWUDEhd
         ka+Gggsfz+2wjo2PTV1xWcygl/G4jADLioqv1kGlLdemzucItJQiOI6rO/lMlb1TlldG
         Di7g==
X-Gm-Message-State: AOAM531mKt6uPqxnTFmFZ6CCMF0q2LlTdMKUjjDQT2XmCzZvWgNbqQOZ
	63C3v/oSEkxXa5X6IP6nIBnFicJ3xM+Izw==
X-Google-Smtp-Source: ABdhPJzms2RAh7E8qqdffWQOOeLBfnUpZtUBC3ZfChJBNguQ0/DhUCM82SWN7vfB0JLIYyMvM7uksw==
X-Received: by 2002:a17:90b:224f:: with SMTP id hk15mr2801271pjb.180.1626857814067;
        Wed, 21 Jul 2021 01:56:54 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id u15sm28996250pgf.77.2021.07.21.01.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 01:56:53 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next] Squash to "selftests: mptcp: add testcase for active-back"
Date: Wed, 21 Jul 2021 16:56:49 +0800
Message-Id: <67cd742a1da03b8633e4837c45991860236af431.1626857584.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the debug logs and make the output aligned:

link ns1eth3 down
01 multiple flows, signal, link failure syn[ ok ] - synack[ ok ] - ack[ ok ]
                                        add[ ok ] - echo  [ ok ]
                                        stale[ ok ]
Created /tmp/tmp.dltHx8oBcT (size 2048 KB) containing data sent by server
link ns1eth3 down
02 multiple flows, signal, bidirectional, link failure syn[ ok ] - synack[ ok ] - ack[ ok ]
                                        add[ ok ] - echo  [ ok ]
                                        stale[ ok ]
link ns1eth1 down
03 backup subflow unused with link failure syn[ ok ] - synack[ ok ] - ack[ ok ]
                                        add[ ok ] - echo  [ ok ]
                                        link usage [ ok ]
link ns1eth1 down
link ns1eth2 down
04 backup subflow used due to multiple links failure syn[ ok ] - synack[ ok ] - ack[ ok ]
                                        add[ ok ] - echo  [ ok ]
                                        stale[ ok ]
                                        link usage [ ok ]
link ns1eth1 down
link ns1eth2 down
05 backup subflow in use, bidirectional, link failure syn[ ok ] - synack[ ok ] - ack[ ok ]
                                        add[ ok ] - echo  [ ok ]
                                        stale[ ok ]
                                        link usage [ ok ]

->

01 multiple flows, signal, link failure syn[ ok ] - synack[ ok ] - ack[ ok ]
                                        add[ ok ] - echo  [ ok ]
                                        stale             [ ok ]
Created /tmp/tmp.JYR5OkgZ9C (size 6144 KB) containing data sent by server
02 multi flows, signal, bidi, link fail syn[ ok ] - synack[ ok ] - ack[ ok ]
                                        add[ ok ] - echo  [ ok ]
                                        stale             [ ok ]
03 backup subflow unused, link failure  syn[ ok ] - synack[ ok ] - ack[ ok ]
                                        add[ ok ] - echo  [ ok ]
                                        link usage        [ ok ]
04 backup flow used, multi links fail   syn[ ok ] - synack[ ok ] - ack[ ok ]
                                        add[ ok ] - echo  [ ok ]
                                        stale             [ ok ]
                                        link usage        [ ok ]
05 backup flow used, bidi, link failure syn[ ok ] - synack[ ok ] - ack[ ok ]
                                        add[ ok ] - echo  [ ok ]
                                        stale             [ ok ]
                                        link usage        [ ok ]

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 220154cb92a7..d0518487b874 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -228,7 +228,6 @@ link_failure()
 
 	for l in $FAILING_LINKS; do
 		veth="ns1eth$l"
-		echo "link $veth down" 1>&2
 		ip -net "$ns" link set "$veth" down
 	done
 }
@@ -634,7 +633,7 @@ chk_stale_nr()
 	local stale_nr
 	local recover_nr
 
-	printf "%-39s %s" " " "stale"
+	printf "%-39s %s" " " "stale             "
 	stale_nr=`ip netns exec $ns nstat -as | grep MPTcpExtSubflowStale | awk '{print $2}'`
 	[ -z "$stale_nr" ] && stale_nr=0
 	recover_nr=`ip netns exec $ns nstat -as | grep MPTcpExtSubflowRecover | awk '{print $2}'`
@@ -878,7 +877,7 @@ chk_link_usage()
 	local tx_rate=$((tx_link * 100 / $tx_total))
 	local tolerance=5
 
-	printf "%-39s %s" " " "link usage "
+	printf "%-39s %s" " " "link usage        "
 	if [ $tx_rate -lt $((expected_rate - $tolerance)) -o \
 	     $tx_rate -gt $((expected_rate + $tolerance)) ]; then
 		echo "[fail] got $tx_rate% usage, expected $expected_rate%"
@@ -1039,7 +1038,7 @@ link_failure_tests()
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 dev ns2eth4 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 2
-	chk_join_nr "multiple flows, signal, bidirectional, link failure" 3 3 3
+	chk_join_nr "multi flows, signal, bidi, link fail" 3 3 3
 	chk_add_nr 1 1
 	chk_stale_nr $ns2 1 -1 1
 
@@ -1053,7 +1052,7 @@ link_failure_tests()
 	export FAILING_LINKS="1"
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 1
-	chk_join_nr "backup subflow unused with link failure" 2 2 2
+	chk_join_nr "backup subflow unused, link failure" 2 2 2
 	chk_add_nr 1 1
 	chk_link_usage $ns2 ns2eth3 $cinsent 0
 
@@ -1067,7 +1066,7 @@ link_failure_tests()
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,backup
 	export FAILING_LINKS="1 2"
 	run_tests $ns1 $ns2 10.0.1.1 1
-	chk_join_nr "backup subflow used due to multiple links failure" 2 2 2
+	chk_join_nr "backup flow used, multi links fail" 2 2 2
 	chk_add_nr 1 1
 	chk_stale_nr $ns2 2 4 2
 	chk_link_usage $ns2 ns2eth3 $cinsent 50
@@ -1081,7 +1080,7 @@ link_failure_tests()
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 2
-	chk_join_nr "backup subflow in use, bidirectional, link failure" 2 2 2
+	chk_join_nr "backup flow used, bidi, link failure" 2 2 2
 	chk_add_nr 1 1
 	chk_stale_nr $ns2 1 -1 2
 	chk_link_usage $ns2 ns2eth3 $cinsent 50
-- 
2.31.1

