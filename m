Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECB462C
	for <mptcp@lists.linux.dev>; Thu,  8 Dec 2022 02:46:49 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id jl24so222609plb.8
        for <mptcp@lists.linux.dev>; Wed, 07 Dec 2022 18:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgtwbM9/80y8yPptKc/3f93/fPhOk90dsnObLjOfD9E=;
        b=aoAUJJjCuv131Xbp1+q6Tuo1Z4Yn19M4OJk+y3nPFp1+ddgVhsaj8PAILaWs2jhWLA
         9RsMZkI7dqSLSZfyeOKBKhoKNyByLKZ+VwmoeIwTPQuWBEmipq6/zjJw73iqGidGISRW
         xHiJRXHg1dNCk0Not3tW0JtA8mI4fxuN4+uK3Uvf6aUI92T/Y9rXJWFexzykMWVNYJw2
         KqENYtvrp2PuiC97nBIF97Nnnk+J4WOL1gGBBJXby11+AOSLPLb9NppfjWELQbPQz2fS
         1kR913GCILfRl3mp2GKWzuaafMtubkFCInXbkq18xnJU6vCgKAp8DUMwd+pNHiUMs3sP
         7jwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgtwbM9/80y8yPptKc/3f93/fPhOk90dsnObLjOfD9E=;
        b=dsN3bU4r6N/j4OEtfyiwQxAX6IjVKJC/U0IuTgOUBmjeOzfd1Vrfexf+hkdGjHOdDk
         mTNITRUcGL+igIdoP5JnnWSs9kXRd0xoRCcGGd2hZwoeLAF8IvCuC281HCwmHzaxyImB
         Gakvj8XqtAyCLDZV2VyIMW3t6vtz4Khnny325A8LmmYvvZtjwCYFu/dJ1xXIUVis8Cxw
         xqGpKTeA7OeRiVoniVUqosSCbmkTPiagcQwwFJWI2WFQZBdkyCCgsOMhWtstOSy9LMUP
         hjwGxBA6w86M+lB+OCsKmaQzw5lfIFQRgE8WWbbOV9Ap1319dP71CZbjwnHIyL3IcHSN
         YK1A==
X-Gm-Message-State: ANoB5plRiFVGCt9/lnXiFD7u2UFHYTKq9OkyAJ5XZvvvcnaVFh8HC9Tq
	POHAWekjSyUe/JJaUGx/iR0=
X-Google-Smtp-Source: AA0mqf4R0EwhkKm+hw0DR4/HXUn3mLwpYD67iIRs86WpRsBUR/1Q3Lkrgo2/+xvwsQW9U21I8h5FXQ==
X-Received: by 2002:a17:902:ee82:b0:189:f0ce:43db with SMTP id a2-20020a170902ee8200b00189f0ce43dbmr7547530pld.88.1670467609120;
        Wed, 07 Dec 2022 18:46:49 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.17])
        by smtp.gmail.com with ESMTPSA id a26-20020aa78e9a000000b005769cee6735sm8606394pfr.43.2022.12.07.18.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 18:46:48 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v8 4/4] selftest: mptcp: add test for mptcp socket in use
Date: Thu,  8 Dec 2022 10:45:43 +0800
Message-Id: <20221208024543.113633-5-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221208024543.113633-1-imagedong@tencent.com>
References: <20221208024543.113633-1-imagedong@tencent.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <imagedong@tencent.com>

Add the function chk_msk_inuse() to diag.sh, which is used to check the
statistics of mptcp socket in use. As mptcp socket in listen state will
be closed randomly after 'accept', we need to get the count of listening
mptcp socket through 'ss' command.

All tests pass.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
v7:
- check all processes exit in flush_pids()
---
 tools/testing/selftests/net/mptcp/diag.sh | 56 +++++++++++++++++++++--
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 24bcd7b9bdb2..ef628b16fe9b 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -17,6 +17,11 @@ flush_pids()
 	sleep 1.1
 
 	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGUSR1 &>/dev/null
+
+	for _ in $(seq 10); do
+		[ -z "$(ip netns pids "${ns}")" ] && break
+		sleep 0.1
+	done
 }
 
 cleanup()
@@ -37,15 +42,20 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
 
+get_msk_inuse()
+{
+	ip netns exec $ns cat /proc/net/protocols | awk '$1~/^MPTCP$/{print $3}'
+}
+
 __chk_nr()
 {
-	local condition="$1"
+	local command="$1"
 	local expected=$2
 	local msg nr
 
 	shift 2
 	msg=$*
-	nr=$(ss -inmHMN $ns | $condition)
+	nr=$(eval $command)
 
 	printf "%-50s" "$msg"
 	if [ $nr != $expected ]; then
@@ -57,9 +67,17 @@ __chk_nr()
 	test_cnt=$((test_cnt+1))
 }
 
+__chk_msk_nr()
+{
+	local condition=$1
+	shift 1
+
+	__chk_nr "ss -inmHMN $ns | $condition" $*
+}
+
 chk_msk_nr()
 {
-	__chk_nr "grep -c token:" $*
+	__chk_msk_nr "grep -c token:" $*
 }
 
 wait_msk_nr()
@@ -97,12 +115,12 @@ wait_msk_nr()
 
 chk_msk_fallback_nr()
 {
-		__chk_nr "grep -c fallback" $*
+		__chk_msk_nr "grep -c fallback" $*
 }
 
 chk_msk_remote_key_nr()
 {
-		__chk_nr "grep -c remote_key" $*
+		__chk_msk_nr "grep -c remote_key" $*
 }
 
 __chk_listen()
@@ -142,6 +160,26 @@ chk_msk_listen()
 	nr=$(ss -Ml $filter | wc -l)
 }
 
+chk_msk_inuse()
+{
+	local expected=$1
+	local listen_nr
+
+	shift 1
+
+	listen_nr=$(ss -N "${ns}" -Ml | grep -c LISTEN)
+	expected=$((expected + listen_nr))
+
+	for _ in $(seq 10); do
+		if [ $(get_msk_inuse) -eq $expected ];then
+			break
+		fi
+		sleep 0.1
+	done
+
+	__chk_nr get_msk_inuse $expected $*
+}
+
 # $1: ns, $2: port
 wait_local_port_listen()
 {
@@ -195,8 +233,10 @@ wait_connected $ns 10000
 chk_msk_nr 2 "after MPC handshake "
 chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"
+chk_msk_inuse 2 "....chk 2 msk in use"
 flush_pids
 
+chk_msk_inuse 0 "....chk 0 msk in use after flush"
 
 echo "a" | \
 	timeout ${timeout_test} \
@@ -211,8 +251,11 @@ echo "b" | \
 				127.0.0.1 >/dev/null &
 wait_connected $ns 10001
 chk_msk_fallback_nr 1 "check fallback"
+chk_msk_inuse 1 "....chk 1 msk in use"
 flush_pids
 
+chk_msk_inuse 0 "....chk 0 msk in use after flush"
+
 NR_CLIENTS=100
 for I in `seq 1 $NR_CLIENTS`; do
 	echo "a" | \
@@ -232,6 +275,9 @@ for I in `seq 1 $NR_CLIENTS`; do
 done
 
 wait_msk_nr $((NR_CLIENTS*2)) "many msk socket present"
+chk_msk_inuse $((NR_CLIENTS*2)) "....chk many msk in use"
 flush_pids
 
+chk_msk_inuse 0 "....chk 0 msk in use after flush"
+
 exit $ret
-- 
2.37.2

