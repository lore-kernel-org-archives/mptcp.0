Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443A233E2
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 16:39:00 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-30e5b017176so627179f8f.1
        for <mptcp@lists.linux.dev>; Thu, 08 Jun 2023 09:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686242338; x=1688834338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lx8RcPnsVd4tQ/K/CCVK2jyjdwYbBjaw/JSTSvRmWqQ=;
        b=uQbFKr4IVFManhEASa1+kCUmK2jgfq7EwASEjIkv9CUL+jFsDhOkBYbVcYUhaRYqp1
         +L4y230P4eX3sa/wdNWNrbh9q/IRnIG8gEYmwcOIXxXUgMI9wSAkMGuD/aWTLfpRm0MY
         w9CyEukdLp/Bjcji9FQCYdFQZOq32d9OBW4NnZXo6bb2JLOFMTAs+zd/U7Jz/3zZUWAO
         d30GIiEKDUo22bfksyDVkiJIXPhCeAUq6dvK3MVY5DRaJ2fOPTg2PoJShL1bjSNQgbrZ
         1kNl8obdM8T7LJKUUALd+EfsAZbTHOw2XkacdCqTAHkdPXGOMeA3e5EjFSYhPSUmqrh4
         JkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242338; x=1688834338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lx8RcPnsVd4tQ/K/CCVK2jyjdwYbBjaw/JSTSvRmWqQ=;
        b=NIhKBwonv+Xsm4prd6MTV67Amj/U3dEz9hdC59WgsVE2Xbbg05wamHgeLh7SlQl9Fk
         p9MQozSeyZLtEn4vbU5P6SrSkTj+CydtYgyB8tULkPMK+IUJLm1u+QjIgQHRR0/igeYF
         Q1bHe5caYOjr6aUHYuPjZuGG7orFFxGQmz+S3l4y9FjvMsgSQvZbBe914ltrBmliA2bx
         ii1fpZ6FQbsFDU6RVgQHVqCDViGXneDQsfkM6ShiEAL/Q9Noi0cXrNECKst5rkPMDNbA
         BhLGE8XbXCbbIUDOrXE8rV2J7YemnXz5mXPnrv8yH0ZeMLU6ucbp3nhdZvoJbpmrf83o
         wLTg==
X-Gm-Message-State: AC+VfDy+W1X2RzjSP7nae7U0LDHiO/qr20Siwbr1uA2BLtvX2dmHCsGX
	Qxav59ZwBn8pB7ICtyaTlv3vdKKJizRKmklCpEz+vw==
X-Google-Smtp-Source: ACHHUZ5Dk7yiYEDIKc9t4hy5u0PORbw0qZgBFBfIZg0+6XMoeV+zyUzD95h/zc5Fc41tgQUoMEmrXA==
X-Received: by 2002:adf:ea91:0:b0:30e:5b10:6ac4 with SMTP id s17-20020adfea91000000b0030e5b106ac4mr4489672wrm.67.1686242338468;
        Thu, 08 Jun 2023 09:38:58 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e13-20020adfef0d000000b0030aeb3731d0sm2038215wro.98.2023.06.08.09.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:38:58 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Thu, 08 Jun 2023 18:38:47 +0200
Subject: [PATCH net 05/14] selftests: mptcp: diag: skip listen tests if not
 supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-5-20997a6fd841@tessares.net>
References: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-0-20997a6fd841@tessares.net>
In-Reply-To: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-0-20997a6fd841@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Davide Caratti <dcaratti@redhat.com>, 
 Dmytro Shytyi <dmytro@shytyi.net>, Menglong Dong <imagedong@tencent.com>, 
 Geliang Tang <geliang.tang@suse.com>, 
 Kishen Maloor <kishen.maloor@intel.com>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3556;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=opPOIne3ljEGSqeLiJ1isp//Fw0wv+108k0GKT5anpY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkggQZ5Cp28T3EpijYaDimGWGlH29vVrPeDSxMO
 AMRtatqYI+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZIIEGQAKCRD2t4JPQmmg
 c0hnEADX7xf/Ss/QTm8ym/KshWMYeE7BirkRZXwJ050WxldqeJEFq8WHIWdWp5QNtLXm/xBq9wk
 VUQW0dZKdYle2I5x6Bjuqs9an3zHjg2wffDyvzGsP0VApPxJX3w8eB6qaHvOkcQv3xs/ALsvti3
 RD6gNNXrGbb5ImETdm+kaE6o7C3CtHgyJTT9axkbOxv1mp9edN5l2n445NMv6LVfSPHmNPCMNOG
 MmH2OXBTtnjKJWpHzaa87nxznlBJQR/7HTk3Ntub0t0ga0vNa0iifpAvyWo2ThxxjP6MK9rgQEl
 qKXsHxeVujNhtTAQygQeXltgCDH7rueoYtSS0MXFPFM1G1Zxa8U7W9H2yqc/u2ukSdRA3NThWpr
 j1sALhQGAx48J2PN7Vc9LltXENRJnNShwOkv+i3cRCxui9dgt1sLeDYzitgdzCeQfFqtLBXLsK+
 QKAUKLHXRlLit/WAXXThvKttb2Go4ICvGyEqpPYXYgK3LHRE+MNSnzdoL/jfYMgdlYN/sCit/qa
 uJWMbH4NWRN/Ve1++iAuHCt4mIxj+F/nja2XenQEcObSnRSF6xEPOSuscaiLwPi0xd/JNP76msB
 g0CSlMuz/uMVD36+bzHVj1LdZvAIeagFEOBq5uFLqqHOzmo+WZ0EwRh3liAGhFLi5mEMdHDv993
 BRNFNDahii3ac2w==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the listen diag dump support introduced by
