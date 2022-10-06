Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EA864C
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 06:11:57 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id 78so957567pgb.13
        for <mptcp@lists.linux.dev>; Wed, 05 Oct 2022 23:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=u7lcW4Bg683HfDSH1iijL+2r4PqGfhjxnDSrzqJPet0=;
        b=mM6m8dyMA9e98m+oDRa1+66KHqGwQ7fdEtJJY7XCCehNjSf2eocsMTZrLdDHUzIRYn
         6qsu39HNYfoyWP7P+Ab4y1WHxGT5CJ4+Rw7D3JTSPDe4Co1WK0qW71BReFDUYAjLKrew
         HZ+mKvmN8Kvvu6UzYK6DFj9nQZ9T+YOklZ/HBe+Yb5oSc88gh8buz422XWbvYGBi+XWB
         Uq8tRvztBpIWPU5y7mg1p/1DDdKr5mzqqMlMoHAWu9IIwaflG+Cu4MBs3VsN0YwyU4lJ
         IWHCN/q6RjJuq7c2OIDMTixDG0i2wyYVz2QA+LgNe4KbS4QuVOpMshsaqI/D4alnWwcA
         lntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=u7lcW4Bg683HfDSH1iijL+2r4PqGfhjxnDSrzqJPet0=;
        b=u+sHGdHHF5lb720GuxGTaPF/qpPPw7JudYeN5Fsi4sPRnH92bh5uMCRuF0ds6kbI0V
         TAUnbmpfI7q4QJGviYSDfYKfax+ELDcXqxCprazdZS0818/MIF9zQFCo08OsG27dlwyA
         DVi05ILvMYtdbHhMSi8TufPT28yc2j+6DBWdu/PIJtf4OiB7q1F6YZmGMNJFMAyWkmnv
         wKiXgKvwgN6SniuzmOtpgjMG3u4ymG4VoFwpIht07NDZWdIy7SnvgcaMHShDyoKyTIFP
         lEz3w2J1se1C/IpM/b3K1MC9jTu+atG/kYZnzOksCAj+fNN6llZnLuJVhN+67Driwe95
         1elw==
X-Gm-Message-State: ACrzQf2QETwUyjyizDsp9FVMQHbXzGRevpa+RTquywmNl/ljlh1fUN4U
	clgSFKx5ZUGnrmyGe1sS/Glo0Cwr1lLpGg==
X-Google-Smtp-Source: AMsMyM6DDryVdX+/VbgU73UQPGeKOPi9+U0t6S1WNkLcHqdHzEOEwHZFBymG0Jbhn0UpjioaEOBYkA==
X-Received: by 2002:a05:6a00:1346:b0:546:ff1e:26ae with SMTP id k6-20020a056a00134600b00546ff1e26aemr3188028pfu.45.1665036717194;
        Wed, 05 Oct 2022 23:11:57 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.12])
        by smtp.gmail.com with ESMTPSA id bd12-20020a170902830c00b0017bbd845c17sm11398046plb.158.2022.10.05.23.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 23:11:55 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: mathew.j.martineau@linux.intel.com
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v4 3/3] selftest: mptcp: add test for mptcp socket in use
Date: Thu,  6 Oct 2022 14:11:22 +0800
Message-Id: <20221006061123.1474224-4-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221006061123.1474224-1-imagedong@tencent.com>
References: <20221006061123.1474224-1-imagedong@tencent.com>
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

