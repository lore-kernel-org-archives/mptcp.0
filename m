Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2364B6955
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 21:35:00 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id c6so4690253edk.12
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 13:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mpqepvshfNyt6d2vM3maMlSAvOqiJZn5oGOXwOrcldE=;
        b=kXOZDlFIOtv8a1vRtpj5KacMS2gdeRzEp6v7iYDVAuXEMpZVfJYMMIBQ0VBa3yKLi7
         BWnrMyOt2yjylTSVub5E2EOFkNxOPbbv5CyFOYQ7ApLlUzv+xZYRvebE0foLyCW8BZ6L
         8QcAPt5ZHEY1vkHIXxhcgYIu60gWC+dH1Zq1aDBuNGPuYuVqaa/i4bwN53+AwZkJzr3o
         beTshabqdH/NlJUIkvnDv4ouZh8yx5YbPJf4NG7YIczHBefZHSD+lAriQIhAs4xna7sa
         uWjhJ+kdxsa47tztuP2FRM2nTaYP5kr3+w2w5Dd3+z8egPdptEM2pLjikX0Ldm4VImi6
         /uMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mpqepvshfNyt6d2vM3maMlSAvOqiJZn5oGOXwOrcldE=;
        b=4Abp4A1vI5566S2GUtirZzw/XDeNi2t1QvUzcSBSEbNhlYA226XVb9oXIxxcRvyg/B
         1rQmk/1+U048LZ+RQMM5gxQk/n0i0UPazDNIgebE8yF5SmeowsWnZGRxzmDFCKyFJ8Do
         cbC8tUEmh+rI5KhkRvpc02LSZnS3haXd/xjNPJkdN0P8XsrP78UjqiMZCYfj1TjLCLUJ
         JU034HNEeRFoSFXjXTEyu2guF7PvXGL9q/aTwe1Zqlad+wHEiBx3gb9qwhwkDYKTKCtd
         4sp2Y8FpbUpB9YqEyk0TH3gLYn6QRWoWXBelNcn45CqPIikTjnM8sxzlzTAfkAWn7uh3
         lEVw==
X-Gm-Message-State: AOAM532N0xV8V6ZavSCfvNW+CTFqKxwMO3wFtBllQNNDU2tB+DCVkfeS
	GSeYyOcyGCF/Wem/uf+JiY6njlFyO/qex7QJlyI=
X-Google-Smtp-Source: ABdhPJwDcYBwluBcFjfCYpo3QvRkWGX8BPooaxmV+B3reVv+e5jH8rJE1zD/cWv6y9LnY7IhpKgIWQ==
X-Received: by 2002:a50:e1c6:0:b0:410:e2e8:9d3 with SMTP id m6-20020a50e1c6000000b00410e2e809d3mr4200479edl.180.1645738498132;
        Thu, 24 Feb 2022 13:34:58 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id z22-20020a17090655d600b006d229436793sm175195ejp.223.2022.02.24.13.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 13:34:57 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v4 01/12] Squash to "selftests: mptcp: Add tests for userspace PM type"
Date: Thu, 24 Feb 2022 22:33:55 +0100
Message-Id: <20220224213406.3127061-2-matthieu.baerts@tessares.net>
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

