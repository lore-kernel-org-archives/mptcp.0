Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C4613AE5
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:31 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3f60804faf4so5351415e9.3
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773510; x=1687365510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgzMqNvsOOrR58XLyg8/XzeF7uycHXOuqoBnn27nwG0=;
        b=XjFwX/589SfZYgWslEXz+W0NdiQZjABuIVwWce/9RJJkFM9Mbk7e+5F3LOdubCMRnQ
         hcZSkdJesUBcCzrzUU3St0lFHc6gcBTcMWVEriGG+0I8Z+TQzMyUnw/7vnpHdl73nJOS
         iwRi+99SL0K9+aYmMZ/711ekrc5LVzf5ARnSPOcDtqQIp5DwPUvw3STscj0yk83yPwkO
         8+h4QEwzFUUCLJzx7no3UfzeZlxa7ut3HGMN7m1ZNwKrJYD7AYkKfKypxXkY6ysvvxPl
         LVtDlQueHHtVlJ2Y1xmHarrtXVVWC8HEryU4+uGBrHGYSP2ooCbZE1u9/PQClSkfXgKk
         D4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773510; x=1687365510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgzMqNvsOOrR58XLyg8/XzeF7uycHXOuqoBnn27nwG0=;
        b=HzXSIIWvqKUfBIdll3zGoL4Rk6MX7cB11wPsFBJl3xrtUQGe0ayHZToNdPrq3ZaeqQ
         hufMLJcNdeztWpvTvDX9wTm7+DUvSpkRyDhf4EHQK3fLs3xdWczItjIcH5LZ9UthRLZR
         iIkzAYAmmM/1QseWeVg2iYCfxsmjnHestLWOpXIC2uY8Zmq4oEShzXP9h/85wuI7fMFc
         meJuMXpChJGSap7iU+VcpCxYcH4+ppZzNnVtTBnXEzFdoLaadM1zV8CyuAyAvCBVvjTA
         IuTCO67M9dEjlBxd+BxA+D05LzSVyslZcdp+PDvu9t9/Iv/nENM2Dvv5LFS9alY/03Dn
         5HBQ==
X-Gm-Message-State: AC+VfDzGaLlTglkb9VvGU0pITwadQ81L8TZ0ZuLMDO7Hu1oIDQkkX0oQ
	Z8c+UUKoLeF5p4NFOTVCmYkqW4qYpuJPgy6C7ZRzzQ==
X-Google-Smtp-Source: ACHHUZ78RQenLCYkxk9+CzCIk+O8vCkKR3U+xIHICPPk8fMwfTCGRZWwvbvrkCMDLnlSE9jGyOEsJQ==
X-Received: by 2002:a05:600c:2152:b0:3f6:938:1001 with SMTP id v18-20020a05600c215200b003f609381001mr63274wml.8.1684773509801;
        Mon, 22 May 2023 09:38:29 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:29 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:59 +0200
Subject: [PATCH mptcp-net v2 27/37] selftests: mptcp: join: support local
 endpoint being tracked or not
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-27-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2031;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=arZmfNlZiJYrK6XCf9+gbWxZ7Kz1AFhMHl7pmmtxWvQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pxOOLSckky54gZWbE2qyRN5dg6smpOGg0OI
 xMXB++vKfKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacQAKCRD2t4JPQmmg
 cyAZD/939z5ngyzAYfrIt9GY6BEkSntBM2ONCJ2GhJ9mxbEDq8isK3MVYS3GHhbAJTLpkxgOC0l
 lFG2aLcX3P/Hn5+34zJFr0GGOG5jEaKQIIGpf0dL5I0yrj8jroFCke3aMLIQS3VDJWw3kvArssM
 ZK2MdTX8eu0HPWrVsZMfMk6AXKPyZLRYf+WnD8/nDCZy11qQHe60rEIqfF0wRYNyneFx/FuR/7B
 UtGvpuFNFiephqIqgTn3bXgzmiDhE0c6tc7S4xi9MjgSH3o4/C9d9WwXJiXFC18ZL9SMeY2diGc
 /+ZNsQ2NX6k1RxNyFjHXPFhwvxccYLn0nixXuYkciUwPjFD41ww71cX46V8QtxWNxtM/TsKzdWp
 V7VNLBMf9dyppAPj2fJdB2ctz3EYTOT9dZanuqn0nt1Ix2qryjEN2Kx439p1+mmCYMLRIR0Msue
 RiSZCtPXCEI2WyqBFvH4WQpaXtwuHtIUyG3/Cy8QqOqLywCAQBgqopS8iek5ZoZ3GMqL/6NK336
 fCi7cpj15wm2gcWaNciRKX6s/mUviUh7tjlCtQpehs4dVlW0d3mTwyvZHV1usMuShq5cwqwRNQs
 /DHV98CwwcaerWT9onz33PohZtgq51F+Ob6jeAsiOf0gYr2NQmYzDXddksJPDsXurBTOkOK7wa3
 WwjS4pVm+tODpiw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

At some points, a new feature caused internal behaviour changes we are
verifying in the selftests, see the Fixes tag below. It was not a uAPI
change but because in these selftests, we check some internal
behaviours, it is normal we have to adapt them from time to time after
having added some features.

It is possible to look for "mptcp_pm_subflow_check_next" in kallsyms
because it was needed to introduce the mentioned feature. So we can know
in advance what the behaviour we are expecting here instead of
supporting the two behaviours.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2ae6d99f3eb9..1f24495308f9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2184,11 +2184,18 @@ signal_address_tests()
 		# the peer could possibly miss some addr notification, allow retransmission
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
-		chk_join_nr 3 3 3
 
-		# the server will not signal the address terminating
-		# the MPC subflow
-		chk_add_nr 3 3
+		# It is not directly linked to the commit introducing this
+		# symbol but for the parent one which is linked anyway.
+		if ! mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
+			chk_join_nr 3 3 2
+			chk_add_nr 4 4
+		else
+			chk_join_nr 3 3 3
+			# the server will not signal the address terminating
+			# the MPC subflow
+			chk_add_nr 3 3
+		fi
 	fi
 }
 

-- 
2.39.2

