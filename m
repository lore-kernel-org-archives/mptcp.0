Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35FF1FD3
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 17:43:49 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id u1so10310567wrg.11
        for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 09:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z5mCHXlgCr1Jy2Vc+TRuUoNTiJ7IX+SwmRwresxLMD4=;
        b=eWT1RfGWR5TO2mYUviW03hfaLFuR2Gn6bbCjXlrHX6V7+ewffer284wN1oKAt8DlXS
         kdIVM6Br5x2O8+VaNMSaWglIDYGD5L6hk1ELH7BGkRb+7uX8eXK9RE1qNHInxAFrifwc
         o5JgPPrYIIYKCL/IBAlwq2cFHKd78uGn0oIbb5ZhkG+jZF+JXUmxYz11eawT9kGGHA0q
         aE6OJGSFiHOXYr7DvpUOHFabjscAJ8y+7ab6NbbRTWalDr/CTjuF8hcoibN23nO+WjGY
         x0NtueptMLLhANWtyl6siAYwJyLkRyjzUEkTwZR7eGfk4KXwUuzqxxbLP/bpG7J/BG/o
         WbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z5mCHXlgCr1Jy2Vc+TRuUoNTiJ7IX+SwmRwresxLMD4=;
        b=HA1wtreJ0krlSbxgkgQfq2GO1/FnC7Y3OYeE/aDYn5eG5/Y35zXpUXAZ/7K7kkogPC
         EvwWcDOy49x4SSPulYhS5QesqQLFpnjGz0+Cz6KTGw6lIzx68DpY1ScmSNc9CCepVPzm
         erGDlaWhrbuWQ5JxUV+cKA2sFdE/YTZTd1d21DEjjMmbQZ+JPrtEslwzrr3xSIaC4RhZ
         +TM/YipPUrnp9g0xs6kZ+JQSYkEI7n0SiLazuj1MypTGuIXei/bRuI8rrE6Vs3gKh3dY
         wNPUJu8cLjjvIt15eZF7p/a2kd6RQyzjlFQT1+f7ILiqEDtqkUzAaltNKqXWsXaZE87i
         rBOA==
X-Gm-Message-State: AOAM531FoGC9bBbnE8i3b/4890H13U1/5SO2fQ62S7iqU2eiFgOb72SL
	acn1K5f54TjZPTaj99n2sB1MH9LKunfnsSaZ
X-Google-Smtp-Source: ABdhPJzNspp0iZSQKOfz18DcwmUxEw1T9zH/PGGn5aB5V0A9j89E1KxUrUNoROJrLV+qxjc6/YDo4g==
X-Received: by 2002:a5d:61d2:0:b0:1e3:c0b7:c3e7 with SMTP id q18-20020a5d61d2000000b001e3c0b7c3e7mr3079085wrv.682.1645119827793;
        Thu, 17 Feb 2022 09:43:47 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id 7sm23060203wrb.43.2022.02.17.09.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 09:43:47 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2 3/9] selftests: mptcp: join: reset failing links
Date: Thu, 17 Feb 2022 18:43:23 +0100
Message-Id: <20220217174329.826430-4-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217174329.826430-1-matthieu.baerts@tessares.net>
References: <20220217174329.826430-1-matthieu.baerts@tessares.net>
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

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 747dd6d887ea..6e84750ce3ae 100755
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
@@ -63,6 +65,7 @@ init_partial()
 	done
 
 	check_invert=0
+	FAILING_LINKS=""
 
 	#  ns1              ns2
 	# ns1eth1    ns2eth1
@@ -1411,7 +1414,7 @@ link_failure_tests()
 	pm_nl_set_limits $ns1 0 2
 	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 	pm_nl_set_limits $ns2 1 2
-	export FAILING_LINKS="1"
+	FAILING_LINKS="1"
 	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 1
 	chk_join_nr "backup subflow unused, link failure" 2 2 2
@@ -1426,7 +1429,7 @@ link_failure_tests()
 	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 	pm_nl_set_limits $ns2 1 2
 	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
-	export FAILING_LINKS="1 2"
+	FAILING_LINKS="1 2"
 	run_tests $ns1 $ns2 10.0.1.1 1
 	chk_join_nr "backup flow used, multi links fail" 2 2 2
 	chk_add_nr 1 1
@@ -1441,6 +1444,7 @@ link_failure_tests()
 	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 	pm_nl_set_limits $ns2 1 3
 	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
+	FAILING_LINKS="1 2"
 	run_tests $ns1 $ns2 10.0.1.1 2
 	chk_join_nr "backup flow used, bidi, link failure" 2 2 2
 	chk_add_nr 1 1
-- 
2.34.1

