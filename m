Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51269883C
	for <mptcp@lists.linux.dev>; Tue,  4 Jul 2023 20:44:58 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so73145725e9.3
        for <mptcp@lists.linux.dev>; Tue, 04 Jul 2023 13:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688503496; x=1691095496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbs49TeREvqiLDtiZ2Z4ZyV3x/f9tvCjUJNddKBzHqM=;
        b=71EEytLCLqTLccLzoPuPNNeb09hv4H7omNK0iWbNSc7k+BRsAfXs7LypSn311LKrpK
         j85zL7PrtNLLWhQh3Ni6YkxakmFLZkyoTrQ8UIXWW4+bgqE8FifXrsb74vFd5XkFoECd
         8wKS+dZuhR8+mjsLqdKY0kmcGE6Rvpedn0JiyaL+1vRfIgPS4xZSTVPKkIITj+YQxhvr
         EfOcxxSpNI3yWrf89stjIhEzecBYFlKA4s41NbIqME3RUdXSXeqaGxbYU5Jb06HKUrms
         wcCC+NCp6HnHITxrzyOKtYG72LP1MvFOfpQ5riSXWr6AzR42/zDtD5I+VdRchqByZ6J7
         I3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688503496; x=1691095496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbs49TeREvqiLDtiZ2Z4ZyV3x/f9tvCjUJNddKBzHqM=;
        b=C13Czmp1Yqr/Wh6+QAGjiiDFvnt8w50/6L9I5X6XYkDVZ00AN3OLA/bG1KfvwZejv+
         Ir0dtzdsEjDhURmUSc8Q4n7IpTC79F+Kzu9yReZRAmESF48X/Fs/x3Rt3OyzK8vZ+h3P
         BIDXvAuodfrR78gZYdUQpLGPGVQTDxDi3yJwN9adRhehVDG2LYH7nV/0Rzg5MENCLiD5
         SzSzrZLe4iPf189kvavLYua105jgclK7DkJDNAZwK5QXmjZtRFvSSh/YyNUkDGJECPWR
         /eLxZYQKbuGkr6T1SrhDbwdt6MIQbA1O+b1y0fLF+Pt772syJKld/sQCT+aF0ZkO55/x
         eaaA==
X-Gm-Message-State: AC+VfDx8qGa7+zLmG6S+K7j8TtkA00sGWG0CjcO5oQJxELTlhtbx2tWz
	aRi7Gi+nf7s3LPB23YWW1xRKmFEPaE34/A43fWEcPA==
X-Google-Smtp-Source: ACHHUZ7OfLkD4EL1eZnOC6SEWIJqO7T1GYXlDxM0eers3/RaR8s/fjvsySnar7tgGhowCyYNqnPUYA==
X-Received: by 2002:a1c:6a07:0:b0:3fa:934c:8356 with SMTP id f7-20020a1c6a07000000b003fa934c8356mr12936237wmc.10.1688503496449;
        Tue, 04 Jul 2023 13:44:56 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id y4-20020a05600c364400b003fa74bff02asm115332wmq.26.2023.07.04.13.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 13:44:56 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 04 Jul 2023 22:44:36 +0200
Subject: [PATCH net 4/9] selftests: mptcp: sockopt: use 'iptables-legacy'
 if available
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-4-d7e67c274ca5@tessares.net>
References: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-0-d7e67c274ca5@tessares.net>
In-Reply-To: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-0-d7e67c274ca5@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Florian Westphal <fw@strlen.de>, 
 Kishen Maloor <kishen.maloor@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2360;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=hNWOoD7/LcwT6MxZn3z9Ny8SyuT+nO+3gHstFbn1a9M=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkpITDErJzB3ia+oVRtyW4uFBhqIl7+o0+PF3/9
 GfcPSzELw+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZKSEwwAKCRD2t4JPQmmg
 c5AtD/sHKEDly/PyEbPrTJenSQYp6qxYdSsKRj2UOokdmfmCiKDxM13u5H1sC+bIp1cLmjybPro
 bGAOxX4kCmRzF26gYCE/fUgy6vHQc1XUYushwdYcVQcqCCiuj7bh74qdLqsYXXfbsE4xaFwmXi6
 U0eMJ2+w3bIfq+jvqGX5ze+51ltqqWVnHK4YM8kCJlUzOMK/towrnmaOsB6rejwyPafV91Xia4l
 0+22YYZYKE2XJtrcfK6LYFwdA/kclrmhUE3la+quoDrFxQhsvPV7eTrlFp707atnNkVK3im7yXb
 Uhyy06xh2uI/50D3kRuvgTXsCJyUIIb5mrmXGvFj/COI48NzYaNSuvxEprxcvbkplbwTyeKczKT
 gEH0G2Ubg9VtHVBfs5o/e1rm2030i9DK6HeSX92OSs3TfNtelL2lpdupLlh1ZDDfzpIfnVsdR7l
 MWczEoXNVQr9C669SFN0ORYOdY8/ZIRzASTCAFNT6DFRZj1YGXT9wCHB1XCvySEqoJ78lAgAmq5
 pFlaFxb1Pvn1D04PIZpI+kp8J2zZB2/gXqJFLBqIkzfzIjdBKBwAPbIu8Fj9VDxbmh5OM5UaXXE
 UM6NLfmlkzIMV2o22UG6st/3zcEIx05nLvfEW+PREMuaK6gxHvSubCzQwPp5dh2m3sSAqsGAd/Y
 mEYSiwGdbDn6Fkw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

IPTables commands using 'iptables-nft' fail on old kernels, at least
on v5.15 because it doesn't see the default IPTables chains:

  $ iptables -L
  iptables/1.8.2 Failed to initialize nft: Protocol not supported

As a first step before switching to NFTables, we can use iptables-legacy
if available.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: dc65fe82fb07 ("selftests: mptcp: add packet mark test case")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index f295a371ff14..c21bfd7f0c01 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -12,6 +12,8 @@ ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 mptcp_connect=""
+iptables="iptables"
+ip6tables="ip6tables"
 
 sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
@@ -25,7 +27,7 @@ add_mark_rules()
 	local m=$2
 
 	local t
-	for t in iptables ip6tables; do
+	for t in ${iptables} ${ip6tables}; do
 		# just to debug: check we have multiple subflows connection requests
 		ip netns exec $ns $t -A OUTPUT -p tcp --syn -m mark --mark $m -j ACCEPT
 
@@ -95,14 +97,14 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
 
-iptables -V > /dev/null 2>&1
-if [ $? -ne 0 ];then
+# Use the legacy version if available to support old kernel versions
+if iptables-legacy -V &> /dev/null; then
+	iptables="iptables-legacy"
+	ip6tables="ip6tables-legacy"
+elif ! iptables -V &> /dev/null; then
 	echo "SKIP: Could not run all tests without iptables tool"
 	exit $ksft_skip
-fi
-
-ip6tables -V > /dev/null 2>&1
-if [ $? -ne 0 ];then
+elif ! ip6tables -V &> /dev/null; then
 	echo "SKIP: Could not run all tests without ip6tables tool"
 	exit $ksft_skip
 fi
@@ -112,10 +114,10 @@ check_mark()
 	local ns=$1
 	local af=$2
 
-	local tables=iptables
+	local tables=${iptables}
 
 	if [ $af -eq 6 ];then
-		tables=ip6tables
+		tables=${ip6tables}
 	fi
 
 	local counters values

-- 
2.40.1

