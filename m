Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBEA63B9
	for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 18:21:44 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id b88so12748550edf.6
        for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 10:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hSujlS3nFnOPbHBlmg6jHCCFtLwoDWGFBQwBrhobyM=;
        b=mZMePtpJeQLrICjPZQkbyK0oW8p16vT1RrNP2rJuBY8uhZnXagNs5Qy3o3HqBcndvH
         OJm8C/gec0Gw4c6m4J1Z3uDjEO6w0QCWdqM8d3wvSUCALAqdVBVgNPRt7MG9sUG/WwcK
         ceUK3Hy2JOdJ2CguxjXnXHvGCL1ux5QKBk+s4fZZBcHgTHRW5J2e9vhozWVYSMS1vHTG
         bY5jvcqkqR/SAITe37QM8MJa282pMVl3nn0hpa9YbJjO/VZ2QXuKRNeRVxgMBwO2lP6k
         tT0/xCv92Yb6v0NTWU6w33FxieRqj5biSvOwbBCMjfP7pmALXRPaFb6vLBxnkx9BAsGM
         hEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hSujlS3nFnOPbHBlmg6jHCCFtLwoDWGFBQwBrhobyM=;
        b=RbVD8dRpHyPWzmcnk4ACT4ZAg5/2IUAs3De3mdUp7JarGeijVS7aoRkttcRAm3+rW9
         WhB3QG3VA9kVpb3bv6Le5s67FBjHao3eL4cvKKOjH0PnoE5mPI4osjIZ/OFqrDUdPyYq
         0tE/h0QdYlbAuABiLgHAx6rsg8NHWgrCyIgDMJVelPUxeovdbZo3elNNMH3A64U7ZgNl
         hkPvyk5VJayt7aW1lxpAzSf5YNRAEv6nr25V8UdI/SnQxwlFwY4mWm2o8K2KMBKlXBvf
         8ZWoNPFPJ9mGTA+tOk3jGEVT7C77XsEePzSN9ZhrcpL/O94Mw37NfUmCbPEPYXSeGfL/
         YssQ==
X-Gm-Message-State: AFqh2kqfG3I/b2K1UvdIIfCFocBLnDq49iu3P6xHiEEn2nhoRdHNy++9
	mKgXHgljzhOqUfGio+kOTN2HcA7bykTzVVoW7xaMLQ==
X-Google-Smtp-Source: AMrXdXsEFJCqpLDGkKLaALLvNgGX1GNYWLzobJqVjqXgazhuKC+fBwuPyenaZvrRZDZTrbZfqd9pAw==
X-Received: by 2002:a05:6402:501f:b0:461:5e1b:85b5 with SMTP id p31-20020a056402501f00b004615e1b85b5mr25550991eda.2.1672165302431;
        Tue, 27 Dec 2022 10:21:42 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o17-20020a1709062e9100b007bd9e683639sm6336612eji.130.2022.12.27.10.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 10:21:42 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v3 09/11] selftests: mptcp: userspace: print titles
