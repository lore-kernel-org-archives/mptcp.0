Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0763F1109
	for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 10:18:14 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id jo4so37408256ejb.7
        for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 02:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXCSBF6liyCYU8H57JsfKDAkklMDGoDA3nQJzOmYetk=;
        b=1DJ6c33B6bVWmM5bQ0ZbEekHBDN1WeWrjv9dnDg6hasRg131RdrCtzSQGgaab9kc6x
         abtpz172kaMGXrEDr6Rj331X9M5MGuiHCO/clailKCNMNvoX9grcvjLNnoZjlnSKX2oL
         sKxUwQhfZfP1F8TPANuRk4fY4seyI2VCcxHLeLEbw0pNl+Y1WVdchVgAmA7Utct8shRf
         rchxLxRQvlyT0NsmiJXJX54QZ7CExNR4g74C3OjiVDddl6tfeZyPLg0O+nb/oFU15JTr
         OccYjP3KdJA6++IaCXbsy88D1iK0zNeAe/5zNoAFPN+4+XMCkWcOm2gUXWJGejULL94I
         BHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXCSBF6liyCYU8H57JsfKDAkklMDGoDA3nQJzOmYetk=;
        b=vqxjy5BxzLF5vJji69mJ0jC7d1S0vROObIFnjBkS7eMhpP3lhbxESS5vt6MgzS9oT0
         cUOOJ0RmAS11qDZq9uO0mY+zw1Afu98vBBjX/xps9zRyOTR/+iuyn98wJ/rJZJRzuvDh
         MMLyBIQqQ2brEHH7UCV2D69YrxVnV5KZ4kiCbhJgFw62NlYQXBwGI14IMn8eEUBdGdi2
         L2tEAeVSc1KSYph+FJJMXg6zbOW3rnDlCpApk8l9KojTLlehZ6/MLqBht1tsY4P8XIv5
         VyOt9CqaQBlLk2Cw8flGN3hcblCFFcX6v3W1LDLpdUSfEBD/7THwWbgOI4a5c6ZCuNXU
         frbw==
X-Gm-Message-State: AFqh2krs0zq06ylW9Tnxv/IH57SRHZLT4ev2JnnVQfk4bmntnnM8mErQ
	agj7B8NN9GKri0inxnegEiOziUFN09LOUHRbWI8t4g==
X-Google-Smtp-Source: AMrXdXvLDOskVgusmlfvrKL5yqrk7//PLgeXq7cXc5cioP2LgK40OlfIV7IGSFMFiVYmAQFWR/FSPA==
X-Received: by 2002:a17:906:c0ce:b0:7ad:d7a4:4346 with SMTP id bn14-20020a170906c0ce00b007add7a44346mr26914020ejb.66.1672222693254;
        Wed, 28 Dec 2022 02:18:13 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090676ce00b007ad94422cf6sm7174127ejn.198.2022.12.28.02.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 02:18:12 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v4 09/12] selftests: mptcp: userspace: print titles
