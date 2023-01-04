Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61356AD57
	for <mptcp@lists.linux.dev>; Wed,  4 Jan 2023 17:16:00 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id i15so49578545edf.2
        for <mptcp@lists.linux.dev>; Wed, 04 Jan 2023 09:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqP1m3ysIMg0iSieM9IErT6eQu57d4t7jTZbtjotdQo=;
        b=hdfgaw6yWUkoaSTZYoS5Zjt2BFTasse1Rb4vChB9rHzs3Ud3MnbSw+EWzrhDJ2rvpt
         g+xzcocYBpwyE00gsn/jczzHR0pfIGss5l1yIT57okzVOgWHmv/lDN03xm2oOP/TmqCm
         bt//KrKTZD3A2B+klSqAKRFFO6FzmY4+NrRcPGrj58TWS6bEDcdTfzGyhgRQ3vUmFo1D
         SLXX/o61HO0zapyaB7Qi2BAT+IlA18TcmFjf3VKqOoSYLQvw2JAJvvNkAKKOme7UJRXb
         UNyqxqpwJtI6cYZNgiNAky5FMjW5JPSpgM13xnjTUBi7ZZnnZMVkgHtsFRtpnxGzq4ZI
         EquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqP1m3ysIMg0iSieM9IErT6eQu57d4t7jTZbtjotdQo=;
        b=qZn3HyeQBLumbVDeZjEL85xIVT4xazhaUq3I9tw1eBPR1q9kLy65eIfAB2AmzdKy+1
         WyqtHcz2EOwVAgWWj9dx25mR2NkzXsLbgjH0qQbFcId8Bw+z7Sqttg9QsVT8s2meKyjb
         IRq5BbCBU/HpbQ7DmDJUuT3SqR/PkMMAI/XGpe6V/UFQiGfNUo4HbNSfnUZ8mn3QOIbJ
         JicQQ1xzCGzRQpsEpg++nyLFhquBT1Nhb6+nEtaGwXlcf1EsPmBVxfuy07dMOKhpNQQf
         58uWNzMOqM47cSdwEqrhLA+ZrtzGnJKTqA5gUDo4PcVFrWzK7uYKR8/CDqXO2JHrPmDf
         y52w==
X-Gm-Message-State: AFqh2krAl9uNBAaFc1tpAcPqtX8ySh5X0rMTU97T6yYfPU0boXaT1YDh
	HHNdPI96Pt4Bx60t2ZhwXA/gCKhcHO1PvZ0GMUA=
X-Google-Smtp-Source: AMrXdXuv0EQBafLWPbP1MEvOIujSR165JO6DbCBdoN9FKylBIM++07WmtJ0qCxkXztH9udVQxfRTRg==
X-Received: by 2002:a05:6402:f05:b0:45c:834b:f28c with SMTP id i5-20020a0564020f0500b0045c834bf28cmr43531954eda.9.1672852558287;
        Wed, 04 Jan 2023 09:15:58 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m11-20020a50cc0b000000b00487fc51c532sm9258074edi.33.2023.01.04.09.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 09:15:58 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v5 06/12] selftests: mptcp: add test-cases for mixed v4/v6 subflows
Date: Wed,  4 Jan 2023 18:15:20 +0100
Message-Id: <20230104171526.1416746-7-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
References: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3187; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=PF+uTEj4sVeWj5WOdqleYcs6AGKouaOt3Y7ZNlAhaDY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjtbQI/u9W3XrLYTL0rSfmiQqGD3i+cS34N+jOWwX+
 +9eeMG2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY7W0CAAKCRD2t4JPQmmgc4YcEA
 Cbj8zq9Si72wYPpJ7lWeBWSAZ4l4BO1JZAxS0srtHZGmYZs5dLVbqoHr/3ltx8cIMRsot83oHIRZOM
 wMWe5y9/yybX1WIs+AuDs9/r+wZgybtozGAIzceBTap6OW9dGGJpqWP6E7Nl3cITzG7S+j1Fjc2/la
 mYJTa8VlKhRQuomHi1fUzLS2BNRFMQlClMQg/6ZW6dDnmugd7/TbhgM1KecmV2hW98mDbKEiz4PoxS
 964jDTnaya5FxquX6ULyQjwOsBXmgsZtV54PVKRzbf25DGAYA9+8qXxAPYb6qilv5OPiKmlaZKgkAQ
 ChlSG/COHSeKHx63AvuU9twelmpq2aWzU/HsnK9b/F18UG1d+aba6LqvgUfNeoL+UjSgLIHQPiSTBp
 /cpDCBPaEv3gBx4hahlq5i7RRi5XWNvnR9mNhwhrJg2qkj8ZfsevtwV4GxpMsQjq6/g9CgesPt/jqB
 8krqWkUfhkg1b2DHppsWBRBFRKWior42nM1UVXs05A7c4ABDVWHFqDmMljkab4BneO+DzEQxmVyxaL
 VrpCR5FfmPb1Cn9V5rIt5uTsBU8jcH/hDqbCokOzFqpx1POyK75pyQrGhbLB4Xut2hnxIw2V2nTf6A
 8Rfwsz+RD6FQ6CnCJ6Mgl/dHhzfzRubZcr4TmunIHMeqIP1Or9ZBWPGoHtDQ==
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

