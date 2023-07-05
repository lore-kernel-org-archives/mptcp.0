Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202F112B69
	for <mptcp@lists.linux.dev>; Wed,  5 Jul 2023 17:11:11 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3143493728dso4263701f8f.1
        for <mptcp@lists.linux.dev>; Wed, 05 Jul 2023 10:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688577070; x=1691169070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JWpdgqtFcguEOJ7JLAgihFTkDv6ED+BcGhrDZsfYBs=;
        b=T/jCnlekz3QgM8C2zXeI7tQM9DjXPwmSB7UyCjeo5U8aml9At/nZK8yhUayaF2wVGg
         Vi7E3yc12iUflvQEHGf6TOQrgU4P0uqhcjfpog2fR/+992d2fJOKD8LwJI8pk0nMSnBY
         FF0EuHGkF1cacvwcAntgvnX4AE7/5LdtXQiLjgIhGSX7HHSp7yz7Pw2VshHgwiQRHVNH
         wOg7oN0YcCLb9v3IuHMJQekm7rT4y8y+K96T5rgUnZQ2O+Sr81/KYgMWfQc6tdPHgj+A
         clHv8J29XhNNz9gfxKpWQFqZBxS8Hu72wiMBmiUHvJHXKTPHdiEdicXrohRFpg4fh3Fc
         kK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688577070; x=1691169070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JWpdgqtFcguEOJ7JLAgihFTkDv6ED+BcGhrDZsfYBs=;
        b=JmIDhdUxMjvg31Bu1uguJW8xv+mLR3tW1VnyMzb2gjcm5zNTflelVV0NZQklMQtZo7
         RK7CGE/Q7G72zXQoepMItc16/IuB8eBgcdfnra7RnrqekMb82FhcnSBSZp1sDnMmfPoK
         jtzZqfNRwYNITsb9IwwtCf+namkugg6gTSozRQvvulbwRjhTrCEJ+pWTANixbE+j+oEQ
         UxuC/7AZhkZxNXEye/wMCQgHnOBFvBLsdzbc23IhIsRlUygA6ex71r8/CLXS7A84r510
         sCp4T6Nl3U4pvYkTAzlxwm9eX5c14m+ApcLoB8V1gLUISGziVQhFMr3pC+jGXsFVepvu
         JiKQ==
X-Gm-Message-State: ABy/qLa2ngRXQ9vaJhNDRBW3YZGbGWrehrX0w572FC1CmLVkYHvGI4fZ
	0e3paMh2mqXBv1BZYFRnIvTeKW+71v2c2Cp0UwFxlBCq
X-Google-Smtp-Source: APBJJlHGtiiMRKYS+vOCkmg3vmbY9ur3faj9pLq1TBFTwDfLX2BeahuplzQfwkdiMgp8v8Ba7m5/cA==
X-Received: by 2002:a5d:550b:0:b0:313:e5f2:7cbf with SMTP id b11-20020a5d550b000000b00313e5f27cbfmr14345127wrv.58.1688577069668;
        Wed, 05 Jul 2023 10:11:09 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00314172ba213sm16993444wrn.108.2023.07.05.10.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 10:11:09 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 05 Jul 2023 19:10:39 +0200
