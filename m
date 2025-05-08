Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0583F224891
	for <mptcp@lists.linux.dev>; Thu,  8 May 2025 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746692412; cv=none; b=FnhSzq/obqLCFt4a+2pC/SNNUYyKXSpnouoeSiOcv0wfBF+HlRUj/MAO5z1QRL0HdUtY8on9NDqyCqZKjI7GRaMoO0IAQny5SMJ/3U3K29knBQ8CWo0elty9lY5BCaiTTw9ZLcddNTTTiFF3pGo3My4O+RInH0++rIylcqyJX70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746692412; c=relaxed/simple;
	bh=nfnnrkbD9lHq5M4BurhUV9GrLo0bCdesTsL9mlx9IRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7mFbAevGtxawlbJU2WmOpjqt+5aeInIdeaSh8tkrGieRB1Y73L9XlyfTGP0BT+kRiXPgbeHlgeSuwl3vkm9/0qoIqD9/ABd5qWNVJHoz/xIi1+IPUbLx+3xT3Z194ZS+y5yU+qxrvZg7XY4jjLqOolb2NHe1WQDYMGN9SUBmhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mn7ulf2n; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn7ulf2n"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-740b3a18e26so229384b3a.2
        for <mptcp@lists.linux.dev>; Thu, 08 May 2025 01:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746692410; x=1747297210; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iF/sCoumpbrrcZbQjjir0fJBDlQMYwoeVJwZhV5rgpk=;
        b=Mn7ulf2nToQTOupHfQzTcPCyrgWXngafcBmU0rENtmo5cFPqkgoT4AQ66y+Gz9oB3j
         NB1nG7QbImy11Y169k8m5iHLVh1cIO4IMAN5THl1sdE3fS9HVrMR8PDpo+ptYYNzOJ9X
         8jkn5Rev7AKQwhmOtQSpJ5AuILukV1AmmlFnwwqFPoKZWF/hth9Zzlm6RQ29cDCtSLhD
         ESC4xAO42KaOOzaOcjOBYvydy8kEtvJ+Ni1uS4FUpa3MDjd3HWe7XdMbB48Ucha5cUek
         0ZtRorL2Z0vTp6ZD6Vt7k4l/w2couHkZgmZuzXbRYHCVtpvM128nkkvydJM+Q1AhLbNC
         ylyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746692410; x=1747297210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iF/sCoumpbrrcZbQjjir0fJBDlQMYwoeVJwZhV5rgpk=;
        b=C0ojsoPWjWnoHuTjyJQqWz5b3OfBbpWMj8irklBHkpEGSCyuJd5gHZg5kBUcyfJwpJ
         ZWLvcYQBwy98nrmiotOHtTBAsFZXqcYGWP7e1rSwqwjpjmh+mdHNX5B3wk0PV2eqqtds
         9L+n5LgdrQ12t9LzYQ5UXrjlxTqIU/ZgkqNGUYVFUIEwrMKHD+iRs8DJMCN57jbfyPBe
         fdGK3YJYpA5tsvsc6ZzrIDhXCoklalhq5fMzggXfy7Kj+baRwf0QmgwHwYRGTAnkDAyU
         dtEvEHHYPkrjkg6thi82vAvVjg9mey+10YtBFRQ+yZl+x7xAYEB3tC9hZLcXRvqvo7p1
         oHZg==
X-Forwarded-Encrypted: i=1; AJvYcCXyn7lHlrSHxDBMybNtQhG8majxsBrrWa28zG8Cv+oHx/pm1bycTsOpi8gvdua2a6LDpi1vtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyr0MkR3GeN35atCiP0B8HAkxNuOK3FwZpZr3N5obc+1SEM9uMe
	V98LdqYUSHW/j2RHtLKPkx2/PKIEgJN1fP1t2ezgCywg99WzdGSs
X-Gm-Gg: ASbGncv/4lCOXj9U2OelsBMLLMn8voLd4yAr6vsMu7S5TX2jduCLvyMzKWPZkOUy1Jr
	E5vdrzll7Wx955aSrw+vWw9L1r66LSuaTIUl5alpLNSAdS3rV5ROUKMLm8aN/cx6S6gEsYZfdk+
	nYUcuhxLmHB38xr83Kr8HC7xmXNmlCninJBvWB/XVz3Bix8dyvNzdTUEqz+nW7mdwHk+5eQj0Xw
	Ka0ZiJQHoY00g5V+sSWOTkIAJhiQ+KyQx46iNdLswj8RnoSUZo16YYupF6LuEHaEBCWIZWbfiJ8
	u4pRNCp12ps0TYd5f/ZPuYI858CfmyDOrZ57NVdtmovk50/ZKsJRSEb5q9MV
X-Google-Smtp-Source: AGHT+IHz2qi+IhB5F80jpVbH8rKZ54H2Ipi3hZso3Ha/e4qS4CiCojKLLFlE/kbvGrTd/XTIEbRrAA==
X-Received: by 2002:a05:6a21:393:b0:1f5:6e00:14db with SMTP id adf61e73a8af0-2159af4bf72mr3663176637.14.1746692410384;
        Thu, 08 May 2025 01:20:10 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7406a36c523sm10907408b3a.144.2025.05.08.01.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 01:20:09 -0700 (PDT)
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
Subject: [PATCHv2 net-next 6/6] selftests: mptcp: remove rp_filter configuration
Date: Thu,  8 May 2025 08:19:10 +0000
Message-ID: <20250508081910.84216-7-liuhangbin@gmail.com>
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

Remove the rp_filter configuration from MPTCP tests, as it is now handled
by setup_ns.

Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
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

