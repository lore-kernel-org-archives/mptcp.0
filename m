Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DF12F41
	for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 09:20:38 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id w24so571391wra.10
        for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 02:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681291236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57LCbEmSbEn3cmFK86PSZdg+TXjeEyLRMiwDBLi06xo=;
        b=QGs6Io4J+yipd9ZxoSzJwCu/YcWcrSWv8Soa1jWSR7G+jFOylp4Tjlv2H8Wrye3ZMA
         1bFMwbhH5jWxYAHkO8Q6i3xBq9u5Azl9nQkbRTrk//dlOMcrM9pXxBML4CrDN0LKmrg2
         JAQ36RokbzeJvxml6rLOPQF+8/yp+tbNPAWjLZXxQHfD7Cox4MUvWJdxarmn/Y5S/An+
         0bM8Lh0umozPo9tANmTdFApY/xc44HhhY/Jdea4OvAL36xBj43lUhgbvJWlG/SRDD8VV
         hnF4LwWL7WqBUMrVdhcMFDNHISdY6UM9iS11i/HDK6ENCaohpIM4Pv+y/WvIMk+eDSil
         O0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681291236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57LCbEmSbEn3cmFK86PSZdg+TXjeEyLRMiwDBLi06xo=;
        b=vdU6xZuuQ5VWHv7OsabG+eofqiGgchHWXzq3NVE0X7etsJaW+XdQe6Ot7vcUiuhdjF
         tBHuksLR1hIVfR8/H7Q9wJczrASTTrD8mhNGkumqcMzNpzfc2RtP1Y3D3CsOmwnO3p9D
         GjgFR1yHLgimnpXfaaNwsBVDXQqtYxrNQ4+v/Yce/yZ8AsPSfh+9E7Z4ZWZtNeJhF38q
         JS18yLWoae1FXJH6jh04/R2G9J/jwdzOVmy7gjIx3Vky5yWR3TNagQJUH3OiLqQ/ixKm
         c/MdW1HvmJ7h0DY/kmUX0ZdKa7GPT70RrZwHU8jd8F8D/xqJ3jEKb3Le1xFsnw4IUL1t
         dbeg==
X-Gm-Message-State: AAQBX9da0Qg0ciyrh+bC0YpORDNy6rY5iZ4iYeqEpK19oBZrmYoz2bZr
	Y3l7+NM3x4yxRc54SECLpqM6p4dN+WrCpfAy3MXIzw==
X-Google-Smtp-Source: AKy350aXXEQZb/r650js9bhWbfD4vJ1WTqEZzjO60BmLa0hMz8Acj89X5HklBBVVp+BCBeHAH767DA==
X-Received: by 2002:a5d:4581:0:b0:2ef:aeb7:5add with SMTP id p1-20020a5d4581000000b002efaeb75addmr10704271wrq.68.1681291236645;
        Wed, 12 Apr 2023 02:20:36 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id k1-20020adfe3c1000000b002f01e181c4asm8981069wrm.5.2023.04.12.02.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 02:20:36 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 12 Apr 2023 11:20:13 +0200
