Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FA42F21
	for <mptcp@lists.linux.dev>; Thu,  3 Nov 2022 11:07:55 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id s196so1360445pgs.3
        for <mptcp@lists.linux.dev>; Thu, 03 Nov 2022 04:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFVgivVw6M9+GgI53tlp2IfU3DX6z8d/psWvyGeKtOo=;
        b=mt6BfGem0IihRM6JeSoDHXYK5rpkbknVMm6/NWUO+TizagETwQprDcAB6vtKyloZn0
         EJtel9CbZeaoj7+zeU5e4RuEZ1lWvtV5XNCFBCEPAPkJzhfmEsMCWtYZHcBlUVQW0gEJ
         5Myox6TMaMPGt34qWvgjQwBEVrkfGpHRnKlYa9Qe4sJlCUhNSvmZiWdQ1tz7ZOIsvQlz
         SYMU47d3WxGZy8H6p5RWwhUXWGVicMkjxMLYLtYs0PyMpv0wk01kuCkMDW3UW6fTxJvW
         ImoQK7LZGjJXiYXiaCGkEEZ/sCC0TxI00oYV8UsF2aaKMM/hGoIN33ym2fPf9n/qIwr8
         4rAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFVgivVw6M9+GgI53tlp2IfU3DX6z8d/psWvyGeKtOo=;
        b=Ch7wyYQRqJF7SAPmj3PzTNQRI5OI6ntexbZIDDww9/i1WOSTjnDvnrG1fD0F2xR8A8
         h0U/LW2dv1xTRPnN8R2H/FXHreWcy642KY5CUn+Cq+CuFJ30QruGrDE2YVSWAjGDdkSy
         Ygd5/Gvdeb+ySc9c3EYSncV65svIZwPiDC7DiECeJ2om9nhebkYHVMRzJnahwMR814lU
         mFK8Bz4Ur49HHdknFry/xOaRIhsRJHRuHXsoQ+3ZI3TDoxgKji0dPjZXnPrBdliAw3Ph
         IhiEGMUNPD7ucbml8OtrXxf2qsynP51KLdLd9AB1BUbzuHBEIAnZ4oJSpSsBfocNADqO
         pYUw==
X-Gm-Message-State: ACrzQf2rcVdtMAfpBOFBYRluy2b9aPjGObdTSYsqVQFsAyw3sf0v2YZN
	nsa6NfCLlqIPU/3aIp8dpFA=
X-Google-Smtp-Source: AMsMyM533QhuB6uR+344tloOntQ7kCPOerDmweZyloRg/2u2SnnKagSuxRmuwEyce/c852Y4rV6qXw==
X-Received: by 2002:a05:6a00:8ce:b0:56e:6961:c6b6 with SMTP id s14-20020a056a0008ce00b0056e6961c6b6mr518146pfu.3.1667473674928;
        Thu, 03 Nov 2022 04:07:54 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.83])
        by smtp.gmail.com with ESMTPSA id w14-20020a627b0e000000b0056bd4ec964csm450555pfc.194.2022.11.03.04.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 04:07:54 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v6 4/4] selftest: mptcp: add test for mptcp socket in use
Date: Thu,  3 Nov 2022 19:06:49 +0800
Message-Id: <20221103110649.299284-5-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221103110649.299284-1-imagedong@tencent.com>
References: <20221103110649.299284-1-imagedong@tencent.com>
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
v6:
- reuse __chk_nr to check the number of msk in use
---
 tools/testing/selftests/net/mptcp/diag.sh | 47 ++++++++++++++++++++---
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 515859a5168b..9994cb23f8a0 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -36,15 +36,20 @@ if [ $? -ne 0 ];then
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
@@ -56,9 +61,17 @@ __chk_nr()
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
@@ -96,12 +109,12 @@ wait_msk_nr()
 
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
@@ -141,6 +154,25 @@ chk_msk_listen()
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
@@ -194,8 +226,10 @@ wait_connected $ns 10000
 chk_msk_nr 2 "after MPC handshake "
 chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"
+chk_msk_inuse 2 "chk 2 msk in use"
 flush_pids
 
+chk_msk_inuse 0 "chk 0 msk in use after flush"
 
 echo "a" | \
 	timeout ${timeout_test} \
@@ -231,6 +265,9 @@ for I in `seq 1 $NR_CLIENTS`; do
 done
 
 wait_msk_nr $((NR_CLIENTS*2)) "many msk socket present"
+chk_msk_inuse $((NR_CLIENTS*2)) "chk many msk in use"
 flush_pids
 
+chk_msk_inuse 0 "chk 0 msk in use after flush"
+
 exit $ret
-- 
2.37.2

