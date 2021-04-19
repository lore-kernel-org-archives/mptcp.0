Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3052F9C
	for <mptcp@lists.linux.dev>; Mon, 19 Apr 2021 20:34:31 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id mh2so33408274ejb.8
        for <mptcp@lists.linux.dev>; Mon, 19 Apr 2021 13:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aWIUzeL2ubUjWH7prj+znSIxc8Rvojcz8sBu78V2p8k=;
        b=dlUq36G4vGSt+vaDn2FAURqeZpLe342iOIxL8Wtu8ZsJ+L3EXeQJfJZoIVuyeibA1H
         C5bZZGKJLwSGV5DHHAdlAF74G8vT8PWF3tev6ObvXVZvOtqdLtTMHwBOTDm+daVTOaN0
         96mB+gikA612/0eqgkQGfrKq/61aWWq4seJfLu0jPoN6FoCUKpahPRWKA46Js1BJ116H
         jK032+yoyOLFfjXPc94Ol8MYDsVxpAlWNOjAheXQ1LjrhP6b1IwUAEFhfksd7iOMckWL
         +bWs68sBHOuZyhJvkKl4A6qlLjbFTGe3otfPC6k0RLUqwLNHhxC+9phBhKRkkXBB8I0F
         vnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aWIUzeL2ubUjWH7prj+znSIxc8Rvojcz8sBu78V2p8k=;
        b=cavoMLEHBWJ7A0ESxp5nGulCjUz38KRf0ld0xjLPci8Ruvd//FSCTN9y6kTObwKIzM
         PDVES3gpU+9MQKEaxddlen+WbegCUtLk2IRxrFR4dLngoQXiY+917QzeJy84jDF9bSmP
         IfPqYNrxUV+4N9l30wp9ivcLLsc8PYHfR4nkYD7K/yHyk1eo0AiT5WBG+Tz4gmcp5ptu
         uDNyGl4/VhHVkYrBSISFSXFf9/WAoZUlvWmK1O++EB0OyTfq0bxuBgCvyRFzyXeJsD6z
         AJve842ZS6VleCcg0IHm4fqnn3SPR8IG3JoUaX4xVxqbPJpUfFGezEEj3yP6Bk3TITDW
         zGug==
X-Gm-Message-State: AOAM531r7aPZ/5pMq3nkPgBdiI/8L03u0D7QaElNeXsVjr/gJldcxQ7/
	S00PYNbDyfMrZECteakSNsfQ4RuvM8+LUyPCQYM=
X-Google-Smtp-Source: ABdhPJzZCxsRsHTVxhUDlmiiKlQ1yctSkJ1fa+kwD7SkFNP8RPaFCmANIwuZZpCarM1i/EbU3hr7wg==
X-Received: by 2002:a17:906:d8cd:: with SMTP id re13mr19292048ejb.141.1618864469726;
        Mon, 19 Apr 2021 13:34:29 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id e16sm13941867edu.94.2021.04.19.13.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 13:34:29 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Yonglong Li <liyonglong@chinatelecom.cn>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 3/3] selftests: mptcp: avoid non-const global variables
Date: Mon, 19 Apr 2021 22:33:55 +0200
Message-Id: <20210419203355.3937162-4-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419203355.3937162-1-matthieu.baerts@tessares.net>
References: <20210419203355.3937162-1-matthieu.baerts@tessares.net>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In these scripts, we have "global variables" that are only set once when
parsing the config. That's fine, they are const.

It is often not recommended to use non-const global variables for
various reasons.

Here, we were changing the behaviour of a function by changing the value
of a global var just before calling this function and reset the global
var after for the next tests. Even if we are in a Bash script, best to
avoid this because that will certainly cause issues later.

Now we pass extra args for mptcp_connect directly through the functions
we call.

Also by avoiding code duplication, it allowed me to detect 2 issues, see
the previous patches.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 44 +++++++++----------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index dbb4aea8b636..9236609731b1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -23,8 +23,6 @@ rcvbuf=0
 options_log=true
 do_tcp=0
 filesize=0
