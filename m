Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88997748E
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 17:06:58 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id y14so42822660wrq.4
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 10:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680887217;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EbeUnaxCToMYLf90EZg17RWGgr6qa3CnSSvyzF0rqyI=;
        b=RpjVJIEFkZ7U6+ZCvDzT8mvR8VdhSzB5QCAUQI1JOHI1rLDM+YQFuJfHjpFeaz27cL
         c4OgaCqpdKru9o7qUMLmOjgyOztVlj4cYv3JjB4atmH12usOsY00QWJWDgnlEbqdDBUN
         XQPDtSGcYmUJKU4Z4w09HUWGIN9CcG5HGPQPvo/ZYyV3Pr1gn2fkCfyIaThQEk6ejYx8
         78QnG5f1rkRnbQCsPMViyTCRMrR/+WXjcy7C9RITM6+RQvMkrJB2m3q/Vp/5SIKnhxvk
         Nmfpzlai89kXPuo2Ch51SmIH683rpvlKQWeKps9A7sNDqnO3Rv8E3t11AUBUGyhRtqmL
         cx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680887217;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbeUnaxCToMYLf90EZg17RWGgr6qa3CnSSvyzF0rqyI=;
        b=PqSe+3rk7EUK042exybota1VJrl2jOyZJo0hSTExIFKk+ebpSqw4IW/zJZQ7C8Gisd
         /T8kGWPSBQ01LRi/czULz5EnM2TlEl63+tvXpv4QcbWtxJpNM1fFr0b6MatuZpGzjlvk
         4YRbPRK3nBkgbehJhxx3Ud8lpNR13RBEikVQ4n/rQcSKCymlCi7u10LeT//0f6ga9jpT
         OftQX9YENxuwZNV7UNIBY6CoUeVz2yTUCce73+opbDwMyrJAvRrUIaPrg48gu10OLVv0
         vLoKh8Aa4kQMyk3HtuEIZC6zAmIKCr46RGOjXr6+1D95FJFldGJnGf/nlHVH2ufHSbyp
         VVIQ==
X-Gm-Message-State: AAQBX9fxd5rqt2S0DKThPkGNFNmTjLrHXFcd8OvqGm7CztNvcJisGvRk
	W3lnk1rsbt9Swe/QR0zYJZMnzdpjK3lHEar0zvn0FQ==
X-Google-Smtp-Source: AKy350Z6hXLPWs9obxjomBEx5L2o9idCpFI2XldWcEz6T0llVZuL8HYjEOleaXLWC/owFQ6CBCoPgA==
X-Received: by 2002:adf:e94a:0:b0:2e3:a038:7870 with SMTP id m10-20020adfe94a000000b002e3a0387870mr2029254wrn.40.1680887216786;
        Fri, 07 Apr 2023 10:06:56 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id t5-20020a5d6905000000b002efb4f2d240sm908360wru.87.2023.04.07.10.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:06:56 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 07 Apr 2023 19:06:40 +0200
Subject: [PATCH mptcp-net 06/13] selftests: mptcp: sockopt: skip if MPTCP
 is not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v1-6-246ac567724d@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=f6gNm3LpzKNwEQa/BeQWxsJzjsjQQQdbyMTTSBpnCog=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkME2qiW4/hcXwzoaeG5LvapxrRKrlPuFN4T04e
 REOplcKZSGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDBNqgAKCRD2t4JPQmmg
 c0ZkEADLkIUfmWqkZYfPpr/CZIPd24hYVdBU9DA9I1einS7PNPmXHqpPDNHdTBoPwj/nKPYjR7R
 qO2LOxdFq9THUK4rlYuWPYb31zj65t6ag/RorNr65/teVHlWV7muA8m4b90P//XeXwihKJYuPyz
 OSJuUVeIiMh4N6Vl3Hb4VOTCV4cqIf8wlF9b+e65mNTD/DO6t9MQ05JlBE1DhK//3LbxYUBVRMC
 juoKx17pS8xZAsViqobhyCHWDL5UFGpS4YlTnOHeD68CzICIltB82v+5ix3cY0zJBDGstRo4E1F
 8l/AKoBlL1qCDIHgV0yZZKDsbCUYKsDW9WGlkKMrhlFdDFIyjdYQVYVs/VAnKOgTXFlLdQLd3YL
 Qf5Yvo219XxuB6wKPyBmhSAvfXHAk3jnRul/0ufj9QpziZg5H4GhCn772Hpa2s2jpX5b/AlJV/L
 WCSGingC6vlRBkFifru33aMpzpD32cYBUj6bxc8ybH/wUrKVrmLGV4bsOkji0VjJSMmOPEqSQur
 Ewnipbe/9pa5WF7GwBun2ftMJ4hn+ZeMYX4ao9ThWXZlYZ//tJbPWsrUxpOjzdsydEEF2fwS2c7
 9CC2VRzrC45hKpE8mo4eCfrIGo6oKGJAp/P+uJgPEloCHEpTGJaJN+wClzkb66Tu6TsLiar0QlW
 G5BozssOsY0Cn+g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped".

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: dc65fe82fb07 ("selftests: mptcp: add packet mark test case")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 1b70c0a304ce..ff5adbb9c7f2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 ret=0
 sin=""
 sout=""
@@ -84,6 +86,8 @@ cleanup()
 	rm -f "$sin" "$sout"
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"

-- 
2.39.2

