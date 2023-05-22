Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B1013AFB
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:25 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3f60444238cso14215335e9.3
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773503; x=1687365503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCrvs9KuaJPBHPbSLawjvznF0KYbjCDrVaQ7kMdCOUk=;
        b=HQbOwDea7eCON1K60U7dMUFv/fMSsf4LK0JFx262LV4jOzWYPeXfjcTXvqYP5mBRgm
         NhsklxmRlcU7bRUcO6vpxGmdTGgRI7WOgVLNxnwPzyF8p4BV/P2+7utZGiLaMxsrVUXk
         e1A9vAFv1g00VoIJLs8b7tIdtlfoJ3p2auneCsbvSFfXO/qb1i8BR+hZ+2Mi636JihE5
         lOpOP8Vu9TFiag7m7iGMVW44AFbePyYVLzQzGcH5HEN6DngmXtdl7XnLhhUPBB+MCXVx
         4IEQeigPru2v4BJCORGvyChVogpMEmDH75DEG/GMHfFSH2pti2tXYtxQGdbDpX1CWZyB
         4HiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773503; x=1687365503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCrvs9KuaJPBHPbSLawjvznF0KYbjCDrVaQ7kMdCOUk=;
        b=guZsO0Ww3jj3HqxGWNw+Gh4zVywjTcqcYLx2uB7SfvuJdvFPvFfVfl7oUizPo0cLHx
         WUOYvdGMMDRo6lL95AnykQt1ADw1JaLWcaNibDZHr27wzZES67C2YRRPrsJDNGFkTat8
         D1wKU9rhJaKVK8mmLavxonoQzxPgJ1KXeBqlk1LzNCT7fTY+XPo0aknuqawKiARlK2ra
         mSG6XAT7SafhslflUQda5aJyTfuxatH0YiuRS4203vLNM+Oo1iGl5PRUnH5o/P73H1Rc
         2+qF3qzFOGfw/zvRTtWO1fMMLCQTcG/do+4r1Z37fDwaToOaamGVvCpdnc5bGHiGGqqA
         A4+w==
X-Gm-Message-State: AC+VfDxmYEoCx4yqfnwgSEGhQqTG2gGiQRadc1L4RQ7JU57mQnPtYY5o
	LZGayLU90YINMc6WNVkr2Gwb5GWyjzpIX8CTG3nQRA==
X-Google-Smtp-Source: ACHHUZ42xDDqVRqkYXBiO2Tp0KUssJUWsySRfDdji9M91MOSKLvT4Hi1OWae8OOhkebS/y3Tvv/r8A==
X-Received: by 2002:a05:600c:2057:b0:3f4:27ff:7d52 with SMTP id p23-20020a05600c205700b003f427ff7d52mr8500703wmg.2.1684773503773;
        Mon, 22 May 2023 09:38:23 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:23 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:50 +0200
Subject: [PATCH mptcp-net v2 18/37] selftests: mptcp: sockopt: skip
 getsockopt checks if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-18-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1494;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=icoGKoeuZNXRgie13vOw6f4dROQKB9nPaAGUyT9nKr8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pwaPs0/d1WT88sB/paUdMJRDD72lAVprH6x
 7lgeUlYaRWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacAAKCRD2t4JPQmmg
 c6j/EACuUQVhx6KjB836+siMc956SSrPETDrq+fw7VpVAb5AJ0hkIdWVg6QtxZBM0HRR1keIzUr
 KAC2n4O8qJFRCnxqHC05S5dkPoBDtv94S8PTg/TYH6tSRhH/xxE6qzw6WDWOBW8WR+KWk3lKau9
 ORuL2DqmdlJlzoH//OCgtjYFeaYu5MlqhMmqAek4uizY8R8FEcXFw7Ho8fHpgzObWNCkiDb0V+n
 nJr71+jXrV+2idPaIwHPwCSwPu010aLTvP9MsfmH9G9ntpwyPEiYJhzRu2bHBSxLVcVTZWyzp8e
 /5NrVRRb3wxYnQIllb1MlgJzwzV3z29oaMwEq/UNqCduXbXz1Pn9+Df3c/PoJYA9278FssZAr75
 BV3V2JSgtXKJgc+MhNpkWdl0N6h14xDbAVJOFKJFGPIM4rHONmRsOmPxHe6tWJD9NuR/IUYSVwj
 z3BPP3YAwUxk9Q69hOXUpYkqNgKcjS0KDKzWmXVbvGGVKczwsBiABS7zj5R/R6nfyC2AGb+3zQd
 hBo6NlfzABzOY9tMFVUyw+tDZ4ftxKfzy042WPHva0Y9HJCA5TvUVanEt2QYxNwZaORrODNLp/X
 4eEjUwrtGBdmGi80pltBHrsydSYPGQffQ40Wvv5E2hUEsSpbh6B/nJReyPhYbX3W79ZC8sdLxs5
 TEVcjpQhpaZiIBQ==
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

