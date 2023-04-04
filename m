Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F65BA40
	for <mptcp@lists.linux.dev>; Tue,  4 Apr 2023 14:56:17 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso1028461wmo.0
        for <mptcp@lists.linux.dev>; Tue, 04 Apr 2023 07:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680620176;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOafcJFrWtZ47jdzTypArQ36sYijAijwBp5l4C9k1HI=;
        b=Pd+5eqUkNXAmzVgqRgSTXr5Qmj9Z9HdOswBfexwLI313Pq6g4SS1Z8+J6nQWu5eELL
         d6y+uSAY/GHAptbq+z6lfzRcM8inQm2uhnuvgcgy2dSfAaS9FNKFKARfFBrICLyvfA3P
         Y7B6qPe/mErTGiHA4I8QWPHTw5OrQQ7F6kGj2o+qTGZHT3MpM/T9u9iVWpspAM4800Yy
         FvjNLKXDNaq4jhCYRyytSF7tLQJrSnMPV0S6g6+yh2O94YtsLduIcQ/aODSlpRn+Ji6G
         /HosvU6W4g/lIadStlE2Oi6EaGmAc1NRCigmtasLOQ/DfFdH0NNYYj94UX2pIvxNgeZ6
         AMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620176;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOafcJFrWtZ47jdzTypArQ36sYijAijwBp5l4C9k1HI=;
        b=zKi6h+BkNL1lU7KDQZeCERn7kMWQEVHWO8WEPN+zN4D5h7onaupsvjXih52nmUuu/x
         RqM1iq8U+5Ft52nIE4/t14UN4q+Oo98kRYHfCHcguRjQOT2dQBJy4J0OO8oPGhrNFP82
         x1yDXCL+rKTwHxT0JfUd3NrGzJRs8MFkpV3NwYgvcoLD8gCoi1kB1ib97Sgmv2sp3x2y
         Yrre99p9YvCDMJqciSEVugHVjbkr1EFcqLVb+RjhheEMMpdPiaMB7odNigMCIAmgq+VS
         PogVkcXObfVfFhJL3T+odt0YTjg2+x82KXBpWYEMk8UdYRjGcIhYnxM5HmiIisqtMuee
         Jo2Q==
X-Gm-Message-State: AAQBX9e5nUPNZTDdoOoqZ4drrDkLXH3N88w8SNdEmgbu2wuLevEV5JQq
	ZEOiKf6fGVakF+S6VdpQK10LuUJZYwXMHgHBRoKVQgGm
X-Google-Smtp-Source: AKy350Z27ADkB/03IkS1twpRVko2fEhodQjfnAZ3y9NnYs8dhDSvKCMjnzrby2seb6bwse2+1KVrsw==
X-Received: by 2002:a05:600c:2193:b0:3ed:2eb5:c2dd with SMTP id e19-20020a05600c219300b003ed2eb5c2ddmr2327694wme.39.1680620175979;
        Tue, 04 Apr 2023 07:56:15 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c228300b003ed2384566fsm15413333wmf.21.2023.04.04.07.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:56:15 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 04 Apr 2023 16:55:59 +0200
Subject: [PATCH mptcp-next 1/2] selftests: mptcp: join: avoid using 'cmp
 --bytes'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230404-mptcp-selftests-join-busybox-shellcheck-v1-1-65892428a951@tessares.net>
References: <20230404-mptcp-selftests-join-busybox-shellcheck-v1-0-65892428a951@tessares.net>
In-Reply-To: <20230404-mptcp-selftests-join-busybox-shellcheck-v1-0-65892428a951@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1841;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=IDIhASqB8al/uYlZWN2Gskqs9lKyFSbiKuIYVKWYEsM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkLDqO1PjkW7O/aZAb8WaPOV76M1cSUT4q8fvAH
 Qpb7HbJ2cKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZCw6jgAKCRD2t4JPQmmg
 c8iOD/4jr5eFgCK5ZQ86S/pfvGYuKnIFY0iJDfEC7dNr3RPRHpPcWW/TwkfLNqnUbn7eHmv+/Mc
 4PNJuao3yyTkfq8+TEQgEhzQWfgBVrln1CkT4BInakN/MEQo+N8cngZIMpSj1+tDsvFjiVjIdJU
 U+T9TN/ugTYdxl0wcmCdE69mGr1tIjY3utManmbzecE1UDAw+31Qasul4j8OQDtbctcFaTCK/7h
 tP3nlIydEyumexGBwCWanYL2IOQN1s27bmX+0k2rbiJD9YuC6yynoUIyUbp2wafRJyFyRwfqrgO
 2a92BPp4V+c3KagaoU6ZeMocK0Zs060BMdImFkxG6TJHuAG9Uybm9f9wKDcVO7gTBfVufZX0a2C
 +EZrlLT6KvWVhlo3m8DhbY7gAPLBbWr19XbdEbAz3NVVKuPoJp7i/dkrATLiNGscetSEo+BSy/X
 wV0LYdWXpQOLekX0GoegDzzS1FO0SEUJAq/52tWYYZUhlurIPlGT1pwcjFKUzMkKkvrKEQJpHSC
 +zAKH0+xmhG7AXe7VQLmRMxOr86mVfitHtTNmpIuJVGxlLVgLIe1ZaRAJnNczrPyAfptKPFYt/A
 awJ2mH2JFWGleT6bzaq8GFylXFPDBNaUa5P9utn2DyifWxoqZRBZPmHh9e4Ushtp4RVjgqNRiHw
 oWPYyjA4Q1xO5vA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

BusyBox's 'cmp' command doesn't support the '--bytes' parameter.

Some CIs -- i.e. LKFT -- use BusyBox and have the mptcp_join.sh test
failing [1] because their 'cmp' command doesn't support this '--bytes'
option:

    cmp: unrecognized option '--bytes=1024'
    BusyBox v1.35.0 () multi-call binary.

    Usage: cmp [-ls] [-n NUM] FILE1 [FILE2]

Instead, 'head --bytes' can be used as this option is supported by
BusyBox.

Because it is apparently quite common to use BusyBox, it is certainly
better to backport this fix to impacted kernels.

Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose test-cases")
Link: https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.3-rc5-5-g148341f0a2f5/testrun/16088933/suite/kselftest-net-mptcp/test/net_mptcp_userspace_pm_sh/log [1]
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fafd19ec7e1f..b0b0931379b3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -378,9 +378,12 @@ check_transfer()
 			fail_test
 			return 1
 		fi
-		bytes="--bytes=${bytes}"
+		# note: BusyBox's "cmp" command doesn't support --bytes
+		bytes=(head --bytes="${bytes}")
+	else
+		bytes=(cat)
 	fi
-	cmp -l "$in" "$out" ${bytes} | while read -r i a b; do
+	cmp -l "$in" "$out" 2>/dev/null | "${bytes[@]}" | while read -r i a b; do
 		local sum=$((0${a} + 0${b}))
 		if [ $check_invert -eq 0 ] || [ $sum -ne $((0xff)) ]; then
 			echo "[ FAIL ] $what does not match (in, out):"

-- 
2.39.2