-peekmode=""
-testpeek=false
 
 if [ $tc_loss -eq 100 ];then
 	tc_loss=1%
@@ -377,7 +375,7 @@ do_transfer()
 	local srv_proto="$4"
 	local connect_addr="$5"
 	local local_addr="$6"
-	local extra_args=""
+	local extra_args="$7"
 
 	local port
 	port=$((10000+$TEST_COUNT))
@@ -395,14 +393,10 @@ do_transfer()
 		extra_args="$extra_args -m $testmode"
 	fi
 
-	if $testpeek; then
-		extra_args="$extra_args -P $peekmode"
-	fi
-
 	if [ -n "$extra_args" ] && $options_log; then
-		options_log=false
 		echo "INFO: extra options: $extra_args"
 	fi
+	options_log=false
 
 	:> "$cout"
 	:> "$sout"
@@ -595,6 +589,7 @@ run_tests_lo()
 	local connector_ns="$2"
 	local connect_addr="$3"
 	local loopback="$4"
+	local extra_args="$5"
 	local lret=0
 
 	# skip if test programs are running inside same netns for subsequent runs.
@@ -614,7 +609,8 @@ run_tests_lo()
 		local_addr="0.0.0.0"
 	fi
 
-	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} ${local_addr}
+	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP \
+		    ${connect_addr} ${local_addr} "${extra_args}"
 	lret=$?
 	if [ $lret -ne 0 ]; then
 		ret=$lret
@@ -628,14 +624,16 @@ run_tests_lo()
 		fi
 	fi
 
-	do_transfer ${listener_ns} ${connector_ns} MPTCP TCP ${connect_addr} ${local_addr}
+	do_transfer ${listener_ns} ${connector_ns} MPTCP TCP \
+		    ${connect_addr} ${local_addr} "${extra_args}"
 	lret=$?
 	if [ $lret -ne 0 ]; then
 		ret=$lret
 		return 1
 	fi
 
-	do_transfer ${listener_ns} ${connector_ns} TCP MPTCP ${connect_addr} ${local_addr}
+	do_transfer ${listener_ns} ${connector_ns} TCP MPTCP \
+		    ${connect_addr} ${local_addr} "${extra_args}"
 	lret=$?
 	if [ $lret -ne 0 ]; then
 		ret=$lret
@@ -643,7 +641,8 @@ run_tests_lo()
 	fi
 
 	if [ $do_tcp -gt 1 ] ;then
-		do_transfer ${listener_ns} ${connector_ns} TCP TCP ${connect_addr} ${local_addr}
+		do_transfer ${listener_ns} ${connector_ns} TCP TCP \
+			    ${connect_addr} ${local_addr} "${extra_args}"
 		lret=$?
 		if [ $lret -ne 0 ]; then
 			ret=$lret
@@ -659,6 +658,15 @@ run_tests()
 	run_tests_lo $1 $2 $3 0
 }
 
+run_tests_peekmode()
+{
+	local peekmode="$1"
+
+	echo "INFO: with peek mode: ${peekmode}"
+	run_tests_lo "$ns1" "$ns1" 10.0.1.1 1 "-P ${peekmode}"
+	run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1 "-P ${peekmode}"
+}
+
 make_file "$cin" "client"
 make_file "$sin" "server"
 
@@ -738,16 +746,8 @@ for sender in $ns1 $ns2 $ns3 $ns4;do
 	run_tests "$ns4" $sender dead:beef:3::1
 done
 
-testpeek=true
-options_log=true
-peekmode="saveWithPeek"
-run_tests_lo "$ns1" "$ns1" 10.0.1.1 1
-run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1
-
-options_log=true
-peekmode="saveAfterPeek"
-run_tests_lo "$ns1" "$ns1" 10.0.1.1 1
-run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1
+run_tests_peekmode "saveWithPeek"
+run_tests_peekmode "saveAfterPeek"
 
 time_end=$(date +%s)
 time_run=$((time_end-time_start))
-- 
2.30.2