Subject: [PATCH mptcp-next 2/2] selftests: mptcp: userspace_pm: unmute
 unexpected errors
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230705-mptcp-issue-368-pm_nl_ctl_ack-v1-2-40bcff40cb6b@tessares.net>
References: <20230705-mptcp-issue-368-pm_nl_ctl_ack-v1-0-40bcff40cb6b@tessares.net>
In-Reply-To: <20230705-mptcp-issue-368-pm_nl_ctl_ack-v1-0-40bcff40cb6b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=17981;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=f1ktJ6IcdjCP7uq5qkFZeBHM2fQoSo4uHK6z2W4JbHk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkpaQrtrEkETP00pQ0tNSH99M0rixYZwwvTx3Vk
 2dzSlp3bnSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZKWkKwAKCRD2t4JPQmmg
 c32KEACE3YIbPIPLv0fI5zhvc/D3+cufw/Gbb6R5//Hy/EfSU0WUisj/8irY8QUy07RgkCJQMj8
 L4p3PNmXdn0xgb1xkuAMoFM5FTWKZvaaP4C5d6YrxH31tCmIpUPJnnSUx3roIJRAB/Fi1MGbWno
 1hBym4u2/84zNI8LTcqVfqVs0o2bfTmPYflxclWZOcG0ajmRONwsmAOgkNtFThrZRx4a+5Fz3B9
 RzM+oQzTQ2vWEwoxJ10eTvMel4eSvkI6Ucndq6YTBbY5eJHJoHCB9imW7AMQKXlwsZvdaA9y2Un
 sEVJVzcvv8jpfQ7i1hjkO4SxbdMyOuOyiuzcunckX8Xl6uf8ruXf/boJISV/Xv3iCez/znum1Vl
 eW1JQwsKcXZg5GSHAzwcADgTcgGDn+XlAbobS69tOGyTKK2Eu3qW2wA5YEjnV4q4r3rsJuYGkXK
 k6YlB7P7U14In1auYNO8/Z8YIec7cbAN9/eYQusTwSxHQMaDRjdeETtrl0/iC4ffPtQeSACgvS+
 C3+kmTkXwYINbZ9X0eZeXLW/8sBJyaaUFGAHCbZV0LyWyhaaXK4eBqZ+eLheuBc6RQ7bNiLxLT+
 KdkKlp0g7B8SltA6gT2gzlrs3DowIxn8HALw6yMulXwE6nWiY1kVU59nkmCXjUmNjbrbh4mF++r
 r9xFjyPSFwcSP1Q==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

All pm_nl_ctl commands were muted. If there was an unexpected error with
one of them, this was simply not visible in the logs, making the
analysis very hard. It could also hide misuse of commands by mistake.

Now the output is only muted when we do expect to have an error, e.g.
when giving invalid arguments on purpose.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 100 +++++++++++-----------
 1 file changed, 50 insertions(+), 50 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 23f8959a8ea8..b25a3e33eb25 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -380,7 +380,7 @@ test_announce()
 	:>"$server_evts"
 	ip netns exec "$ns2"\
 	   ./pm_nl_ctl ann 10.0.2.2 token "$client4_token" id $client_addr_id dev\
-	   ns2eth1 > /dev/null 2>&1
+	   ns2eth1
 	print_test "ADD_ADDR id:${client_addr_id} 10.0.2.2 (ns2) => ns1, reuse port"
 	sleep 0.5
 	verify_announce_event $server_evts $ANNOUNCED $server4_token "10.0.2.2" $client_addr_id \
@@ -389,7 +389,7 @@ test_announce()
 	# ADD_ADDR6 from the client to server machine reusing the subflow port
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl ann\
-	   dead:beef:2::2 token "$client6_token" id $client_addr_id dev ns2eth1 > /dev/null 2>&1
+	   dead:beef:2::2 token "$client6_token" id $client_addr_id dev ns2eth1
 	print_test "ADD_ADDR6 id:${client_addr_id} dead:beef:2::2 (ns2) => ns1, reuse port"
 	sleep 0.5
 	verify_announce_event "$server_evts" "$ANNOUNCED" "$server6_token" "dead:beef:2::2"\
@@ -399,7 +399,7 @@ test_announce()
 	:>"$server_evts"
 	client_addr_id=$((client_addr_id+1))
 	ip netns exec "$ns2" ./pm_nl_ctl ann 10.0.2.2 token "$client4_token" id\
-	   $client_addr_id dev ns2eth1 port $new4_port > /dev/null 2>&1
+	   $client_addr_id dev ns2eth1 port $new4_port
 	print_test "ADD_ADDR id:${client_addr_id} 10.0.2.2 (ns2) => ns1, new port"
 	sleep 0.5
 	verify_announce_event "$server_evts" "$ANNOUNCED" "$server4_token" "10.0.2.2"\
@@ -410,7 +410,7 @@ test_announce()
 
 	# ADD_ADDR from the server to client machine reusing the subflow port
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server4_token" id\
-	   $server_addr_id dev ns1eth2 > /dev/null 2>&1
+	   $server_addr_id dev ns1eth2
 	print_test "ADD_ADDR id:${server_addr_id} 10.0.2.1 (ns1) => ns2, reuse port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client4_token" "10.0.2.1"\
