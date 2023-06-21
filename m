Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C65619BAF
	for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 17:18:32 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-311099fac92so7157454f8f.0
        for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 10:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687367911; x=1689959911;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h2EdQ3JDQONImAx702zX61SGKq1gne/3I+N13/5zM6Q=;
        b=sJcJhSNVeuyCml0NpGi8IvlyMXrUDDp0ZlDl0pP8x3+AJyZxihbX/zlQl5GXoqedw7
         R3DuVXtORXQLp/6BvSXalTFvPKAqCRImLIz8wNCuWBI55LdtQayRXW2gLwwWAbLFFs3U
         GBDME0G3f1hwUS5PcISBof+CyG1cnLMlLXyxEsAZwPYTx4ffbJYP4yrDvtoARVpWI+uD
         C8PP6YMdvwYu6FeM094OVbyLJsVz2firCuLhYRTI7wBH8KCYgZQ05Vvlda5GCX8c/W0p
         HexifVaFGcjGOOK91cMmZRYAqQi5xzGyeEADhJqTwTunWmMbOzXld3poPTWns/EOWWUB
         ubhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687367911; x=1689959911;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2EdQ3JDQONImAx702zX61SGKq1gne/3I+N13/5zM6Q=;
        b=LrOya1XyvjimEMwuYFcT+jt8q7D1Bf/HHl8ukqOBdXO1aKVO49g3vttKSdzaC7gcxS
         I12ISStf2weGKU4pMCMUQVk3l9YEXFBaG9ZIfr23v67BhmNKcDsVIu3A8t7S/AmmN2Ce
         3K/6iLjkQTzlHwUq0LS5md5EvwoCNCy7gl2tPHZ/ml3GLbV/KRaBWl2jPKDQLri4oxt0
         5MqyqtZuhC+EbhOUTttHcRRNQ2nl52thhHa+Og0dyd9N0p/flJOP5SYj1d6p4uQ8g182
         NtD0H+q3uFL0y23UnmWQBBucUt1kWboCSKL4UxrhXOh/zEsWsA7uJOFQN21OkwwdB0jD
         y4Eg==
X-Gm-Message-State: AC+VfDwgx3dKJfvi5CxeJId8LPWk2s2UUSFn9FtJQ+cltd6nTgXotL5j
	QVyGFnGKCFSlwVmJzb3UNylPSo0PmF+a6gY8f+B5MuUe
X-Google-Smtp-Source: ACHHUZ5fV1mMTuS8plTifwTGaGWUqZerMKJl+mEEZJWElR4hEZY9SLiF7Hqtj/sQ2YbHQCXGsKdxcg==
X-Received: by 2002:a5d:62cc:0:b0:30d:2184:84c0 with SMTP id o12-20020a5d62cc000000b0030d218484c0mr14165611wrv.30.1687367910854;
        Wed, 21 Jun 2023 10:18:30 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id f1-20020adfdb41000000b0030ae499da59sm4930027wrj.111.2023.06.21.10.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 10:18:30 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 21 Jun 2023 19:18:04 +0200
Subject: [PATCH mptcp-next 03/18] selftests: mptcp: sockopt: return error
 if wrong mark
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-mptcp-issue-368-selftests-subtests-v1-3-0cae453ae1fa@tessares.net>
References: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
In-Reply-To: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1695;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=59N81gpCRPDPY0cHa0+5/xM5wYQnpdwvir/4Bjc+mPg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkzDiCCQ1vv1q1gje0lFMuMuAnbitEyLCW1qzk
 +jJyjyLKcSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJMw4gAKCRD2t4JPQmmg
 c9duEACG7p26Uv2CnZcITPRGMUkq+Ah4kC89Xeakl0U+ixn/jXBqEok7gmpWp0Xv8vV/t5ThNAN
 kh0ITcQWp7tKVbi4seFfySADbFMFIrB1qczOHAWpn9OkIi2rMn4vU5jIMIcOB8xF6HARA0Poofl
 7i3qJwFBR8/41KsSh6caegffChVEmPT/ADMJr7SH2AsOzQ+kINhdpYfKofmqpaNNOJcopF5/InM
 97iieTmHM4iqINOnoRlOt5onuFxTPNi3zEygkvgSNxvkk8GF3lLPnHaZG4t5ot+LyCgDlE958VL
 1RcT+tZy1cn4/4K5p+33ql0jRifnyzj0Q82fn3hJCxGqv8bKk0IrHx/tyPj+v2QqODw4pxqg04X
 M9S8gutLx3chaBObtyabwrf1UNqaRy3Hd8ehZEEZtw3YiiyZd5azWECXquBravfGrfNKTwbu2Ol
 yYb89uxMjiNiMrLOBFJYuXpmTXZ15QTKxnYgzVu8qtOXBbY7Rvch7E2Z+1TtCaUFvP/R+mEl74I
 7kcxCXouiSGeVDAzA0pVn7DPSVUzI4MCMvxKeMJAMl6oV1moCvWjNXYgmvJgtlRnKKstQjgfsZ6
 k6qZbjUlvtrK7+TaM4epIbGiUPFo11hOj+zJiU1z8lblbgzfliSQF9M1kc0n16ixBfgV9UbyzFo
 +mV/5YcUAk8TuIw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When an error was detected when checking the marks, a message was
correctly printed mentioning the error but followed by another one
saying everything was OK and the selftest was not marked as failed as
expected.

Now the 'ret' variable is directly set to 1 in order to make sure the
exit is done with an error, similar to what is done in other functions.
While at it, the error is correctly propagated to the caller.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: dc65fe82fb07 ("selftests: mptcp: add packet mark test case")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index c21bfd7f0c01..dc8d473fc82c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -128,6 +128,7 @@ check_mark()
 	for v in $values; do
 		if [ $v -ne 0 ]; then
 			echo "FAIL: got $tables $values in ns $ns , not 0 - not all expected packets marked" 1>&2
+			ret=1
 			return 1
 		fi
 	done
@@ -227,11 +228,11 @@ do_transfer()
 	fi
 
 	if [ $local_addr = "::" ];then
-		check_mark $listener_ns 6
-		check_mark $connector_ns 6
+		check_mark $listener_ns 6 || retc=1
+		check_mark $connector_ns 6 || retc=1
 	else
-		check_mark $listener_ns 4
-		check_mark $connector_ns 4
+		check_mark $listener_ns 4 || retc=1
+		check_mark $connector_ns 4 || retc=1
 	fi
 
 	check_transfer $cin $sout "file received by server"

-- 
2.40.1

