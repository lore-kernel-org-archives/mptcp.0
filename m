Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D46BA2F
	for <mptcp@lists.linux.dev>; Mon, 17 Jul 2023 13:21:38 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso46375275e9.0
        for <mptcp@lists.linux.dev>; Mon, 17 Jul 2023 06:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689600096; x=1692192096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C19OOQjys4g0HZbyxfn1tMfB0ZlUmaAeplCvwpV4yU8=;
        b=kV3uMPCmfenfR9XYgoBJYMtkwY8ae2Sutqmrw4sXe3sPEP8pTMFjy7PI7baLLsfvgc
         dXTXoxmIpYMlr2reVA1Qrvgk0f5QSWbLj2Sm4BpCE59Dxz+TDRQgVFWOKvB4wg38oZ5Q
         sDCBgG0J4Q3zHhffNPUcQF/idNBhKv+D5/oLeZqCgD/baMgZEIrWSLrR3QMuDdvr1wp2
         M+B/Q1Ve8LvnFq7zBfDH84TCDi5gRixEbHKY/VdZk6mTdq4Kf1CKK477mopgA4w9Ga1o
         pU4zieiE9n5DtoJ2MzZLCKkb/lCb3YOFQ/kT3ar70cWRAVp9r1HgZa3H4aghcEUgVgA/
         XXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689600096; x=1692192096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C19OOQjys4g0HZbyxfn1tMfB0ZlUmaAeplCvwpV4yU8=;
        b=hvkt6w8UWFICxfrsiDRHb6NNZbAN1us+PJEDvLN6b8jGUgjSJqDvEbhY+7N/6cSk47
         ENPdTX5Jwk1yoFg6F3K9cNQh+C7prTR5Yin3wmH4A98fQe2i/BbcCztzZzpQN50HPoii
         Ye0kdOkUBfIs0Ky2k0yhaYIks9kQRxlvX8M0vOrALdBi2jFkpHhK40ZRMoXANH9gxX0c
         anVF82aeUBbv+OeS270DYA6oxH4TWE4zTHrHzHejLTNR+Yp7jYpIJaVosvrLLD5iOrwy
         IFvJbmucy9lAZYsXKSZF9WWaT5Cn7Pc9G8wANa76qGI6u6+lzVIx+PtTafPVpAyywPLm
         eiFw==
X-Gm-Message-State: ABy/qLbBg2+y3oqQ27Mk81509NQd6TMgtC5+baSrTUaomjpwGZGMyWaW
	igxjARvUJTLASWWB8/T1Q7JLuw==
X-Google-Smtp-Source: APBJJlEHEKtYBQlHrAmHpe7KvaH3pOGz7GH9IagvGAJVNabSEEePcghaij24VGRT0fUDgYtLfNnO0A==
X-Received: by 2002:adf:fd4a:0:b0:30f:c012:b529 with SMTP id h10-20020adffd4a000000b0030fc012b529mr12388036wrs.56.1689600096776;
        Mon, 17 Jul 2023 06:21:36 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b0030fa3567541sm19249836wrx.48.2023.07.17.06.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:21:36 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 17 Jul 2023 15:21:22 +0200