commit 4fa39b701ce9 ("mptcp: listen diag dump support").

It looks like there is no good pre-check to do here, i.e. dedicated
function available in kallsyms. Instead, we try to get info if nothing
is returned, the test is marked as skipped.

That's not ideal because something could be wrong with the feature and
instead of reporting an error, the test could be marked as skipped. If
we know in advanced that the feature is supposed to be supported, the
tester can set SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var to 1: in
this case the test will report an error instead of marking the test as
skipped if nothing is returned.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: f2ae0fa68e28 ("selftests/mptcp: add diag listen tests")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/diag.sh | 42 +++++++++++++------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 4eacdb1ab962..4a6165389b74 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -55,16 +55,20 @@ __chk_nr()
 {
 	local command="$1"
 	local expected=$2
-	local msg nr
+	local msg="$3"
+	local skip="${4:-SKIP}"
+	local nr
 
-	shift 2
-	msg=$*
 	nr=$(eval $command)
 
 	printf "%-50s" "$msg"
 	if [ $nr != $expected ]; then
-		echo "[ fail ] expected $expected found $nr"
-		ret=$test_cnt
+		if [ $nr = "$skip" ] && ! mptcp_lib_expect_all_features; then
+			echo "[ skip ] Feature probably not supported"
+		else
+			echo "[ fail ] expected $expected found $nr"
+			ret=$test_cnt
+		fi
 	else
 		echo "[  ok  ]"
 	fi
@@ -76,12 +80,12 @@ __chk_msk_nr()
 	local condition=$1
 	shift 1
 
-	__chk_nr "ss -inmHMN $ns | $condition" $*
+	__chk_nr "ss -inmHMN $ns | $condition" "$@"
 }
 
 chk_msk_nr()
 {
-	__chk_msk_nr "grep -c token:" $*
+	__chk_msk_nr "grep -c token:" "$@"
 }
 
 wait_msk_nr()
@@ -119,37 +123,26 @@ wait_msk_nr()
 
 chk_msk_fallback_nr()
 {
-		__chk_msk_nr "grep -c fallback" $*
+	__chk_msk_nr "grep -c fallback" "$@"
 }
 
 chk_msk_remote_key_nr()
 {
-		__chk_msk_nr "grep -c remote_key" $*
+	__chk_msk_nr "grep -c remote_key" "$@"
 }
 
 __chk_listen()
 {
 	local filter="$1"
 	local expected=$2
+	local msg="$3"
 
-	shift 2
-	msg=$*
-
-	nr=$(ss -N $ns -Ml "$filter" | grep -c LISTEN)
-	printf "%-50s" "$msg"
-
-	if [ $nr != $expected ]; then
-		echo "[ fail ] expected $expected found $nr"
-		ret=$test_cnt
-	else
-		echo "[  ok  ]"
-	fi
+	__chk_nr "ss -N $ns -Ml '$filter' | grep -c LISTEN" "$expected" "$msg" 0
 }
 
 chk_msk_listen()
 {
 	lport=$1
-	local msg="check for listen socket"
 
 	# destination port search should always return empty list
 	__chk_listen "dport $lport" 0 "listen match for dport $lport"
@@ -167,10 +160,9 @@ chk_msk_listen()
 chk_msk_inuse()
 {
 	local expected=$1
+	local msg="$2"
 	local listen_nr
 
-	shift 1
-
 	listen_nr=$(ss -N "${ns}" -Ml | grep -c LISTEN)
 	expected=$((expected + listen_nr))
 
@@ -181,7 +173,7 @@ chk_msk_inuse()
 		sleep 0.1
 	done
 
-	__chk_nr get_msk_inuse $expected $*
+	__chk_nr get_msk_inuse $expected "$msg"
 }
 
 # $1: ns, $2: port

-- 
2.40.1

