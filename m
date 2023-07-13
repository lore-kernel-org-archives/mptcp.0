Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39BC1F191
	for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 19:08:26 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3fbc656873eso10578625e9.1
        for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 12:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689275305; x=1691867305;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JWpdgqtFcguEOJ7JLAgihFTkDv6ED+BcGhrDZsfYBs=;
        b=8odobowMtZt9WkAKL843WT9sOh5bZ9ITFjmWBRZmzEmVHuauEbLZpY3rd0kzcrSc36
         jrX6/VFyT/T1l3QQZGHqUMJbhzrW5wyWsPlP7Rk1ThsBh9rZ9nuNeM9gcbUtidHp4lki
         3RIltZl5p3UqJqBEl5msssSnS4XUFq1+XiXWeI+IpzB+hb8TimE8GXzK2pkqCmegaLrR
         SOr2ogjB6jIFvzfodiDZsRV/IURtJx/6nsUgy+ANz9ovQb6a4d2mg/+YmxhFU/YHXqb6
         QOXlP9rzxQh/8JsRUOS2UMpvqtRI27F45zuDotTTpvl9K2mGs7Qt/admop39pHeGQZV6
         R7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689275305; x=1691867305;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JWpdgqtFcguEOJ7JLAgihFTkDv6ED+BcGhrDZsfYBs=;
        b=k/yGPn4mnQK0C00sWzheQ6Bj+VPFeGVUCG7OWmrW2vWv0Gli3pk0UrqtRRBurn5/qb
         ihg2MT0+t0B2rtj9wSGeM+DNcX8/CLewqng3u+BtsvCcfaoODfTWJoTxBhYu8fskUaWQ
         +VVDN9ngJ/oKB5CxxNVoF+4kdJ84VSruSH8f1Ho1E2qb/q+xiSN1ECLuow0GOUvWoI5j
         8BOzelhwHszvMjEVerp4O0Nhn+yT4TG9e3fuFynG3IPWt0II4BdmWXFujHbPfZ/Oa/U1
         JxHEXfRwXfvVKF22e5HoEIS2oYAF6Tr01Dpy02mhbGRzdUmYSb06lUOIThZH6FPFJgJ/
         s67w==
X-Gm-Message-State: ABy/qLaVljeJZGc2SYcGi/3dpYZHvqKfq/RuyY4oNGOng2LMt0agvUIb
	4fV+qFSBkk53UI3qvbHMGhetwywrqeERi0wr2A24fyoX
X-Google-Smtp-Source: APBJJlEFIjRSFNGYa/du8brAZo0k10QmoTCExCwB50k2EfRimdRZzTb8dyP1tCsUfKJuFrJxfZjAHg==
X-Received: by 2002:a05:600c:ad4:b0:3f9:b748:ff37 with SMTP id c20-20020a05600c0ad400b003f9b748ff37mr2698908wmr.20.1689275304743;
        Thu, 13 Jul 2023 12:08:24 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id p11-20020a1c740b000000b003fbe36a4ce6sm18988530wmc.10.2023.07.13.12.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 12:08:24 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Thu, 13 Jul 2023 21:08:15 +0200
Subject: [PATCH mptcp-next v2 2/2] selftests: mptcp: userspace_pm: unmute
 unexpected errors
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-mptcp-issue-368-pm_nl_ctl_ack-v2-2-eb9582b8e24b@tessares.net>
References: <20230713-mptcp-issue-368-pm_nl_ctl_ack-v2-0-eb9582b8e24b@tessares.net>
In-Reply-To: <20230713-mptcp-issue-368-pm_nl_ctl_ack-v2-0-eb9582b8e24b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=17981;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=f1ktJ6IcdjCP7uq5qkFZeBHM2fQoSo4uHK6z2W4JbHk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBksEumZVPCi37pS1w2vIN0tf7ieu+UdnLOdvGR8
 PHB0204GnaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLBLpgAKCRD2t4JPQmmg
 c5tHD/4gF9wD1vgbXawlIMbPEe+LdMq4VQGbZqzCUlbVlesvS62Qopril/Qw9shA6a68AV8rwBA
 64FSuU06VGUjrSGBAhsb9N0qmeeOXqt2BEIKs99p0N62q/F/IxrYcSpxrT3KVliVOgif/lyz46r
 WToR1MDUoFlj4vsXSiaLe+Pvr1njb+xIm2WieMKwu9aegY9hOyuh1Z5AXShL7L3oeBCr6nkJgng
 7+5tUQlVcjJEv4cx0X+dn+jZLwuliY1CnN3yho6dWDhHJmu417anKXku5HzN+XgVlT63iDvKLE3
 At+LWUrT/gIRg32LlFmL6vHybyNiTOhM49w/hZWPeRYpbbpSZEiLDibuUdool7UZ1f1wgSlQY8q
 Bptvoe6pl7Ttuowaw+ENZ6KuIuvtr8biMptoGSYoqfAxcHBEI8VA9zmgCMRNULN9xkORXofW3GI
 Y72mx8o3trUk0Jtzssvxv6U2285kPQkryXI8HmyRiEZANXjkKI27sZB/GBnQM5y8UVif+j+ovsU
 Y/HHPC/AENsNcU0z3xT3LsQkGMunfNTrHCoeygiCumW/fImNVcgn9ACeAoXAq9IiOAK+jaWFuXp
 Zb40fA/qYXToCJBgBW5WgV1N5wzXHo95LQ+mqEQDO1jFjehotQGbe0jvseA3aWpiIiSXriUO8Ik
 egE2+TjHpFnRcYw==
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

