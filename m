Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9780E19BAE
	for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 17:18:38 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4f766777605so8267755e87.1
        for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 10:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687367916; x=1689959916;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p1oSQ4Ccu/f5EthrQQvSLS3SHaFzVjpXNFB2Is4Ne4o=;
        b=gIU/VWZq8BXsipOjp22ilw2FoKhK6ZnCIRHBXiAAh6/5KzPGnpjnHkvPntJDrv8xbO
         4bIBub1WWf+eRLu+xXCOEb5sRTx1Db5+o5Wr8h0q+IABoc39gTT0vvYiTLUpoo4or5Vv
         H/7S9QfbE68gxDWlwYDOaW3xVfUMDFv4FWn+NzHXLk/ubWBQpfGbDTFKEDsSJbPx/K8V
         Oq5IQOA/3GpFJlTjikclINMN8nfAWF5QAKFkNknrkMGgj3EyOkU/HA8ccn7Q7GLez1yc
         HjFnNRy2mEMZjq/rLOVMZj4IjIDddjyKrkNHcvtZViggAEc9HNXXB9A4d/4r2jW8FHPY
         X1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687367916; x=1689959916;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1oSQ4Ccu/f5EthrQQvSLS3SHaFzVjpXNFB2Is4Ne4o=;
        b=ZYaqMuLHId1wCQqQR6xQ6doHDGhngICrhHM3Xdgm8mrX6tPvXFhH2/fI3beYCtMy0g
         /qRBJSqfyvXh61qLFyV58belUetwVqT/AZtJAxvLItdmC+zwG6oOqHGvbA7QpT4Od7Zn
         o/IqzYtpLuk8A3MiVKEPDyqeb9yQgL0l0uM+tnSNduEWP4TGD/veoZH7nSkbti2nansx
         f36e6Nycc6TPxx5ju/hon/vwp9QKLPLXFSWTXH/rDeJJyqp9/+N3DLGehRvBWxEjWM0W
         a8yJWL528/5qbsULIJls0ZH8Lr0BD2pXaMLH26cc5KT3CPSDRljP9AKgwFQc0qJQJ+60
         cURg==
X-Gm-Message-State: AC+VfDxeZ2fAAOe9AY2QCeP6zNwBbIoyD65mIRoLXhZotGXmBNzHZHz8
	fKk2tMla2kQ/bVF/tRArgkNE5Z9F5cZ4I9SnalUv0ZU/
X-Google-Smtp-Source: ACHHUZ74TgNknnfQzxZUMqq9ASP/LKcd+XL/jtg7BX0EX7UhfMV+krWOrSnxUhZMqLI/SpsMg28fBQ==
X-Received: by 2002:a05:6512:291:b0:4f8:6e26:9347 with SMTP id j17-20020a056512029100b004f86e269347mr7260195lfp.68.1687367916115;
        Wed, 21 Jun 2023 10:18:36 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id f1-20020adfdb41000000b0030ae499da59sm4930027wrj.111.2023.06.21.10.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 10:18:35 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 21 Jun 2023 19:18:10 +0200
Subject: [PATCH mptcp-next 09/18] selftests: mptcp: userspace_pm: uniform
 results printing
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-mptcp-issue-368-selftests-subtests-v1-9-0cae453ae1fa@tessares.net>
References: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
In-Reply-To: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14088;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=BOWFEpbaKJK7L6N+YzvXRsJ8yTozFgI5zIeqYFgq4g4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkzDjTClPxO8LUXWLhvgz4iY2wrU1NNUfrGzF1
 Eigri19SyWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJMw4wAKCRD2t4JPQmmg
 c4n1D/9ygK3TwyHfFOkiGEv/p+5MsDEeblag0sDs/b+4O02+oc8qjqZjIiV7vfke5oGgwB6r4Kn
 YASpu9QzLR4am4IYDfYJuTFqobtAr9yCzkZnWfiBoy6PDD9xBI2pXdLLrQkLOSwaj4Q1pPhFmRr
 RyV6SOtBez1MFFpa/N082I14rboZhAuBTqGsau1HC/FtLRaJBwqzI1lB9dmObw22RJKN/q757KU
 P6+qqsXA819fW1WEwACi3ZHvtapZSpILq3C5be8FqpsvM7/SW58KKxKnh9lEVqcKD40Py0+Vuzh
 oS5SgsDErw5neWWOnk0WHNUzbyafqTDqpuh5KkA5hQ7XeZpyJGDOlqXELVLPLikD76ynjvpZurp
 Q2WFsk4J9FDQ/OOVbj9TGk7V0JXu8kgodq1dy5m+1SyCObCvXRLUWwvH2mQ1A/6qIKKSgCHFe3/
 Mce8KB0RHqThmhktmONevM+aS+xxIFJzOcq5jTfQzaQjrJ5Y9OIh0w1YlqyrT/ex34Y9QqcdY6p
 5nCNPdVlh/+EbB6s7XDeuvgH0kep4f7ONF3wXZZUosf/qLuMRbB77hEQApyTIKzeEKf2/1QTV0s
 /5qkC7aPzOTYXgunBad8W2tzLoX/09hlSJxQlDYEUpbzbO5kzypLu1ElXDuXQSq5AU26KTOryGb
 r0gsJ173buffrRw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