@@ -419,7 +419,7 @@ test_announce()
 	# ADD_ADDR6 from the server to client machine reusing the subflow port
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl ann dead:beef:2::1 token "$server6_token" id\
-	   $server_addr_id dev ns1eth2 > /dev/null 2>&1
+	   $server_addr_id dev ns1eth2
 	print_test "ADD_ADDR6 id:${server_addr_id} dead:beef:2::1 (ns1) => ns2, reuse port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client6_token" "dead:beef:2::1"\
@@ -429,7 +429,7 @@ test_announce()
 	:>"$client_evts"
 	server_addr_id=$((server_addr_id+1))
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server4_token" id\
-	   $server_addr_id dev ns1eth2 port $new4_port > /dev/null 2>&1
+	   $server_addr_id dev ns1eth2 port $new4_port
 	print_test "ADD_ADDR id:${server_addr_id} 10.0.2.1 (ns1) => ns2, new port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client4_token" "10.0.2.1"\
@@ -490,7 +490,7 @@ test_remove()
 	# RM_ADDR from the client to server machine
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
-	   $client_addr_id > /dev/null 2>&1
+	   $client_addr_id
 	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1"
 	sleep 0.5
 	verify_remove_event "$server_evts" "$REMOVED" "$server4_token" "$client_addr_id"
@@ -499,7 +499,7 @@ test_remove()
 	:>"$server_evts"
 	client_addr_id=$(( client_addr_id - 1 ))
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
-	   $client_addr_id > /dev/null 2>&1
+	   $client_addr_id
 	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1"
 	sleep 0.5
 	verify_remove_event "$server_evts" "$REMOVED" "$server4_token" "$client_addr_id"
@@ -507,7 +507,7 @@ test_remove()
 	# RM_ADDR6 from the client to server machine
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client6_token" id\
-	   $client_addr_id > /dev/null 2>&1
+	   $client_addr_id
 	print_test "RM_ADDR6 id:${client_addr_id} ns2 => ns1"
 	sleep 0.5
 	verify_remove_event "$server_evts" "$REMOVED" "$server6_token" "$client_addr_id"
@@ -517,7 +517,7 @@ test_remove()
 
 	# RM_ADDR from the server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server4_token" id\
-	   $server_addr_id > /dev/null 2>&1
+	   $server_addr_id
 	print_test "RM_ADDR id:${server_addr_id} ns1 => ns2"
 	sleep 0.5
 	verify_remove_event "$client_evts" "$REMOVED" "$client4_token" "$server_addr_id"
@@ -526,7 +526,7 @@ test_remove()
 	:>"$client_evts"
 	server_addr_id=$(( server_addr_id - 1 ))
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server4_token" id\
-	   $server_addr_id > /dev/null 2>&1
+	   $server_addr_id
 	print_test "RM_ADDR id:${server_addr_id} ns1 => ns2"
 	sleep 0.5
 	verify_remove_event "$client_evts" "$REMOVED" "$client4_token" "$server_addr_id"
@@ -534,7 +534,7 @@ test_remove()
 	# RM_ADDR6 from the server to client machine
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server6_token" id\
-	   $server_addr_id > /dev/null 2>&1
+	   $server_addr_id
 	print_test "RM_ADDR6 id:${server_addr_id} ns1 => ns2"
 	sleep 0.5
 	verify_remove_event "$client_evts" "$REMOVED" "$client6_token" "$server_addr_id"
@@ -610,18 +610,18 @@ test_subflows()
 
 	# Attempt to add a listener at 10.0.2.2:<subflow-port>
 	ip netns exec "$ns2" ./pm_nl_ctl listen 10.0.2.2\
-	   "$client4_port" > /dev/null 2>&1 &
+	   "$client4_port" &
 	local listener_pid=$!
 
 	# ADD_ADDR from client to server machine reusing the subflow port
 	ip netns exec "$ns2" ./pm_nl_ctl ann 10.0.2.2 token "$client4_token" id\
-	   $client_addr_id > /dev/null 2>&1
+	   $client_addr_id
 	sleep 0.5
 
 	# CREATE_SUBFLOW from server to client machine
 	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl csf lip 10.0.2.1 lid 23 rip 10.0.2.2\
-	   rport "$client4_port" token "$server4_token" > /dev/null 2>&1
+	   rport "$client4_port" token "$server4_token"
 	sleep 0.5
 	verify_subflow_events $server_evts $SUB_ESTABLISHED $server4_token $AF_INET "10.0.2.1" \
 			      "10.0.2.2" "$client4_port" "23" "$client_addr_id" "ns1" "ns2"
