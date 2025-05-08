Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE086221703
	for <mptcp@lists.linux.dev>; Thu,  8 May 2025 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746692368; cv=none; b=QhJ+iRkT+WI08lYElO716eZgOhTPV7Uzg6cWm9Bly7n0RTGJ7TV19pG2qU0EcnqbC9dB8EnY8LwrVmkZ2m3Cu5QE+EROgDavqJSB5LyhlqCDNwL7060LGP4FVQxvQkp2UdLco85FGyANqSgzTlRah1I98lf+xD6HHuU22xRwe8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746692368; c=relaxed/simple;
	bh=14n4tW0qeqU54B1pKTKeoFx7E7yIyzyMSpakYOShDt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jp3wVAbR2fsbPuUsJRyTaWyO/b2q+Ooic7DeGZT+OXCmfUCBY00lVihz/2MBS4t0ijbw3J3f/dFFnjrbSdV95Lqo348XgSw0ZOab8vkJjTCBoPUSrLO61z3IK7JquHCo939zOAmB6xYT3Hblc3oePYHdHZnZ7AOfqfIWL79AXps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fd0+qors; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fd0+qors"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so756448b3a.1
        for <mptcp@lists.linux.dev>; Thu, 08 May 2025 01:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746692366; x=1747297166; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HPpdRtp3aVyMAVOGkWkmMRZEWVnHO+8x5d8pJrgFXgU=;
        b=Fd0+qorsl4xWs1bF18aMop0NIuFCOwvCa2eU8i8ChqLAme6YQzHhlrafuddJz1Jq2H
         eUV39wxGcjdeMccpXbFiBQMqPi5PrGca1YVYhSpGfgLu1BWZWPsmiWOfxMWPBSVp/gUG
         wEPZIMOs0ZT4GiWzPA+kr9MrcGqkZj2Hk4Y62h3e3LDOsFkpUM44UDl5A48SNU10584O
         elEynOOxZ5r/djZrKJEH+9aYQfKsaJlhQ3OA1CPwKWxE7edkVARMy6/MV42hMYKUc1nu
         3vWywpPMsg5vdy9JRYjMvdX2GkLLDQp3pAdh+hSg8zip1H1q9CSThpht9Bi2sAlTEdnc
         qw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746692366; x=1747297166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HPpdRtp3aVyMAVOGkWkmMRZEWVnHO+8x5d8pJrgFXgU=;
        b=s0nwUZYxFd7fySUry+Au0hMXmmAaGj1yeC6HKxT2ecT962H0GesaGeaMDEheMx3sEE
         /QW4f9aaRX6e94Jxb4mqVoo2hYldJGpemrvcdgiV7350SO1k6SK06HMTUJWQiH5ErUON
         39PUBzN2HsEDrpohogu/wfE4+kMrAQr5Gcpe09LG5hWR00jsU0DU4YRn7eiilxHKcL83
         qNPPPnNlTbqVqKWZR8X12FCIkjLpIYIC6qgF6kNpGyT1JCgV+cvuzqPwFi+ApSmi0saW
         rf6NmHCPqPdxpnTjcPPt3begkuwvf6dWW/saI3veDbhYtdm0RMr6KXhqOpIsujKfrsRY
         nhEg==
X-Forwarded-Encrypted: i=1; AJvYcCVO3vduf7VwIWNtABmirNXleW7QIhNKWlnCQXqQvHripoF7m1AMKAAz5FFZtfIa6495dZUhtA==@lists.linux.dev
X-Gm-Message-State: AOJu0YySXoqzA9N5hBARL7Ef2ObXvJBbeNfh0qQs0n7gjnha+Lx0alrg
	xpFskUAJpUuaX5A7OnoAlqeARoWQg0b1oRw+ZSS4jY5Z/fIPG6OU
