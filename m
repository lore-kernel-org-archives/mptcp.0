Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE47A4E
	for <mptcp@lists.linux.dev>; Fri,  7 Oct 2022 09:31:41 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id bh13so4175610pgb.4
        for <mptcp@lists.linux.dev>; Fri, 07 Oct 2022 02:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7lcW4Bg683HfDSH1iijL+2r4PqGfhjxnDSrzqJPet0=;
        b=AfB7ySYLqhjov+Dsn6xjM1vHbcnBFZ4dH4HjkqJp8DE4k0anHfyzJip5SgbDl8srge
         IVZo9ZJYQkdc21RMN9rG+DMlY2qa9B2Agj6FaBKR+GJUqafQxHL49tUQBylXjF/VmG2b
         xUzOdkQ5ba71H4dh7QSojIpOZ5X5cyyfbNgYaAMaGA8pyJOH1FEa5POhGNLg9HeVsK5A
         zNxfhF/+KI4waMq00Sb1peHXUHihvYBKqEzVkfbBb0tK3Lc8LwTKvt+e2iZSduR6Sym/
         Wr1i7qgmVkRoveOOwzKW9YQcaAPqtE2kiVvlZQMSVrLUwzecR9JAbhJ9OTNnw3VF6Q5R
         uxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7lcW4Bg683HfDSH1iijL+2r4PqGfhjxnDSrzqJPet0=;
        b=TSscwOiri5Pf5jHGhEjOp3z/bv2o6f7jRf9+NB0xE3OIObIoU3QyyhQ8GSP4KXaQs7
         0nBwks/vkvkXKXKQaz4YVk9EsoIJ9lI20sCecBVq3Z06yk+lAoLjEzrresTqm6zZaNIQ
         J7Fu2uBHZyaiTI21iY3XUgr6e5lK4Kh+suueV+eTwXLigEI2nXxcjatEIeyVC4C2d9/h
         HvCE6028eklYuqWFcidESEub9kquUJOXd+1gqpowJLcczmc6IDle6mFqcpoNtbv7dVxX
         VZSp3BEfLPifGv8PRp7LRnH15MNGm3ZlbcbDHguwjdhOo9PJa6vJSpn+gNpZjYOrzxHC
         DQQw==
X-Gm-Message-State: ACrzQf0Fx0WPRVYiR2vAITaCqep4pmXggWKTbrCg3C3nkGYNl04lKoA4
	HNQdB0HpHpVIcnzjku9SXhjUvAayi3UFjw==
X-Google-Smtp-Source: AMsMyM4jiPwUXU2ftDW5zWhkT42buaO7MpcmsdySf59+amk1wfAgkxRE9FUWk78rb2ci8GnisX+xkg==
X-Received: by 2002:a63:4e18:0:b0:43c:2fc7:2eea with SMTP id c24-20020a634e18000000b0043c2fc72eeamr3846155pgb.119.1665135101329;
        Fri, 07 Oct 2022 02:31:41 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.87])
        by smtp.gmail.com with ESMTPSA id 61-20020a17090a0fc300b001fd7e56da4csm4187421pjz.39.2022.10.07.02.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 02:31:40 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: mathew.j.martineau@linux.intel.com
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v5 3/3] selftest: mptcp: add test for mptcp socket in use
Date: Fri,  7 Oct 2022 17:29:22 +0800
Message-Id: <20221007092922.13169-4-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221007092922.13169-1-imagedong@tencent.com>
References: <20221007092922.13169-1-imagedong@tencent.com>
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

mptcp_connect command with '-r' flag seems won't exit after flush_pids,
therefore we need consider this additional statistics. But after the
second flush_pids, it will exit.

All tests pass.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 tools/testing/selftests/net/mptcp/diag.sh | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 515859a5168b..d969cb45b8a9 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -141,6 +141,28 @@ chk_msk_listen()
 	nr=$(ss -Ml $filter | wc -l)
 }
 
+chk_msk_inuse()
+{
+	local nr listen_nr
+	local expected=$1
+
+	shift 1
+	msg=$*
+
+	nr=$(ip netns exec $ns awk '$1~/^MPTCP$/{print $3}' /proc/net/protocols)
+	listen_nr=$(ss -N $ns -Ml | grep -c LISTEN)
+	expected=$(($expected+$listen_nr))
+
+	printf "%-50s" "$msg"
+
+	if [ $nr != $expected ]; then
+		echo "[ fail ] expected $expected found $nr"
+		ret=$test_cnt
+	else
+		echo "[  ok  ]"
+	fi
+}
+
 # $1: ns, $2: port
 wait_local_port_listen()
 {
@@ -194,8 +216,11 @@ wait_connected $ns 10000
 chk_msk_nr 2 "after MPC handshake "
 chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"
+chk_msk_inuse 2 "msk in use statistics"
 flush_pids
 
+# with '-r' flag, client won't exit after flush_pids
+chk_msk_inuse 1 "msk in use statistics"
 
 echo "a" | \
 	timeout ${timeout_test} \
@@ -231,6 +256,9 @@ for I in `seq 1 $NR_CLIENTS`; do
 done
 
 wait_msk_nr $((NR_CLIENTS*2)) "many msk socket present"
+chk_msk_inuse $((NR_CLIENTS*2+1)) "msk in use statistics"
 flush_pids
 
+chk_msk_inuse 0 "msk in use statistics"
+
 exit $ret
-- 
2.37.2