Date: Tue, 27 Dec 2022 19:20:55 +0100
Message-Id: <20221227182057.2288816-10-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221227182057.2288816-1-matthieu.baerts@tessares.net>
References: <20221227182057.2288816-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2588; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=RRBhlicoV9KULZPIHN3Smnb1BSOOw5KsDm73nyunhLg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjqzd69pAicw2OjdxXoHaBF5Hmb6JBXg98D+zBAm9v
 kUluJ1uJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY6s3egAKCRD2t4JPQmmgc7aIEA
 DCse5YBxnFMQPF2FNpizrxahpzlW260/CeVpSbnnQJ6BxnGrDmaIw+kpuTIqLkjgwFjm7U2ktKg8uU
 niyr4hVJ1Ht54LdaHHkALvJAff/FhMCEsCUPtNTe9V50DX4n89GSBU+9Xm9uxucrHrbyasYq1nE/WE
 fYHbZw5dm2iAomN/j29vt/jC7BU3jL2oju6ZL0hAE249fNCCESpy4Nn+Sf/9idjORN5XdvcgKqxQOv
 RLLJ/mV35Q+Ag7PgR5vC/9M+4FTS/BO/Yw8cs9L+Ou3RbfIQEjHOKF1ElKao2/xLO2U8Svi6Flvn6c
 Kl6Jqn3dY9fNoPWae3lIiN9KBmCBS7XXG4sq9D4gHo8ep/jRwC9q5A+NDEBi4GiaH8Cj5qr6+IT0Ye
 60iUgF9Pg4FIjqbXXsalQs8wBJxPJbeUDRFq2hSvFLzgvFdb0AnMgc+cwRbAakBzTIXI5BAuvQAr8B
 PvcBHTf+gAxIWCqk5w0xXiSKuXy5c/bSTso/G79uofBsGT3+rH7bv33jexuhUoi98CAS/pZqDtCF4B
 JV4sBC43V6IX4CtAe5slijwqndR2Bln+Qogchj/7IOq0MZuV46Gi1Gb3nm8K5EJz6rbb8je7hZiSKt
 SB9OkBMqroJhTVJt+hSBfcfBfd++RwkY6OGsHcvs/Ki7aI8pEnzMXGvOkVbg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

This script is running a few tests after having setup the environment.

Printing titles helps understand what is being tested.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../selftests/net/mptcp/userspace_pm.sh       | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index ab2d581f28a1..d2d7452d0d73 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -43,6 +43,11 @@ rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
 
+print_title()
+{
+	stdbuf -o0 -e0 printf "\t%s:\n" "${1}"
+}
+
 kill_wait()
 {
 	kill $1 > /dev/null 2>&1
@@ -108,6 +113,7 @@ ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
 ip -net "$ns2" addr add dead:beef:2::2/64 dev ns2eth1 nodad
 ip -net "$ns2" link set ns2eth1 up
 
+print_title "Init"
 stdbuf -o0 -e0 printf "Created network namespaces ns1, ns2         \t\t\t[OK]\n"
 
 make_file()
@@ -255,6 +261,8 @@ verify_announce_event()
 
 test_announce()
 {
+	print_title "Announce tests"
+
 	# Capture events on the network namespace running the server
 	:>"$server_evts"
 
@@ -359,6 +367,8 @@ verify_remove_event()
 
 test_remove()
 {
+	print_title "Remove tests"
+
 	# Capture events on the network namespace running the server
 	:>"$server_evts"
 
@@ -521,6 +531,8 @@ verify_subflow_events()
 
 test_subflows()
 {
+	print_title "Subflows v4 or v6 only tests"
+
 	# Capture events on the network namespace running the server
 	:>"$server_evts"
 
@@ -754,6 +766,8 @@ test_subflows()
 
 test_subflows_v4_v6_mix()
 {
+	print_title "Subflows v4 and v6 mix tests"
+
 	# Attempt to add a listener at 10.0.2.1:<subflow-port>
 	ip netns exec "$ns1" ./pm_nl_ctl listen 10.0.2.1\
 	   $app6_port > /dev/null 2>&1 &
@@ -800,6 +814,8 @@ test_subflows_v4_v6_mix()
 
 test_prio()
 {
+	print_title "Prio tests"
+
 	local count
 
 	# Send MP_PRIO signal from client to server machine
@@ -876,6 +892,8 @@ verify_listener_events()
 
 test_listener()
 {
+	print_title "Listener tests"
+
 	# Capture events on the network namespace running the client
 	:>$client_evts
 
@@ -902,8 +920,10 @@ test_listener()
 	verify_listener_events $client_evts $LISTENER_CLOSED $AF_INET 10.0.2.2 $client4_port
 }
 
+print_title "Make connections"
 make_connection
 make_connection "v6"
+
 test_announce
 test_remove
 test_subflows
-- 
2.37.2

