Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B07EA8
	for <mptcp@lists.linux.dev>; Tue, 22 Nov 2022 03:51:29 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id o5-20020a17090a678500b00218cd5a21c9so809827pjj.4
        for <mptcp@lists.linux.dev>; Mon, 21 Nov 2022 19:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niWQtG1fWIVuG/NRj2Q8+EYIVC8ygMo41dzMZHL4cCc=;
        b=CogAgdhYGXh0HbudKT/RNjJkh1ASZr5KW+jxvJTd18Z/OUM2BYQ9QxjHKLXKEsOpa8
         0Svw3oEM+VL/o7Xz22gA6ZaZbEJVdadYjLMZv+AjOl5afgHotFw4MnvzBDmhvHHIv7EV
         NpdDTWtODGC7BZ2169NoKn7buWCUCPCJdNSGr/W+P1aLp/5tWNIzVgAM0zLjMRoE/+qw
         Fin6kn5iKoNqMuy+lu3QJsyTP4t2fEzL65OpOteABBBFLnOzpRyHxBFnHlJkHweQWBrR
         Uzz+3uBnLV5FTXfyoK2fQvpL3Rz9w6FaiR9uhBVuYrdRayz0oJvh7yYfb7dIm3Zg29UN
         Ku+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=niWQtG1fWIVuG/NRj2Q8+EYIVC8ygMo41dzMZHL4cCc=;
        b=A6z+XpkHmutcrVY9nGAJpPOaqCJphACUMinPWMPBYgpZOP1wyCRPeDA76cJtLEWFLq
         13QHrax6aoFrK7EFcxGjJpmh7HLLfdXQbcOQoN4M1BKIr926RmwmLn3le/QHLNzWIH/p
         8vJoE+rNM1Grh+BqotDpQVwlq6ZVVYmQ+fGQJQkNOmzSE5K+WLovkgPkfz/OoLvjVrDd
         XcjdzUKNClq368fX+kM+5ywVTWOPmFf3/s+vHVBGZ5rSLUbclC4TB7MuIcSZ6SVLrD4H
         /bH27NKRgKUw8CGcAODmc4qOWwgrv7xEfam7JkedwsHk5xd7KW42GPapd9ydv+2IQQXo
         TTNw==
X-Gm-Message-State: ANoB5pkKzds9exinJSX/rawD9qsX/5GVst5bG5ZqYrxmDBd6N8sIhMvL
	4+nuhtt+2c70AVV1uQaqL90=
X-Google-Smtp-Source: AA0mqf4a8a+eMKTXr3FV3BVbRZH7F6M9PVz0j/6oghDJhJ+Z8zTISA/r1yOjvR+fSe1J7/ilUaXiHw==
X-Received: by 2002:a17:90a:d38a:b0:218:a7e6:60df with SMTP id q10-20020a17090ad38a00b00218a7e660dfmr10282326pju.38.1669089088887;
        Mon, 21 Nov 2022 19:51:28 -0800 (PST)
Received: from localhost.localdomain ([162.14.78.182])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902ec8b00b001869d71228bsm10707220plg.170.2022.11.21.19.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 19:51:28 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v7 4/4] selftest: mptcp: add test for mptcp socket in use
Date: Tue, 22 Nov 2022 11:49:23 +0800
Message-Id: <20221122034923.804955-5-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221122034923.804955-1-imagedong@tencent.com>
References: <20221122034923.804955-1-imagedong@tencent.com>
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
 tools/testing/selftests/net/mptcp/diag.sh | 54 ++++++++++++++++++++---
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 515859a5168b..4dd5dc1130ca 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -16,6 +16,11 @@ flush_pids()
 	sleep 1.1
 
 	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGUSR1 &>/dev/null
+
+	for _ in $(seq 10); do
+		[ -z "$(ip netns pids "${ns}")" ] && break
+		sleep 0.1
+	done
 }
 
 cleanup()
@@ -36,15 +41,20 @@ if [ $? -ne 0 ];then
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
@@ -56,9 +66,17 @@ __chk_nr()
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
@@ -96,12 +114,12 @@ wait_msk_nr()
 
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
@@ -141,6 +159,25 @@ chk_msk_listen()
 	nr=$(ss -Ml $filter | wc -l)
 }
 
+chk_msk_inuse()
+{
+	local expected=$1
+	local listen_nr
+
+	listen_nr=$(ss -N $ns -Ml | grep -c LISTEN)
+	expected=$(($expected+$listen_nr))
+	shift 1
+
+	for i in $(seq 10); do
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
@@ -194,8 +231,10 @@ wait_connected $ns 10000
 chk_msk_nr 2 "after MPC handshake "
 chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"
+chk_msk_inuse 2 "....chk 2 msk in use"
 flush_pids
 
+chk_msk_inuse 0 "....chk 0 msk in use after flush"
 
 echo "a" | \
 	timeout ${timeout_test} \
@@ -212,6 +251,8 @@ wait_connected $ns 10001
 chk_msk_fallback_nr 1 "check fallback"
 flush_pids
 
+chk_msk_inuse 0 "....chk 0 msk in use after flush"
+
 NR_CLIENTS=100
 for I in `seq 1 $NR_CLIENTS`; do
 	echo "a" | \
@@ -231,6 +272,9 @@ for I in `seq 1 $NR_CLIENTS`; do
 done
 
 wait_msk_nr $((NR_CLIENTS*2)) "many msk socket present"
+chk_msk_inuse $((NR_CLIENTS*2)) "....chk many msk in use"
 flush_pids
 
+chk_msk_inuse 0 "....chk 0 msk in use after flush"
+
 exit $ret
-- 
2.37.2

