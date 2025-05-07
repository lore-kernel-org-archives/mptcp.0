Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837F614884C
	for <mptcp@lists.linux.dev>; Wed,  7 May 2025 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623966; cv=none; b=Rvhg54KA0IPH3SdNykzejHVoXfD2RypLosBH8pbTKv9qY082F/paMptitr8JX44q9ddDg8TqVDUtcW+CNQd23wlok0PRNB9OJyAgv5N7A9Mr20ouIDd/ZN7si3dqwZbDjuZTYhr9vZUhrfn8YWBcoiGAfDD1Cu1WppHPmllWztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623966; c=relaxed/simple;
	bh=NDqRijYzjhs0y/BEUOAKtrmFA7xwhtMvr8QfCvPf9aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUTnjG2VFMmUV06b7aYpCMLaMqQ89lu3b4GVG6Nnx8hASSQLpF1sJXiUmiWL2cxhx/HZShxwuZz6W6BveOZy/EhvXYoMLAvNUerXNm4+Rwif3lLO03BkzNFs7jFaYeyVYV17BYBpEXjNTaXj6twP2MvKFOtWNF2peMOlmp/uXMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bzc1ZO0K; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bzc1ZO0K"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2295d78b433so67720385ad.2
        for <mptcp@lists.linux.dev>; Wed, 07 May 2025 06:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746623964; x=1747228764; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtfXnYitCXVUTGCdTcTCxeQzg7Q4AmshUJnCjDRlr08=;
        b=Bzc1ZO0KrXoQYqrU6oXTv8dZYvrQxR2GtU/qWrVgqR49JBAZ67vLoYQC3hzxTN+qdX
         kA6QRNPBNcaUHeDQIt9CYkYXMI66m4N+6usaqIueiKE0Cq9Fx1yQ1Vs3cgltyBdWTuf+
         5RMTMrzFU12d7a8dbIHnfZUBwHavnZ5v02O4uJyO/OvJ78kX/iIeSXo/Wcxa+Lc1n5sN
         W5l8d97OkQO1FCjLkFYp8VCLT8UzGnDSIpAangva2E6ZGUHYhfmZG4iHNh8qS6m3sEKe
         KpBMedWJz53R2ey7umwDK/+4EzrOHVXpTagpkAAOWEg+h7XJxyt6iBuSEY4pzvgC4H3D
         368A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746623964; x=1747228764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtfXnYitCXVUTGCdTcTCxeQzg7Q4AmshUJnCjDRlr08=;
        b=OkJWlkhMNgfIQDIEEa3RtbBmSgIXeO91jj1W5I3vpg3BItnGi9s29AlZB8btuvmRd1
         LR8SekpTzb67DuZKRbMAi7JAqrVcJReO6BThD8eU4QSk3Uy9UvzcO32yAjNzf56BJi1U
         +7F+l0gNPmOFD0OSRIvpQfSCfn0o1rNbhHT3YdLUIo9s86sCszIqEkKTqLwtvBdBDWF0
         lC9t08LM4MkcSrB/HXY2ptGXH5Ihy4YNMDMRutQk9aKY0qjJedhd7vp+illKUOlzv8Oa
         s+ENErVwB/xVJQEGa1MFyXZrKHQ8sqdjxKifXICA7SCO2amKLUzfaVIl9KcM2VZCpN4c
         FdEw==
X-Forwarded-Encrypted: i=1; AJvYcCXAVs29ngzjRfbeUwl31b0rYaTCTHI+3Vh3OYKD5tyWCyKe/fGuDcxSwnxcQIMxZD2NAiIH1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwrAFY8hCkMn11dgSDzMmUOkP4duNpuAmPVCD61+k49EqWECE4s
	WtR6qRsjx9yAki0pFiKbK6HToZzndrE6m1OK4tOQUSq56Jma6M7h
X-Gm-Gg: ASbGncsH3teugDRXqLLa0Og4VxX3AJOMFGvzKMWJV8b6Bsotfmf7AJ0Yhnl6XLY8mO9
	opg63tjOnhAA14oGjhOJDHah1BhprlbQD6+X4MAcGpRkofeNyMc9gq7UXJNc2m1PqO262mhrJ2d
	ror00h1qN1+beQi6AW/NFp0QgZKCP9Ru+jJFj/HBEyQhVTtRMMeO0/wx1Q+/yUZT6riV6KkPcGz
	suNX73NkKZEIGOXZ3/eDg2YYTUuagJAsZWfCsfRojx4TioLeyXvao0dSQhSIl6DborijSVni46Z
	cMnBfcURgrE2qtr5Unin36gAHhyhbUNR9BylCJthyiJ65y9tKRdv5M4CO8lF
X-Google-Smtp-Source: AGHT+IFSdSQM3IiHqluyQXlAUvMv4gM0CqL/WRQ17JX5c13/+GiFUCTdNuQLWbuZWinMIpGIpqDeYg==
X-Received: by 2002:a17:903:2f85:b0:21f:45d:21fb with SMTP id d9443c01a7336-22e5ea64dddmr47456425ad.3.1746623963559;
        Wed, 07 May 2025 06:19:23 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e5e93ee88sm17414765ad.86.2025.05.07.06.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:19:23 -0700 (PDT)
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
Subject: [PATCH net-next 2/6] selftests: net: remove redundant rp_filter configuration
Date: Wed,  7 May 2025 13:18:52 +0000
Message-ID: <20250507131856.78393-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250507131856.78393-1-liuhangbin@gmail.com>
References: <20250507131856.78393-1-liuhangbin@gmail.com>
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

