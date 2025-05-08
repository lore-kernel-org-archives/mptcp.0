Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8BC221D85
	for <mptcp@lists.linux.dev>; Thu,  8 May 2025 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746692383; cv=none; b=jgzclmw8hvgMvC4OHN9X5AXOQFS2ItWbMx50nL7Ww94aF0nOtXqJGLENthORvbcUYealnDKo9hp4ASJE8RoIVok9Vk5rG4faRbGJDlpwhE/5pWlKU+63JSSwHDDak+ynaOWV2m7aPnn/6Q1CEdVPEv1ttAW3qW5FUEu7ZppxffA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746692383; c=relaxed/simple;
	bh=NDqRijYzjhs0y/BEUOAKtrmFA7xwhtMvr8QfCvPf9aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivIRYBGDVK9Ji03U+nCobfa7Fo9DM4gnqKUB9iDENQa3Rb7y8jnMOAzH4Omv3RgYn4+CAaQRPBlk8+YcUHoAZhJKX/vO7ZDvUZ+2fOx3MH49REAWMzcQo4eXK8Zf3tEMvjcUGC+lzn0WXX/GLdG5DbUQ0pQKzO6PVqjaDXdErVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1OU/1GY; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1OU/1GY"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-736c3e7b390so724170b3a.2
        for <mptcp@lists.linux.dev>; Thu, 08 May 2025 01:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746692381; x=1747297181; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtfXnYitCXVUTGCdTcTCxeQzg7Q4AmshUJnCjDRlr08=;
        b=e1OU/1GYnnbR0JLzf1pp4eLdLLRlMQXovyPDD4vURXxl8Kwf/rThdjexPjG+p3Lncy
         SRFMeSZ8JaZp89M3jO+blJmMPKHXOKCvE7AZn94FzJg5vWSrUWL22Db0LTQWYMu6u949
         B7SgwKOxdX/j13qkjPobWXTzC06XIAd2uTFKH7zl+Q31KWd37RKyyAxQQi1rILqmDSjo
         FHbTVfLDvSiP+eY1gEPDgeVoyqFO4zOeUciFVPoTsB+CsBH40a7ZB5GN9Uhnwl1CATXs
         JnPxkHO+6h8bHGCDQhkwfVK+ZY4HVuFaO/vfsh3FI8QIdKuDtx/lpL/AmOlcKNiqLvy/
         FcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746692381; x=1747297181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtfXnYitCXVUTGCdTcTCxeQzg7Q4AmshUJnCjDRlr08=;
        b=xFonbNI928TDOYJCAlkbDZIVrbfuIBluV74VGBjHvKlS6K6zXkaytadKk8oke/446d
         o5+/eTD+fnG2CcIbpzuxQNHJPMKVkKABtqoieHmXnfmos+fR5/W5+gzYWrmFgIp7XuiT
         b4akvnX4nHuqWfLalHq97q449sEEoaO3YEZceWhHCYcbPlVTCkS12Rnvxr2ipWLaWMLf
         OFCRpEO9zPGiaboi1RCz3b+RVp1elPstEFvdMZ3sMNb4oCkBYI/eZdJHvi/PVJdte02S
         S0IWoFDdv9ouwwZxqiVmuXIU6a9vgW9vPF6dhHbR3ynJ2JIAWI+aRSEiie4JsY3gPfcj
         7V5w==
X-Forwarded-Encrypted: i=1; AJvYcCX61CyiRDAumcxWdSE/EqVW71WuqFUT/UZQlK/sX+ut0DYNSVSEglFSIsayFLiy1cJ0RJ6WFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZ86lERrCJ8m4DDFPFk2iUDXX8/ZDalIKO5w0PkG54tWlS0Unk
	VkXouZQqeuGKKiiR/S+9/fiorQYjTJnZ14KzrBpYfMR3KU2zzu0m
X-Gm-Gg: ASbGncszEUyoXF7cIWX+9LQPWuznKlX5K1DsTHQ1W8q1rioyT0zLEOjXBz8PB84Bt5k
	r1QrvhV1NLJL0rvRN/JjFt/9K6H8p92XuyAhvxFuGwQVXFjqfF28aM2EFKbUAI+nEQ1NH+3M5UM
	WclU3kQ285NulXyTttSfAZhLW7gkXDYNURvIYkKZRW6OcWi8RYISCKv2zif6ylV7hF+OItvyupV
	Cxa7lJupYly9DPeYv51jQRzinwr/AYrOBawsbQPd0eEv+Y3+n9DVYZJIMeYwBgmxQK0sXEJJ+4E
	2wWopSWUGP4Uh79rO/iyWJnoDRB8RBUzjfSZTEONJt0uW50BN+vDmqYcFSyY
