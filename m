Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF0363A8
	for <mptcp@lists.linux.dev>; Wed, 30 Nov 2022 14:07:01 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id ud5so41599503ejc.4
        for <mptcp@lists.linux.dev>; Wed, 30 Nov 2022 06:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBj/U42gqgyxFUVrg5VQBmaofMncAmVJOsdRq/xN5Pc=;
        b=NU5tWU08fHE1TTgVHomqTdpYrqbrIf5tIko5VY5yPUNv98/0JlYv0z+QbcuTaDrn1g
         3Z0COWJO++GCtfc9NXGJmPEJcKQeABWWUfxIKCpyMBeIusxr0ZrKn+m0WlsYfYPKF0up
         8Yk7flMl2X2Enfj1c3PyCCU71kQdBQxNS5X3YRXp64PrK0Qd1qwhvcg5mf+BFr2RC8mn
         lIDO2MLV6EAkZXA1hZF2su0yqTvYP8r/0AmN+EVePxamAiqcnGtwhLCA8vDdgem2EYtn
         Bf53TSGSok1P5Ki/NhjFqNY44qCuQHRHXp5R7OM2aekPzcrzvjDLIVgPsO7aOLRN0KWu
         Er6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBj/U42gqgyxFUVrg5VQBmaofMncAmVJOsdRq/xN5Pc=;
        b=iH5FYdTCWMXxzbBpLmmVR0sSJUi+Z84AaUOf1kg8HTq3wJbj1QgHCMUckvh0cM6Ggm
         U3YjLD5RjmHd2Ao1DhTg0JiRaIsuLefIceoH+5/Ua/UTZ5q6uPFW6mWFMjJr84iTzFh9
         PLUSX45qRmyrIrBTwaN9Objc8pKq3Ct/gHqZP9gqu0gSp0K54rAqsfgJejUmlm1bTG13
         CuGZqpJf+RGTyF9GsoLZPEJQYkvg4IGiyAR9y+Jx2QuiiJK1rDfugp7DpGtaCtUtJwoC
         XrtlerdUAjIeUzalFH+Sb5T1RllTOMltUs/AWG3ty+HCAQ93pbXvpFI3p5/BUVHSWRaP
         x51g==
X-Gm-Message-State: ANoB5pl4lrhQMdIwvu0wrKesZ+GD4MjIkKjbss7Zwhfat12+7X37wx1C
	8UXmZVKu68cS+oeylmtHX4980ZaJy+/OdWpIfiU=
X-Google-Smtp-Source: AA0mqf4xvaSPBJ1Fh+TBfwNKz8pveAReQVkfUE1V97XbMJvkKYWfWQ3PzFquOMo+4NAUZTwurzC+wQ==
X-Received: by 2002:a17:907:900f:b0:7c0:9879:38d4 with SMTP id ay15-20020a170907900f00b007c0987938d4mr3871460ejc.746.1669817219774;
        Wed, 30 Nov 2022 06:06:59 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id mh1-20020a170906eb8100b0073d83f80b05sm692454ejb.94.2022.11.30.06.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 06:06:59 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 03/11] selftests: mptcp: uniform 'rndh' variable
Date: Wed, 30 Nov 2022 15:06:25 +0100
Message-Id: <20221130140637.409926-4-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221130140637.409926-1-matthieu.baerts@tessares.net>
References: <20221130140637.409926-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3621; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=czOc1nAblZhAn2DlORqpq06aMc8ExsLsax85fE7Q4Qk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjh2Nol4cUE4IpE/zP1tt/xCYKkzvQ42ktz7h9FiIY
 DoerSeeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY4djaAAKCRD2t4JPQmmgcwdIEA
 DIltlOcGse4BX3HAl47DtvDjhakb4Bw06Mel15849x658xaDBDla96q3PTR9C3UMH2KKcA0ea4sjUg
 UJd2YoQ7VF3IRziKDh0/MO/VeIQaHyJ5JdWVB4jxjSG5+KEQcTZebQME5+xb6+cyo15HUWPJyU+h+N
 9eykHcuJKCS3bizVWZSH/YRGxaxByZKEcC4JVQV6wQDxIJq/b7pg6tPZ6WthRU6xvDYm/5Gv1exW1y
 RhBJx81T0DFPzEDNdb71wCY3ZflU+nz10bLgpapFLNvAmaFTqDLIPhPbfSHZ78KVAabcb5Eni93Ohz
 A4MCEhpvBRAtk2wEhY7DUDPZlCOj8ag44vIqAZzNEIWUzrvDPxRCLyGsreDK9AfiKKZIUY0sY1LllE
 BwWT3Eqxqfsxv4oO5JOmPfjRkxJZl9YERZIDh2Rf4o/cD7hjHJ8Hd7ZdH5cQUtXh7swyFcDST1csDr
 UJMa9qohkLwVBfZJ/eVJ9gKr/cJVSWN2IvvNKEExTHhle6PCq1+dKLbDQZx6ZjN7Y1lq47r4s8Nml3
 Uyd5vTn65hja1g6zhkVobRxfnUuxBtD7nZtyNZ/AsNmb0TkcjUOZXErSyemdklrT38fkbtlKHFzvQv
 P73kRx66KSufaY5kcjvaTOM/NF7oF5XwzgyjEnSFZtCN71AqeGOsv7PRn/AQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

The definition of 'rndh' was probably copied from one script to another
but some times, 'sec' was not defined, not used and/or not spelled
properly.

Here all the 'rndh' are now defined the same way.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/diag.sh          | 1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 3 +--
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 5 +++--
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 2 ++
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 1 +
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 2 +-
 6 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 515859a5168b..24bcd7b9bdb2 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -1,6 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns="ns1-$rndh"
 ksft_skip=4
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 63b722b505e5..a43d3e2f59bb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -274,8 +274,7 @@ check_transfer()
 
 check_mptcp_disabled()
 {
-	local disabled_ns
-	disabled_ns="ns_disabled-$sech-$(mktemp -u XXXXXX)"
+	local disabled_ns="ns_disabled-$rndh"
 	ip netns add ${disabled_ns} || exit $ksft_skip
 
 	# net.mptcp.enabled should be enabled by default
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2eeaf4aca644..2a402b3b771f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -59,8 +59,9 @@ init_partial()
 {
 	capout=$(mktemp)
 
-	local rndh
-	rndh=$(mktemp -u XXXXXX)
+	local sec rndh
+	sec=$(date +%s)
+	rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 
 	ns1="ns1-$rndh"
 	ns2="ns2-$rndh"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 6e8f4599cc44..dbee386450f3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -30,6 +30,8 @@ add_mark_rules()
 
 init()
 {
+	local sec rndh
+	sec=$(date +%s)
 	rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 
 	ns1="ns1-$rndh"
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 189a664aed81..9f22f7e5027d 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -1,6 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 3229725b64b0..5dfc3ee74b98 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -33,7 +33,7 @@ client_addr_id=${RANDOM:0:2}
 server_addr_id=${RANDOM:0:2}
 
 sec=$(date +%s)
-rndh=$(stdbuf -o0 -e0 printf %x "$sec")-$(mktemp -u XXXXXX)
+rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
 
-- 
2.37.2

