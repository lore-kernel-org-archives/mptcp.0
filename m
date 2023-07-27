Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF37174F4
	for <mptcp@lists.linux.dev>; Thu, 27 Jul 2023 14:17:40 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-31768ce2e81so1089360f8f.1
        for <mptcp@lists.linux.dev>; Thu, 27 Jul 2023 07:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690467459; x=1691072259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JpiYyl9rsB1AwGQpZxE+ZLJX2842YC/a3DdWQCMD3qk=;
        b=dVykZxn/K0SK0bZombziphoaQKHmehHR1sLnzpfeAlXZu2sOMztQSrp7lffTDXGW6h
         iGEU5jYPs815AL3PS4C4RSohhBJ6wfrpLIhJ4Qq1MhOTGtgBXiMsHKx4gExIhs4M5wwC
         VKR7XOrHZ8nphm4+iMG3c3UeR8KfICAuVh1njI8kw9mhR+fq1FA2tLxhfgFZQ/Ix5zOv
         u8yOFH2JbYcBMDVs+rMJax9iGb6RmvSvPgYmAko9DpbgMyHh9s5pzuBSd0uxm59hCcrR
         xUDG73kc1zpdIwzLmvZhLPF5edcBlivvPzLfHJn9B9yJXWbKEOvCkQPouKHpvzdrRs+q
         J/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690467459; x=1691072259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JpiYyl9rsB1AwGQpZxE+ZLJX2842YC/a3DdWQCMD3qk=;
        b=B4LN3Sc1SQp9f022RnQKls0qsO/JDuUnzG7pg2KUlDYiYCd7rP00SNjCI2nWn/vdrz
         huVhT0arZEBt9ce2/O0nhTBQ3n1zhsdPW2Mvh1Pc8FTidsV0+/qyy+kXGQ2nDSmzjRz1
         A8wkTcDn11Gud7CV6WBpVGXIExuCLM5AamCep9sqWEhcRIpbjU4Rgy6T4+y/demFitLw
         kAUNh8Y5fdGvv/vaYf9GKoK5NB15dplVGI2E8QSGSjfwGXP5AC61KwbC4LJgUtDf+wht
         cgW01Kp7Qj8agD/Pls4Ugfkim2pgVLi6nqFkQiJxylcD9kFJaHGPWbeprUvoVbiv88Xx
         xC+A==
X-Gm-Message-State: ABy/qLaPEInE72lv8a/JFLqobd+OECc5BrbIIEM4BH2JTI9J+lS7p8pQ
	b5WiMVav2DpKlJJzAl2XLD3Bpg==
X-Google-Smtp-Source: APBJJlE15GyGDtJ/VgIsOQV2s61E/lNYO614OqYzAwZcy+uSJ52GHZaE+7ROWq5tHtp919uTRPj2uA==
X-Received: by 2002:adf:f0c1:0:b0:314:1b4d:bb27 with SMTP id x1-20020adff0c1000000b003141b4dbb27mr1755176wro.64.1690467458987;
        Thu, 27 Jul 2023 07:17:38 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id k17-20020adfe8d1000000b003143867d2ebsm2192516wrn.63.2023.07.27.07.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 07:17:38 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 6.1.y] selftests: mptcp: sockopt: use 'iptables-legacy' if available
Date: Thu, 27 Jul 2023 16:17:21 +0200
Message-Id: <20230727141721.2525575-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023072146-grit-winking-6e88@gregkh>
References: <2023072146-grit-winking-6e88@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3385; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=XwtIBzbx2+Od23pf8ImN7yZG8k8CV6ujJEG8Jk4cG/s=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkwnxxRGfPJkTBalI9iL+gDxUlmDCDSYcAF8QZ9
 5oZD2U4LhCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZMJ8cQAKCRD2t4JPQmmg
 c/suEADWUiooxawmy+dZEC4bDsSEcSD7sFazQZwxLGKQNiY/VQx8qJlNGBFlko2lnn8wLL1gBZU
 mCuRHW2yJzbSpA/kvr8XIYk7U6imuvWuJqfNWYzFeFzYEpDhvHV0q8zf3NvSYqkBQLPADazYwol
 KD8A7rpfdFxSBoumZyPB8KOhzk8HWwD5skBJwhpRin2MF6ptBpa25Hug1CFkOpWM8b+nIQ1vpZq
 bAnFGgbmXfa95Lj5snz9+nHYhgKuzZ/Dzhaz1xTcUe8gmrLgDks0t289FDiPJcZeHnMqWxH2KvC
 52/gBnJRLVQEt+eXQFBshtznxl4xaIJeZ4QgyMXcfhINAgCg+4KJvKrdRAkuERTX92U1o60OK3p
 HV9/YpKamHv13SRcDNWyuiGQZNSB2czn6s/bHyLKehMemOXLkdPvggqe1ua6cx4AgMqdsuoJMqb
 x5yCv4Sja71F4Sqmq9y7jyGJimaDO1zSTxPV4nkOs2upwRpO7AwzocMTo3KzHtH70vMKYFdxthH
 aVlR9QGwx0cuVGDVvw3FKOZZvl8eUxykfhTVE1oOqkLs97Rv3q2JJkWl235FIPakDEhWb255FNk
 N1D8sOV4QH0rvn7pKz9zDpaGFlchHEq+3EmCh5VyVX2UJE59a3o1unjIyuL5i0UiCK5OGGI6Nap 4qftRT/tl6XnGBg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit a5a5990c099dd354e05e89ee77cd2dbf6655d4a1 upstream.

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Backport notes:
  - it was conflicting with some cleanup patches: b71dd705179c
    ("selftests: mptcp: removed defined but unused vars"), de2392028a19
    ("selftests: mptcp: clearly declare global ns vars") and
    5f17f8e315ad ("selftests: mptcp: declare var as local").
  - conflicts were in the same context but not with the code that needed
    to be adapted.
  - an extra adaptation was needed because 'ip(6)tables' is used
    directly in TCP INQ tests, a code remove later in commit
    b4e0df4cafe1 ("selftests: mptcp: run mptcp_inq from a clean netns")
---
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 24 ++++++++++---------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index af4fccd4f5cc..114c4ce719c7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -13,13 +13,15 @@ timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 mptcp_connect=""
 do_all_tests=1
+iptables="iptables"
+ip6tables="ip6tables"
 
 add_mark_rules()
 {
 	local ns=$1
 	local m=$2
 
-	for t in iptables ip6tables; do
+	for t in ${iptables} ${ip6tables}; do
 		# just to debug: check we have multiple subflows connection requests
 		ip netns exec $ns $t -A OUTPUT -p tcp --syn -m mark --mark $m -j ACCEPT
 
@@ -92,14 +94,14 @@ if [ $? -ne 0 ];then
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
@@ -109,10 +111,10 @@ check_mark()
 	local ns=$1
 	local af=$2
 
-	tables=iptables
+	tables=${iptables}
 
 	if [ $af -eq 6 ];then
-		tables=ip6tables
+		tables=${ip6tables}
 	fi
 
 	counters=$(ip netns exec $ns $tables -v -L OUTPUT | grep DROP)
@@ -314,8 +316,8 @@ do_tcpinq_tests()
 {
 	local lret=0
 
-	ip netns exec "$ns1" iptables -F
-	ip netns exec "$ns1" ip6tables -F
+	ip netns exec "$ns1" ${iptables} -F
+	ip netns exec "$ns1" ${ip6tables} -F
 
 	if ! mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
 		echo "INFO: TCP_INQ not supported: SKIP"
-- 
2.40.1

