Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2D2154B9
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:53 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3f6e72a1464so44057775e9.1
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542611; x=1688134611;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8twWBmnba30a2pixgXyNg6a89JuPR9fBcpRZn4FktQ=;
        b=429TAcEGtuc9HqQTCtXk1sYcWqKKU41B2I7atqgVpBsSvGnoIpX5ifHb1K91+06ygB
         5j5In80TBekIE+J+AQ1/muJ1cGaxA88qgu6iDbHqmLpsKwo73gHYdmGXd4VBV+u4K/sX
         iwxVCeNO4h8N1GDObRfGZcwur7ilS9bTELmM8P0L/uxchfYCl6eHl2nLVfxuVOLqHDMC
         2W+TFR9r8UZMQXjK95uZOEsw6lYrlrG5o1A4hmErbuIqmxYibATY65QnmN5nMMZtI0tx
         lHOFf9Or/KeYSkyuEbeJViwy9Gb78ahlDArOeiQfxeWxi8Z2ekWkcsJf3bOREWLDV2Gl
         SN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542611; x=1688134611;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8twWBmnba30a2pixgXyNg6a89JuPR9fBcpRZn4FktQ=;
        b=ZWpuvzqA9qA3HTAqfBKeP6ThhVlzkURpjPI3zjDrIuolL+uzmMOwLNzgtRTESsFNDX
         bhO11xioTo4muz8ONWn8GZIiiiDKfn64vAzuSn42S+AQKFYG0wt5Mh0YMPqHwAbpEwRF
         RmHO1loBjV1Y8TiLnSVblHV6LGtTk4DIqoxMeITyaMJ6IJ7FBFtJxTtxlGN+dOvt1zss
         7TcPkGwx7hoSAVVtduFKYmrAWe3OsArqWCbnkfij19fbhe0yrBvOGSUAaUxhN1msqp0A
         Dg7vP7xDEqfGtC0eyFtVPoPPbi1zWkH3JpEJ4tO2vP5g6k5Pfirycaj3P/znOsmwYVNX
         SMfg==
X-Gm-Message-State: AC+VfDxE/DHQj1jqWSl6ZivOgPB0SqtNEg9fo4IPP/jPJbcQwvNxM2qu
	YYSIx4oUDpOJVK0VyC0Ql7Evc5GTRLPvhgVkYaGd+fZZ
X-Google-Smtp-Source: ACHHUZ4PG00PobVq+Us6du9r7SoYxLtW1EsAKQPO65CM70iIma3rOvPOgDpe7ZfqLO4yq7TMoId+qg==
X-Received: by 2002:a05:600c:228c:b0:3f4:2365:e5ac with SMTP id 12-20020a05600c228c00b003f42365e5acmr4032888wmf.13.1685542611721;
        Wed, 31 May 2023 07:16:51 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:51 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:40 +0200
Subject: [PATCH mptcp-net v3 20/32] selftests: mptcp: join: support local
 endpoint being tracked or not
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-20-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2031;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=KNqNpKTYPCpOEXPv8p7U9KkBXS3V6gWg+apQ6WCXEM0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bD16IlWN8PKrAUKtUmwaq3dCdKLelg6inCP
 6CVSlrqImWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwwAKCRD2t4JPQmmg
 c6lFEACjX4AF9gFotMC6fBLt1EMsBouMiCZnGn2pcnpmMIi+/M0FuOnQqDJ85p5qXzI6/0b55Qj
 BwXlJhpcUdos3q8Agu2LfZDHvpIZ3qz1X7OTPfOrXQICVorVvK2rg63Vbvx7Nu9ldJaMpYVAYvE
 C1sIk+KoaMC6ObxVUhxRhL5lYXs8StrnInBPoQ9xXqiVopIZ/6MLNTZ4m2hvXFugg29HA5DaGk2
 v2xVQj4GsBqV0djUcSPoIwH49sAeygrNYQTnAbRC9ULhrjSiq0yc9qwZ+KXt6ilrIduolF+JakX
 QpFjWEoL/AF9OsOqCHJp4kZZb79N26FyDVjJ10PlLsvv+C8hpd1usIt4lNOpnv0DBFnE19rTrc3
 mrCqj4XUmIOraSVIt02dtcNRrY/ogzSiuU0NEEeTw+gUEN8aONUnzrXH7bjtdhrRckRk9sFyD2D
 1tG5j8QJMkcZS4A4VGa67wNvNe29+C3SoCVu1JazkJ0enIBvu7sAeKgJaV9RDG+EhGQ8S+aYAC1
 vcVU+M0Keh5czOaq5lglw9+sDjegzK3qUwjTFOCNyLXZ3fjCBBwVbu8Uov5X+SW6yprVYsmhUXP
 0ew79wGyTVkDtFxyZrgUzXY5UAXPpCq8vM9wWxNq3iWmiAOlC23lzihg3nNvKp+LEkcD3RpH3Sa
 lxuCY/YRSXjvfHg==
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
index 31b7d04a4e1e..443a186e536a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2135,11 +2135,18 @@ signal_address_tests()
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

