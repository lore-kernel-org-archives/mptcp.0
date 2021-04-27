Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB38271
	for <mptcp@lists.linux.dev>; Tue, 27 Apr 2021 10:08:15 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id c17so6389385pfn.6
        for <mptcp@lists.linux.dev>; Tue, 27 Apr 2021 03:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5qg3ewgSL1Sjqds/O6pKnG1emFF+l6oCu8M5aFmzdlI=;
        b=VzG4qWso2VkBJTQrP1XMdB2ghh4tyckTKgy9TS+/v2iS1MtvZzGNYX1bwViUJg9Mhq
         r0e6lRhx98Vs5dw6FWov4fYotVMu+PQDtMU+6u6iijLSuo3tbnQ4hub9tdfRLoiWM97C
         RlejqVw6Yom2hPFV2D9jYk3Yj030UzHXDUKuXfOw+slBbgNT7Z1uxwigvwm8ajhyqEcc
         PJ2fu6fi04as7DjU1w3M9yOKYFM0MNb0+89Lq6l7NNs8kKQSRudLyYA3WZ46CoNQmwhf
         nY8awkrJpdZHc5GJZQORu7r0w+/USc9VdYsIe2N35RfH9zYtZHFGGhBeZP7V7AOhAthv
         Z2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5qg3ewgSL1Sjqds/O6pKnG1emFF+l6oCu8M5aFmzdlI=;
        b=GdBSslbm021pmCKalu1T8ADH4l8qV4SIIRLTBM9Re+ihULdur7Bguy/4SUpTFR5XVC
         Lpofd8q1dL9r5WQeqyI7Y/ipkSIwEy/klpmBg/vSO6IlX7qpBnQrmric5lUdIMSMjtg6
         qdSv9/X0Sw1n75hfbazuglsl0z6KiAXbFyUdtrjWoWQxkdy3k9dtCGREHgdxOV1UB5Zy
         tdOjBG1/0dYuNECyL6faU4X3Srj9sWavaQgFSHdRl7jCi5YGNeskDLABIGT4K/MhuynV
         /YkacHaTv9oHx3LsRLEtEE0q2ZUd6VQIHutTUPnXIFz/NsZ8EnnOjuzrL2rtnGuR+Bk4
         AC2g==
X-Gm-Message-State: AOAM5336sBmJCn5Rb+uJnlOG9rqmwpl/3341B0BvMBu6LM2y7FkD5ShL
	909gVLWfASq8i2UPStXBC42b6rCghdE=
X-Google-Smtp-Source: ABdhPJzmfVqPBXmdHQXI+rtzUlZJZeLVPUIEl6t+IehywSt8E0JxnsfQrsAqg5DT0I4hi2gLcYqvww==
X-Received: by 2002:a63:d153:: with SMTP id c19mr21062940pgj.311.1619518095063;
        Tue, 27 Apr 2021 03:08:15 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id q26sm2297319pfg.146.2021.04.27.03.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:08:14 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 5/5] selftests: mptcp: add join_denied testcases
Date: Tue, 27 Apr 2021 18:07:57 +0800
Message-Id: <5038ca65d65eb20a4674fbeb11acbe0e6d250d71.1619517696.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <3afc2c7d715a21cf73d2573909be1e24fc89883e.1619517696.git.geliangtang@gmail.com>
References: <cover.1619517696.git.geliangtang@gmail.com> <b1aefbc214bea1e5cef3dcf3c1c0b5caf502734e.1619517696.git.geliangtang@gmail.com> <073e1b2e4f7d03b0302e8eacb235a728774b3104.1619517696.git.geliangtang@gmail.com> <945e6d874461b595c1a08916d87cb4fed219ac40.1619517696.git.geliangtang@gmail.com> <3afc2c7d715a21cf73d2573909be1e24fc89883e.1619517696.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added the testcases for join_denied.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fd99485cf2a4..c70555a82418 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -124,6 +124,17 @@ reset_with_add_addr_timeout()
 		-j DROP
 }
 
+reset_with_join_denied()
+{
+	local ns1_enable=$1
+	local ns2_enable=$2
+
+	reset
+
+	ip netns exec $ns1 sysctl -q net.mptcp.join_denied=$ns1_enable
+	ip netns exec $ns2 sysctl -q net.mptcp.join_denied=$ns2_enable
+}
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
@@ -785,6 +796,22 @@ subflows_tests()
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow dev ns2eth3
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow, dev" 1 1 1
+
+	# subflow join denied
+	reset_with_join_denied 1 0
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "single subflow join denied ns1" 0 0 0
+
+	# subflow join denied
+	reset_with_join_denied 0 1
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "single subflow join denied ns2" 1 1 1
 }
 
 signal_address_tests()
@@ -850,6 +877,24 @@ signal_address_tests()
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal invalid addresses" 1 1 1
 	chk_add_nr 3 3
+
+	# signal address join denied
+	reset_with_join_denied 1 0
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "signal address join denied ns1" 1 1 1
+	chk_add_nr 1 1
+
+	# signal address join denied
+	reset_with_join_denied 0 1
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "signal address join denied ns2" 1 1 1
+	chk_add_nr 1 1
 }
 
 link_failure_tests()
-- 
2.30.2

