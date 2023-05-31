Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A250154AD
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:43 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3f6a6b9c079so44037185e9.1
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542601; x=1688134601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/NL1S8lhGJSEixGTC5s2Q7QQBHnjZlVf6Vv3vuuQfYU=;
        b=2KwKA/Bypyr0hXt1sr2eR87C/KTF8Hs+b/VPRSZ8ti/3o1xRyZhfjvGh07EIkQSRYt
         A5/F2kIDeGRNdLdIubvjiWQiyy+E9pW6C7AutjaI5GKdDvfKOSlaw+DG72zBa6VwMihc
         ucBGGKJforcsDkIKHIaD3BC1r8N14ie9RN4InXIGUce2E2JzNyConlcHB7GwxEr4vaql
         oZCDPLhQ+DPZmg0n5kj7O3uHtCTl8YyaDDGiOxYI8tx7prbNXW6JRlGynd7X7YDtYK3v
         qUJ44EqLoGz2CIbjIjxgbi46BYGh7JQ97Ig+wzjbIknjxDtnkxKe45RUJ5pOBviDx7BL
         kPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542601; x=1688134601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NL1S8lhGJSEixGTC5s2Q7QQBHnjZlVf6Vv3vuuQfYU=;
        b=FhzLPy/vgCJobS1Cdloujnv6A7Pgg7006ttyKJMCE0iruuKvt+T3BL5j7a7ieivpD6
         nQM6q5HTR0YB/zX9hsLSW/JfVkWUgO5F50evib8bF156cvmZ2tUB77xLz9gR9Mo0EatP
         jWrnFnAgekHEn945kg6aFTGiuxr0+nP4YrtRH+UlKO9Pr5NraSQ1Ty2f8zqA8p4h5WUt
         lpnKMXm6AIkC6DpEGMEnKzJ+vQW3IEKNj2s4tCGYJRHhuNermDbhEFF9sKlO3uFqlWkA
         Nm4DgW9AFx1fc8cQvZGeLV/6QOndH+CTsg5qlDL1nMjK74u269dg86RPWXoCOW7hPN5X
         rXXA==
X-Gm-Message-State: AC+VfDxwvXZkibdmqIimnVEuafFdDZ4UpBotN7STudFg8ZHUA6ZF7v1L
	p+lKYPZgdq0pbnduhs0JgJ3NWw==
X-Google-Smtp-Source: ACHHUZ7akZ5hK8FmYIfWvFVIdRUsQaAHQygQfEk1NMemDJ5sviLquTBgwuSifQDVGe/uBrCRQHzqgA==
X-Received: by 2002:a1c:f710:0:b0:3f6:683:627e with SMTP id v16-20020a1cf710000000b003f60683627emr4389705wmh.9.1685542601452;
        Wed, 31 May 2023 07:16:41 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:41 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:26 +0200
Subject: [PATCH mptcp-net v3 06/32] selftests: mptcp: diag: skip listen
 tests if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-6-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3528;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=sdOYUwFaHFIno3mXaLEHPDrsSyqWajIe21G6Vik4cT4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bCdxUff7A7E3hXfwOkFkL/VYstwHbh/GL3m
 ZHCajye4biJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwgAKCRD2t4JPQmmg
 c+sSEACSsbBRyijhYlnaBcQSoOok+jYiONCm5G6CYPzLiZPGWW8iz2eQN3MnQIguPSBkM4GR0Sv
 skNFqO/r6sYt0Lv0SkVsAvAHRqBNdG46QRQluAA4AHMDCTmnZ31Mzjhrha/kvqCUDNCVXlJsDVs
 zsh/ljReAcjbtEZPpCvQzMWevuHUEe0cAxWEDw2j0O5BLNBWdeZIfC8UCm/+5tQVBzfJh7Ns0tL
 KIFE0p33wl2pNdHzeSIhI1NC/3gEHVomQLriWJFR8YNEtDA7+Rs2Hw3Rc0cM6Vjpk545rxMwXMX
 C+XbQUk4JIrKp2KEsR1WW+cqhsl0QpaTOb8E0zK8RJ7ondedauSI9vvBh44eri/qiDIXSZHr9lD
 fQMc4dp0d3lAWqJDBEcSI0hCd0baV37xm3BofRs0tL8p8QsFbuwr+ejTiowKO9ksh8fYMM3WYXv
 Bo0+bxnKCRAoTlFysPswKCk0lfCvD6+YWhVRL4iquEYnMkIWLa/koW+9SI+s7wYkcDgWAOh28op
 Jg4TbakQ+Ug296pGoGCrDy7PCarlxYakWmb75cK3teMDWpQWm37amRhLHR7IU2yQ6zNjJ99/wdt
 UPjF9iFyEuIUQTD1rVgcwnunHWGJ7KI8+u6pjrVgNLa1GJsp0iizz0wIA0to//8ZffFKp/G5OOu
 KX16ES/JQmpMOwA==
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

