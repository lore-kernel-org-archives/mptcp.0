Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1485F280A2E
	for <mptcp@lists.linux.dev>; Wed,  7 May 2025 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623995; cv=none; b=c0JYC7D1CZJXG/onbxbIqFxWkD+VzdjB3zCwAzQypsq48HLI3IDIn8rU486rIIdY/Nx4BnbHyttht1sOPfCUMM8O7BGXJ6WGN8tzXbmctwJP5QfqHyRBaYFVDXtTgXWsrcWq6m2Gs8tS7gkgwavM2PSDJQwJL4MO8a9+jlxYeb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623995; c=relaxed/simple;
	bh=pGCESf98a2q8tFRVKDwEPR9HphxMHhS6pJq4K4rLTvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWMwkPieI8t/E2t3CnMKFkMEI1fCPbyhnee8Jpv0s2XsVK74q3tisHXFJytKrQOXJgIB24WJpMR14RLTr9JmzxjFChIGJ3nohEEkTx0P8AMQgViEJJeu4J4KAaUVyLEe4terRP6wDb5LKHdjZvB+vm1Qr6Zu9Rm3ufH+9PiIaAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5P1dRiT; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5P1dRiT"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-af52a624283so881554a12.0
        for <mptcp@lists.linux.dev>; Wed, 07 May 2025 06:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746623993; x=1747228793; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWIeCnEAL6ezhpEyDQ2QxTqdF36G5ahedpjkpixynRI=;
        b=Q5P1dRiTgdel5OmbKsEoJ7OuoIX2uWtezCyP3LC3Mb2f6JBSsNa1IpYFlpy1GxZ+Xw
         ZwaBpivopuy8aIxMMlmO0N3Xr21iGMNGcXnJ8Uq+ONCA1I/yldC0CqQJjmfisQu9/Ex7
         fmA4rIpc0yXSjj3jaNz3/IB/S3p8WPJU4VebfuvTsX3yYeSQ56SkN+4zyeAImU+HMRfr
         cWhu5QEDlvZutM9fKUQ2lOGKnsaC2WQUY5XHTroUmJYYXcIu1zDX5bN4Ux0trLvdZLWx
         qU+nfNrEJa0tN1MZw9tLeJ3NbCw/FmYYVD3YwMpGsA3AIVXArambO7TN6tcdwxxsFPra
         i+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746623993; x=1747228793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWIeCnEAL6ezhpEyDQ2QxTqdF36G5ahedpjkpixynRI=;
        b=bZ8jEQZVF9xB4/Fbb+x+VnW4OTzdB/WUGlWV3OwFKnbM6t2zL34TrqTX2MPokHMHlK
         AsLMTJom6nESnvy01Unso8OomBPFc7go0UW7RFscMt6D6eSjldPXyjAEAxYMARvnQGlX
         5I02WCnkLNXJVeyFauNkKO6f2RoTvvfkIK315PXX4sxIH95RJqcUN0N+9YKalcVFptzZ
         Bk59SN4+NRy+1NFEk8NWPulGejvbUe4Vb4qIo3SMm2z0Akzre+MzZSuHuV2pORtmXUKf
         zynN+SZ6ntqtTddy+2QRBUucE9jDZh9kiSNybiHOSYH7IIAYG0WaLAx5U09+EIjpYmFl
         34ZA==
X-Forwarded-Encrypted: i=1; AJvYcCW/KF/xU68hrnM9B077qPTLj8dknF/XGMz9+R0kt1FQzQrjgI8YC85y2Zuo6+/BqzJhJ0yI5w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJY8Qxk3XjMVXJaXabgKV0s9wEqWp3YWxT63ng2yR+QEDSurbs
	8a9wK6J3UfuQLnZyS425TWXdSe7WMtfuV/fApGWJD0HKI+WEHjr1
X-Gm-Gg: ASbGncu1dJ9qrULQyZJv9pTUTtWewX2W/LvMUa2cwzfwTbPmCmHPO28W1wbgU1kVaxO
	AwlzKRSmQ1vbIOADWcw1xGIiuZ7nOgthWmxcL798R5hkq37HgP2xxla0cS1Qaj9RFuJcHYJ0dHz
	KAs9tqb1qkDxCWezAUEnkrPMxs7MmtEEyzwQT8e1AxunlyF1UNuda3Oc++1/+RINPOSSREb46RG
	7StABGLRgwCR85W9pIdJwMBII8gqc7CvVnMg3kG00ojxrt+x/18FjwBq2BKoeifJ6WDV9Axiwsy
	F3tN4w+x8e3M8QIBq4hfvEMdFv0KsdtqpLs/pI/W/wZGWqSObGTozAUcPAaA
X-Google-Smtp-Source: AGHT+IGWaWfGTs4mdubVYu6seZegE278kHJcKhUfM24Xyh9AmlVDo+zcwuC5LDbCC8DzofCmSPW9EQ==
X-Received: by 2002:a17:90b:2e45:b0:30a:9feb:1e0f with SMTP id 98e67ed59e1d1-30aaecdc652mr4538239a91.5.1746623993354;
        Wed, 07 May 2025 06:19:53 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e5e93ee88sm17414765ad.86.2025.05.07.06.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:19:52 -0700 (PDT)
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
Subject: [PATCH net-next 6/6] selftests: mptcp: remove rp_filter configuration
Date: Wed,  7 May 2025 13:18:56 +0000
Message-ID: <20250507131856.78393-7-liuhangbin@gmail.com>
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

Remove the manual rp_filter configuration from MPTCP tests, as it is now
handled by setup_ns.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 99c87cd6e255..55212188871e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -479,8 +479,6 @@ mptcp_lib_ns_init() {
 	local netns
 	for netns in "${@}"; do
 		ip netns exec "${!netns}" sysctl -q net.mptcp.enabled=1
-		ip netns exec "${!netns}" sysctl -q net.ipv4.conf.all.rp_filter=0
-		ip netns exec "${!netns}" sysctl -q net.ipv4.conf.default.rp_filter=0
 	done
 }
 
-- 
2.46.0

