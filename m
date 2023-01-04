Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BDDAD54
	for <mptcp@lists.linux.dev>; Wed,  4 Jan 2023 17:15:58 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id u28so44681793edd.10
        for <mptcp@lists.linux.dev>; Wed, 04 Jan 2023 09:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09g6QqktahkBKWabGA7JntIoRRWNFTXK9Wy8Tqe6jNM=;
        b=e9Aku4X2C45KxqXED80ZhQ0TJgPz/k4KgSNj1Wgy4TsG0EIHKVm0bjrFn/Hx0CpP6v
         ivvfmln8mOmob2tpBaezTj+LaOxo40EPR0y2x4yB2yNjd+9RPhJpqxZNkacOQdcvjDBL
         7q7CIObhPJJJjMs8y841S/tdPrFPFwlAFOH3jqnnWpbKnQ0S9w/Do0BRsNiGe/k7JK4Y
         E3YT05kBMqbUjsfSNUVSRpM54XlzBnq4XsTs6HD9Gba4H2ECWHvWbyfflEoaiJ+WkIQS
         STLdHs/u7Bc0KWj3wcm9+Fm2MXIEVdP7bbak18gP+Ik8jv2sYDKBbqAfov8km5YkIcwJ
         mhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09g6QqktahkBKWabGA7JntIoRRWNFTXK9Wy8Tqe6jNM=;
        b=16cWg6pVqzj8Kil62060iHzzmXQYXHujP1z716DZwgeaujUw1KwJjS77kNoTAUOoOY
         dmxe38yJBXeLMLlepdSf57DGRrj3/Rz7FzIMncjBavknlS/i4gkqxzr8mj9IMMP4+Xgs
         cUe4empY++qj4lvL/KzFCvVxaMqtlsunIhshMgLgJjxS5mzf6uxsIZz5g6a6HjRvNEFb
         rwzDkqxEHytQ9ced3sxmA4YdWfB7tKFSv7YjLZ6EanjCMVRAPq/9cz4n7bD7G11jSPkw
         S6+GA5sYvRvX75Zbp6FKFSMAU2/gzy6tloBD5TmVwvD8QhPsP44tDsC8JNcu1l77wHcc
         dXWg==
X-Gm-Message-State: AFqh2kpIv7J7WPstcBJ4rV5keKcvhvEYI4J8h1V9L5cywIMnB5PM8/nn
	sjVf9lm4AnkeVw/fNJf1nR+luMvaiMoK4vrkLZs=
X-Google-Smtp-Source: AMrXdXvy/AtbbpD/kntx1ScODPb/jpH/SnqeTn/r+3D3yua+ZTwG0uEzW5IQGdwqDPMVtwmfHLe9Wg==
X-Received: by 2002:a05:6402:2074:b0:48e:a97e:9f2d with SMTP id bd20-20020a056402207400b0048ea97e9f2dmr6798930edb.11.1672852556099;
        Wed, 04 Jan 2023 09:15:56 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m11-20020a50cc0b000000b00487fc51c532sm9258074edi.33.2023.01.04.09.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 09:15:55 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net v5 03/12] selftests: mptcp: userspace: validate v4-v6 subflows mix
