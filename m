Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E111116
	for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 10:18:12 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id t17so37399435eju.1
        for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 02:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqP1m3ysIMg0iSieM9IErT6eQu57d4t7jTZbtjotdQo=;
        b=405pKO3Cl6Fd3rl1MY1U9UByokLG+dzG/deXNAHeAhU5i5dhVBexYQJZ/IVrQLqUvh
         fNsonJMilqqs22ZI19nEeefCZBrFt0sqv9LVXIsCdBQak1I6vtc01QFO/Wna7vHfDva7
         sRVlkoMUx03QMuDrTl5k4N/V/BhF99sltH+suWeCzK0x9nB2PsknLAhJglErClTTO2z4
         EVySJcsc5DK1kbKcXka+4C9mjMdb57hcSO/GbcKCo9eDRIhtuoN4cv5vXGzm6e1nx6U7
         WIBR51oU4NMdVvhx4R73kRJJ5OGLi/h2VUkjZ7K22vqU/jEx9otWsGadYdSr+KNDf/zB
         GVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqP1m3ysIMg0iSieM9IErT6eQu57d4t7jTZbtjotdQo=;
        b=YuPSfil/EbndIbjaEyOw5cODkV2sm3VgTJLn9ijBeAoYX5vS/oVrtoa/Yp94Sf1gOX
         7jQp5d+WgwyiZxz1iIIOmFGqYwUnHhRJCxmAqtoc8se3sCQBBct2k5Fm7ozUNatfHRaJ
         8d8MD2dSu6EH/9uXjvjixT3Tpqxq3t3Ejp0P2pR+fFxAaX20/k0LWrIv+MkYyfTljxR6
         82vuiu/K2EqR+5fF51p2yD9ao74aFflCeH/1ixveMQtJTb5oYwkFGQtNIwWFCqJHjoMe
         TfCCMUgAhXSP+nNJ2W81sjgx+d+eMoGz2Jo8ikHEzsGCL2G/hDxQaE0epwOW6X3kLsyb
         Bt+g==
X-Gm-Message-State: AFqh2kpG2g4Ypd0syNIC1bb5nmtCQS+aIzrqYjuzxT4nBSy7bDSYaLI0
	XLjxOw5YuXbr25dIlTDj/MHxewBgRL3UUwCC4vFZ2g==
X-Google-Smtp-Source: AMrXdXv40hxEPvIqi9bWmozjg07KEwY52xeUUkKqJ1PDjZEzaMhI0bNlKjVvuFv0DZ5aP5L5EMHaHw==
X-Received: by 2002:a17:906:3c18:b0:7ba:9b49:53d4 with SMTP id h24-20020a1709063c1800b007ba9b4953d4mr21320770ejg.71.1672222690965;
        Wed, 28 Dec 2022 02:18:10 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090676ce00b007ad94422cf6sm7174127ejn.198.2022.12.28.02.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 02:18:10 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v4 06/12] selftests: mptcp: add test-cases for mixed v4/v6 subflows
Date: Wed, 28 Dec 2022 11:17:42 +0100
Message-Id: <20221228101748.2518303-7-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221228101748.2518303-1-matthieu.baerts@tessares.net>
References: <20221228101748.2518303-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3187; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=PF+uTEj4sVeWj5WOdqleYcs6AGKouaOt3Y7ZNlAhaDY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjrBe//u9W3XrLYTL0rSfmiQqGD3i+cS34N+jOWwX+
 +9eeMG2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY6wXvwAKCRD2t4JPQmmgc3dBEA
 Da367T0W/gaP2E7brKO/kfdZvaiyOridkDCZOXPFsYYGng4ssdityTDidNJWGlTk6JRcfdR7ifACDs
 a/RUkAM3COIdDai89g1UT+7adZsChMpPqLq51ZvOKyp2elSmXRk5AXCasa7lKUeN3QBu9Fl/CfJ3vY
 rlzMUln/MlS3OEsEwfIlM7nGp1orl7IoFhohuencgyOE0y82zf7hS1HRCNLhlywkEhzMtqqDxw+QGP
 dniwOXoWTmASiFKCM+hqSYzKjNIEOwjS1yn8EduS1+95TDmc/shMwsyW99tvnRuC3D8X/8QnMU/JUy
 b0h632XnMKFD7YzTt6dGBhosB6cttyd/zXCQXkoFdz7QXVakQ97ZDzXlViX75OSy1cgywKCmo3qdS0
 qNhKKIun4yQL5OirkWHHdR4alMicJqTd4+BBzNVa2/WraoY3osQGLne/t3yOX2UaX19bvNk7inFbDe
 c5OhZ4X2hDI76atIG7d+hJTLP5xOxMWkle6DDRDd0DDZ1WP4MGU1O2jPLDq4ZJ4wVAv83fAkwr3aKF
 +CanjsTR9z9EwKi7nJrVZi6IqrriWvakJ8DQUV7nuJPAR1VrtBLY7m6Ve3UDyKEvPbNUhOYjmOvYzM
 E0gg4Ln4XUcrDBDNrmxsbVQVyp3I4HXkumFvSMQAtrVaEfZkD/vuNX8S09Mg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

