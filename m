Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246A463B9
	for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 18:21:42 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id fc4so33532420ejc.12
        for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 10:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqP1m3ysIMg0iSieM9IErT6eQu57d4t7jTZbtjotdQo=;
        b=sppVVW2dpTb6AoyzQO9lHIargc4OvboetyZHtHdUUb4bRBm/H3Qx412R2GgRpb16B7
         8n7DXiSM2JPIA5+FDWen1JQMrODtPL2aJCFB3dNiI6WPZUUCu29XQ3jUhRlsaPbxAKVp
         wA1+a5RVajd0qEQayVV68umyMPahBIumy6VDl3SWaAlXVy7WCJw9+aoTNy8X4bJ1VdUQ
         4lE/ptfRe0mvz63msERwd1Pjk2jbJ2nGCKET3MdFxk1vy+g5AFwPdrV9xGShyJmEgMqp
         uuhZ42pmwEts3MohYSwLEa4cvwkv+r/gT1h4f/M/W4fEadguUDXjOk0YT1rit2PXFdF2
         9awQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqP1m3ysIMg0iSieM9IErT6eQu57d4t7jTZbtjotdQo=;
        b=HApeBmTPVjdm+OUa19edaqMQDC0pxSeQeD9XLwJ9hNp7fdnbkuGUlRt96tFaCDHh/Q
         EZaHd88baCAtNhUr9bvnz2rF2A6M3nUu7NhWgDsaggU0+P+5z4j+a/PvAx95aZi5u558
         Ce3/K7P886Jbmzr5fq5psGV1oqpOp6oavX2O/9swB89Dk9zrMr0vpT12xfgrQXEt10X6
         kJFxT4GlVfnB41oVA428FrFE3U2ScsZoDjDuzor3JveB6e5DpszmWQH7owg3W1ikHVIv
         lcAIpvX9qMCVVN9lNEPUw9b/F4gGctrj+4a76R/2IOHUZyp9NG7nD9njUwl5vs6ICK/3
         5emg==
X-Gm-Message-State: AFqh2kpvd525m/XbJZgVIUZMHX1SetOadFPkUb0BhW1IO5VcQvQdmnG/
	QIjhLt5NUbJ5fJm8p4/7nmS9fS4DGvQvHAxhb9V5Dg==
X-Google-Smtp-Source: AMrXdXvUt86k+3bxB3RIEhISpHAJSXfz7w8MHm5gHCETMYueM0byQBE05z7wcLcNaP93iMALjPE7Ew==
X-Received: by 2002:a17:907:c301:b0:7fd:ecee:c8ba with SMTP id tl1-20020a170907c30100b007fdeceec8bamr29927365ejc.42.1672165300169;
        Tue, 27 Dec 2022 10:21:40 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o17-20020a1709062e9100b007bd9e683639sm6336612eji.130.2022.12.27.10.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 10:21:39 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v3 06/11] selftests: mptcp: add test-cases for mixed v4/v6 subflows
Date: Tue, 27 Dec 2022 19:20:52 +0100
Message-Id: <20221227182057.2288816-7-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221227182057.2288816-1-matthieu.baerts@tessares.net>
References: <20221227182057.2288816-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3187; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=PF+uTEj4sVeWj5WOdqleYcs6AGKouaOt3Y7ZNlAhaDY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjqzd6/u9W3XrLYTL0rSfmiQqGD3i+cS34N+jOWwX+
 +9eeMG2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY6s3egAKCRD2t4JPQmmgc6mOD/
 9mUziO3/vqgt7DQv5o8qkW33ZcG+RAl6EyVLv+9Thx/DDlxU669hMnX1bHY2JJN+2Gav6/ThmUsgG5
 2Z5EGiXsdI+U6EGPpwWvcWo0Fh23Fljf0roAQTvDB0eANz13RB6EZvK0ZNT0TnIW/R6dAV0ZsVvw7r
 vuNKAvyYohjDDhyAAHnfAnJdTb80Gh19WjrkSvaiEhZ4AhoWKZ7tnVT0NEp4LIgGjTNtRjd6d+G9rx
 h2qpIGCDkgPYYwGQXIhOQC8v52SoX1GhtAs3AQI+VsghgYWdJCRpSNUXOUsdFLBGo+66dFC/T/W75F
 h7if9FSoX4PaprRLAac86A/f/3I88RI1vlUiX1hmFYnDr2F2ArlYkhxJmFdGxfzsqe/HM9m+2uGRg4
 fYpJ5WFA4/dsqkV36rOCFki+ptKQnEFqh/pUdsus/Oc0AXwXafgJIjAYnYFrTNUOawb9LaOyOf1Y8E
 eOTEAaxoHuCPBq9q1P4PYMxCGw+BzHukwKvPSBJLCwZPns//9D4iByaMunWCOZbrnqW4IOqWi6rad6
 nn/PBUgUafg53nlrIzDrZtk0Qv2USgNVNBXaH2R+XroGl/xb+rE8UCzN1FsfP4xu/4JG7thsXrpMdO
 4We2uBEMq+UeiNXE9jWk1VihefyYiHxBSGm118M9qNLeH55n5u2XxplrNVnQ==
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

