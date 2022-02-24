Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA5A1B62
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 13:56:47 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id p9so4525464ejd.6
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 05:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mpqepvshfNyt6d2vM3maMlSAvOqiJZn5oGOXwOrcldE=;
        b=RKch9nfPVIht74tNF5yexDqMFfOzlVeiE00hSjZd0CdNNVOXeIS2o2UFsew6Vtp3uP
         /CoHCBYsbo+dibqSQBp4cCEAH/L9RntLB969nLa9CWSTwLDyBM++Lyyu4h81PgAUVCgM
         CGFOpqYcL4TwacfXRkAnCHwrmNOQlzZzqf2zQSQxWZkdlhY5amHimCsCu1e1/Ge5bxDO
         GFpq8dNZump7KGpH/ygWkyMS2NyuUqDTUy0za4IciTZjmDcWTjxjUtTdyjIaqzZlq4DJ
         CA5m+On2LTZiVx8X9kGfME44T7dkYSOy/znK9gE02PjPoS3Hd16uLz2YgchpjyN/dP5f
         DsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mpqepvshfNyt6d2vM3maMlSAvOqiJZn5oGOXwOrcldE=;
        b=ZM+NmKk3Lu7vxTHk0hXH2TUYsskG1fWYYQzX0H572qIHkUjSOmgl62Wgo9orz+DBTB
         dncvVs825p2HCGQq5zo6zQuxVx3YRSMCdefwz+Y/kxtUaAnfk4GnmnNeWGsgINe5hDyq
         f79sjOWUOD+2pt3ZNBw2/I3HdE8NrcgdHV2oQiw/WeDYWxdcn2nKUndhpgQ5JVa2DzcJ
         DcsgC+wBKRcbMiFP3NIqDq1a/Tcm/teXdjisfPNrQ2460kCl5x5Ek2sdX8iSu6C2I8IB
         qQIXPRK5G0t6bGIDA6ceuhFLI78ppdz5QekmHuGSVFYau8AHJGCRTFOYWtTZpP+Jus4V
         RMhg==
X-Gm-Message-State: AOAM531r7WOsPmPTwIO521Nrb9hf/qvE0lGaswhUCsalzOtEwSoBbzDb
	Wx9NCuW2fKZ2aiXzxIsWyxGjNcD0GLQVqZe8P9I=
X-Google-Smtp-Source: ABdhPJwz5P0FHIRXQ07Uch1OsWjwzezNGf3ecNnuXsno6Xes5CIpIS7xOkQN0/o79hBtyq0GwBFLJg==
X-Received: by 2002:a17:906:684a:b0:6ce:c1b4:b503 with SMTP id a10-20020a170906684a00b006cec1b4b503mr2437384ejs.355.1645711005667;
        Thu, 24 Feb 2022 05:56:45 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id 7sm1360733edw.37.2022.02.24.05.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 05:56:45 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v3 01/12] Squash to "selftests: mptcp: Add tests for userspace PM type"
Date: Thu, 24 Feb 2022 14:56:08 +0100
Message-Id: <20220224135619.2523272-2-matthieu.baerts@tessares.net>
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

Commit 34aa6e3bccd8 ("selftests: mptcp: add ip mptcp wrappers") has been
applied in net-next before this other patch.

It is then needed to do the same modifications in the userspace tests as
well.

While at it, a new helper has been added to avoid long 'ip netns exec'
commands as suggested by Paolo.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    to be squashed in "selftests: mptcp: Add tests for userspace PM type"

 .../testing/selftests/net/mptcp/mptcp_join.sh | 57 +++++++++++--------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ef57a28cf722..e2d56a5bcaf4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1448,6 +1448,13 @@ wait_attempt_fail()
 	return 1
 }
 
+set_userspace_pm()
+{
+	local ns=$1
+
+	ip netns exec $ns sysctl -q net.mptcp.pm_type=1
+}
+
 subflows_tests()
 {
 	reset
@@ -2468,59 +2475,59 @@ userspace_tests()
 {
 	# userspace pm type prevents add_addr
 	reset
-	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=1
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	set_userspace_pm $ns1
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type prevents add_addr" 0 0 0
 	chk_add_nr 0 0
 
 	# userspace pm type echoes add_addr
 	reset
-	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=1
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	set_userspace_pm $ns2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type echoes add_addr" 0 0 0
 	chk_add_nr 1 1
 
 	# userspace pm type rejects join
 	reset
-	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=1
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	set_userspace_pm $ns1
+	pm_nl_set_limits $ns1 1 1
+	pm_nl_set_limits $ns2 1 1
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type rejects join" 1 1 0
 
 	# userspace pm type does not send join
 	reset
-	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=1
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	set_userspace_pm $ns2
+	pm_nl_set_limits $ns1 1 1
+	pm_nl_set_limits $ns2 1 1
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type does not send join" 0 0 0
 
 	# userspace pm type prevents mp_prio
 	reset
-	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=1
-	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	set_userspace_pm $ns1
+	pm_nl_set_limits $ns1 1 1
+	pm_nl_set_limits $ns2 1 1
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 	chk_join_nr "userspace pm type prevents mp_prio" 1 1 0
 	chk_prio_nr 0 0
 
 	# userspace pm type prevents rm_addr
 	reset
-	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=1
-	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=1
-	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	set_userspace_pm $ns1
+	set_userspace_pm $ns2
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
 	chk_join_nr "userspace pm type prevents rm_addr" 0 0 0
 	chk_rm_nr 0 0
-- 
2.34.1

