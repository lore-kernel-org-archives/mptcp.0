Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC902F3B
	for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 09:20:37 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id d9so10261131wrb.11
        for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 02:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681291236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TAQjicgVP7wqxQ8Cn8cjgHvnZfLNLlLzvDBKDNrU2qo=;
        b=6Iut8u4XNAsz+/+rX2WZFirmbhLCS7/C4WYZ5YtVkY4H6OHx7bB5jg5oUi1h7H4Pfk
         hJ4YX2oZjPg4hHYQHur7ZmVRV5byJaHvKPF3Mg5QAwDuXONRKnsR1OzlyeCIS+M8MtMH
         3y+LntZ70Yw8hP7u80RA+5jFhX37vALs+SH+ybCWARtTA7PzeMs8M6HJuxqxi1/p6Ztn
         MhGVyOOvwKpepWpl1/DOoKX3NTWu6sNAlHNiQXAuQgWZ1nbPvbr4mKxDSO1PTG4M0ACS
         fYaL/UkNr/6k9Rh8LIB5uJzahPtuS/QCWMDbcvCGhn6AwmWsdtThnzq4XO2+5IU7svcL
         txmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681291236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAQjicgVP7wqxQ8Cn8cjgHvnZfLNLlLzvDBKDNrU2qo=;
        b=JfB1HGGA0+dcgI4iYnQTlRTKqgHm2NFdwCi9IFKlCRYNC3MnEUSHJ+mban37YsOLhK
         shhJ7FGlM+s22qLvlvTCfcEzgi2wvqAOEfk3S/gD+MRSZv1Qn9RkuQ/r0IMwU7OKmVWG
         oAqVknAD+Dz8NcXJ+FUl9v+uVLXpjJUfxo8aFwaQtOOu4UzEDRqY15s6OdBdaYHtMjMm
         CfPIrmuzPVTVI00njXjmpEKPvedt72LYChzEvWvmKrITkeialI7HRag9KYihzhJmefTK
         sDU8MIQy2jkbEsB1nN+Ux0PcZ8mCDRQJIKGUR4wchy8fBEmeSsqUDiHokEEZnFvQo5cj
         SIfw==
X-Gm-Message-State: AAQBX9f9V5VCrVr8zNDVPkJ23z2xh1z1+1bT1lknz8PJwZ5W8ScJW0cf
	WdpXDcUs3EocLAOAugU28MUMGw==
X-Google-Smtp-Source: AKy350azFbWQ6vfo0STwrVGrzh2nQ9l6MPaaLvZ2pBibQDUmUn/VLhRYivL7ndsHjgAPMMO5FefrOQ==
X-Received: by 2002:adf:e386:0:b0:2ce:a6be:2bd with SMTP id e6-20020adfe386000000b002cea6be02bdmr4301939wrm.1.1681291235932;
        Wed, 12 Apr 2023 02:20:35 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id k1-20020adfe3c1000000b002f01e181c4asm8981069wrm.5.2023.04.12.02.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 02:20:35 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 12 Apr 2023 11:20:12 +0200
Subject: [PATCH mptcp-net v3 1/2] selftests: mptcp: join: avoid using 'cmp
 --bytes'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230404-mptcp-selftests-join-busybox-shellcheck-v3-1-eab5dd7bc996@tessares.net>
References: <20230404-mptcp-selftests-join-busybox-shellcheck-v3-0-eab5dd7bc996@tessares.net>
In-Reply-To: <20230404-mptcp-selftests-join-busybox-shellcheck-v3-0-eab5dd7bc996@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2523;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=Qqv4VPDAvCc+KPNEC0MK7+YIobeMOVhGeL61CItDkj4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkNnfikwyZqU7OyJsew1Fk8t2a7kElw/1c7LF51
 0Kxi7Ecn5KJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDZ34gAKCRD2t4JPQmmg
 c00iD/wKKRL7eZR74toOKjJzAqQEWajGgOqEmjCWt3Xuok5dhxKvg/8kGB4rNjqwEwcwpSI4/vo
 9jROXWKH6YkLiUQHliFuxSmyVqqBwSKm2EJOz5DB5JW8u+00yZZszqiCHXStYOXw+JrAueUId98
 cyGN/XNaW6/SToJKtJ7yupU9RlIzS9MQZirsd37mEcvFmbe/chgqDKTgR7KN6jtX0cGzZrD91YF
 DeL7ROqSoPWOhkvwp2qrpQV1qwmSwxBuicqIT4x68KpT3HOT5l/kkIqWpCv+sk4HqcrG7QHV3Jm
 nILLjelt8b9cCAlfB61f07tMz4Pk5OeNlqBksAJEj9Yu351+5DZeTAs9MtQD3zRo8pW/NoDLGIh
 9bMm5mbZlC3/YEIR9pcSD4aY2g7eUSBaH4M0WlmEhaD6iFYkRhi/QCGP1xcNz+EtTStAhfvSXLq
 X1De/lhMXnLmg7PWwjQk2FefvUn9jvRNPzvKm0PbTBmqmKynJhwMgYd/mbpd8gf60qoPxk2UmDP
 YiN3AgUpxSVk4ElwFTNiAkA6zT2F3+D61YY65EgEu2cY04sWs89JCsg+fS/jDV7JVsjo5ELexjf
 P/Jcne8RUTOcx77MUFC58nSRXA4zNhcHlcNz8fNoyoZGKmR4515fv3Yk+3o1/VlT0TUd4zE84Jt
 N7Y42/AkZXk2H8Q==
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
BusyBox. A temporary file is needed for this operation.

Because it is apparently quite common to use BusyBox, it is certainly
better to backport this fix to impacted kernels.

Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose test-cases")
Link: https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.3-rc5-5-g148341f0a2f5/testrun/16088933/suite/kselftest-net-mptcp/test/net_mptcp_userspace_pm_sh/log [1]
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
v3:
 - use a temp file and remove it in the cleanup phase (if we are really
   unlucky), from Paolo.
v2:
 - limit the input file, not the output of cmp...
   (strange that on my side, I didn't reproduce the issue but the CI did)
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fafd19ec7e1f..555781826289 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -13,6 +13,7 @@ sout=""
 cin=""
 cinfail=""
 cinsent=""
+tmpfile=""
 cout=""
 capout=""
 ns1=""
@@ -171,6 +172,7 @@ cleanup()
 {
 	rm -f "$cin" "$cout" "$sinfail"
 	rm -f "$sin" "$sout" "$cinsent" "$cinfail"
+	rm -f "$tmpfile"
 	rm -rf $evts_ns1 $evts_ns2
 	cleanup_partial
 }
@@ -378,9 +380,16 @@ check_transfer()
 			fail_test
 			return 1
 		fi
-		bytes="--bytes=${bytes}"
+
+		# note: BusyBox's "cmp" command doesn't support --bytes
+		tmpfile=$(mktemp)
+		head --bytes="$bytes" "$in" > "$tmpfile"
+		mv "$tmpfile" "$in"
+		head --bytes="$bytes" "$out" > "$tmpfile"
+		mv "$tmpfile" "$out"
+		tmpfile=""
 	fi
-	cmp -l "$in" "$out" ${bytes} | while read -r i a b; do
+	cmp -l "$in" "$out" | while read -r i a b; do
 		local sum=$((0${a} + 0${b}))
 		if [ $check_invert -eq 0 ] || [ $sum -ne $((0xff)) ]; then
 			echo "[ FAIL ] $what does not match (in, out):"

-- 
2.39.2

