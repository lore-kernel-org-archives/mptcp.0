Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB27154AC
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:46 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f606a80d34so44190105e9.0
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542605; x=1688134605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCrvs9KuaJPBHPbSLawjvznF0KYbjCDrVaQ7kMdCOUk=;
        b=KfcBtDzX2my2L1kti2QToWpmMjRvX8nsUbkLGW78jgO1klOMpCRbVMdbsRPFlIEiSJ
         2lWYLF0bqkNNBti9Y74RP4Rl/5j19oJwSIXzspQShtNhuVdt01mqWPWGfAKPmT1yuHrJ
         /6NPxkW51a8ap/voH8dMGxb896STBGcVcrgt8Ifs10BXEiq07SB3injhAd70B7gbp/bv
         zi7LIGS5mBoOkw0dI+2WHbISoD7jCDsP8Q9YewELRyPJOAjpjbeaPiQBwQWHCy/5eoRY
         eXMd4UmL9M1MIta+c1Fs8cS/hg/sKJW2Yq/jdyiEqmLFtxz6qSHFk0kEQKjYS2meso7t
         tKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542605; x=1688134605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCrvs9KuaJPBHPbSLawjvznF0KYbjCDrVaQ7kMdCOUk=;
        b=KSzWLsMAeXTwAWsYDUVeeQzqi//QJJBuZpw9emrRVGKHXASnnV2QFVS3AC+Lxf8JhH
         4YSbp/xy2n+CY9rFE/akYMyqU9Ev649KPeeD3jVuJdGoYtv7aNEj/M/DKk8Hk6gJvHTu
         3TM2XAxqbumzd7Wmhzc98ISNTXtkeVyHBeZo/rr2FiguUQkLW3L1x3l8NVmpiMfUrZtU
         hxzJBzqfPPtv43DUy3ysf2QqdiIMDZMfRx5yFDOBNX5VnAfmSGTSRSQAzYCAZSPCI9o3
         sSXTIRsb4DyVNpxUYIYhQhltW2+Ap8yf4Sqi2cx1NsoVXELpgp+Ib9M5K/LBDn9goDIP
         GQTA==
X-Gm-Message-State: AC+VfDwbsy4w6Prp1DiQt36r+ebuMBgF1VTCqSRNfUncvxv/T14JdX+3
	pamEg096bLms/fmmvl7el+abew==
X-Google-Smtp-Source: ACHHUZ5pvT5iWLJoae89RndQzYJ38DV1hCAk4FpGlYq+wACM5C/BEERQSertKEgAbn4WJyVkJLo4VQ==
X-Received: by 2002:a1c:7502:0:b0:3f7:470:ec60 with SMTP id o2-20020a1c7502000000b003f70470ec60mr4060216wmc.2.1685542605139;
        Wed, 31 May 2023 07:16:45 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:44 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:31 +0200
Subject: [PATCH mptcp-net v3 11/32] selftests: mptcp: sockopt: skip
 getsockopt checks if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-11-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1494;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=icoGKoeuZNXRgie13vOw6f4dROQKB9nPaAGUyT9nKr8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bCRF/B14Ewpg62oCVZHdQw36bF45BDCQEZH
 qpv0HnCciqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwgAKCRD2t4JPQmmg
 cxffEADCUIXPQHamKu/ul9ng3Htb20gn1Le1evEq0nEC2rOmby/Lib9/REskemKPwTd9GIsJPGH
 d4PVeuB4GaiAiW3qYUwYFg98BVeR/+yMrYnkmGbTBN2f8PL65qb/lvPkvCMcXrBw8v5/P5dnBV0
 UH6ZTcG4Msrc8m2GkQ3WzzBWZMe5x4i70Zlyik7AeVHOR+ftjRW6nWpa0xofI/1j9oVxIU4ojHh
 H2MX8H3W23aW0uSewCO4JDCyyH3mJqD8bY5jGfO6hzzaI33Ev7kCQDgqWDZ+LBYTbaK7h+K+OEB
 FR87U9PFV6bnj3WcGIN+IK8ql2MqIaowLmrH+5/5FtvTwWGd4S/v2qGGLhJc0OGbYEa0A5tWcic
 BkvsCAir+lvLOed7HiMlizw11/7g8T6mBtCenSWjK4rib/ItxdZdhu0doYjHAhiEYN67aZxs1wb
 sDqDwlHVNdIXOOlHiQOHpL2V3S1oGgJxNuEDnME2Ea+tPLL+6VRXMigiYg3m+4QLynLAdIGZBvh
 twoEjbx0ZkUdST2vaDmWFTM8Uk9Lte1ZeCod0dP6zzHvrdmeSEVnF6QIDtNgr9ZnJOLk+NXACGs
 LOT01AUgtN3W0EFukKl6AAyTOS9Bugo2NBQ6lVPJl3pEMjVdx0nN4Db5DAizRDf5rueM2V22rAt
 Cx5lDN0pHryE8YA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the getsockopt(SOL_MPTCP) to get info about the MPTCP
connections introduced by commit 55c42fa7fa33 ("mptcp: add MPTCP_INFO
getsockopt") and the following ones.

It is possible to look for "mptcp_diag_fill_info" in kallsyms because
it is introduced by the mentioned feature. So we can know in advance if
the feature is supported and skip the sub-test if not.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: ce9979129a0b ("selftests: mptcp: add mptcp getsockopt test cases")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index ff5adbb9c7f2..1d4ae8792227 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -87,6 +87,7 @@ cleanup()
 }
 
 mptcp_lib_check_mptcp
+mptcp_lib_check_kallsyms
 
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
@@ -253,6 +254,11 @@ do_mptcp_sockopt_tests()
 {
 	local lret=0
 
+	if ! mptcp_lib_kallsyms_has "mptcp_diag_fill_info$"; then
+		echo "INFO: MPTCP sockopt not supported: SKIP"
+		return
+	fi
+
 	ip netns exec "$ns_sbox" ./mptcp_sockopt
 	lret=$?
 

-- 
2.39.2

