Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA3B6AA3
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 21:35:02 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id p15so7051841ejc.7
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 13:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nn8BY3qhq/PfVWLIPLNgoIeFpA33i3pdez6h1ESHrig=;
        b=Lcelo/ARs9iCUewWWNkJt3Gp6+KWv258TKQv2JYDGBOljH52B1EeeZkw9KfIbErd+6
         iFPOgNh8nfTJ5Wbw3L6hOiGl+XRI8sBNLgZ+xOi+JPrRRMSnsrek18xjNbEPKWY5E2dX
         Mdq8edUK69/NtVv5gCuOYvT+8z1SnP3SSaiK9lny35K4MbMOkk/GhtiyjPivhKSiNaWr
         +/3COoxJ62G9XEvMwRbf+RyO8L8N1/HfqnkaLlk5CPodUHLgwnrm4rxJe3pBxKxRaRL2
         xZLU38kxyfF8iDRQQ+Oy/LS/qV0bla2ynyuyzHS0HtNXIq0sAUoh0KEQzQ3nM3EEpBal
         RqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nn8BY3qhq/PfVWLIPLNgoIeFpA33i3pdez6h1ESHrig=;
        b=jO7Q3wmH6W9lNAACLuu9FPpYAxYLfARzmADndQuFvZqgoDKaujJ7+XLVQtPYozN46f
         M2sSMsiQ2A0N7bFQ5+Usxgky7psWxk5O4R4td+2+hikEvVlObkDXN8u21WYHg0fhWfpq
         qbfWdUlymqhh+O6pDeYY0JReeK8EXXo4us9QdfMuugCkDEQGxzcURl38hdl6L5PSbhEt
         3T7tAR5olfkDHeTf5X0ZZZkxQg2u3uqWnxFI6qh29YdgTwDUNaCbEqkc1uo6Ngod2caE
         QHKaSGvCa2MpWIWnO8ILZA9C/kORXGjgNUDmezv+qgtarBaLJGGjwSo3dOX+MVS42Dc/
         GvTQ==
X-Gm-Message-State: AOAM530dssQOAtBUgCBzY6NgkB9B40x9csUzE12MR1XOQ6S19TDHiQt1
	TZmcaH2PG++vGa81O0hroavO4gIBIXnarpS96yc=
X-Google-Smtp-Source: ABdhPJwrXS1Y6uhzGOt1EYPSKdinMIOw5CjuNhecgS1uPu+a2Kni763dfCZvm/qBTLmz/wtBT/Po0A==
X-Received: by 2002:a17:906:5cb:b0:6cf:954:d84d with SMTP id t11-20020a17090605cb00b006cf0954d84dmr3995570ejt.560.1645738500879;
        Thu, 24 Feb 2022 13:35:00 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id z22-20020a17090655d600b006d229436793sm175195ejp.223.2022.02.24.13.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 13:35:00 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v4 05/12] selftests: mptcp: join: reset failing links
Date: Thu, 24 Feb 2022 22:33:59 +0100
Message-Id: <20220224213406.3127061-6-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224213406.3127061-1-matthieu.baerts@tessares.net>
References: <20220224213406.3127061-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Best to always reset this env var before each test to avoid surprising
behaviour depending on the order tests are running.

Also clearly set it for the last failing links test is also needed when
only this test is executed.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index aa68aeac328a..f68be7be3d1e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -23,6 +23,8 @@ declare -A all_tests
 TEST_COUNT=0
 nr_blank=40
 
+export FAILING_LINKS=""
+
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
 CBPF_MPTCP_SUBOPTION_ADD_ADDR="14,
@@ -64,6 +66,7 @@ init_partial()
 
 	check_invert=0
 	validate_checksum=$checksum
+	FAILING_LINKS=""
 
 	#  ns1              ns2
 	# ns1eth1    ns2eth1
@@ -1716,7 +1719,7 @@ link_failure_tests()
 	pm_nl_set_limits $ns1 0 2
 	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 	pm_nl_set_limits $ns2 1 2
-	export FAILING_LINKS="1"
+	FAILING_LINKS="1"
 	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 1
 	chk_join_nr "backup subflow unused, link failure" 2 2 2
@@ -1731,7 +1734,7 @@ link_failure_tests()
 	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 	pm_nl_set_limits $ns2 1 2
 	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
-	export FAILING_LINKS="1 2"
+	FAILING_LINKS="1 2"
 	run_tests $ns1 $ns2 10.0.1.1 1
 	chk_join_nr "backup flow used, multi links fail" 2 2 2
 	chk_add_nr 1 1
@@ -1746,6 +1749,7 @@ link_failure_tests()
 	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 	pm_nl_set_limits $ns2 1 3
 	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
+	FAILING_LINKS="1 2"
 	run_tests $ns1 $ns2 10.0.1.1 2
 	chk_join_nr "backup flow used, bidi, link failure" 2 2 2
 	chk_add_nr 1 1
-- 
2.34.1

