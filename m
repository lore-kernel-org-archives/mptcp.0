Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E027E134B0
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:35 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d1so62447475e9.1
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773514; x=1687365514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgnO7zrIiXErID6aV6nh3833oyfYH+POA4h+b9GGbok=;
        b=vJ3+KkJuV0G9r1s9N1kUVYzo1fQf2efosnP3meAD1/sAKf49NNrQ6Mbcdhjb7M+Xse
         o0AkNGSKTNqsRM/C+9zRLlR9uKj+qGYTCtmd7o9GwyRfKwlSsKrz9q89p9YzRfhwqC55
         KNeDHX9mHwv/UOU+kPTPS5MBYOPglYj24VsmrPR8Spy91uAIwpGODpYSQiuVyfrcUCiO
         73+krU9+i3wwdQmFNLjKk+Yrc8fiwup658aZNDDP7O+KDiHNjWfTmhxjcpjOD9Tq1c0b
         JXG4+ky4o15Yc4MxNhShfMHKN+w68Sx3f/2v5HUQR/G+EtfCJiTV7FhtHTOcpkYZV6Fj
         joOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773514; x=1687365514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgnO7zrIiXErID6aV6nh3833oyfYH+POA4h+b9GGbok=;
        b=iwpWIQHpmYcVaD6Bm9EA/7e894p+urKDDVSH/QrC8QcSjh9OyfyXfi+XumZpIszRCV
         CS5Noww++/eY+G/g61kwBwWp/4oYwDVMufc7IC4pmlv8oLeunGoAZPD9jEZv0PfR6qfv
         baaFoinXlQP2NEMISqKVJrWqJTsvNd8N1HB1JmPrJM+ENkOuMegYA4+V+On4KhPuVx94
         xzOtofnvpOZtDH7xq2lz+0AOkrieQf825G6C9uVAQgKrBzPA8MgsmqSqb18ptitjetJQ
         9cjUCvySZkww29ZcK7/Wj3giCs+pYZXSjqFf3YocvDG9ynI1Af9GxRquGaXFBw2FXYID
         waYA==
X-Gm-Message-State: AC+VfDyc5IDN2DHrHTH7+kmKcD1coIDWNnGHA6f4HT4otYhNuJPwtBhX
	fFnvef+sHYNQ72RAHLQT5QJC0CX/Pe/gdlGrra8qJA==
X-Google-Smtp-Source: ACHHUZ7Zlcuy4XnVbsX4ihfRg6NYY41SlPYPfLbz9sCsS8fWB6eUxUyRsS0o77i5r+CU+ZoFnFBNGg==
X-Received: by 2002:a05:600c:2284:b0:3f4:2186:91c0 with SMTP id 4-20020a05600c228400b003f4218691c0mr8639639wmf.29.1684773513957;
        Mon, 22 May 2023 09:38:33 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:33 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:38:05 +0200
Subject: [PATCH mptcp-net v2 33/37] selftests: mptcp: join: skip userspace
 PM tests if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-33-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4437;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=IR6+nUSramdN+vQLIpBYa4qToBLjAlWksQGznSh9tvc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5px9YHF6OfYUVJRiBpKTi6IZPdl3uDGl2P1R
 UMfj/XlH9yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacQAKCRD2t4JPQmmg
 cwQOEACtgcRzUPeVmJJoYXa0ti6OFEpyLNUsB3emJKiP9GVzlIloH9wGO4F5msCTW7u91dUjayE
 oxHzJQdNJCmvpoIjp+n/VQlr6sZJCMIfLuOwIeCZWt1xlljiXERMefXKsXPIb67Lz20lnNaKRJb
 Bhy83omN+ot1Y3Xh+kOxjc7kiKtK5Vvt4o+opGr9uvZRqWUsPKlcaVTpRWEg9XMRM30Ghj2LcRx
 7PoMVxxOgbnD6+KEb9rVBmI6m9Bo8Sa3tgVaoeKZMvHeHVoIkUVFMB4IdCoOoyUTfmW/EOTIraU
 uJLCBttVfV7JtWnb8xWM4e/AICmGWvmNbKOnEPTJ6J7/Y5FKC/lIHcIP5fgWfVIKHlVm5MQRJnM
 0o7XwqR3gzjG4NnglG6e/QanrFkyyBLVltgLLlMQqxm9AwjWTjdrLSQMxU9JP7xx6uRkgMGrN4d
 NM8PPpySdwTZSZ81jA9YSWwA2tmN34qy7LSqRfh52GHXnBscCVRsxiBGKJUsfbxqa7kPsUwQPdf
 X8wyZTYsG0nb6SSPaPvZY4Jt2V8+843hhpw+J2DWfbM4GfePVKZddEzehzX4M8LqR8AnsNBOZC4
 jVv/ASQis8gQgy19V5o8IOq+AHSS7XM1taEMjRq2mHp4aYfJSHnT20t5wEoyE4YAqfP1ZNwtC7w
 Y6CvVyX3IhSN8bA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of the userspace PM introduced by commit
4638de5aefe5 ("mptcp: handle local addrs announced by userspace PMs")
and the following ones.

It is possible to look for the MPTCP pm_type's sysctl knob to know in
advance if the userspace PM is available.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 5ac1d2d63451 ("selftests: mptcp: Add tests for userspace PM type")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 26 ++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 795a27933e6c..2783a3c59aca 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -85,7 +85,7 @@ init_partial()
 		ip netns add $netns || exit $ksft_skip
 		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
-		ip netns exec $netns sysctl -q net.mptcp.pm_type=0
+		ip netns exec $netns sysctl -q net.mptcp.pm_type=0 2>/dev/null || true
 		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
 		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
 		if [ $checksum -eq 1 ]; then
@@ -3249,7 +3249,8 @@ fail_tests()
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
-	if reset "userspace pm type prevents add_addr"; then
+	if reset "userspace pm type prevents add_addr" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
@@ -3260,7 +3261,8 @@ userspace_tests()
 	fi
 
 	# userspace pm type does not echo add_addr without daemon
-	if reset "userspace pm no echo w/o daemon"; then
+	if reset "userspace pm no echo w/o daemon" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
@@ -3271,7 +3273,8 @@ userspace_tests()
 	fi
 
 	# userspace pm type rejects join
-	if reset "userspace pm type rejects join"; then
+	if reset "userspace pm type rejects join" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
@@ -3281,7 +3284,8 @@ userspace_tests()
 	fi
 
 	# userspace pm type does not send join
-	if reset "userspace pm type does not send join"; then
+	if reset "userspace pm type does not send join" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
@@ -3291,7 +3295,8 @@ userspace_tests()
 	fi
 
 	# userspace pm type prevents mp_prio
-	if reset "userspace pm type prevents mp_prio"; then
+	if reset "userspace pm type prevents mp_prio" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
@@ -3302,7 +3307,8 @@ userspace_tests()
 	fi
 
 	# userspace pm type prevents rm_addr
-	if reset "userspace pm type prevents rm_addr"; then
+	if reset "userspace pm type prevents rm_addr" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
@@ -3314,7 +3320,8 @@ userspace_tests()
 	fi
 
 	# userspace pm add & remove address
-	if reset_with_events "userspace pm add & remove address"; then
+	if reset_with_events "userspace pm add & remove address" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
 		run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
@@ -3325,7 +3332,8 @@ userspace_tests()
 	fi
 
 	# userspace pm create destroy subflow
-	if reset_with_events "userspace pm create destroy subflow"; then
+	if reset_with_events "userspace pm create destroy subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
 		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow

-- 
2.39.2

