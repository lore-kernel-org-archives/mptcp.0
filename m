Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37226FCB
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 17:06:57 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id m2so42792504wrh.6
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 10:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680887216;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2moyIEpgMC4mAHvK5C3jCKDi9tp9AsGCBR572h6d2LM=;
        b=Ceqy/pePmqCT0yPTuXX4OvV2eUKRsA96GrwZIbHYCYqog8yxxqdbZglb46k9fc/6dd
         1mICXI5KjEvTuXovp/5gW8fsAT21Htv7uU8Q+ivOSqgfotmv/E90mL4/FUifsEW4UyjD
         Mv+y7Gwk6wguYJ3AoKVL8sm4m7zH6s8h3xD7w8ZjOLdYklQ/3JWAZPx2+q8OMsAsI1df
         nvmp/9IEa/AAKyjHbzqMMQnYhqEldNjbufR06/RLMJSCcLb2RFEuQr6XE2I3ciil1Zkz
         /HlX6EJG/RwWgA5lqJExYB1UfdXTmY5oGH2BH75ugvM+Li7hv4LobtUlu3W+UZxWr12C
         vkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680887216;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2moyIEpgMC4mAHvK5C3jCKDi9tp9AsGCBR572h6d2LM=;
        b=1d5XtALSclKNTvIfHKkPeruvic4XZ6PqVkln8ucprH8lbAojzOVvon8cwO4ZhjRTJT
         7cnXcHhmSE3WiLWxMvNq85pZwFFvMf5Ytn+PjXcCBS5tfRGI3yISDvOa1vin0wxLi3KN
         S537Fh1IfUNmSNyGnRjwyFjupR/4pOJB5gfXdGr9k6Ft6lk7ltUrkaoKkEsP/e7oxWHL
         yU/wZgAPy/Bz+3phobnyOZdIOROKscAsck1D2bT6j3zUpIdhAEuP8W/IWn9VGm96zFRW
         pSDQpyY7DHWfG1BwC2Xsu7GTFbruZFV2nB8x4hCpP50UlcA/PMlVaZ11hxhKE0W+mT6b
         wIaw==
X-Gm-Message-State: AAQBX9eB+mAGCaNQVbejYDP9Z/geYZVDs5FBpLXTxgdteCeNMOjUppzq
	i5NmdXb7MYJ/L0roPY/FRq8B+RdJOh1Aa3iQGEh1JA==
X-Google-Smtp-Source: AKy350Yx/PxjgPOwROY/fJNTmZMfwGkCNEfxIeawb/6R7vdAlnXTCxn+id94cEsCT59VJDD+Y+a/UA==
X-Received: by 2002:a5d:6988:0:b0:2cf:9889:8428 with SMTP id g8-20020a5d6988000000b002cf98898428mr1824845wru.35.1680887216033;
        Fri, 07 Apr 2023 10:06:56 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id t5-20020a5d6905000000b002efb4f2d240sm908360wru.87.2023.04.07.10.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:06:55 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 07 Apr 2023 19:06:39 +0200
Subject: [PATCH mptcp-net 05/13] selftests: mptcp: simult flows: skip if
 MPTCP is not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v1-5-246ac567724d@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=uQrhrN3VLtLshSxxi4lbPMHbgQWWhmUdbF/7BUpdA1k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkME2qiaU6M83MQhlCsURJPoh1eaYjUvYjHaQ9i
 MkNKgTDi6uJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDBNqgAKCRD2t4JPQmmg
 c1noEAC7G4dzk7fVUgrOV59QcWxP9w43imP5JGo7/UCwkuhWmtAUsoEFthuu5j1RdzvQupiZMtF
 U29YGW9B6JGQdyo85an2oZ4TYC4Y9XpR+vj08rccx1AisUkvA5oLyhxAqas/RJ6g195NAMf+eSQ
 G3aEDD3tvm2CbR6YdW5rIex0PJ8x3+ePcn9Z51DL6c+azMQOzJF/VxJG9Y/SDOZUpZxv/M2LIk8
 HGDrRWMfMVSbjst6mLTwiSw4b7S/owCKjjcGejIVj5xF2yEY74SMQfreuQB3GPatPcXK1ZpKmWE
 YGnU4WmFdJx2cpVSXg1SBnQY5AD+Hn8283ORCttej1dk7x1nq+XT9Nu9NcL5YLxdLjFbBozinVk
 enhoe/z41Xk+jIEBqcS2m8ZXtfYOrZq2p0sk7XNzcWxJGIb5ER1WwowoU1GRzQggyJT/3vVrsQH
 78oEzvAISad11DW5Ui2qwQSsf1Ta4gWF6qql79QiUiR7WBmo/pTMWuPnAVYxOeAaCHpxLAzcYnh
 6BL2OpsTAS5sbP9PNv2BJpDCZUGw4PW6aMnin64CDr897ANGK7Bq0G/251LY2a0q+YZicnO0KG8
 VSKymjA88ZVtqh9xHTRYNrJoS6eTDg7sSI/GOJg0XOKBLcgkwIHwpj/dolGG6+LVNeoTownpj+2
 5EwHPVjWrP4WWOg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped".

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 1a418cb8e888 ("mptcp: simult flow self-tests")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 9f22f7e5027d..36a3c9d92e20 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
@@ -34,6 +36,8 @@ cleanup()
 	done
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"

-- 
2.39.2

