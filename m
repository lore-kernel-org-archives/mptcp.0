Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2138472619
	for <mptcp@lists.linux.dev>; Wed,  7 May 2025 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623951; cv=none; b=qtkuNntWpDdygzBJL5mPSfWv1fJ4+hZw2i8wKjQjpdm0fffyiOGZ4shYX9WdS3Obs7YECfPJSZuAaGa2v3JSjEccSNwKnc1kNtpjFXxKfkvKfVh/q+kLIp9JZ4Oj0yenjzPACdcfu1njBi1Tvu4ItIaq1PTgV441Wkc4Ff6BVro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623951; c=relaxed/simple;
	bh=GZkfUCb90AwgYTu3CF2nfh0Om+zRBKE64m3kyCgtnvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eJb98D2S0ZvlVeLNXyDuvdfcxUXYZkqjbk9uS1DOfKFD3dswjAgyS0dvLqy628HwImVG6yBpch+OiLVrXdtBfTwtbD4OVi7Cq8eeYn3MH7PtmkDmJ9COQuOSegZUE4gJp2H6T5/IEEWsPvYvm2eZIV9VeLt+Ojzh4Jt7+jfyftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECPGvHWT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECPGvHWT"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22e70a9c6bdso6214265ad.3
        for <mptcp@lists.linux.dev>; Wed, 07 May 2025 06:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746623949; x=1747228749; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/0+7hj5vfYYCIfikC10U5TKg0ZgYAqvVLBu9ngisEFU=;
        b=ECPGvHWTKJunrN0pRLGf3Z7YIfF/DSkEK5tPZG0M+XBEW1MOzC2uqZy7Un93VvC7uG
         C1gwbJHXCM9kyoVPRsfk9Ixjk5+pZlZ0E/NjqLdjrXivTiWdChhvEfILDj9VzzlK1LI3
         CWCzwQ2hLX9vW1LABvxMS+720WCGoQxKlhkHdoiTNp8G+NuPljfIfxRQOcqPpv9T2+zR
         ruAJbb4wXMJu/w6L5rPoujT6Gv8SpjIaZH5bxfUi5Vuip/RoY83SJyxHzEaleGtplZq7
         nHg37cxYpLynRe8xAWbYRfmWn0NlV22E5iVwvmAXn2aSq84ucjPgdps7yNHMSZMGxsqn
         NDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746623949; x=1747228749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0+7hj5vfYYCIfikC10U5TKg0ZgYAqvVLBu9ngisEFU=;
        b=p6uLF8Ca1CP+X0YLQ23zKp49YYQUoE57VBykf50+EiULTyMFg4VEE0f/sIKHuLSrRV
         wZ099OAYW/y7RaDKa9FOW6xSpptnHU7XHVzSIDTkupK1QWdAwbc4U+SJOSK8XZvATXNl
         +auzKkEAHjjoCvO4wDvWD6PA0P97BRtFi/zfYDF15qFUzyq3xqSem2Y2Y9SY+idGVois
         pJ46UEV59dp5RIaHGDCcwN7A/LCI88vnkzWefBYWqGZMl09r/EB7YxgmkLOC9Dh35Vk7
         sQDiZKBHgUBTab1UfyQ9v3EVUXy9NObZ3J15QjUujL8g26s024mJngxry7KkQ7ldMvf3
         +OXw==
X-Forwarded-Encrypted: i=1; AJvYcCXHV7SdHTBEy859CZ/KUWA78wGKNmOe/iRnK0BZ2ZcBPSPUqjsre7+FkdoqvMPgZo/rZgKdAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxj+Y6rXTAc6j9XsFiWM6laARg+RWnS3pwtWPp8Aav5COVJRkG3
	bgXFUr1zLrYEc+mEWuEc+WlK1aocM8otYF38bzJ0pO1jkWVrj1u8
X-Gm-Gg: ASbGnct5epu1DId0JO2y8r0m7k9nnSHGQ65g2Ii/V/flHG79M2wRyM9DiM3vAmzPth2
	4tt1102CcbMshC/8Zb56wvvoSRtZtA+Dst1UNFBstJQVLCoDBqr1dN66TwcEy8o3QqEcleOnes3
	6mzIXV7xhyui0Q0VgmnGLk95+uwbgE75fUZwSheLfrx/SKKXpE2efzh4t2cgnyoymBrBywvZEsl
	Im9viIWQQFj9jWm6bW0Bbz+zK47GCdz+qM2O2LbdlcsULghKFbEjOKJw1mVSzqkm3qFzj0WhJwp
	Gb4Tyv9WGZbNzpVvi8yIbE1fELju/ufCFcXLJ9iodZrk9NAFxhgYH0LxbSPH
X-Google-Smtp-Source: AGHT+IE3aXmNIXQtf4fL4/bp0RdlV5edrxeN1OA2BlzBfH+4n8c0fY1fUmHLL8nXNuECNV+ySfcqKQ==
X-Received: by 2002:a17:902:e38a:b0:22e:62c3:6990 with SMTP id d9443c01a7336-22e62c36999mr30258795ad.16.1746623949214;
        Wed, 07 May 2025 06:19:09 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e5e93ee88sm17414765ad.86.2025.05.07.06.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:19:08 -0700 (PDT)
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
Subject: [PATCH net-next 0/6] selftests: net: configure rp_filter in setup_ns
Date: Wed,  7 May 2025 13:18:50 +0000
Message-ID: <20250507131856.78393-1-liuhangbin@gmail.com>
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

BTW, the patch 4/6 for srv6 is a bit large. Please tell me if you think
I need to break this one.

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
 .../net/srv6_hl2encap_red_l2vpn_test.sh       | 77 ++++-------------
 19 files changed, 87 insertions(+), 331 deletions(-)

-- 
2.46.0