Note that we can't guess the listener family anymore based on the client
target address: always use IPv6.

The fullmesh flag with endpoints from different families is also
validated here.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 53 +++++++++++++++----
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d11d3d566608..387abdcec011 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -774,24 +774,17 @@ do_transfer()
 		addr_nr_ns2=${addr_nr_ns2:9}
 	fi
 
-	local local_addr
-	if is_v6 "${connect_addr}"; then
-		local_addr="::"
-	else
-		local_addr="0.0.0.0"
-	fi
-
 	extra_srv_args="$extra_args $extra_srv_args"
 	if [ "$test_link_fail" -gt 1 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
 				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-					$extra_srv_args ${local_addr} < "$sinfail" > "$sout" &
+					$extra_srv_args "::" < "$sinfail" > "$sout" &
 	else
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
 				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-					$extra_srv_args ${local_addr} < "$sin" > "$sout" &
+					$extra_srv_args "::" < "$sin" > "$sout" &
 	fi
 	local spid=$!
 
@@ -2448,6 +2441,47 @@ v4mapped_tests()
 	fi
 }
 
+mixed_tests()
+{
+	if reset "IPv4 sockets do not use IPv6 addresses"; then
+		pm_nl_set_limits $ns1 0 1
+		pm_nl_set_limits $ns2 1 1
+		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		chk_join_nr 0 0 0
+	fi
+
+	# Need an IPv6 mptcp socket to allow subflows of both families
+	if reset "simult IPv4 and IPv6 subflows"; then
+		pm_nl_set_limits $ns1 0 1
+		pm_nl_set_limits $ns2 1 1
+		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
+		run_tests $ns1 $ns2 dead:beef:2::1 0 0 0 slow
+		chk_join_nr 1 1 1
+	fi
+
+	# cross families subflows will not be created even in fullmesh mode
+	if reset "simult IPv4 and IPv6 subflows, fullmesh 1x1"; then
+		pm_nl_set_limits $ns1 0 4
+		pm_nl_set_limits $ns2 1 4
+		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow,fullmesh
+		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
+		run_tests $ns1 $ns2 dead:beef:2::1 0 0 0 slow
+		chk_join_nr 1 1 1
+	fi
+
+	# fullmesh still tries to create all the possibly subflows with
+	# matching family
+	if reset "simult IPv4 and IPv6 subflows, fullmesh 2x2"; then
+		pm_nl_set_limits $ns1 0 4
+		pm_nl_set_limits $ns2 2 4
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
+		run_tests $ns1 $ns2 dead:beef:1::1 0 0 fullmesh_1 slow
+		chk_join_nr 4 4 4
+	fi
+}
+
 backup_tests()
 {
 	# single subflow, backup
@@ -3120,6 +3154,7 @@ all_tests_sorted=(
 	a@add_tests
 	6@ipv6_tests
 	4@v4mapped_tests
+	M@mixed_tests
 	b@backup_tests
 	p@add_addr_ports_tests
 	k@syncookies_tests
-- 
2.37.2