Date: Wed, 28 Dec 2022 11:17:45 +0100
Message-Id: <20221228101748.2518303-10-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221228101748.2518303-1-matthieu.baerts@tessares.net>
References: <20221228101748.2518303-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2989; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=H+9EHc7FP/MHeHEjjNd26f57XIP8B+ErItLbmQVHXng=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjrBe/RLHwMAfsnmaWyMo8L7biigvp7cf2bLozce9Z
 z6d0+xKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY6wXvwAKCRD2t4JPQmmgc/mhEA
 DADmela/xzOtVPdY99YHRWq3yWw70W1U3EoETwbVgHYIkxehgQ8amQ8PqPnvxR6lrzKKKMrRiBdulU
 2FHIJ209/D0+yuqee1MNTpNxNcqIwCnsq77HTUrlzZoiblZL6zFF4kSCk4nbvxGHTmIJLI4F2kltva
 UVZkwypoaflV49oQHa2j3iDF49QBTvDLAieQZht+vzJybVx9UhprkFfEY2ld4WxKLOjwiZX5e1PaBO
 w+wFpFLWzYLLzFqtjtbfjFh7Chxe/Hlph9c93S7Ij40ocZBkMpLrdo8W7U+dul8GNEQE/q/JI0jEH1
 ZacX8+RlxzGB6t+lGDGNiVRm67BE/w/umUcqFMFRSGx4iZaYfotC45R3R+Aq7HUoW8D3IUz4VepfKX
 0oBmzloFE7akCSSqD/boZ0q7GRCeDKPmXOsrO+g3hH6IpOBZfptHk/qW5EWRjbrbcYBQvdGB83PVPp
 iFLCKZXjdEqBBpCVYx3w8fC2fFUPbPxDV5hqMNLJ8AScD3WlAO17dfAvKsoOs4EhJ0qirUUET9e1he
 Vec19VOUwixFlfIHUjq4lSu5mo8ymsw5n/N9BDneH2GLuhxmd0LshyfO+X7RMFN+k08ZAm32I7iqYM
 xrpMLi4wSvSMQkicQrXD4vCT0EvV+jkaIRDzvGL65UAAI9vH3EUUhti9LqOA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

This script is running a few tests after having setup the environment.

Printing titles helps understand what is being tested.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    v3->v4:
      - Add a title for the Cleanup (+ 'Done' at the end)

 .../selftests/net/mptcp/userspace_pm.sh       | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index ab2d581f28a1..f9a03e6e968f 100755
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
@@ -51,7 +56,7 @@ kill_wait()
 
 cleanup()
 {
-	echo "cleanup"
+	print_title "Cleanup"
 
 	rm -rf $file $client_evts $server_evts
 
@@ -78,6 +83,8 @@ cleanup()
 	for netns in "$ns1" "$ns2" ;do
 		ip netns del "$netns"
 	done
+
+	stdbuf -o0 -e0 printf "Done\n"
 }
 
 trap cleanup EXIT
@@ -108,6 +115,7 @@ ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
 ip -net "$ns2" addr add dead:beef:2::2/64 dev ns2eth1 nodad
 ip -net "$ns2" link set ns2eth1 up
 
+print_title "Init"
 stdbuf -o0 -e0 printf "Created network namespaces ns1, ns2         \t\t\t[OK]\n"
 
 make_file()
@@ -255,6 +263,8 @@ verify_announce_event()
 
 test_announce()
 {
+	print_title "Announce tests"
+
 	# Capture events on the network namespace running the server
 	:>"$server_evts"
 
@@ -359,6 +369,8 @@ verify_remove_event()
 
 test_remove()
 {
+	print_title "Remove tests"
+
 	# Capture events on the network namespace running the server
 	:>"$server_evts"
 
@@ -521,6 +533,8 @@ verify_subflow_events()
 
 test_subflows()
 {
+	print_title "Subflows v4 or v6 only tests"
+
 	# Capture events on the network namespace running the server
 	:>"$server_evts"
 
@@ -754,6 +768,8 @@ test_subflows()
 
 test_subflows_v4_v6_mix()
 {
+	print_title "Subflows v4 and v6 mix tests"
+
 	# Attempt to add a listener at 10.0.2.1:<subflow-port>
 	ip netns exec "$ns1" ./pm_nl_ctl listen 10.0.2.1\
 	   $app6_port > /dev/null 2>&1 &
@@ -800,6 +816,8 @@ test_subflows_v4_v6_mix()
 
 test_prio()
 {
+	print_title "Prio tests"
+
 	local count
 
 	# Send MP_PRIO signal from client to server machine
@@ -876,6 +894,8 @@ verify_listener_events()
 
 test_listener()
 {
+	print_title "Listener tests"
+
 	# Capture events on the network namespace running the client
 	:>$client_evts
 
@@ -902,8 +922,10 @@ test_listener()
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

