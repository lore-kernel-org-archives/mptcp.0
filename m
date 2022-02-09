Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873C229CA
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 21:25:48 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id k6-20020a05600c1c8600b003524656034cso2593693wms.2
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 13:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yo+24i5Jrplu+k7vy6a2D0OwpIYXGc644PFMEbOVLMQ=;
        b=hANNMvS79A10GGXEcz2BqH8YaMaYeqRwb5qLpmYVfNMcgi8uXyHjlb2sbyTXpDmeRS
         8yDhM0GBnTmK6EqjNAcJL4oliZdeAccIGhqO8QjOja9nu9S/BjGMXX32icYrhjEPhmaB
         Kuj1qztYA3n6SLKTbA3TDif3s7nkFHuVABdUZ23PZhKvOHIp1aOAgBQGY0h00VJJjMKW
         HTUct+mZG7wwRX6l3j2uj7Ah4UztjxPiLBsADnAoPDOUzDUUseBLAugBjrfs0osZML6h
         S3xisht2U+Q2ra8fBkeVKcwGWKPbA2fNEXVq0aNLxybEbNymXdQfftBMS7qiFs0DeC1u
         z0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yo+24i5Jrplu+k7vy6a2D0OwpIYXGc644PFMEbOVLMQ=;
        b=2PEZptgswvX0JmaSQoNruSYBx4nTyNZcEKdutLpgcd91uw+/l1uja5/cc+ZMFiq/A4
         G4aHGUIUaloNdzYjtmu73cMV2UpbC/tTDGWnXzRW4uknWL2farbtVy1RrPWkZRa7RYzU
         y32rzgBAbzh2o6BJw1GzbmbU1kLhHWsG5ptE7z/eDED1BB+Sr/6W5yy6G/OpyXLXcblr
         WAF0e0Q5laRfNu42IcjxNY8F0mpVZ+VQRkT4LQFmRcSV0lMfE8n9qa3ZSsW0wNlCOlwb
         HbrHg53V3pQJa4BRrWqF6deBaPClp/WLICT65JGXD1uwOzqbkZqH9HI+IXPAeTnf9cQl
         /bTg==
X-Gm-Message-State: AOAM532yNsAvVhjyEIvEFsh4PZmzLWVBCmppiZep1ICiCjv1vherWEos
	T+SE9umeXJVtMOtZjAslOBcgG/wYKK1FtVRZ
X-Google-Smtp-Source: ABdhPJwiAiQ/GlVzq/fA5c9rMupaLK7PX00UtN9nlFF3fDtYMTL5fptxUhhVc2SwWFsjd7RqnMDCgQ==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr4493592wmg.139.1644441946355;
        Wed, 09 Feb 2022 13:25:46 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id p14sm18500730wrr.7.2022.02.09.13.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 13:25:45 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 1/9] selftests: mptcp: join: allow running -cCi
Date: Wed,  9 Feb 2022 22:25:12 +0100
Message-Id: <20220209212520.2989291-2-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209212520.2989291-1-matthieu.baerts@tessares.net>
References: <20220209212520.2989291-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without this patch, no tests would be ran when launching:

  mptcp_join.sh -cCi

In any order or a combination with 2 of these letters.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 66ac990415e6..9bbb95837f73 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2242,7 +2242,7 @@ for arg in "$@"; do
 	fi
 
 	# exception for the capture/checksum/ip_mptcp options, the rest means: a part of the tests
-	if [ "${arg}" != "-c" ] && [ "${arg}" != "-C" ] && [ "${arg}" != "-i" ]; then
+	if ! [[ "${arg}" =~ ^"-"[cCi]+$ ]]; then
 		do_all_tests=0
 	fi
 done
-- 
2.34.1