@@ -635,31 +635,31 @@ test_subflows()
 	# DESTROY_SUBFLOW from server to client machine
 	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl dsf lip 10.0.2.1 lport "$sport" rip 10.0.2.2 rport\
-	   "$client4_port" token "$server4_token" > /dev/null 2>&1
+	   "$client4_port" token "$server4_token"
 	sleep 0.5
 	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server4_token" "$AF_INET" "10.0.2.1"\
 			      "10.0.2.2" "$client4_port" "23" "$client_addr_id" "ns1" "ns2"
 
 	# RM_ADDR from client to server machine
 	ip netns exec "$ns2" ./pm_nl_ctl rem id $client_addr_id token\
-	   "$client4_token" > /dev/null 2>&1
+	   "$client4_token"
 	sleep 0.5
 
 	# Attempt to add a listener at dead:beef:2::2:<subflow-port>
 	ip netns exec "$ns2" ./pm_nl_ctl listen dead:beef:2::2\
-	   "$client6_port" > /dev/null 2>&1 &
+	   "$client6_port" &
 	listener_pid=$!
 
 	# ADD_ADDR6 from client to server machine reusing the subflow port
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl ann dead:beef:2::2 token "$client6_token" id\
-	   $client_addr_id > /dev/null 2>&1
+	   $client_addr_id
 	sleep 0.5
 
 	# CREATE_SUBFLOW6 from server to client machine
 	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl csf lip dead:beef:2::1 lid 23 rip\
-	   dead:beef:2::2 rport "$client6_port" token "$server6_token" > /dev/null 2>&1
+	   dead:beef:2::2 rport "$client6_port" token "$server6_token"
 	sleep 0.5
 	verify_subflow_events "$server_evts" "$SUB_ESTABLISHED" "$server6_token" "$AF_INET6"\
 			      "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23"\
@@ -673,7 +673,7 @@ test_subflows()
 	# DESTROY_SUBFLOW6 from server to client machine
 	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl dsf lip dead:beef:2::1 lport "$sport" rip\
-	   dead:beef:2::2 rport "$client6_port" token "$server6_token" > /dev/null 2>&1
+	   dead:beef:2::2 rport "$client6_port" token "$server6_token"
 	sleep 0.5
 	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server6_token" "$AF_INET6"\
 			      "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23"\
@@ -681,24 +681,24 @@ test_subflows()
 
 	# RM_ADDR from client to server machine
 	ip netns exec "$ns2" ./pm_nl_ctl rem id $client_addr_id token\
-	   "$client6_token" > /dev/null 2>&1
+	   "$client6_token"
 	sleep 0.5
 
 	# Attempt to add a listener at 10.0.2.2:<new-port>
 	ip netns exec "$ns2" ./pm_nl_ctl listen 10.0.2.2\
-	   $new4_port > /dev/null 2>&1 &
+	   $new4_port &
 	listener_pid=$!
 
 	# ADD_ADDR from client to server machine using a new port
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl ann 10.0.2.2 token "$client4_token" id\
-	   $client_addr_id port $new4_port > /dev/null 2>&1
+	   $client_addr_id port $new4_port
 	sleep 0.5
 
 	# CREATE_SUBFLOW from server to client machine
 	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl csf lip 10.0.2.1 lid 23 rip 10.0.2.2 rport\
-	   $new4_port token "$server4_token" > /dev/null 2>&1
+	   $new4_port token "$server4_token"
 	sleep 0.5
 	verify_subflow_events "$server_evts" "$SUB_ESTABLISHED" "$server4_token" "$AF_INET"\
 			      "10.0.2.1" "10.0.2.2" "$new4_port" "23"\
@@ -712,32 +712,32 @@ test_subflows()
 	# DESTROY_SUBFLOW from server to client machine
 	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl dsf lip 10.0.2.1 lport "$sport" rip 10.0.2.2 rport\
-	   $new4_port token "$server4_token" > /dev/null 2>&1
+	   $new4_port token "$server4_token"
 	sleep 0.5
 	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server4_token" "$AF_INET" "10.0.2.1"\
 			      "10.0.2.2" "$new4_port" "23" "$client_addr_id" "ns1" "ns2"
 
 	# RM_ADDR from client to server machine
 	ip netns exec "$ns2" ./pm_nl_ctl rem id $client_addr_id token\
