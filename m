Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA2515495
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:48 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3f611ccd06eso44515345e9.0
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542606; x=1688134606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0ei76i35q+o+nzUQpSan8v+cX9LImprp1hU5M2lz48=;
        b=MoMvBqS/cCsvvmLyc5XnrExwoAEUoqwRZ9sVbjQjjaApO/Rfxz3DnAsISdLb7Zy64n
         JXNDOS2pdvTDzf8GDDmeQ3m0Lrorps+b2m5XnMC7Z4YfRyeXfjjUTQYMFDt+x6RkzeoW
         XzMAAyx2p+RZBN5McepK2KhKNJofHxGCpq08TWYz0c3zz42tqm2ChbSUS40dduAOPvLM
         PZQBOdKycF98YeQFOt8ncv2W93ZRRqlMALJkYsBLgVg3sunYDx4jft2Q1c2BTf8tAAof
         czn2blJlTKPu2eS6V54dkLile9WyvCGq8Cs7mBCq9Ojw+QWJdIhBe/G/4zhM/4TK/5Yl
         6p9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542606; x=1688134606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0ei76i35q+o+nzUQpSan8v+cX9LImprp1hU5M2lz48=;
        b=ZEkMKWDARPhSN/6c1nTVdGXCHraRBilkNsW+NpvwrK9/L0zW8V6lnvFDbojdVeKeB9
         RLGyqWdybD7kQtHLCHMsqmDmeZH25U5T4VFgANg2pQ4KLeMYpEMyqewoXOnAGbRozycj
         4oWqJBn/3LTpgN4NT8Oam/eEM44cXZ3UylVDFVBeSC/QK9I1r0YJgiwSQoGR5bVhCAHB
         YVYhSbAZySXZ809agnpyXJXGSsYIeAoUE56/TDoBVzz76bqPKWjjoU39PnakH1uKRmx9
         F96CnWiEZZKZF+p/3KXAx7yzrb0f8eZCIZVhZJp0xMiwXGs5FDm6rWcvVbqOfPabMoeV
         j4xw==
X-Gm-Message-State: AC+VfDwLKdhEElsb3YKmZm4vCHZseWy+AIbKi2VCeVHsdEeaMyQYvj8Y
	GAp0HSTLc4L/Np+z5OKh7Asp4Q==
X-Google-Smtp-Source: ACHHUZ6Z/TyZAHyCy65XYwnhP4u8EM/trVGEDvHZp73YPSlzhJ6VIFl+KUFHiReL+DOCfkCkKmhZCA==
X-Received: by 2002:adf:f38f:0:b0:30a:9c8c:161b with SMTP id m15-20020adff38f000000b0030a9c8c161bmr4401546wro.65.1685542606586;
        Wed, 31 May 2023 07:16:46 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:46 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:33 +0200
Subject: [PATCH mptcp-net v3 13/32] selftests: mptcp: userspace pm: skip if
 'ip' tool is unavailable
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-13-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=946;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=xTK/VWv7eqgePWxueOI9iC20Wx6RmAiAnEOlv8Am34o=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bCQFY2CIynhtbiZ0ijPENKKdCyagxgAkDX0
 OhAWsIQP9yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwgAKCRD2t4JPQmmg
 c67GD/wIKpns6ELvMNShOks7cmoFSmq1B5d2kUGtVUtshllKxtXAxM3uSgWq1NaAje3TulVftg5
 MCdK/LzQX5Vp7JSClYQ0R0/cfD3JV/FHe1lHaJiiLg4vKtVUFKOsQemnYK91PIICC7I5WcKXfja
 UKIqwIRBWvSssgB0h8oBxSDdkK+kfDvSWVh40nSD8N1+plhcLD5Ojg5VzlL1ghyguxS5tqHgGkk
 vO/SGkrSqIQF4kt6syEojNOysqyR3tpkKSeU5dwrbdFb/NEPJF4cb1WYiZTmtoVTTuPjvT+AkpD
 OWV4hW2VaKlG1hu1MFnahQrCrfR+2Qxb/en5OJ1A7EVcWSTpTZTaZnH1mGXYsy+gXr2Dr/qxMZI
 KzXe781hlg4FbnfJsfoeQ67SoVMWzIpQgq3vAoedmPoimlTck8epPp97fnrS2VpAc+9kVa4b33F
 4WLZc2+6cI0pv7j9xqpe9KxRoEoDXWFre2B0NJe+2S/ufeFvGWJ9xudvcGEGqs+k+tM42ia5z76
 kw8UszDWU91a7CN509BAaHVjuYoqGMoqn8oOm6wcNtOt7MqaUskDnsyIFQg5xJC5Hwn4UP2rWeU
 bUDXeFZysHUi7ngcydNvKd4k42C/ExockGa9GtlGhjD1J69f4a1iQtbYeMPRtoXrYnDVtfzddAf
 c40tJrOImDsuUPQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When a required tool is missing, the return code 4 (SKIP) should be
returned instead of 1 (FAIL).

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 259a834fadda ("selftests: mptcp: functional tests for the userspace PM type")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 8092399d911f..192ab818f292 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -8,7 +8,7 @@ mptcp_lib_check_mptcp
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Cannot not run test without ip tool"
-	exit 1
+	exit ${KSFT_SKIP}
 fi
 
 ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED

-- 
2.39.2

