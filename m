Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162361B62
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 13:56:49 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id cm8so2974097edb.3
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 05:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tt5AtZfDgzS7v94Fv77l+8XRNXqq9FkUAGIVf/7/K8I=;
        b=AC6pAb1BX0RYEi/0jVIp0YJU/g38we6kE/9tqkWeUTDiGyRdVyd/lFKwUpNXqW+K1V
         ggNA8F/osXzvm/VM27qrAZmvnizVXf+giwb+JZ3E2JW4nK/xqF74BESpiCvjV1y4/lYi
         U702dKIyqv6l8pDiSCjqagGFwGBZB9F9l+6i9DdTM0vnnYhIkTdVKS57T+GxL8oc/LYX
         ngB9Tpnx8QRLbRQdkRlLmr7+VaMbfCA2Aghowkg5bbLJ5Br2hmkC8+tQnCrnbob8Miz2
         68bZBlJkMngOkQ/DUGdbz1HxK7obd7gg0e6VPI7tVu9k2djPH5RJ8AHDA9UcsfSrYpo5
         cCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tt5AtZfDgzS7v94Fv77l+8XRNXqq9FkUAGIVf/7/K8I=;
        b=XQRGn9Qe69wyR/5EXV03K5+LuiGgutpsN9+cqLmVtOFr0KDgRVYz+wr9ntm/JTsopK
         7PDCFZ+cRVMvZvnUnMVM2p33aBW+byZexIeoSRIlHJmNvqnkI6b4ghdBc87fBAL9q8IK
         9zBNnNVR0TOWYDATIOPPSgv95y8j8ZvBsap9i5mpvvJikK952o2UJBCoKRY1Htlwnttq
         w5QPDYBBy8u9mYtqbBMorHEbys0haKayqeObPlRttiMHcQC94wLOK49pVTc/tL+Jey46
         Aw7ZvzLB94qOOPFz3QEtRwzWcDJs9SpCi4jH43CyOeaKIxFNznKh50tMNE7daY1mVjJM
         /78A==
X-Gm-Message-State: AOAM5313V0Foy/cWn8X84zYlaMFNViPTbc2vR1vx7g5LJBO4coBv5Hhz
	vn7gWHoy2Ts4WxrAmwrriI3IFiWD+2kg6R+tU1Y=
X-Google-Smtp-Source: ABdhPJzMmjc8xr6LIceqabnRTXv29EGFqRswRMlaYRG2BRNZfKcmyYXbc7jo083C7rO3fTdmgqvhoQ==
X-Received: by 2002:a05:6402:d0d:b0:412:d49c:74d3 with SMTP id eb13-20020a0564020d0d00b00412d49c74d3mr2389866edb.207.1645711007996;
        Thu, 24 Feb 2022 05:56:47 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id 7sm1360733edw.37.2022.02.24.05.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 05:56:47 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v3 05/12] selftests: mptcp: join: reset failing links
Date: Thu, 24 Feb 2022 14:56:12 +0100
Message-Id: <20220224135619.2523272-6-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224135619.2523272-1-matthieu.baerts@tessares.net>
References: <20220224135619.2523272-1-matthieu.baerts@tessares.net>
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
index 9d14851f9732..eb6735e2d570 100755
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
@@ -1712,7 +1715,7 @@ link_failure_tests()
 	pm_nl_set_limits $ns1 0 2
 	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 	pm_nl_set_limits $ns2 1 2
-	export FAILING_LINKS="1"
+	FAILING_LINKS="1"
 	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 1
 	chk_join_nr "backup subflow unused, link failure" 2 2 2
@@ -1727,7 +1730,7 @@ link_failure_tests()
 	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 	pm_nl_set_limits $ns2 1 2
 	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
-	export FAILING_LINKS="1 2"
+	FAILING_LINKS="1 2"
 	run_tests $ns1 $ns2 10.0.1.1 1
 	chk_join_nr "backup flow used, multi links fail" 2 2 2
 	chk_add_nr 1 1
@@ -1742,6 +1745,7 @@ link_failure_tests()
 	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 	pm_nl_set_limits $ns2 1 3
 	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
+	FAILING_LINKS="1 2"
 	run_tests $ns1 $ns2 10.0.1.1 2
 	chk_join_nr "backup flow used, bidi, link failure" 2 2 2
 	chk_add_nr 1 1
-- 
2.34.1