-	   "$client4_token" > /dev/null 2>&1
+	   "$client4_token"
 
 	# Capture events on the network namespace running the client
 	:>"$client_evts"
 
 	# Attempt to add a listener at 10.0.2.1:<subflow-port>
 	ip netns exec "$ns1" ./pm_nl_ctl listen 10.0.2.1\
-	   $app4_port > /dev/null 2>&1 &
+	   $app4_port &
 	listener_pid=$!
 
 	# ADD_ADDR from server to client machine reusing the subflow port
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server4_token" id\
-	   $server_addr_id > /dev/null 2>&1
+	   $server_addr_id
 	sleep 0.5
 
 	# CREATE_SUBFLOW from client to server machine
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl csf lip 10.0.2.2 lid 23 rip 10.0.2.1 rport\
-	   $app4_port token "$client4_token" > /dev/null 2>&1
+	   $app4_port token "$client4_token"
 	sleep 0.5
 	verify_subflow_events $client_evts $SUB_ESTABLISHED $client4_token $AF_INET "10.0.2.2"\
 			      "10.0.2.1" "$app4_port" "23" "$server_addr_id" "ns2" "ns1"
@@ -750,31 +750,31 @@ test_subflows()
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl dsf lip 10.0.2.2 lport "$sport" rip 10.0.2.1 rport\
-	   $app4_port token "$client4_token" > /dev/null 2>&1
+	   $app4_port token "$client4_token"
 	sleep 0.5
 	verify_subflow_events "$client_evts" "$SUB_CLOSED" "$client4_token" "$AF_INET" "10.0.2.2"\
 			      "10.0.2.1" "$app4_port" "23" "$server_addr_id" "ns2" "ns1"
 
 	# RM_ADDR from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
-	   "$server4_token" > /dev/null 2>&1
+	   "$server4_token"
 	sleep 0.5
 
 	# Attempt to add a listener at dead:beef:2::1:<subflow-port>
 	ip netns exec "$ns1" ./pm_nl_ctl listen dead:beef:2::1\
-	   $app6_port > /dev/null 2>&1 &
+	   $app6_port &
 	listener_pid=$!
 
 	# ADD_ADDR6 from server to client machine reusing the subflow port
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl ann dead:beef:2::1 token "$server6_token" id\
-	   $server_addr_id > /dev/null 2>&1
+	   $server_addr_id
 	sleep 0.5
 
 	# CREATE_SUBFLOW6 from client to server machine
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl csf lip dead:beef:2::2 lid 23 rip\
-	   dead:beef:2::1 rport $app6_port token "$client6_token" > /dev/null 2>&1
+	   dead:beef:2::1 rport $app6_port token "$client6_token"
 	sleep 0.5
 	verify_subflow_events "$client_evts" "$SUB_ESTABLISHED" "$client6_token"\
 			      "$AF_INET6" "dead:beef:2::2"\
@@ -789,31 +789,31 @@ test_subflows()
 	# DESTROY_SUBFLOW6 from client to server machine
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl dsf lip dead:beef:2::2 lport "$sport" rip\
-	   dead:beef:2::1 rport $app6_port token "$client6_token" > /dev/null 2>&1
+	   dead:beef:2::1 rport $app6_port token "$client6_token"
 	sleep 0.5
 	verify_subflow_events $client_evts $SUB_CLOSED $client6_token $AF_INET6 "dead:beef:2::2"\
 			      "dead:beef:2::1" "$app6_port" "23" "$server_addr_id" "ns2" "ns1"
 
 	# RM_ADDR6 from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
-	   "$server6_token" > /dev/null 2>&1
+	   "$server6_token"
 	sleep 0.5
 
 	# Attempt to add a listener at 10.0.2.1:<new-port>
 	ip netns exec "$ns1" ./pm_nl_ctl listen 10.0.2.1\