X-Google-Smtp-Source: AGHT+IG7pwQ/ZmLNv85y0ipwxtsXxWTqjT9C0wws4LQDnBve2+4o0xCMNV6ghhEGty2Mj/8lwIMs5w==
X-Received: by 2002:a05:6a00:ad07:b0:730:75b1:7219 with SMTP id d2e1a72fcca58-740a99cb1ebmr3589916b3a.12.1746692381066;
        Thu, 08 May 2025 01:19:41 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7406a36c523sm10907408b3a.144.2025.05.08.01.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 01:19:40 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
	linux-kselftest@vger.kernel.org,
	mptcp@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 2/6] selftests: net: remove redundant rp_filter configuration
Date: Thu,  8 May 2025 08:19:06 +0000
Message-ID: <20250508081910.84216-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250508081910.84216-1-liuhangbin@gmail.com>
References: <20250508081910.84216-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following tests use setup_ns to create a network namespace, which
will disables rp_filter immediately after namespace creation. Therefore,
it is no longer necessary to disable rp_filter again within these individual
tests.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/fib_rule_tests.sh | 3 ---
 tools/testing/selftests/net/fib_tests.sh      | 3 ---
 tools/testing/selftests/net/icmp_redirect.sh  | 2 --
 3 files changed, 8 deletions(-)

diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index c7cea556b416..5fbdd2a0b537 100755
--- a/tools/testing/selftests/net/fib_rule_tests.sh
+++ b/tools/testing/selftests/net/fib_rule_tests.sh
@@ -516,10 +516,7 @@ fib_rule4_test()
 	fib_rule4_test_match_n_redirect "$match" "$match" "$getnomatch" \
 		"oif redirect to table" "oif no redirect to table"
 
-	# Enable forwarding and disable rp_filter as all the addresses are in
-	# the same subnet and egress device == ingress device.
 	ip netns exec $testns sysctl -qw net.ipv4.ip_forward=1
-	ip netns exec $testns sysctl -qw net.ipv4.conf.$DEV.rp_filter=0
 	match="from $SRC_IP iif $DEV"
 	getnomatch="from $SRC_IP iif lo"
 	fib_rule4_test_match_n_redirect "$match" "$match" "$getnomatch" \
diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index c58dc4ac2810..a94b73a53f72 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -2560,9 +2560,6 @@ ipv4_mpath_list_test()
 	run_cmd "ip -n $ns2 route add 203.0.113.0/24
 		nexthop via 172.16.201.2 nexthop via 172.16.202.2"
 	run_cmd "ip netns exec $ns2 sysctl -qw net.ipv4.fib_multipath_hash_policy=1"
-	run_cmd "ip netns exec $ns2 sysctl -qw net.ipv4.conf.veth2.rp_filter=0"
-	run_cmd "ip netns exec $ns2 sysctl -qw net.ipv4.conf.all.rp_filter=0"
-	run_cmd "ip netns exec $ns2 sysctl -qw net.ipv4.conf.default.rp_filter=0"
 	set +e
 
 	local dmac=$(ip -n $ns2 -j link show dev veth2 | jq -r '.[]["address"]')
diff --git a/tools/testing/selftests/net/icmp_redirect.sh b/tools/testing/selftests/net/icmp_redirect.sh
index d6f0e449c029..b13c89a99ecb 100755
--- a/tools/testing/selftests/net/icmp_redirect.sh
+++ b/tools/testing/selftests/net/icmp_redirect.sh
@@ -178,8 +178,6 @@ setup()
 		else
 			ip netns exec $ns sysctl -q -w net.ipv4.ip_forward=1
 			ip netns exec $ns sysctl -q -w net.ipv4.conf.all.send_redirects=1
-			ip netns exec $ns sysctl -q -w net.ipv4.conf.default.rp_filter=0
-			ip netns exec $ns sysctl -q -w net.ipv4.conf.all.rp_filter=0
 
 			ip netns exec $ns sysctl -q -w net.ipv6.conf.all.forwarding=1
 			ip netns exec $ns sysctl -q -w net.ipv6.route.mtu_expires=10
-- 
2.46.0