Subject: [PATCH mptcp-net v3 2/2] selftests: mptcp: join: fix ShellCheck
 warnings
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230404-mptcp-selftests-join-busybox-shellcheck-v3-2-eab5dd7bc996@tessares.net>
References: <20230404-mptcp-selftests-join-busybox-shellcheck-v3-0-eab5dd7bc996@tessares.net>
In-Reply-To: <20230404-mptcp-selftests-join-busybox-shellcheck-v3-0-eab5dd7bc996@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2487;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=ojtyXhuz6XXZ1uUuC7M9Zik0E19LX3n2dRoDaBQWh/0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkNnfiNiYwoOFFzpfGwAGYIwep82qOtyvZq5043
 AOLgumL9QOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDZ34gAKCRD2t4JPQmmg
 c7jsEADHW4PqLmJUcfZNzBlhi2KX9DBDna65cRk4TobEZTlrnsqDpgAux+wn73tQP+9zpcnkyzG
 fv3hkQs6fvNSgClEaYqAuviZQEypmScFaVMR9cVTrLjjJYdXvXBq+Jx6dTqTzifKQfMgf+EyL8o
 oQsMCkHzMQ5zRhvL4TawpZ1RO+/gRgMvkRa09xkLbNnaKM8jHC2vb1xXOdsdFxolZCG/MXVI+UX
 CfFDm6Bj5hHM/4+ixY31tl3g8kcGZ8aVIaW4bPcuLYonBt/qGzq6ghnM/H0LoOD3I7kojEPwerw
 Pva3uIhPXTf3AZqa3deqLdW4DoA9x+8P/w+bgRTpPIH58VR+16n9idHuuP1SQLltH6x7lsN9z84
 6cUf6OkQgQ9IXZ93+Dwxu24ULqriNlk5FaBoHaOCc9xtfAneIt/sQGj+cxnDTpjs6GuZlNAtv/y
 0yPZkfUBz+FYDs3bVzSXtpYpXm3z3fkFV6IDuhfPJ5wXC89oJR2H0bb+DITv9vBdW6V6qAzZEHa
 t93OBA9IcGajCNIrUDL1Xdnxbro9xsWcOQHkiQdjr8NWad2j7/bM4woeLdB5Zw/gU+HGkECCG4W
 HmsHHjzGpl7iyEfpn3MHuKacfKeYNP7tDoyJUkUZiZO5QeW8nfYlEUjNSW1Csnri2U6qjmL49k0
 ixha9cRoDdlYoEg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Most of the code had an issue according to ShellCheck.

That's mainly due to the fact it incorrectly believes most of the code
was unreachable because it's invoked by variable name, see how the
"tests" array is used.

Once SC2317 has been ignored, three small warnings were still visible:

 - SC2155: Declare and assign separately to avoid masking return values.

 - SC2046: Quote this to prevent word splitting: can be ignored because
   "ip netns pids" can display more than one pid.

 - SC2166: Prefer [ p ] || [ q ] as [ p -o q ] is not well defined.

This probably didn't fix any actual issues but it might help spotting
new interesting warnings reported by ShellCheck as just before,
ShellCheck was reporting issues for most lines making it a bit useless.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 555781826289..4f3fe45f8f71 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -6,6 +6,10 @@
 # address all other issues detected by shellcheck.
 #shellcheck disable=SC2086
 
+# ShellCheck incorrectly believes that most of the code here is unreachable
+# because it's invoked by variable name, see how the "tests" array is used
+#shellcheck disable=SC2317
+
 ret=0
 sin=""
 sinfail=""
@@ -373,8 +377,9 @@ check_transfer()
 
 	local line
 	if [ -n "$bytes" ]; then
+		local out_size
 		# when truncating we must check the size explicitly
-		local out_size=$(wc -c $out | awk '{print $1}')
+		out_size=$(wc -c $out | awk '{print $1}')
 		if [ $out_size -ne $bytes ]; then
 			echo "[ FAIL ] $what output file has wrong size ($out_size, $bytes)"
 			fail_test
@@ -509,6 +514,7 @@ kill_events_pids()
 
 kill_tests_wait()
 {
+	#shellcheck disable=SC2046
 	kill -SIGUSR1 $(ip netns pids $ns2) $(ip netns pids $ns1)
 	wait
 }
@@ -1712,7 +1718,7 @@ chk_subflow_nr()
 
 	cnt1=$(ss -N $ns1 -tOni | grep -c token)
 	cnt2=$(ss -N $ns2 -tOni | grep -c token)
-	if [ "$cnt1" != "$subflow_nr" -o "$cnt2" != "$subflow_nr" ]; then
+	if [ "$cnt1" != "$subflow_nr" ] || [ "$cnt2" != "$subflow_nr" ]; then
 		echo "[fail] got $cnt1:$cnt2 subflows expected $subflow_nr"
 		fail_test
 		dump_stats=1

-- 
2.39.2

