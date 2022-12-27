Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B3463B9
	for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 18:21:39 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id ud5so33611528ejc.4
        for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 10:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09g6QqktahkBKWabGA7JntIoRRWNFTXK9Wy8Tqe6jNM=;
        b=5B9UCo3fhdE/4irlDkmaEvp/68bDrn9n++36iZn7XMrci/cUOkoIk90U2093vjpfsu
         CN/mDx5CaRDaR1uszsVbENt771H53wqYVGmg3DhGxqleOKe4wC0nzhqseYVnPbuhTc5R
         D/vaSPHaM9MH3F4dgWull6vfafPyUhbnBiUzBF3JMhftc0TElC19vSYy5+DtKQgKA+nc
         vO+CPC18eOn3ADxqXmm3PW3+CDysVdw5p/Uxkah9iL8yPiV6Beu7SAQdkBeQ/f/ON6CR
         ip672df16pdQhs4kDrHiBQCalDb1mNwR3fMbjTxio0G/N6vriSPvNOUG4QtrEx2OD8KC
         mZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09g6QqktahkBKWabGA7JntIoRRWNFTXK9Wy8Tqe6jNM=;
        b=edMN8ts54g/l/uIC2AZQ72MpHNvopX9kxXg1tCiV8552rdpCa/+O/TYC+UqTrungBc
         zqDS9mynTtxyG2zMLoLJ4FzXHu7ffhuAjVNx5uNxOt2V0jLqwU1q7e0neAX/39G26hh9
         erGSIWgSC/bcUHioaGpa1iQwEEMs9M/yBY/c/jXo8THankkWzwGDOHEwDqPclc/zUiXe
         9y8nJJb7Ba3tw2Cccabe5DlkjvdfBLqtqRIEVAcxXkiQEAjKG6DzHUD46nl5LkBC6O7X
         Vu/8xr/6X3cXqX/OUVkGL4cogglGsAaaJWHc5NYUX23JRfVYRi1g1BoCDZD5YNXbD249
         7j5w==
X-Gm-Message-State: AFqh2kqdS4HkeasmDqBv+cxduE5Wn9ciKBAdVigRpExkuBtT2Rea58vP
	lGLBznoE29J7bIoNxNfwswlKfGnrzgf8b0qvpqR61g==
X-Google-Smtp-Source: AMrXdXtaCrGUVwILvPUbUNfQBjrlazgfhSw1P2dAjD7U16wRFSzcyjPwBBrfD/gIBMzZIKIf0Cc1IA==
X-Received: by 2002:a17:907:6f09:b0:7c0:a877:1cf1 with SMTP id sy9-20020a1709076f0900b007c0a8771cf1mr23114274ejc.12.1672165297544;
        Tue, 27 Dec 2022 10:21:37 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o17-20020a1709062e9100b007bd9e683639sm6336612eji.130.2022.12.27.10.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 10:21:37 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net v3 03/11] selftests: mptcp: userspace: validate v4-v6 subflows mix
Date: Tue, 27 Dec 2022 19:20:49 +0100
Message-Id: <20221227182057.2288816-4-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221227182057.2288816-1-matthieu.baerts@tessares.net>
References: <20221227182057.2288816-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2908; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=m9HnWTWgGp3tGRqYrsvJ05oHQXHp33ZFVgSd1l16S0k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjqzd5qeU9rN6zHcQ7Q7UWA7LRvHLxLx6pOBXUAjBi
 Ydw4d26JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY6s3eQAKCRD2t4JPQmmgc+3DEA
 Coo4wZTStfHm0HnLx3rPiwBtQwFBGv3RQZ1GcHKy7Py54iMh5fW/7jd0h5SOGEFgpgVp/1RniK1g9S
 AyaxHzroHyzMv2vvj+6I2yOQuDO0+Jk/XbYnRWAgVHfL4DEabVJEbLx2AvrnRiUbT+A6HMYJER4goG
 vM+dhFDLASdqbo34l2VL16olv2o7ydn5LYnvNLF1xH0mSD6lI+xkyNCyCL4o6nxPLUFgpkSwCOgBhY
 F/J+y5/W7VpIK3hP20v5T1c09sUI82/6LaIc2K0v9qT6kDcZC9cXIeL4SE6nwcW//xIjxKDUqx0bR7
 Jh1nv0Mc7uLImchXJ1EYLwBVay/Pdgx0UEoaaB4vau4omPbgLdMUztlPuMgF7N0ua+NXVEhbB59YpK
 lzvCEPzpwfNSdL9W1xmFcw+ZGj8q7gMOR/0VtDINhHlX1la0w1s0fnhYL2lE35tgtJiKjVZVRYD9xH
 hYTpUDd70nnCmDNv+e1V9hxmkc7tv2FSDXnFyvyvfM29sMyuy9idnTQSyFYTO44TwcDJ6Hxf79m5B8
 O4DBGSxk8cHnuw+g+mLxV4tpXiHye3f8Yr5U+k/6gsr18tyObBU+fW3zFC37stLvhb1qmwzwsil+T8
 AADrw6+FpTK6NM8koPPNiMss1qQBlCjm44L929YC3K0YT3rw9MyiBYnZuPMQ==
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

