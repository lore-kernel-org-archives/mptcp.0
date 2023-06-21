Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9B319BA5
	for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 17:18:31 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-311153ec442so5080354f8f.1
        for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 10:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687367910; x=1689959910;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ypD/yMyaigzGyqp4qaD6UhyRIT9GcdjywDJ7C1whlb0=;
        b=SxvRjVbCVuVYpg3TgZL55b0T7gmzpPt7Va59wfgPFM7ngQ8G0xCYxSq+4lBzFg6V7T
         JhxcsLomYnYelwT2a22pgKy6CGDOmRJoPc9Lv5p8/9YKa0i32OCFg45xqBXYW9d7BXO2
         WkXHONZ1ueKjgMX3yoRb37/2alCGVMGTxjTnFm3Z7ioh4EH/0FhHa16YUZxajNH+ei3S
         t/4cG+3SIh42HLckmhkL2FMQQ4GysTzjFRlTwTSD18Dtr2lK0FJT6XMndVOB4DuI2s3y
         qp92jDRBZAPwGel7Sp7P5ZTmQqR1TwshQqNhVvubCsQMJolj/bQ2kjhnM54S1L+tCw1+
         qXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687367910; x=1689959910;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypD/yMyaigzGyqp4qaD6UhyRIT9GcdjywDJ7C1whlb0=;
        b=a2QIe+gF87YkjhZMy871oHrlu0vi6g0/sAQAiI08uaTlXB/cY3FJMB2Ua9VEcn34Rr
         +r8jyZXjPZXm7urdqTxMnfO900eLXvkwwYD1s+HbZh67dn03y7lrm0Mh2qSr4N4doNM+
         jkaiFHh1TBMK01oGsxiNYTBTW3B3+CYCdZSPb652A0GmFgSn9/VxloJuEhtFNLP2T2em
         sVN8YHR61CSsiPQIjh+/KRLKv2ztjpxbVU+K9PQ4plq89BDr2d5p7UzEYNgiKR8NClaR
         P/3GdeOnKaWai1UcWwijoV8xQjD5DTK7dGQpSMO+KMHDBnvaHJaxaNIEg9r5CDGBZeRk
         uuVA==
X-Gm-Message-State: AC+VfDyNf4ECPGCBPQOWU/fEgffvUyaTbwiZXL1ZV9L/8IBrsi5UFAj7
	M7IvxwS1KCBBS8qiktM+X3RpOPyubaO7yN+OB56icYlx
X-Google-Smtp-Source: ACHHUZ4Ms5Irvt7FrceXJXIrazPSJUrNB249OQrL0L++thh6LNKDHVqglnL18x1sC6Pe+z0+UmNSwQ==
X-Received: by 2002:adf:e910:0:b0:30f:c7e5:6176 with SMTP id f16-20020adfe910000000b0030fc7e56176mr14751199wrm.14.1687367909730;
        Wed, 21 Jun 2023 10:18:29 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id f1-20020adfdb41000000b0030ae499da59sm4930027wrj.111.2023.06.21.10.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 10:18:29 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 21 Jun 2023 19:18:03 +0200
Subject: [PATCH mptcp-next 02/18] selftests: mptcp: sockopt: use
 'iptables-legacy' if available
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-mptcp-issue-368-selftests-subtests-v1-2-0cae453ae1fa@tessares.net>
References: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
In-Reply-To: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2289;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=jK/gu3UqUgOJPUBK52hpPFELn9TeXPonVGSj+M+P1sw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkzDiRk6BdWcqGZy9u823XVV/OmEQZhD3ubAnv
 8sU/w8ZwVCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJMw4gAKCRD2t4JPQmmg
 c40ZD/9r6jtHvUjclwNBhTYZU/5BgvdOFuxRfj7leJuOBbQPjKaA4p4aZV24mRHec7UXmBW/NMw
 1jYT/KKsxzySRzz6KwNqpIOakXIM5wCiK9NHBsyJF3q89aXlJkPHjykewBJp4c5uXbOHRU0v8qS
 ovdHvfB7R+T0BMhJa/wYdk3V1AYgtUjNU/9LPJqw0XquJE5bB9DnlLmulK4W3neRyLqkvpnNULW
 eC4ayEutHt7PnCCjoOwTL1XfA6xfJBQSr/+JZPlJ+VeHSSeZCWqHDrCZbbrOwImaruEFcv1K1c3
 Gba4nDDFIzEhweozra8yjM2JTRooxZN+jNVIsDnDqbpzB+Yat/fmpEqyCR4ppuCJk9EHXfrQF4p
 JYG4JOOZhiYaneB1wNQd6RyX2RVFHI9aABOF2yF4KA4ItJlWWl0ryfibM5aaSFbWqCAgUg7CVpY
 9g/m5PtGeXcDtHyDfavXVUjmpUzupgQLIII/pDZj0iGUPMNhfbfo7+A96ApkbzBsRFhDDpo2ock
 GGtQ9I6PqBrzpQiZLOwV68eRTwx7GJsh8Grh66XJYvAo00daKrwBzL7sG8Z0XbzkL8MN3Y1fUEW
 dJ5OcdfBdML7mNHnrROrWRAo+slS6YcJkHKiUxBU+Z+e0oX7Xh+h+DJCWilJeZJshxq3XWIS8Ho
 BXM6MfCLr8gvMtw==
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

