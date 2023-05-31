Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B778F154A5
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:57 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f6d7abe9a4so44082495e9.2
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542616; x=1688134616;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3f7UDmmuoBaH9t0yOlkN9qHZafnxnE2RtXb6dMS1k0=;
        b=UgP3qzqa9lFUUfQDfe3ybldEDQJ2qQT86i57mfMMIyxZAlE7F+YMiiIhR5al2IH3gO
         +fpe46VhwDAeQ1cLGIGhstLyUlfVYquAHOWDhmooUCGk9n2LAOYGhrHL7z+2y1JqNhxn
         XYa/5oEZNHOeD72Ko0HzSGyRkouiRXTOVwnvPqzjdOdIOHgSFbj9va3BMPM8UOSFXkWa
         jOZO3NPkqGNCawNtp88EsEF2zESXZ8UupZ+nv5t8kB7kLQke6IXijCgON42kwr+q5gvC
         01tmZ7PKX124V2jwwHb5HpndMTlQZaXC5+c1kLLx6Fyx1sALzlz54QHuXwxSg6FhOZam
         cmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542616; x=1688134616;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3f7UDmmuoBaH9t0yOlkN9qHZafnxnE2RtXb6dMS1k0=;
        b=JkWn0e8LmM4E37/d9o9ous4EKzUjEmJnk1cMuRvUdvdW5/gTzU2bURzZ1ntjgZRBeA
         olIoNEoGoNivmF8LxNHUZYEoamWsSkUljYeNp0XLh/DT4TAbqwR0ojFGb55U1j4xAbgu
         C3G3EFVxjQ5a6X+smX4m8pHfu7AA40HoVY0lE42XLwVplrJubaYIseUlVwqo82CMxN7r
         AO8qAbXvf0PgERLw0zcX/cJNISJUIKbB40vQCEFn3iYlnsXJPawI7zAmhObuK02E+vlf
         ID4wL+eSxm/2bHbAqwwLy5oWygNkzSY24SVNxx8p4jPS9U+OiU7x54EU6IJ/OIJeWL+3
         XQdw==
X-Gm-Message-State: AC+VfDwCeys43Y5EqG58z98+oe+9bNvZOKZwr+o3K737neZBwBs6piBQ
	lLOWTQJfuj0mvJCGTM2JOf3J/A==
X-Google-Smtp-Source: ACHHUZ5yI123kA/irv573hLjsyiL09sGqiOEc0lHqA1RSMLRjO95/FUHAI2vFuzXVMsj54hMCAzu0A==
X-Received: by 2002:a1c:cc05:0:b0:3f6:3e9:e2dd with SMTP id h5-20020a1ccc05000000b003f603e9e2ddmr4105954wmb.3.1685542616084;
        Wed, 31 May 2023 07:16:56 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:55 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:46 +0200
Subject: [PATCH mptcp-net v3 26/32] selftests: mptcp: join: skip userspace
 PM tests if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-26-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4437;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=SIFAr20EwibwlqqPS+4DexfX7ft9PnoRMYbVkNDIedM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bDFV1ICYzeZtSDmWvqxZ5wkgN8Fc23fSgXD
 JSlRf1tP+2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwwAKCRD2t4JPQmmg
 c0beD/9M36CYEGBXw+w0MYCS2eeQBvPG+ckJ/iRNcN2HdZfuQwxhUbSFl2lnbf9adYC5ED74pLZ
 d6Lg7OCfWxbQz2HTBF5jXjaQ1CIwotJWRd7oSq66sGR3vBIFcTt3d0QejLdpNK6lLVRFosuQO9s
 Ye8vBNB/Efl37QtWwecs+etGip+WN4mdqneOgXP+FDeFOFUKoVdW2tgqRry5dTXXM97JH8xcLlA
 yfnK6FVr6Y/haBenrgfN3LBqwRit0KnFpWIlTaPfoKcbPINSUgJ0a6ovxBWxFYaUoht1f9zHq42
 0tHwNwyJC9vBhBbL9+UBqNn/penOwaFcEfC6YgMSItD8I08exQyJQgHvvV224rEWc3rGlyVsE23
 qBvIA33ZBwhBd9XlyZ0nvuNSXD7uOUgs9zcOrzfDd2Td/Uvq++0gIa/OySqjOygR57uToYipiXP
 301ShZJaXQ0rI52iQ/z8zXtSgOP+LAZhfY0t5f7SKyekY1BGKik4AZtbPgH3Vne0+OC/g3BZc6f
 NknA92H7+eT8Iz54b434tZHvbiiIIkh0iuUyxjsU+9287fJxAsMQ9S298KKHJDnoJpYK15tdWVn
 OvQJs7mIIrsNenZl7GfLC+xPogH7T580jqs+qSfOOfcJmOVevPC0p88moSS8z3QWSe0pdBa+gUA
 JgvxjBccusn3yCg==
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
index 04464a73ac9d..9c7b620a5c12 100755
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
@@ -3200,7 +3200,8 @@ fail_tests()
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
-	if reset "userspace pm type prevents add_addr"; then
+	if reset "userspace pm type prevents add_addr" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
@@ -3211,7 +3212,8 @@ userspace_tests()
 	fi
 
 	# userspace pm type does not echo add_addr without daemon
-	if reset "userspace pm no echo w/o daemon"; then
+	if reset "userspace pm no echo w/o daemon" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
@@ -3222,7 +3224,8 @@ userspace_tests()
 	fi
 
 	# userspace pm type rejects join
-	if reset "userspace pm type rejects join"; then
+	if reset "userspace pm type rejects join" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
@@ -3232,7 +3235,8 @@ userspace_tests()
 	fi
 
 	# userspace pm type does not send join
-	if reset "userspace pm type does not send join"; then
+	if reset "userspace pm type does not send join" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
@@ -3242,7 +3246,8 @@ userspace_tests()
 	fi
 
 	# userspace pm type prevents mp_prio
-	if reset "userspace pm type prevents mp_prio"; then
+	if reset "userspace pm type prevents mp_prio" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
@@ -3253,7 +3258,8 @@ userspace_tests()
 	fi
 
 	# userspace pm type prevents rm_addr
-	if reset "userspace pm type prevents rm_addr"; then
+	if reset "userspace pm type prevents rm_addr" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
@@ -3265,7 +3271,8 @@ userspace_tests()
 	fi
 
 	# userspace pm add & remove address
-	if reset_with_events "userspace pm add & remove address"; then
+	if reset_with_events "userspace pm add & remove address" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
 		run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
@@ -3276,7 +3283,8 @@ userspace_tests()
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

