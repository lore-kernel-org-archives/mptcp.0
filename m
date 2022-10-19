Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DD53C26
	for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 16:20:08 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id v1so713917wrt.11
        for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 09:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xO7akXqZ9OyM18k2G1NCNjje846oBCwU3NC4tbIuUyA=;
        b=4wMJ+aB66kQm2sa5C0L4jJR2e17lRrYgwKw3oPTKXOlvdyIx0h7nilrfVxZkqFf1T3
         2Ae8ODX2Cytd6F/HXBfKb1KDnCm4Y3PE9TkU3kKYiFIwRiN8LgPmbi4VcPaFtSSy0Rl3
         xHJKG0SJI9NYswoVedK/7Ts/bPZ3Bw+8B/ehaD5EL5E49ctHUWMwRILjnI7FnAD6TIui
         pgJpU7/CvdlhgbT/yYd30y1Y/CppuBnryqXDCZaUBmYwIU8G1SjpidMx3Z0gR2rOf2o4
         t2ivNWzXbrD+6wzMGBGOCDmkgv771QSETbPxw6SFeX3wOYJi8nwE2EtrhC6v0LahhRhX
         zo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xO7akXqZ9OyM18k2G1NCNjje846oBCwU3NC4tbIuUyA=;
        b=J9uN1rEms+jqvBJwJnivL0SVBE7LY9qlXq5oWb86+dNYoRkL7/T+jb30WAc+Yqk42A
         iDTF6/Jx4kvNVzIAX1+5vKB3Zd2rQOpF+s5feD0gZK055Qu3DQGa/ojd+XsV4oTggFui
         yIrGHpvHG+7l8tc+7csxA+nBH7xxmcqHZJx7Ff5+U9h0xXQqHWrOCvieDuzAbBwk+uBR
         GNLDjn8OxPWRQnPzeDKlknIAzbqrIeRTAt67K2Ru4aNSkQzGyHjtiqw7mt+hPEXmXE+N
         Uk3dTAqp68xT7MPygG9173s00pgp/fNap1TYlJ7Czb04khAzik34OwjX1sCAh65SCmVJ
         kytQ==
X-Gm-Message-State: ACrzQf0NxMSMDoHuRYqU91o8dBdyF1Sj6Y3FnXgAPYiec+KBIBNRpx15
	UTrtjkVQqWLldrfXNUGGm7ddKJ4G9zdBvPVJg48=
X-Google-Smtp-Source: AMsMyM7uYnLYNIMI527ylfd/6NjzX7cqieaBSvjBenGRBM1Dtb0O8z8tD5GdpW0kU9g071pogdaU8w==
X-Received: by 2002:adf:f710:0:b0:22c:d668:504e with SMTP id r16-20020adff710000000b0022cd668504emr5763367wrp.98.1666196406508;
        Wed, 19 Oct 2022 09:20:06 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m1-20020a1c2601000000b003c452678025sm433717wmm.4.2022.10.19.09.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 09:20:06 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 3/4] selftests: mptcp: removed defined but unused vars
Date: Wed, 19 Oct 2022 18:19:39 +0200
Message-Id: <20221019161940.3178393-4-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221019161940.3178393-1-matthieu.baerts@tessares.net>
References: <20221019161940.3178393-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2233; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=/aQVed8FVDQJkOFH15QgHf6ZsRUS3VhRUsfnudzsslM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjUCODSQmHr5j/VeaDCmefMo1HjXF+UuVMyzz+QzTd
 jE/TvVeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY1AjgwAKCRD2t4JPQmmgc/SPD/
 9x3EpU1xAm1XhTQi7l191WDIkLcrUMnU+ZJJP+17AdE89iBCZ+v8j4mfD4XSY+wAd01XIq3ktG/d3V
 KaTVoRu3nXpHe5L0yJ+q7QAFMr6pEYevBhF5X+8mroUYCUMR1m+pe/vUnHh8FoNLBExMQOmtlVrVXO
 jPm+OVX3NQ4de72ifZdGsXDbVTQC8l4zhM5U/A5G/a06/7rsgWpXtKA6Jiuhn+vqmu6/EbbWDR6u6h
 Z/3rUVDch0MJ2J+nJR9TO6NREM94ahH6uC4klNTMguSHKoP0bfVFdBlJTX6bPpTVNx4mpv36uc8MPR
 8bUqj2973AJNuzOAxRnP4krj5BgM7Z31G7d6eGrXjmGF2VdB1k+6ZBLvyNo02NNrmUxFM8IJlEsFoK
 Lek0ZS7QP+FR6fGCduFMeW3IW+Adz6IBPxUGy16M+d6djY99zXbGtQHmcx7sjUEOOjUlufSgWD17A+
 Fhh8SMYhSYLxdgRjiw3dPnHr0az2pnRlIB8LHm/sz74i5GQi4XPE5v7OGu19LC+47MYVY1FcyVzELy
 0ZRuVAz30gI3U8VK9YP7Lbg+XqqPIGuI3e4muYd8tAjL8yBmJFuPavRFatr0JBFQXGHrecy80a6v49
 u25ey/PGs/64Ux0lsRt4tRcZ6YhotrPQzwxNVfUmRI6NEpgpsf6x3fQYdoGA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Some variables were set but never used.

This was not causing any issues except adding some confusion and having
shellcheck complaining about them.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 3 ---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 1 -
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 3 ---
 3 files changed, 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 621af6895f4d..5942a16736a9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -764,7 +764,6 @@ run_tests_peekmode()
 
 run_tests_disconnect()
 {
-	local peekmode="$1"
 	local old_cin=$cin
 	local old_sin=$sin
 
@@ -772,7 +771,6 @@ run_tests_disconnect()
 
 	# force do_transfer to cope with the multiple tranmissions
 	sin="$cin.disconnect"
-	sin_disconnect=$old_sin
 	cin="$cin.disconnect"
 	cin_disconnect="$old_cin"
 	connect_per_transfer=3
@@ -783,7 +781,6 @@ run_tests_disconnect()
 
 	# restore previous status
 	sin=$old_sin
-	sin_disconnect="$cout".disconnect
 	cin=$old_cin
 	cin_disconnect="$cin".disconnect
 	connect_per_transfer=1
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 8a83100b212e..6e8f4599cc44 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -10,7 +10,6 @@ ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 mptcp_connect=""
-do_all_tests=1
 
 add_mark_rules()
 {
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index ffa13a957a36..8ae7e0c004fa 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -148,9 +148,6 @@ do_transfer()
 	:> "$sout"
 	:> "$capout"
 
-	local addr_port
-	addr_port=$(printf "%s:%d" ${connect_addr} ${port})
-
 	if $capture; then
 		local capuser
 		if [ -z $SUDO_USER ] ; then
-- 
2.37.2

