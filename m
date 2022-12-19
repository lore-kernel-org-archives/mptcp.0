Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8317D10EF
	for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 10:24:33 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id 130so5878434pfu.8
        for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 02:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgtwbM9/80y8yPptKc/3f93/fPhOk90dsnObLjOfD9E=;
        b=EPpjMnm8yxW6NQnRy4pjIKiK1ZlT8qqEfAk7p3nz3zUjU/GwxDylge9g3bDYk05b2F
         0PjMXgvbZHks6E6yf2mGLf9iz+CIvxzWrjwNJNgojVS6r0lH/918sIIhd0l+svu2tPxK
         G6+G/Mf+1CwYZIygmV2Iy93nVpu0GXSYZhP5uQ7mU4anf/4cI8AMY6qf1JWDOtXMjDVi
         Xn29lAo+6RWAsU0o85hlmM2ry7RfuU8rU9m/HRyvP2/tRmwzv43KaXNJZKnx/6dhGBIf
         7Py+JJmdmvL3wwtqer+pK9A7mfXdcewvHwEZYsaNq54Q3wd7JVodtx4wjd36bkjt032c
         oIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgtwbM9/80y8yPptKc/3f93/fPhOk90dsnObLjOfD9E=;
        b=Qkv/JEltjFIiHIfVkAYX0IwztY3VMSpt+o7eEuROMiAsf+AMMVRUHh5ZHEitZ++FlY
         7mVi1g1vaky9E0LKTlLFvskYghzn5/0Fe3sblvo3KXM+PpjXCGRkE99xl0n5eXp9Thxh
         UKsYNObublmhTTZKCyDDNxEY8Yg42lSghXXacIJOKKKMgpzsWEna1y4/GqfNNMpgMQ+/
         VZJRxX9iyerRYPUB+z9fC3eC5TeZwzUwatQi5VpZ2FWMROwA3zajXhfaQt6bBAvhlY5a
         UXrIhbKi3VFUc8ZOY62N4OFGxRcMVsZCl/XVlkNOdwxyczoha2AJvBg1OjjB/Bf5QzLh
         suvg==
X-Gm-Message-State: ANoB5pme+XYRvwqh1WsoSOqraTImQ/ltx9LIOBwzOxJlwvFFE/LrSVRr
	7Mp55YRwVg5CyiH5SQIjL3MqOaahN1uXzg==
X-Google-Smtp-Source: AA0mqf6t3nueMA0MnZnG/BYV155un6RbJo8aVnRhmXczwg5gbWSYztQGW4aiPTZ910hgvLE9zHl0rg==
X-Received: by 2002:a62:b60c:0:b0:569:a028:a1fd with SMTP id j12-20020a62b60c000000b00569a028a1fdmr37861081pff.34.1671445473000;
        Mon, 19 Dec 2022 02:24:33 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.23])
        by smtp.gmail.com with ESMTPSA id n5-20020a056a00212500b005775c52dbc4sm6206517pfj.167.2022.12.19.02.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:24:32 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v10 6/6] selftest: mptcp: add test for mptcp socket in use
Date: Mon, 19 Dec 2022 18:23:16 +0800
Message-Id: <20221219102316.627491-7-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221219102316.627491-1-imagedong@tencent.com>
References: <20221219102316.627491-1-imagedong@tencent.com>
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

