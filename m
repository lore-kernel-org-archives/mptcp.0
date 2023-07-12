Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA1E27712
	for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 11:33:28 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3094910b150so7440754f8f.0
        for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 04:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689161607; x=1691753607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8lovvW7KdsSDQsKKHgVJkhjhW38ocNnSn6uoCuXZDA=;
        b=EScWqz5VfxBi2Kr7JIGlW/gfxkXqaL+hbnnIoJAA13HAZM400p2Vh42J9NRxtmryAR
         eq5yD/oZL2nEdVCmF3ca03YyunmUoRB/R1MYWd7Vt7TlDswvyYVP4IornuTOVssb6smE
         ZK0dUBDkMrE+5rSEnDdORH+v0qQGgzKacj02tPsUg9nqPrZ1/+uRVrASWkTzsXVwMOh/
         nRHoqjVLJ4EImI5swM0nO7RLfqqETwWmbrIQlDNRCOY9d4G9m0FZIUy8K82PmiKeaozs
         y0tuiyRuXHk49k7TZ/iRWNTX57r2kGbt3BHTHaWRuN0MTjHodx5SlijykucMTlqeTPV4
         LgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689161607; x=1691753607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8lovvW7KdsSDQsKKHgVJkhjhW38ocNnSn6uoCuXZDA=;
        b=MAlSP7GEIHkJPk0DyLWkCo8Zym4c2I9QkyA+Rn3HhwMHCQA9bI7hjxNHxdpN/JPAQF
         7XXAYxFr6ziJ4TdSdRMBDziKVw6FiFKRjKqg+f0oRH+rHX21/qV6pVPfZQWtGC/FfLM6
         OimCJ0VD0fgbTFGXGM/q+TdJApaftg73GF6w5rHTSIiJ/v73K1gpayBwz+Klur2HYaHv
         BSH7asyDESP3+4LlPPTSGatEQ1OdWwM2UOGK1ohA1HN/ApUOTkuBkc/iGZfnSFJwB4Mw
         rIG1JI1NdcXn3VaPcczxQ6+M9+fepHdtkGZc0smFBscH8mVfCANUR89FxfhXfFt3CmWx
         2OPA==
X-Gm-Message-State: ABy/qLYceVt21MIaqwhO9MT09xygOu2c8uWgLZsatH1DeQQUcHciJdA5
	tFcGAaioHk9mhfmf1EcGgZWTDwjWEUMizmNYe5hjfHMl
X-Google-Smtp-Source: APBJJlGUNwalx/hVCqM1rZhlbPAI+rICY2Sb3BHCvwdMBvr0F/XySMRmZLIt6VmHQQ0nhyK1iYjScA==
X-Received: by 2002:a5d:4f0f:0:b0:315:8fc0:915e with SMTP id c15-20020a5d4f0f000000b003158fc0915emr13555717wru.56.1689161606894;
        Wed, 12 Jul 2023 04:33:26 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id j11-20020a056000124b00b0031417fd473csm4892673wrx.78.2023.07.12.04.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 04:33:26 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 12 Jul 2023 13:33:08 +0200
Subject: [PATCH mptcp-next v2 3/3] selftests: mptcp: join: only check for
 ip6tables if needed
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230712-mptcp-issue-368-selftests-subtests-v2-3-c8b174c18f93@tessares.net>
References: <20230712-mptcp-issue-368-selftests-subtests-v2-0-c8b174c18f93@tessares.net>
In-Reply-To: <20230712-mptcp-issue-368-selftests-subtests-v2-0-c8b174c18f93@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1045;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=pnnELJNooEBUuNpDfddSC9DrPTWzN5n6f+kRt6TG170=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkro+Dr63tT15Qp7Q5nlvKort3uVdWp18+y76Oq
 WHXTb4ka5SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZK6PgwAKCRD2t4JPQmmg
 c3gKEADY+2U0zZ8t0ADuzxhjqqysyleIZ1xntGtv9aqlhbkvPlNt/VY+EpPPrU0q/zuwicr+nPi
 urfkzsaabP3pmYWhQ4XGm+5e0SR9emsnrBcLPMFP2jxKdmkzUCSMYP9u8kQ8UdQXeynGi+9keGp
 AgkbhLhCpXl1ZNz7Yqm9ayWXcdYNzhP0v+MKP8hwcBuS6AesUrYmHkt8sPmS8rqh75+LkhnTaID
 iJjpllTRx2IqdkqYRYO4uH94Fv1cPuOFj7PbXyoqb0q52P1v3kV0NlffsyhBt4rXs/PDVkOoffv
 jo13Ad+BJVxKw0uSeqsDga9lP8iHx4YdF93kzA0b3ISlNbgQ3u9Ch+fSvAJEYDRP7lZK6kLqooY
 n9dVv0LvRM4RVfo+hOQtdEbckRdK7eWg1DDcqtwMIfDn5iRA+bQTxogPAr6GxXEdwgtrePKMDbA
 C7xIODHaa9okX17iW1Ch7ZVWQBxgceOTolkViJzLuR8E0k8WpEx5g2PjpycKpHYNFDN8VSMZvP8
 mXWHCpyqnYrZXSVFBcm701Gfnk+puJVTYf2P4+f1nq5/P/5D9OR+/EvAmo6WYKMquZCopNRfNTJ
 TOTMhdwCev/4BGy8Ua6JUBb8Pa2+sI4XtvObFOf4EaZE2ljQPuvGVMwbd1gqi1n+r/lhJD6ZYT1
 ewaZttSjoafD6Mg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If 'iptables-legacy' is available, 'ip6tables-legacy' command will be
used instead of 'ip6tables'. So no need to look if 'ip6tables' is
available in this case.

Fixes: 0c4cd3f86a40 ("selftests: mptcp: join: use 'iptables-legacy' if available")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2f47686b6214..136d20641fce 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -166,9 +166,7 @@ check_tools()
 	elif ! iptables -V &> /dev/null; then
 		echo "SKIP: Could not run all tests without iptables tool"
 		exit $ksft_skip
-	fi
-
-	if ! ip6tables -V &> /dev/null; then
+	elif ! ip6tables -V &> /dev/null; then
 		echo "SKIP: Could not run all tests without ip6tables tool"
 		exit $ksft_skip
 	fi

-- 
2.40.1

