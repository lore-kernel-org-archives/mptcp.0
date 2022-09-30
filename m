Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228491841
	for <mptcp@lists.linux.dev>; Fri, 30 Sep 2022 02:50:34 +0000 (UTC)
Received: by mail-pj1-f66.google.com with SMTP id v10-20020a17090a634a00b00205e48cf845so7698238pjs.4
        for <mptcp@lists.linux.dev>; Thu, 29 Sep 2022 19:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=u7lcW4Bg683HfDSH1iijL+2r4PqGfhjxnDSrzqJPet0=;
        b=XVab6/G3g387DoKsvIb2mGZESZdQhduJYCaNyKz8mkJOnnSYphHKFLzc2U2H120mDx
         ex6RuqhAYy0rZcOOwPHEsyTANCJUsm2Nj0x+hleqSiZ1wFOJ2ytJuge8ag6xYMOQI/i9
         iHCiYUBXWIcyc19hCobT1T/kspt/ChcXq6rHZQwPc6uGpHsHHjzLDUGKz0kpP8+Ds9bj
         5XPZrU/c8OAcY6+/XH5xxJYOdBARk7KWLt5WP1U9GjSPtv0yDyP4fbKLq38eOJl5gcZP
         ChKvsiq4WwDdi8ou0AfkyfOoliVAiApAb6OzvFiMK8yhcOoG7nA9R9CzPKEjQtuDqSmG
         uL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=u7lcW4Bg683HfDSH1iijL+2r4PqGfhjxnDSrzqJPet0=;
        b=h96TStuIUYWiXRP7wXsuL0Wkm+yy4Q1xv0+RXl/dJPTXgvL+zZj0RVMyMDNTf9JdeL
         cGnZqri04ZbMRancFI16LbV/Zo+01+bHEjnWFGoqvYwE43YB9kU42v4k1e7glBVDmXkR
         n2ErvsiqArHR+255zqcJ4Y3y4c+I1N1JNGHg/ne3UJ7E0jhB2KghN0QkoRE2PHGdKPJ2
         Wmjwwf39ndE9ouSAz3/sJvkXnMPMqWMwzYRAoKjE0Fmp5TJGWty4nYzpqNhYTARFXh1k
         dYV3+jbLbvmjVY2+Uy1a6h8GIjuNqjIRuUnELXYTwC74D+n2BSJFlgllvKk6Uu8DJKi4
         9CGA==
X-Gm-Message-State: ACrzQf0NweSM5SKE3LpagEtx1UPPbX94CS0OpLvlmyzD+aPw9JvQBSZV
	LYoFbUd0lWXayncx3gCFP/M=
X-Google-Smtp-Source: AMsMyM4ambssZ5Dlj+toRrL16o1Wa24PsyqAoEa0oCBkElMXjUZwnsA/rPPe6COSVtd4cfvB/J0YLQ==
X-Received: by 2002:a17:90a:948a:b0:209:7137:3f3c with SMTP id s10-20020a17090a948a00b0020971373f3cmr3035129pjo.245.1664506233599;
        Thu, 29 Sep 2022 19:50:33 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.17])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b00176d218889esm606911plh.228.2022.09.29.19.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 19:50:32 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: mathew.j.martineau@linux.intel.com
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v3 3/3] selftest: mptcp: add test for mptcp socket in use
Date: Fri, 30 Sep 2022 10:46:07 +0800
Message-Id: <20220930024607.128202-4-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220930024607.128202-1-imagedong@tencent.com>
References: <20220930024607.128202-1-imagedong@tencent.com>
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