Subject: [PATCH net-next 02/13] selftests: mptcp: userspace pm: don't stop
 if error
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-2-695127e0ad83@tessares.net>
References: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-0-695127e0ad83@tessares.net>
In-Reply-To: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-0-695127e0ad83@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2583;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=qss0q7bvLOJAvB4X0z+6G5X/nAHFAPMEdRnJxgxYDi0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBktUBdufpDnSGqM9fSwPxtyCcCBIzkSdpT4xGDp
 XwYzeG8l7yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLVAXQAKCRD2t4JPQmmg
 c9fzD/oDC4yV0L9hFbGiam/FWu7nxOXtN2xdtkmY+MNIPQYe3BtWmpYD6y03J2zZ4z5WzQhViOp
 x9Il8IxPjm2XVWBcGkAOO+h4lAsDcUGNv1sLK1tLykizSAEWZvbjASAVE0dYy9pDWdgcb2AT7BL
 Fz4xADpq0O2ex6NMkR1RLVJmBhJ5vBeOrbsViqPtXR+RdwUgA88nWFHIjTmnyNYvMSJUa5j/aXb
 OLk2YKq5QSNI1OrBjbET8n7OVEQ7BVYmQJZiGYNH6i2d1eYy9CfnOaC9I041wY0LQtIm49y+oje
 iy1f0sE8JUoDG/x3Dd4f3NG3YKTf9C3QMx2dNBJPrg4e1k7peDIW8RwGGFLagF1PSwhv0Uu44Fk
 /kWcfN04R8DtWwe2TIDftL/IkM5fjXS3N+d7aPJikIiFKi7o6jRx2ZrukO9gHLdhPIqfjNXcNxV
 +8JoMBlDRBtLq0rx944pZ0GQmH7UfrvjuKg0VDOMlSooP6AUE8Aqww4p0s4sIeI9/K8MfeWTo7G
 nHw/JSRtHj7IbJL7OWipVnFQkm1IisbBmF6buS3Qb6h+R9ATb5qUeu5OsHNzASX7jsvo20dQKGd
 fnFyWABiXb0v88frMjC4BLtwSedc6kgOZ/sRDVYsPmmsO0IQ7Sk01ICT9ZcpikZod+9HfqESPxC
 GViUa3FGaVlxcng==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

No more tests were executed after a failure but it is still interesting
to get results for all the tests to better understand what's still OK
and what's not after a modification.

Now we only exit earlier if the two connections cannot be established.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index b180133a30af..c57ce4df4973 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -52,6 +52,7 @@ sec=$(date +%s)
 rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
+ret=0
 
 print_title()
 {
@@ -257,21 +258,21 @@ check_expected_one()
 # $@: all var names to check
 check_expected()
 {
-	local ret=0
+	local rc=0
 	local var
 
 	for var in "${@}"
 	do
-		check_expected_one "${var}" "${ret}" || ret=1
+		check_expected_one "${var}" "${rc}" || rc=1
 	done
 
-	if [ ${ret} -eq 0 ]
+	if [ ${rc} -eq 0 ]
 	then
 		stdbuf -o0 -e0 printf "[OK]\n"
 		return 0
 	fi
 
-	exit 1
+	ret=1
 }
 
 verify_announce_event()
@@ -323,7 +324,7 @@ test_announce()
 		stdbuf -o0 -e0 printf "[OK]\n"
 	else
 		stdbuf -o0 -e0 printf "[FAIL]\n\ttype defined: %s\n" "${type}"
-		exit 1
+		ret=1
 	fi
 
 	# ADD_ADDR from the client to server machine reusing the subflow port
@@ -423,7 +424,7 @@ test_remove()
 		stdbuf -o0 -e0 printf "[OK]\n"
 	else
 		stdbuf -o0 -e0 printf "[FAIL]\n"
-		exit 1
+		ret=1
 	fi
 
 	# RM_ADDR using an invalid addr id should result in no action
@@ -438,7 +439,7 @@ test_remove()
 		stdbuf -o0 -e0 printf "[OK]\n"
 	else
 		stdbuf -o0 -e0 printf "[FAIL]\n"
-		exit 1
+		ret=1
 	fi
 
 	# RM_ADDR from the client to server machine
@@ -859,7 +860,7 @@ test_prio()
 	[ -z "$count" ] && count=0
 	if [ $count != 1 ]; then
 		stdbuf -o0 -e0 printf "[FAIL]\n\tCount != 1: %d\n" "${count}"
-		exit 1
+		ret=1
 	else
 		stdbuf -o0 -e0 printf "[OK]\n"
 	fi
@@ -870,7 +871,7 @@ test_prio()
 	[ -z "$count" ] && count=0
 	if [ $count != 1 ]; then
 		stdbuf -o0 -e0 printf "[FAIL]\n\tCount != 1: %d\n" "${count}"
-		exit 1
+		ret=1
 	else
 		stdbuf -o0 -e0 printf "[OK]\n"
 	fi
@@ -961,4 +962,4 @@ test_subflows_v4_v6_mix
 test_prio
 test_listener
 
-exit 0
+exit ${ret}

-- 
2.40.1