There are a few reasons to do that:

- When the tabs are not printed as 8 spaces, some results were not
  properly aligned

- Some lines printing the test name were very long due to the use of a
  lot of spaces/tabs at the end and stdbuf at the beginning.

- To reduce duplicated code, e.g. to print what has failed and set the
  status

But by centralising how the test results are printed, this also prepares
future commits to avoid more duplicated code and ease the tracking of
the different subtests.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 141 ++++++++++++----------
 1 file changed, 79 insertions(+), 62 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 63d348693e98..6b733b97d358 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -65,6 +65,38 @@ print_title()
 	stdbuf -o0 -e0 printf "INFO: %s\n" "${1}"
 }
 
+# $1: test name
+print_test()
+{
+	stdbuf -o0 -e0 printf "%-63s" "${1}"
+}
+
+print_results()
+{
+	stdbuf -o0 -e0 printf "[%s]\n" "${1}"
+}
+
+test_pass()
+{
+	print_results " OK "
+}
+
+test_skip()
+{
+	print_results "SKIP"
+}
+
+# $1: msg
+test_fail()
+{
+	print_results "FAIL"
+	ret=1
+
+	if [ -n "${1}" ]; then
+		stdbuf -o0 -e0 printf "\t%s\n" "${1}"
+	fi
+}
+
 kill_wait()
 {
 	[ $1 -eq 0 ] && return 0
@@ -127,7 +159,8 @@ ip -net "$ns2" addr add dead:beef:2::2/64 dev ns2eth1 nodad
 ip -net "$ns2" link set ns2eth1 up
 
 print_title "Init"
-stdbuf -o0 -e0 printf "Created network namespaces ns1, ns2         \t\t\t[OK]\n"
+print_test "Created network namespaces ns1, ns2"
+test_pass
 
 make_file()
 {
@@ -212,16 +245,13 @@ make_connection()
 	server_serverside=$(grep "type:1," "$server_evts" |
 			    sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q')
 
-	stdbuf -o0 -e0 printf "Established IP%s MPTCP Connection ns2 => ns1    \t\t" $is_v6
+	print_test "Established IP${is_v6} MPTCP Connection ns2 => ns1"
 	if [ "$client_token" != "" ] && [ "$server_token" != "" ] && [ "$client_serverside" = 0 ] &&
 		   [ "$server_serverside" = 1 ]
 	then
-		stdbuf -o0 -e0 printf "[OK]\n"
+		test_pass
 	else
-		stdbuf -o0 -e0 printf "[FAIL]\n"
-		stdbuf -o0 -e0 printf "\tExpected tokens (c:%s - s:%s) and server (c:%d - s:%d)\n" \
-			"${client_token}" "${server_token}" \
-			"${client_serverside}" "${server_serverside}"
+		test_fail "Expected tokens (c:${client_token} - s:${server_token}) and server (c:${client_serverside} - s:${server_serverside})"
 		exit 1
 	fi
 
@@ -255,7 +285,7 @@ check_expected_one()
 
 	if [ "${prev_ret}" = "0" ]
 	then
-		stdbuf -o0 -e0 printf "[FAIL]\n"
+		test_fail
 	fi
 
 	stdbuf -o0 -e0 printf "\tExpected value for '%s': '%s', got '%s'.\n" \
@@ -276,11 +306,11 @@ check_expected()
 
 	if [ ${rc} -eq 0 ]
 	then
-		stdbuf -o0 -e0 printf "[OK]\n"
+		test_pass
 		return 0
 	fi
 
-	ret=1
+	return 1
 }
 
 verify_announce_event()
@@ -326,13 +356,12 @@ test_announce()
 
 	local type
 	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
-	stdbuf -o0 -e0 printf "ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token    \t\t"
+	print_test "ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token"
 	if [ "$type" = "" ]
 	then
-		stdbuf -o0 -e0 printf "[OK]\n"
+		test_pass
 	else
-		stdbuf -o0 -e0 printf "[FAIL]\n\ttype defined: %s\n" "${type}"
-		ret=1
+		test_fail "type defined: ${type}"
 	fi
 
 	# ADD_ADDR from the client to server machine reusing the subflow port
@@ -340,7 +369,7 @@ test_announce()
 	ip netns exec "$ns2"\
 	   ./pm_nl_ctl ann 10.0.2.2 token "$client4_token" id $client_addr_id dev\
 	   ns2eth1 > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "ADD_ADDR id:%d 10.0.2.2 (ns2) => ns1, reuse port \t\t" $client_addr_id
+	print_test "ADD_ADDR id:${client_addr_id} 10.0.2.2 (ns2) => ns1, reuse port"
 	sleep 0.5
 	verify_announce_event $server_evts $ANNOUNCED $server4_token "10.0.2.2" $client_addr_id \
 			      "$client4_port"
@@ -349,7 +378,7 @@ test_announce()
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl ann\
 	   dead:beef:2::2 token "$client6_token" id $client_addr_id dev ns2eth1 > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "ADD_ADDR6 id:%d dead:beef:2::2 (ns2) => ns1, reuse port\t\t" $client_addr_id
+	print_test "ADD_ADDR6 id:${client_addr_id} dead:beef:2::2 (ns2) => ns1, reuse port"
 	sleep 0.5
 	verify_announce_event "$server_evts" "$ANNOUNCED" "$server6_token" "dead:beef:2::2"\
 			      "$client_addr_id" "$client6_port" "v6"
@@ -359,7 +388,7 @@ test_announce()
 	client_addr_id=$((client_addr_id+1))
 	ip netns exec "$ns2" ./pm_nl_ctl ann 10.0.2.2 token "$client4_token" id\
 	   $client_addr_id dev ns2eth1 port $new4_port > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "ADD_ADDR id:%d 10.0.2.2 (ns2) => ns1, new port \t\t\t" $client_addr_id
+	print_test "ADD_ADDR id:${client_addr_id} 10.0.2.2 (ns2) => ns1, new port"
 	sleep 0.5
 	verify_announce_event "$server_evts" "$ANNOUNCED" "$server4_token" "10.0.2.2"\
 			      "$client_addr_id" "$new4_port"
@@ -370,7 +399,7 @@ test_announce()
 	# ADD_ADDR from the server to client machine reusing the subflow port
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server4_token" id\
 	   $server_addr_id dev ns1eth2 > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "ADD_ADDR id:%d 10.0.2.1 (ns1) => ns2, reuse port \t\t" $server_addr_id
+	print_test "ADD_ADDR id:${server_addr_id} 10.0.2.1 (ns1) => ns2, reuse port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client4_token" "10.0.2.1"\
 			      "$server_addr_id" "$app4_port"
@@ -379,7 +408,7 @@ test_announce()
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl ann dead:beef:2::1 token "$server6_token" id\
 	   $server_addr_id dev ns1eth2 > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "ADD_ADDR6 id:%d dead:beef:2::1 (ns1) => ns2, reuse port\t\t" $server_addr_id
+	print_test "ADD_ADDR6 id:${server_addr_id} dead:beef:2::1 (ns1) => ns2, reuse port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client6_token" "dead:beef:2::1"\
 			      "$server_addr_id" "$app6_port" "v6"
@@ -389,7 +418,7 @@ test_announce()
 	server_addr_id=$((server_addr_id+1))
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server4_token" id\
 	   $server_addr_id dev ns1eth2 port $new4_port > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "ADD_ADDR id:%d 10.0.2.1 (ns1) => ns2, new port \t\t\t" $server_addr_id
+	print_test "ADD_ADDR id:${server_addr_id} 10.0.2.1 (ns1) => ns2, new port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client4_token" "10.0.2.1"\
 			      "$server_addr_id" "$new4_port"
@@ -423,39 +452,34 @@ test_remove()
 	local invalid_token=$(( client4_token - 1 ))
 	ip netns exec "$ns2" ./pm_nl_ctl rem token $invalid_token id\
 	   $client_addr_id > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "RM_ADDR id:%d ns2 => ns1, invalid token                    \t"\
-	       $client_addr_id
+	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1, invalid token"
 	local type
 	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
 	if [ "$type" = "" ]
 	then
-		stdbuf -o0 -e0 printf "[OK]\n"
+		test_pass
 	else
-		stdbuf -o0 -e0 printf "[FAIL]\n"
-		ret=1
+		test_fail
 	fi
 
 	# RM_ADDR using an invalid addr id should result in no action
 	local invalid_id=$(( client_addr_id + 1 ))
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
 	   $invalid_id > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "RM_ADDR id:%d ns2 => ns1, invalid id                    \t"\
-	       $invalid_id
+	print_test "RM_ADDR id:${invalid_id} ns2 => ns1, invalid id"
 	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
 	if [ "$type" = "" ]
 	then
-		stdbuf -o0 -e0 printf "[OK]\n"
+		test_pass
 	else
-		stdbuf -o0 -e0 printf "[FAIL]\n"
-		ret=1
+		test_fail
 	fi
 
 	# RM_ADDR from the client to server machine
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
 	   $client_addr_id > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "RM_ADDR id:%d ns2 => ns1                                \t"\
-	       $client_addr_id
+	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1"
 	sleep 0.5
 	verify_remove_event "$server_evts" "$REMOVED" "$server4_token" "$client_addr_id"
 
@@ -464,8 +488,7 @@ test_remove()
 	client_addr_id=$(( client_addr_id - 1 ))
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
 	   $client_addr_id > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "RM_ADDR id:%d ns2 => ns1                                \t"\
-	       $client_addr_id
+	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1"
 	sleep 0.5
 	verify_remove_event "$server_evts" "$REMOVED" "$server4_token" "$client_addr_id"
 
@@ -473,8 +496,7 @@ test_remove()
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client6_token" id\
 	   $client_addr_id > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "RM_ADDR6 id:%d ns2 => ns1                               \t"\
-	       $client_addr_id
+	print_test "RM_ADDR6 id:${client_addr_id} ns2 => ns1"
 	sleep 0.5
 	verify_remove_event "$server_evts" "$REMOVED" "$server6_token" "$client_addr_id"
 
@@ -484,8 +506,7 @@ test_remove()
 	# RM_ADDR from the server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server4_token" id\
 	   $server_addr_id > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "RM_ADDR id:%d ns1 => ns2                                \t"\
-	       $server_addr_id
+	print_test "RM_ADDR id:${server_addr_id} ns1 => ns2"
 	sleep 0.5
 	verify_remove_event "$client_evts" "$REMOVED" "$client4_token" "$server_addr_id"
 
@@ -494,7 +515,7 @@ test_remove()
 	server_addr_id=$(( server_addr_id - 1 ))
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server4_token" id\
 	   $server_addr_id > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "RM_ADDR id:%d ns1 => ns2                                \t" $server_addr_id
+	print_test "RM_ADDR id:${server_addr_id} ns1 => ns2"
 	sleep 0.5
 	verify_remove_event "$client_evts" "$REMOVED" "$client4_token" "$server_addr_id"
 
@@ -502,7 +523,7 @@ test_remove()
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server6_token" id\
 	   $server_addr_id > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "RM_ADDR6 id:%d ns1 => ns2                               \t" $server_addr_id
+	print_test "RM_ADDR6 id:${server_addr_id} ns1 => ns2"
 	sleep 0.5
 	verify_remove_event "$client_evts" "$REMOVED" "$client6_token" "$server_addr_id"
 }
@@ -529,25 +550,24 @@ verify_subflow_events()
 	local dport
 	local locid
 	local remid
+	local info
+
+	info="${e_saddr} (${e_from}) => ${e_daddr} (${e_to})"
 
 	if [ "$e_type" = "$SUB_ESTABLISHED" ]
 	then
 		if [ "$e_family" = "$AF_INET6" ]
 		then
-			stdbuf -o0 -e0 printf "CREATE_SUBFLOW6 %s (%s) => %s (%s)    "\
-			       "$e_saddr" "$e_from" "$e_daddr" "$e_to"
+			print_test "CREATE_SUBFLOW6 ${info}"
 		else
-			stdbuf -o0 -e0 printf "CREATE_SUBFLOW %s (%s) => %s (%s)         \t"\
-			       "$e_saddr" "$e_from" "$e_daddr" "$e_to"
+			print_test "CREATE_SUBFLOW ${info}"
 		fi
 	else
 		if [ "$e_family" = "$AF_INET6" ]
 		then
-			stdbuf -o0 -e0 printf "DESTROY_SUBFLOW6 %s (%s) => %s (%s)   "\
-			       "$e_saddr" "$e_from" "$e_daddr" "$e_to"
+			print_test "DESTROY_SUBFLOW6 ${info}"
 		else
-			stdbuf -o0 -e0 printf "DESTROY_SUBFLOW %s (%s) => %s (%s)         \t"\
-			       "$e_saddr" "$e_from" "$e_daddr" "$e_to"
+			print_test "DESTROY_SUBFLOW ${info}"
 		fi
 	fi
 
@@ -818,7 +838,7 @@ test_subflows_v4_v6_mix()
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server6_token" id\
 	   $server_addr_id dev ns1eth2 > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "ADD_ADDR4 id:%d 10.0.2.1 (ns1) => ns2, reuse port\t\t" $server_addr_id
+	print_test "ADD_ADDR4 id:${server_addr_id} 10.0.2.1 (ns1) => ns2, reuse port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client6_token" "10.0.2.1"\
 			      "$server_addr_id" "$app6_port"
@@ -863,25 +883,23 @@ test_prio()
 	sleep 0.5
 
 	# Check TX
-	stdbuf -o0 -e0 printf "MP_PRIO TX                                                 \t"
+	print_test "MP_PRIO TX"
 	count=$(ip netns exec "$ns2" nstat -as | grep MPTcpExtMPPrioTx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ $count != 1 ]; then
-		stdbuf -o0 -e0 printf "[FAIL]\n\tCount != 1: %d\n" "${count}"
-		ret=1
+		test_fail "Count != 1: ${count}"
 	else
-		stdbuf -o0 -e0 printf "[OK]\n"
+		test_pass
 	fi
 
 	# Check RX
-	stdbuf -o0 -e0 printf "MP_PRIO RX                                                 \t"
+	print_test "MP_PRIO RX"
 	count=$(ip netns exec "$ns1" nstat -as | grep MPTcpExtMPPrioRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ $count != 1 ]; then
-		stdbuf -o0 -e0 printf "[FAIL]\n\tCount != 1: %d\n" "${count}"
-		ret=1
+		test_fail "Count != 1: ${count}"
 	else
-		stdbuf -o0 -e0 printf "[OK]\n"
+		test_pass
 	fi
 }
 
@@ -898,11 +916,9 @@ verify_listener_events()
 	local sport
 
 	if [ $e_type = $LISTENER_CREATED ]; then
-		stdbuf -o0 -e0 printf "CREATE_LISTENER %s:%s\t\t\t\t\t"\
-			$e_saddr $e_sport
+		print_test "CREATE_LISTENER $e_saddr:$e_sport"
 	elif [ $e_type = $LISTENER_CLOSED ]; then
-		stdbuf -o0 -e0 printf "CLOSE_LISTENER %s:%s\t\t\t\t\t"\
-			$e_saddr $e_sport
+		print_test "CLOSE_LISTENER $e_saddr:$e_sport"
 	fi
 
 	type=$(grep "type:$e_type," $evt |
@@ -927,7 +943,8 @@ test_listener()
 	print_title "Listener tests"
 
 	if ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
-		stdbuf -o0 -e0 printf "LISTENER events                                            \t[SKIP] Not supported\n"
+		print_test "LISTENER events"
+		test_skip
 		return
 	fi
 

-- 
2.40.1

