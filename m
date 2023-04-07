Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988F96FC7
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 17:06:54 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id i9so42806251wrp.3
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 10:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680887212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WHvjOt6wwW2RhWrZuiqV/kcUTgNsy/iCkcV9199QHxU=;
        b=AXTHKZGSmgRLCYiNUf+mXkwvGXYqFZFELpHMt5g6GUwcUD8dkP0/VX4NOBs8r6Mvi3
         OG7m09D50CYbZmtMNdbSay4hr0ESH5RW8IkLPiXoxrkUNJjuGaMKp9+3iUuf6qc3nOe4
         09IFSr/wTRdEz1o0w2YYdM0LNNHuIxLYeUhiMjyufMbIrWpIPQKGXOqQZSygo7Gkh/1A
         ZIsS/83mIvjUCKjQ5EZ4REiq+l4Lt56yWrtjNdSzKcPzXoid1CKA4mOgpZ5Ex8Mdlvai
         M3tD8OdMcrUVLuHd0fCyRIttXZehno3G44PhqOM0kVRyGK90eKxydGr/ccnpuWPCySts
         k4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680887212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHvjOt6wwW2RhWrZuiqV/kcUTgNsy/iCkcV9199QHxU=;
        b=RzFNMRzHzlaSFHBLY3+dscBl/f3IdHeEUauck4qbLrhenw4gpaeWkfdfZ2eOtj9Ttg
         SU1wFB/UA7VkDxf4nRAGXf3351FMbsJFOc8FoLCQUUqYioG6+K8YNve4srmkha48BVJl
         NLdBQT3k8BJEdBS+0YdcMXSQDQvBrUnhIkxzRJwC2Dly0KKMyLyJIu/RdyQs55lhrqQl
         dar4w8hGZKs17zfVJyIb9OfZGnLiZSJMjkYpYXF1I1g0610t7DGaBzsnyxNdfkYZLH6t
         1/75kz9BFIFyfNy6EQHOhlu13tvSUfMtoJN3OYZrLk3D8izC6d85j/Zy1Rj+6disZl/h
         gMIg==
X-Gm-Message-State: AAQBX9fo+fE8N61TID1ARRf5wfdttK2P/IYhRPfQ9tAXUWTCTaSMOpP0
	i1gHCcVFSxxqQAbjznY6sA3Iz8KRd3VYPLOGLQ5vAA==
X-Google-Smtp-Source: AKy350Y6FTO1rly03tITLfbvlZajkp1N0/TiPAkQ6crZGJY9gav7LHDxCmF2EmYXKVBAx4Wt+AaIzw==
X-Received: by 2002:adf:f591:0:b0:2ef:ac43:5135 with SMTP id f17-20020adff591000000b002efac435135mr1723753wro.25.1680887212686;
        Fri, 07 Apr 2023 10:06:52 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id t5-20020a5d6905000000b002efb4f2d240sm908360wru.87.2023.04.07.10.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:06:52 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 07 Apr 2023 19:06:35 +0200
Subject: [PATCH mptcp-net 01/13] selftests: mptcp: connect: skip if MPTCP
 is not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v1-1-246ac567724d@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2392;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=2At//acZBU4t1hPu2dkJ4AOoFnmVZ7wgTUg3SwSVPOk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkME2qodCjSrl93g5MZ6A9kfJ16MaNLraflD9UE
 +TWMv5Tg+SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDBNqgAKCRD2t4JPQmmg
 c4YuEADb7gBRKhWqc/VdaYO+KAWtEa49erjD6x7dy8eqrCwQkcKyRMDeSh+/3MOpXnitJgoykPV
 6YXw9YtVgfwwE/JjKyvyLUkuFCVUWeY6m0WMB7VXN9UOGywzL2dgB9tUrv6RCTJFn9KZac0RXOg
 ysrCmppDHmPyiGCFMVoGCcSn58Fufl4WeD/ozTq3l0W+rtdsaRxO2bb9JYdjQ1STaZw3huOrKlU
 1ONIXlGTFjGjxUrrIW4+D6mjS33km/WSvQQF/EMLYOjBBjYOpWh1ssJrWf5vb9RGz/cmGqT0KvY
 SMqct7ab7nbydKbOscFBt5IFhOnv5FmCxxizELXEQnr6egsa8tP4AhZkQDGspwYnbKevSu4OKdH
 gXX3jmlvfuaRqPwIHzQSL7KfPJRZTaYhDmfMGSREARKx6aygZGRYO2nD8UMbNYgoSqBXDax95nz
 a3m/zFd+SaWbtLyoJRIecKRyYw4oy/nN4evsHxFHF5Lt4vVpYpHe7NRVmZzQiYxMsALQlVgoUkH
 0IwzW018zvWuObedrzJmBb1Whkq2ThZVddZUj2lYu9iOFR4vlb14JxXm/evKjfqnZBOU68lz43C
 U1rDutYUKGlSHBrgBZ3dmnCOWNedQDqz60cJ6qeGOh99knsf9REf6VehZ7uaEL8+1X3iYVx+8IN
 HMU+j5VkEkCrYCg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped".

A new shared file is added here to be able to re-used the same check in
the different selftests we have.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/Makefile         |  2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  4 ++++
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 11 +++++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 43a723626126..7b936a926859 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -9,7 +9,7 @@ TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
 
 TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq
 
-TEST_FILES := settings
+TEST_FILES := mptcp_lib.sh settings
 
 EXTRA_CLEAN := *.pcap
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index a43d3e2f59bb..c1f7bac19942 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 time_start=$(date +%s)
 
 optstring="S:R:d:e:l:r:h4cm:f:tC"
@@ -141,6 +143,8 @@ cleanup()
 	done
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
new file mode 100644
index 000000000000..eb0feb76e2ab
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -0,0 +1,11 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+readonly KSFT_SKIP=4
+
+mptcp_lib_check_mptcp() {
+	if [ ! -f "/proc/sys/net/mptcp/enabled" ]; then
+		echo "SKIP: MPTCP support is not available"
+		exit ${KSFT_SKIP}
+	fi
+}

-- 
2.39.2

