Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835C66FCB
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 17:07:02 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id h17so42773368wrt.8
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 10:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680887221;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AenH2FmFraT4c/STyVW2Wsb0ZFxXwwkey2dSRxiXdek=;
        b=ymRuJVq+CqGVU7wxwJTU4bOed8dPisVFYCISh97KK2+YYUs9OCWXNOHQCKTIfWf0dZ
         1valdGnHlUzXDYNJxS6hvagsu24vT3wOTM2qENOyJaGxi9YvEm3kqSFhWwEjvUlJlZ3h
         0ZjGVCbLqMQ6mFJpOt0UQLmt2Kabgvtab1bXeKOxVojmV/7TNT3/68BzmxRI4ACH0lWX
         Lr3OuZCKGYr8qdVKBoyaWmAfxSZr1+0j68hukKUWuP/oSCrMuueixMM6qE0Y5kBT9LQa
         TynQlXIFSoOUbvAx+QxKN0W/yX2fduErFr/4Poyy/b7iuuOhDIXajRXGGCkRJ0UnzxFD
         Xr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680887221;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AenH2FmFraT4c/STyVW2Wsb0ZFxXwwkey2dSRxiXdek=;
        b=33RQJk/CH4OAzmw/znRpCk+GryIwpaRY0mCywwjYoR1wJWxT+6YJPzWyFxPWB2Cwg/
         gbOBcTEBtkvJWJPSmF2uVW+wzJ3u4uEilCp+jYtatPCMsRuaS0Y4yxpWKDYwasBautop
         pK3kAMhBvs0uhUa27rMOsZmot0cCv6h8NsJQELZUo2m8J7Mh81AUmc2YYM412zizBT39
         6j5VEnj6Eqa++IK8api2oPY7W9yDPmNok4lLOVfhayyduoRQkKsUNc6rpEw6JFApwQVu
         JNlATZ8irSb+Yys+m1L74d75ZPO0Ru8UAJx1MpLy6IcQFwkI01dX80pHh1A/09Ft739D
         QJ7w==
X-Gm-Message-State: AAQBX9fuWObu3Jq5RQjU1VJVClbNZyekv3lMOtOimprVjzsjVoOtdmoa
	4o9+06+ujQg8uFjX1P7llng6DWYB9edLNZwwZlec4Q==
X-Google-Smtp-Source: AKy350ZX53M8TYGK9vepIDMXbuDT4ejfclJovVJRN8NgQWheS/P0APUPiNVuDl5cGRhw2da2NUVJ9A==
X-Received: by 2002:a5d:534a:0:b0:2d2:d324:e44f with SMTP id t10-20020a5d534a000000b002d2d324e44fmr1619167wrv.16.1680887220823;
        Fri, 07 Apr 2023 10:07:00 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id t5-20020a5d6905000000b002efb4f2d240sm908360wru.87.2023.04.07.10.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:07:00 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 07 Apr 2023 19:06:45 +0200
Subject: [PATCH mptcp-net 11/13] selftests: mptcp: userspace pm: skip if
 not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v1-11-246ac567724d@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2005;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=27o6Zik/TIbcH0Nu9FuQeDoODeT3HvzzkeUlyOdIA4k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkME2rsMBPHaxAhpfS3XhBFqdD2rgK6+6Y21bzZ
 cfwqC6IQlOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDBNqwAKCRD2t4JPQmmg
 c+N6D/98dsE7PCFaJjtW4qyRjw4DKgNKD7HwDYXGorkCjBUHNuheuE2YZf1eZZzWRR9GnGtYtEd
 OI7CuXTI4yGx9NJwPUSs82fjPmRfET51rPhqjaXrqyv2HUhOXr+PYKRngmr1ErhY+gNaDvMg1dv
 yNc4r1IwEj9epQMVXMMBakTLHUkr29DABRPWuIOawQSEG3svlc5LMrTtAAc0cz6ipGpTFEuTPm2
 7RE0Q6WU856w66yrCJTiPoNl4+JgZsfMO1kX2KfS+7/GL7e55zx79JG+yutGatcP5ubc/A3o9iI
 646jNuQy30XKFRqRwUCyuLGKJ4HFLIHKu3agYu2ouv/I/23Jx29xKaMnFQlmvvb0EiaV6nEJfu2
 eq55/rw4SnslzmJy3sO7PoSBpttYNPwKXhXOA10GIw5KSVbrCzXj1k8+AwDwwHCyUUeQppXIGSm
 KJDnD1T8nC8rkjTZ2QS84h74KMkMyceOXGA5S0QbzZ2eIyaogKJXmX2Qn2TcnXBD0CNopL3hhT+
 N8IlK5iBZQtriPYul6k7A7hR0579kIRM7pq65rdkcWxFrTOmLGK4Fhx9NTBCjNosBlUCx9dFR6k
 ygKsn68kdMQol1yaQQ1Vau/UcX9hBr6SBBNQxzDjwc5zmAEvfusfeKeZHM6kmetwsQZXYWvW6Y/
 ZUsJDTUJnYwLxLg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the new MPTCP Userspace PM. We can skip these tests if
the feature is not supported.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 259a834fadda ("selftests: mptcp: functional tests for the userspace PM type")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 6 ++++++
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 315ea136fe2c..4bc181485fef 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -135,6 +135,7 @@ cleanup_partial()
 check_tools()
 {
 	mptcp_lib_check_mptcp
+	mptcp_lib_check_kallsyms
 
 	if ! ip -Version &> /dev/null; then
 		echo "SKIP: Could not run test without ip tool"
@@ -3045,6 +3046,11 @@ fail_tests()
 
 userspace_tests()
 {
+	if ! mptcp_lib_kallsyms_has 'mptcp_userspace_pm_'; then
+		echo "userspace pm tests are not supported by the kernel: SKIP"
+		return
+	fi
+
 	# userspace pm type prevents add_addr
 	if reset "userspace pm type prevents add_addr"; then
 		set_userspace_pm $ns1
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 192ab818f292..12556051a72a 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -4,6 +4,12 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 mptcp_lib_check_mptcp
+mptcp_lib_check_kallsyms
+
+if ! mptcp_lib_kallsyms_has 'mptcp_userspace_pm_'; then
+	echo "userspace pm tests are not supported by the kernel: SKIP"
+	exit ${KSFT_SKIP}
+fi
 
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then

-- 
2.39.2