X-Gm-Gg: ASbGncv2gEKPT/MnrgrNpIzzWgp7f4jrSB7tVMMPn/ROMI7ddxJC9ALlN2S6lPjh7L2
	gEgF9ysOtX0mXZDW1jYYvjNdmjZLi8oLrdXxRDqYKADwwOStVL45u9SabnLf45wMC2UhxOrtWEW
	AYR3cCPuZu4bIrFzQh2x/sQeLRg9w/t7jJb5tS1QRPb+xKD3PKKKjquWCUYNfzxo7Hl8+csNrAB
	40N03L6Lwfr9qqu8xfWRlzIgH4L3/r/7Zsl2pIfHRVrq3tq10YOzrlaNmQTEbfpPl/3Ngu2Hbxi
	F3D/DFLo2/PiC2VxuhI/YEzM8RQYWIW3dTod9ZxHiouS6yMib/GT6Wv1PQAn3j//lGIigJA=
X-Google-Smtp-Source: AGHT+IEw7Njo6XB2YXjl91SPT7jER52C00agtAZZ8VbNoPu1BX+dXS3OeJ2BaTH53o5fy8nazQPpdg==
X-Received: by 2002:a05:6a21:8cc5:b0:1f5:5b77:3811 with SMTP id adf61e73a8af0-2159af8c8e3mr3464618637.22.1746692365946;
        Thu, 08 May 2025 01:19:25 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7406a36c523sm10907408b3a.144.2025.05.08.01.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 01:19:25 -0700 (PDT)
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
Subject: [PATCHv2 net-next 0/6] selftests: net: configure rp_filter in setup_ns
Date: Thu,  8 May 2025 08:19:04 +0000
Message-ID: <20250508081910.84216-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some distributions enable rp_filter globally by default, which can interfere
with various test cases. To address this, many tests explicitly disable
rp_filter within their scripts.

To avoid duplication and ensure consistent behavior across tests, this patch
moves the rp_filter configuration into setup_ns, applied immediately after a
new namespace is created. This change ensures that all namespace-based tests
inherit the appropriate rp_filter settings, simplifying individual test
scripts and improving maintainability.

v2: fix srv6_hl2encap_red_l2vpn_test.sh test failure (Jakub Kicinski)

Hangbin Liu (6):
  selftests: net: disable rp_filter after namespace initialization
  selftests: net: remove redundant rp_filter configuration
  selftests: net: use setup_ns for bareudp testing
  selftests: net: use setup_ns for SRv6 tests and remove rp_filter
    configuration
  selftests: netfilter: remove rp_filter configuration
  selftests: mptcp: remove rp_filter configuration

 tools/testing/selftests/net/bareudp.sh        | 49 ++---------
 tools/testing/selftests/net/fib_rule_tests.sh |  3 -
 tools/testing/selftests/net/fib_tests.sh      |  3 -
 tools/testing/selftests/net/icmp_redirect.sh  |  2 -
 tools/testing/selftests/net/lib.sh            |  2 +
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  2 -
 .../selftests/net/netfilter/br_netfilter.sh   |  3 -
 .../selftests/net/netfilter/bridge_brouter.sh |  2 -
 .../selftests/net/netfilter/conntrack_vrf.sh  |  3 -
 tools/testing/selftests/net/netfilter/ipvs.sh |  6 --
 .../selftests/net/netfilter/nft_fib.sh        |  2 -
 .../selftests/net/netfilter/nft_nat_zones.sh  |  2 -
 .../testing/selftests/net/netfilter/rpath.sh  | 18 ++--
 .../selftests/net/srv6_end_dt46_l3vpn_test.sh |  5 --
 .../selftests/net/srv6_end_dt4_l3vpn_test.sh  |  5 --
 .../net/srv6_end_next_csid_l3vpn_test.sh      | 77 ++++-------------
 .../net/srv6_end_x_next_csid_l3vpn_test.sh    | 83 +++++--------------
 .../net/srv6_hencap_red_l3vpn_test.sh         | 74 ++++-------------
 .../net/srv6_hl2encap_red_l2vpn_test.sh       | 83 +++++--------------
 19 files changed, 90 insertions(+), 334 deletions(-)

-- 
2.46.0