Date: Wed,  4 Jan 2023 18:15:17 +0100
Message-Id: <20230104171526.1416746-4-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
References: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2908; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=m9HnWTWgGp3tGRqYrsvJ05oHQXHp33ZFVgSd1l16S0k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjtbQHqeU9rN6zHcQ7Q7UWA7LRvHLxLx6pOBXUAjBi
 Ydw4d26JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY7W0BwAKCRD2t4JPQmmgc0fbD/
 4svjgAAWucfpDsJ7qNSksjtt2BMi44eNMsVPjlHnTp07tTSRbJN4oJ9g6wrZ5CanmUsMxJVVFkRVeX
 fy2RcQ3fkc1uAPYntTKApy0lkHOY8hn87wZe+X8XG0Qim6qHuqay18Fip43A394I0WG75UDJ82ioA2
 jZIHzP6sYVxnpe5CI62ZRVJq5Mn/PGm/bXAEtzZeMMmr8hBccUxa8IdnnOCaMu6rQ6z01utTI9rV53
 crnn8/V34aIZr1JWB/LSSDAsevHyjy6Vx6thSt58d9q7DZUDPIpMwkMfSRob4m1BZxm3J22EBOkacc
 EGPPDq/DTIt6abzBP7Pi95oMqVxhmuhnrlIWal3YvNkTeWp1mEqzD+ADGV/zthC6jW/2zN1XliNP+x
 xA1y4imhpLyIqIROKo0nrBggBzjexSNxFYcJbdHKHWXHBGY6aX27rZGPhV59oW0Nhy/F/v9rgt2hEu
 7qJpkc91ZFKEj2NWyyEDCmXkGyKbFp2UKnKUKyFqpMuN+EZELso1e5CMRGF5kE7IkkypU2nEb/l8Ry
 626T8V6J3g6dovHDByiICwcbEhf8a/7ZaOIV17V/ZWEEEr62Hs8LeZao4G0AoPIWKvGVvL5TehecJy
 Kl4Ae4176GDoBkDPP00qbGT2fIeeWhhGO2h+iQ3DB+ZkcmSuDOR56VnItRLg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

MPTCP protocol supports having subflows in both IPv4 and IPv6. In Linux,
it is possible to have that if the MPTCP socket has been created with
AF_INET6 family without the IPV6_V6ONLY option.

Here, a new IPv4 subflow is being added to the initial IPv6 connection,
then being removed using Netlink commands.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../selftests/net/mptcp/userspace_pm.sh       | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index a29deb9fa024..ab2d581f28a1 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -752,6 +752,52 @@ test_subflows()
 	   "$server4_token" > /dev/null 2>&1
 }
 
+test_subflows_v4_v6_mix()
+{
+	# Attempt to add a listener at 10.0.2.1:<subflow-port>
+	ip netns exec "$ns1" ./pm_nl_ctl listen 10.0.2.1\
+	   $app6_port > /dev/null 2>&1 &
+	local listener_pid=$!
+
+	# ADD_ADDR4 from server to client machine reusing the subflow port on
+	# the established v6 connection
+	:>"$client_evts"
+	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server6_token" id\
+	   $server_addr_id dev ns1eth2 > /dev/null 2>&1
+	stdbuf -o0 -e0 printf "ADD_ADDR4 id:%d 10.0.2.1 (ns1) => ns2, reuse port\t\t" $server_addr_id
+	sleep 0.5
+	verify_announce_event "$client_evts" "$ANNOUNCED" "$client6_token" "10.0.2.1"\
+			      "$server_addr_id" "$app6_port"
+
+	# CREATE_SUBFLOW from client to server machine
+	:>"$client_evts"
+	ip netns exec "$ns2" ./pm_nl_ctl csf lip 10.0.2.2 lid 23 rip 10.0.2.1 rport\
+	   $app6_port token "$client6_token" > /dev/null 2>&1
+	sleep 0.5
+	verify_subflow_events "$client_evts" "$SUB_ESTABLISHED" "$client6_token"\
+			      "$AF_INET" "10.0.2.2" "10.0.2.1" "$app6_port" "23"\
+			      "$server_addr_id" "ns2" "ns1"
+
+	# Delete the listener from the server ns, if one was created
+	kill_wait $listener_pid
+
+	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
+
+	# DESTROY_SUBFLOW from client to server machine
+	:>"$client_evts"
+	ip netns exec "$ns2" ./pm_nl_ctl dsf lip 10.0.2.2 lport "$sport" rip 10.0.2.1 rport\
+	   $app6_port token "$client6_token" > /dev/null 2>&1
+	sleep 0.5
+	verify_subflow_events "$client_evts" "$SUB_CLOSED" "$client6_token" \
+			      "$AF_INET" "10.0.2.2" "10.0.2.1" "$app6_port" "23"\
+			      "$server_addr_id" "ns2" "ns1"
+
+	# RM_ADDR from server to client machine
+	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
+	   "$server6_token" > /dev/null 2>&1
+	sleep 0.5
+}
+
 test_prio()
 {
 	local count
@@ -861,6 +907,7 @@ make_connection "v6"
 test_announce
 test_remove
 test_subflows
+test_subflows_v4_v6_mix
 test_prio
 test_listener
 
-- 
2.37.2

