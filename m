Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B36513AFF
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:20 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f603e0edddso10770995e9.1
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773498; x=1687365498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnJxfMUTO5gcRlmDsQkeCcD8aTThO5cJ7ycW9Ep4zqg=;
        b=iMQ0J8nyykycl51vQlibviwr7SEvINbHtlCL9RQqYWxJQfF9syXi6RWnOkKo5eWAhl
         QmTzNfOo9olPYIPnS6EUhjDTGjS/C19/4XS24DfN2hYx/SFZGQQQV0Mpow2TzxneZCBA
         Gp99x/hY2EUTUsqZKjpAg7GEjc/m5dkHuhsNelWVX0DaRh6edePJXNZmwNwbBMbsuIUl
         S5/HbaSnQUERRYbIEgQJJk16D5ykvpW6lNfg88rxYAOq9qkn3bVeRRnoEpNIOeRlLuMU
         e665IIUctHKwQaGXh+397lSvvARmWpwx9LeOJeqyGp+JjSrg6DOnVM5ehtf5mDxnl2Hn
         9vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773498; x=1687365498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnJxfMUTO5gcRlmDsQkeCcD8aTThO5cJ7ycW9Ep4zqg=;
        b=CfTb7GY4CxDOlUoUoymLRhOci+ytY87jJFEdwS/ekt96I6vnbvBnVV0IJse24mYfBO
         CPzrFOIFyE+6OfHGgwSnAHp8pDne/TBwoOpbjnB6RWltmKZ0IB8yZ4CHpO9QtGKPIiQT
         jiC3jtrqJkXkDqstvHr7YSfPh1u6Ll0JpDC4RQJDoSMMMWi6dwz8qeAexbL1MRt4RDoA
         ZTVnFEstgBBjfMOx6PrsZoPnsmvjDq1hSLSGH626BaN6lpFLvMjt+fHIBy9rwENvjK/M
         soQfGS4Te+8ALoqEXK4BaAIa7WllMvSPonemqyxSS6EgRAGNhrYPKX7z/Q+MjrVBDO1S
         QVdg==
X-Gm-Message-State: AC+VfDy3hVT5lBFVti+6j8uq3LPi4sTd2aidjVmgyJ4yIMWjtuBB2E4l
	GcwtXVBiXL7l0mSTeYjaEa/XzKLkts++UX4ksnHMvw==
X-Google-Smtp-Source: ACHHUZ42PFb7DNY0DzG1CZbqY9+wX4T6H/6rm+vD0qjbDq7+W3Dp8iKGThGRHnon3gwPlK/KQeXwxg==
X-Received: by 2002:a05:600c:2106:b0:3f5:e88:ffc4 with SMTP id u6-20020a05600c210600b003f50e88ffc4mr8867701wml.33.1684773498318;
        Mon, 22 May 2023 09:38:18 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:17 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:42 +0200
Subject: [PATCH mptcp-net v2 10/37] selftests: mptcp: connect: skip transp
 tests if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-10-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1943;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=dPLQ8soz/4YFRDuFKxzIyZ0BiUCyf1h/70xYZNH1MFo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pvjEG4/CN45iqAYpa0Pi+gB1KSgTLca6ysG
 UX7g5Ev/U2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuabwAKCRD2t4JPQmmg
 c3opD/wOyfg62X0y0NEpQfI9qYEWtXI49fk7wM8qI9+uPK9loYXjMCArA5wD3UswYQIEbSHPWxm
 ZV4ybXJalSe+YXD1dtjAcYmddn/sT61+OzePlN8SNvuSgC2TanwrvEhOu/g/BSOuq/prS/RCqkB
 dciYQUDkk5rLioHCZrubWXDav/OqbrOI99LTEBh3q/GuONO2vcvPTZ3Pbux5OJuk8xhJ+z07XVE
 tGy/dnhmYSy9enpImcG0bltA92S2p4pAqEf1KZorapZ4G+jIF9mi5jKbDCfkicSarfD/LYZ58Ha
 wd3C51IydkWNaYLZ0kpJwS/zMXXqdjib5HyVM1EjAyzdlvJyD+XIA8Ax7Rw8XRML6mO+qDv/1kw
 Sg7ZvwMuGeyGN/vS9mBLV8iI2Pw3aXhVChOb5z7AFfZTcSX2qrPYR/6I6KhwSnpuqyX6GYBwqZM
 OfnSFxOOBqHF+GeJsUXzC7KJ1teYgiX9aXXdGUTGUrVxirZHTlSblO7G3mFTIVauxqgcy5aLyOK
 32+upu2C/CWP89sHytqMvK+uSWYLkolQtHAsorD8DEceLcbw7r0D27zN+Bv3sHIeXdzu2dCeh8Z
 1YxYunWQOrBVypqx8rGN3vo1AOso7L4zbvp8INP/j/C6ICZ1gTyawYg/y10aM+CJ/ONa/DKb5en
 ikTZTJw3jymG+/w==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of IP(V6)_TRANSPARENT socket option with
MPTCP connections introduced by commit c9406a23c116 ("mptcp: sockopt:
add SOL_IP freebind & transparent options").

It is possible to look for "__ip_sock_set_tos" in kallsyms because
IP(V6)_TRANSPARENT socket option support has been added after TOS
support which came with the required infrastructure in MPTCP sockopt
code. To support TOS, the following function has been exported (T). Not
great but better than checking for a specific kernel version.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 5fb62e9cd3ad ("selftests: mptcp: add tproxy test case")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index c1f7bac19942..c6fcae6b2562 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -144,6 +144,7 @@ cleanup()
 }
 
 mptcp_lib_check_mptcp
+mptcp_lib_check_kallsyms
 
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
@@ -695,6 +696,15 @@ run_test_transparent()
 		return 0
 	fi
 
+	# IP(V6)_TRANSPARENT has been added after TOS support which came with
+	# the required infrastructure in MPTCP sockopt code. To support TOS, the
+	# following function has been exported (T). Not great but better than
+	# checking for a specific kernel version.
+	if ! mptcp_lib_kallsyms_has "T __ip_sock_set_tos$"; then
+		echo "INFO: TFO not supported by the kernel: SKIP"
+		return
+	fi
+
 ip netns exec "$listener_ns" nft -f /dev/stdin <<"EOF"
 flush ruleset
 table inet mangle {

-- 
2.39.2