-	   $new4_port > /dev/null 2>&1 &
+	   $new4_port &
 	listener_pid=$!
 
 	# ADD_ADDR from server to client machine using a new port
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server4_token" id\
-	   $server_addr_id port $new4_port > /dev/null 2>&1
+	   $server_addr_id port $new4_port
 	sleep 0.5
 
 	# CREATE_SUBFLOW from client to server machine
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl csf lip 10.0.2.2 lid 23 rip 10.0.2.1 rport\
-	   $new4_port token "$client4_token" > /dev/null 2>&1
+	   $new4_port token "$client4_token"
 	sleep 0.5
 	verify_subflow_events "$client_evts" "$SUB_ESTABLISHED" "$client4_token" "$AF_INET"\
 			      "10.0.2.2" "10.0.2.1" "$new4_port" "23" "$server_addr_id" "ns2" "ns1"
@@ -826,14 +826,14 @@ test_subflows()
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl dsf lip 10.0.2.2 lport "$sport" rip 10.0.2.1 rport\
-	   $new4_port token "$client4_token" > /dev/null 2>&1
+	   $new4_port token "$client4_token"
 	sleep 0.5
 	verify_subflow_events "$client_evts" "$SUB_CLOSED" "$client4_token" "$AF_INET" "10.0.2.2"\
 			      "10.0.2.1" "$new4_port" "23" "$server_addr_id" "ns2" "ns1"
 
 	# RM_ADDR from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
-	   "$server4_token" > /dev/null 2>&1
+	   "$server4_token"
 }
 
 test_subflows_v4_v6_mix()
@@ -842,14 +842,14 @@ test_subflows_v4_v6_mix()
 
 	# Attempt to add a listener at 10.0.2.1:<subflow-port>
 	ip netns exec "$ns1" ./pm_nl_ctl listen 10.0.2.1\
-	   $app6_port > /dev/null 2>&1 &
+	   $app6_port &
 	local listener_pid=$!
 
 	# ADD_ADDR4 from server to client machine reusing the subflow port on
 	# the established v6 connection
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server6_token" id\
-	   $server_addr_id dev ns1eth2 > /dev/null 2>&1
+	   $server_addr_id dev ns1eth2
 	print_test "ADD_ADDR4 id:${server_addr_id} 10.0.2.1 (ns1) => ns2, reuse port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client6_token" "10.0.2.1"\
@@ -858,7 +858,7 @@ test_subflows_v4_v6_mix()
 	# CREATE_SUBFLOW from client to server machine
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl csf lip 10.0.2.2 lid 23 rip 10.0.2.1 rport\
-	   $app6_port token "$client6_token" > /dev/null 2>&1
+	   $app6_port token "$client6_token"
 	sleep 0.5
 	verify_subflow_events "$client_evts" "$SUB_ESTABLISHED" "$client6_token"\
 			      "$AF_INET" "10.0.2.2" "10.0.2.1" "$app6_port" "23"\
@@ -872,7 +872,7 @@ test_subflows_v4_v6_mix()
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl dsf lip 10.0.2.2 lport "$sport" rip 10.0.2.1 rport\
-	   $app6_port token "$client6_token" > /dev/null 2>&1
+	   $app6_port token "$client6_token"
 	sleep 0.5
 	verify_subflow_events "$client_evts" "$SUB_CLOSED" "$client6_token" \
 			      "$AF_INET" "10.0.2.2" "10.0.2.1" "$app6_port" "23"\
@@ -880,7 +880,7 @@ test_subflows_v4_v6_mix()
 
 	# RM_ADDR from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
-	   "$server6_token" > /dev/null 2>&1
+	   "$server6_token"
 	sleep 0.5
 }
 
@@ -965,7 +965,7 @@ test_listener()
 
 	# Attempt to add a listener at 10.0.2.2:<subflow-port>
 	ip netns exec $ns2 ./pm_nl_ctl listen 10.0.2.2\
-		$client4_port > /dev/null 2>&1 &
+		$client4_port &
 	local listener_pid=$!
 
 	sleep 0.5
@@ -973,12 +973,12 @@ test_listener()
 
 	# ADD_ADDR from client to server machine reusing the subflow port
 	ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token id\
-		$client_addr_id > /dev/null 2>&1
+		$client_addr_id
 	sleep 0.5
 
 	# CREATE_SUBFLOW from server to client machine
 	ip netns exec $ns1 ./pm_nl_ctl csf lip 10.0.2.1 lid 23 rip 10.0.2.2\
-		rport $client4_port token $server4_token > /dev/null 2>&1
+		rport $client4_port token $server4_token
 	sleep 0.5
 
 	# Delete the listener from the client ns, if one was created

-- 
2.40.1

