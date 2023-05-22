Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE12A13AFB
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:20 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f41d087a84so26977605e9.1
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773500; x=1687365500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/NL1S8lhGJSEixGTC5s2Q7QQBHnjZlVf6Vv3vuuQfYU=;
        b=p5cRPX6kWAqcN7E9BaxsR2MSAMf2yeBzHy6utCWbw3Dzf70CiDRIOfoL4jHCIUl9WC
         q6e4dUoYozUjXzDbxfanKOTttJ78rB5FXprOmByipCyujRJO40O6TE/M/6qj88nHJux+
         0ZxFvdK2UlM9oTzJOZfKbfMPBSci+zYUj/3vcQj6TJO5yfVPn0CZJiGp3M65DbivJqu+
         9hWpOw1c0e8baAzD0NYxwhDjUSIAkiWVuXeOSNtbt8jqBs+1/8KoHmZd/hAkYyUtPmNu
         L3sGKO7AkYCUUNValz7FkV9HvXrROczNR7OHqGwDldMlTEWzAg2+k6pi1VsTwgvCDK45
         h28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773500; x=1687365500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NL1S8lhGJSEixGTC5s2Q7QQBHnjZlVf6Vv3vuuQfYU=;
        b=iiJO3hlbyonoMD5LnRF8YwsouK7lU3oBplzNE6dcUDOW5UNWIbmV8ItiQujYXdTLRA
         UVe5n80q5pqCeou6sIKrE2a23Fv6lagqdiMH9AlQvBvoqE7+p/RXwPaZCj0eBHCLT3GV
         kh3ZqWyTEPUaEZagk6KITIC82g0N69r3idFxGkOgZWnoFscGxz0lG1lEu83STcapJQNO
         kwpm/iGXPZrF14Gi9SSbsLYbrLdzBy0Vmup+QsQfZU63TAC1H2i0v4pPCZxVzj566+Iw
         zyG+jTWk72sCP4HbLaHeUNVqcSrnJF5e81Wim1mdcnH4WyR6gaJFfGVrAZQ8E3Y8/Hu0
         Hliw==
X-Gm-Message-State: AC+VfDzvvu+H41+eV+c0af1D5tV2gFeQgTIz8PtORCqFTC1YdVEKrcs4
	7ENSKyi/PhvTEaaWwXuHzv2Vvx/Dff5JPkyLrxRU/g==
X-Google-Smtp-Source: ACHHUZ5g3XFIdEahbDxgsUaPJnfQqJP1j+Q+5Oldnrw7WQqYqhfHochbcSJhBmMSSAe8pB486FpLGQ==
X-Received: by 2002:a05:600c:1da5:b0:3f1:6fb4:5645 with SMTP id p37-20020a05600c1da500b003f16fb45645mr7999880wms.1.1684773500250;
        Mon, 22 May 2023 09:38:20 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:19 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:45 +0200
Subject: [PATCH mptcp-net v2 13/37] selftests: mptcp: diag: skip listen
 tests if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-13-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3528;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=sdOYUwFaHFIno3mXaLEHPDrsSyqWajIe21G6Vik4cT4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pw/Hd/2k7sTTYuqwLPGqQRIEBZdX73fO6Lc
 vxrtD1SopmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacAAKCRD2t4JPQmmg
 c3YeD/92eoFi35kj5c5YpagaOV8hCe0sJ+hDPyCYsqoYTqmrq4Eh1OPOqqThHeBDKbGvJBMG+ly
 uTET/f8Hee0jbnVDMKf8RYW9rcSK4IyAoRiidwfg1yV7+b62flOyZQJsqjZHpFlcD9F9Ws3y7WT
 ZT4KLltiG9LtgoT5xVPu+KaezYzFhnxBSyKplo5thwUz8J84p4X0lDk3hxJQP5RS14WyncTPagD
 D01xpJ1VysszgD0SMZRSQ8UvjU/ImcKsuM8HOb4BPq4Qa32Sqpp5zBtc9LIj74dCgOkJqLjQdQC
 U+5m2OfjpvLgMaWaSjnf+xlOP80AlZXODyxYpp+9Ux1NKi3sz2S+2IdlourRbO0Y0udznQrkeoO
 713sIhp7p0Kh2ESLWXNY3ceYurSUBDBE4TOuqrR0O9Vd1ZP3kbzPvse/0R8xE+lKHREAuZIBvAA
 rp1IlMtajK1LUATf+ameUj6BSw3ZzAUlCsLIpT7ZBrWHZyYwEiXZGGcyOXpoBtIrDtRjLtRDGYH
 avo2FEJhioYYPy1GKWYmAGD874PO5XB9O5HET07R35SCVR7mf1aqqufnWk25KX+iqoKaVeQTc+g
 sxqlOhlaAVuOVCd6goP08SAtYEPeNEnuKYXQv5Or1OCgC70lSfZVJH+7JTEPNDRrVJ9nMqbrus7
 Xgm/XHxxS7IAPNQ==
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
2.39.2

