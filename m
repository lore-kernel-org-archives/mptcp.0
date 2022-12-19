Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7770ED2
	for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 07:51:58 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso13257005pjb.1
        for <mptcp@lists.linux.dev>; Sun, 18 Dec 2022 23:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgtwbM9/80y8yPptKc/3f93/fPhOk90dsnObLjOfD9E=;
        b=WocQqoa7JMkuKxXK2npT5IGrZFbgAlKadqjJXUs5fDeK7veD/yo7rrQxYAW4HyEqxA
         2telHvZTY+iiEoFXZ58hfUiBzms3EzZbgDdoQvegRwyPoNEZVJ4OFKRTqYjCrl9Kr/LW
         QLYAz+9sZd8aedwQc7rYya39HI5RISp5sEWwTMyoZDJOSr07qmADhnlUJ6sjDryZJTM4
         wGP6oH8jQp4UhqEqBVYfXexNv3lOyu5q+xnzYKe/2jE7QHMSo/canxujRbDuZzZv5Bj5
         fylQctEY8ZMHDeJVHdxr52u6aYDLGuL7IUuCq5yt+vxWTlj6DvsPvcfe7IVCwF2uFuPI
         Cc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgtwbM9/80y8yPptKc/3f93/fPhOk90dsnObLjOfD9E=;
        b=HHp1bMVDoBs/YLLWcwg3fj4wVdNFScnxMywPLO/dxAfLGp8DndUnvCfFxjvP/6gKL5
         +xh2YxgdSQYSlPC1RLWx8y4wWjgx0uXtIdCCOSi1qT86CIsRZ19D3MVwj8K0vDfg5zwO
         5CoYwgqWsnGbDb6SKRWYvMFyJhpgqNPW/6HOsvg/EjL1uIEJXlB1An0wpDPi0y//+Ptf
         hvWcrqN/gMrnhy5H3UMPGry1Caw7del/kkc8WpW1+9YIg9Q4BjAdZ8MZzghSpB/bkJIO
         7thh0IdcHeLbH+KhmxDlN9dIvCY4PI0U2AFni8llbLtPh2lqN/iVbLnmRxR7p1vktQbW
         ZjFw==
X-Gm-Message-State: ANoB5pnSkWR1LTXJp3jHGoO4/DGIlPfGNHSGKLukzV0PK1R4+xQbRM5W
	4BwwC+kfBQlQXF59BwZIgM0=
X-Google-Smtp-Source: AA0mqf5O1ozw49omwKLXqPCnQzXIkEw6dMqPORFNjNOpzLIJrGhRg7/1oIXihBJ16gTpQ0VCyoczQw==
X-Received: by 2002:a17:903:264b:b0:189:ec62:3b2d with SMTP id je11-20020a170903264b00b00189ec623b2dmr44070853plb.4.1671436318361;
        Sun, 18 Dec 2022 23:51:58 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.21])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e84900b001888cadf8f6sm6366673plg.49.2022.12.18.23.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 23:51:58 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v9 6/6] selftest: mptcp: add test for mptcp socket in use
Date: Mon, 19 Dec 2022 15:50:48 +0800
Message-Id: <20221219075048.255811-7-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221219075048.255811-1-imagedong@tencent.com>
References: <20221219075048.255811-1-imagedong@tencent.com>
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

