Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C263C8467
	for <mptcp@lists.linux.dev>; Thu, 12 Jan 2023 17:43:20 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id ay40so13739640wmb.2
        for <mptcp@lists.linux.dev>; Thu, 12 Jan 2023 09:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3e5PBlGJNiXnH3XwFb6/nJ5M/bSXc0/rRRFPQw8A51M=;
        b=zQXXh8ieB1e2x1HIq9SMzCtwStEEFHMtKWzpbnXpd/2CDancPQSwJjAnn3tJuNHSQz
         cw52GdKy2buAYmJ67ykJTuE9AdUYvTIvnveJRELMXxX5eUdHdmgsx68kD5caVrRd+YYm
         BN52TiyqaQ5Oa+9HkstlrEcup1mdv02RCfMv0p8zpLK+6tAd2qCYr2XkokPD3U9NDOLJ
         xOZ2U3ftJuEuKpm2zTX/est7NFdkW+ZuGc6En9WzO5l9tQ3ohmY+Mq7D5EsL/Up/Tyb1
         DAIjm7ijZQMk2DicW3ZwFCmVtp+H8WoMJuhx3tGUGd/DbgqnRLM5iEsxNXQwel/I2FLy
         G4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3e5PBlGJNiXnH3XwFb6/nJ5M/bSXc0/rRRFPQw8A51M=;
        b=d/Ryuerpjo+QZdoQ8DjtZ8bmHt55rUbX27va7UUD9r2Jm721gPlDZxlCtplZs0SBoP
         CFYAT4RNzEzjsU/A/kPY8GWxtpuc/ij1zda41yxLJXMBYZmfehQGRswD5F7kzEmI39qs
         FKjrsanck6yg7Jz15hqbB1stlvA9sZapnATv7rztprSJlJ4gQY/eBq2Z+QQMM8r5kG+r
         j0lM1uFb0s4jpsPO337a43HU/1JMNfDwW5UrYJWWTYwuwxx4M2zKlDYX1AdF6HNCQ7PE
         6UyEPQyrv1c3lUIRqIjvNkEK+J/cmqZ2UasbucDKxrT+zjI0x3F1h8jxWaPmYkwL0aOG
         dsHA==
X-Gm-Message-State: AFqh2kosDsGIJ+KKtKqf23udyVXpdWM/PfCyty1tgA8tBQ7XemG3nXwO
	Q7Io87VxWjXLHXVowIszlu1yOw==
X-Google-Smtp-Source: AMrXdXvsmad4+iB2Sb/Sj//efn71Od0my1o0QKk8x4Q6YxNY4qhjSBwlePQg5j6h89T1z1GdCI98dw==
X-Received: by 2002:a05:600c:3b87:b0:3d2:813:138a with SMTP id n7-20020a05600c3b8700b003d20813138amr59967266wms.35.1673545398942;
        Thu, 12 Jan 2023 09:43:18 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id hg9-20020a05600c538900b003cfa622a18asm26448769wmb.3.2023.01.12.09.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 09:43:18 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Thu, 12 Jan 2023 18:42:53 +0100
Subject:
 [PATCH net 3/3] selftests: mptcp: userspace: validate v4-v6 subflows mix
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20230112-upstream-net-20230112-netlink-v4-v6-v1-3-6a8363a221d2@tessares.net>
References:
 <20230112-upstream-net-20230112-netlink-v4-v6-v1-0-6a8363a221d2@tessares.net>
In-Reply-To:
 <20230112-upstream-net-20230112-netlink-v4-v6-v1-0-6a8363a221d2@tessares.net>
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Kishen Maloor <kishen.maloor@intel.com>, Florian Westphal <fw@strlen.de>,
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3020;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=wMA47rRwNHClCs5+kkPqR8S9uOx26T8C//wUolPsOEs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjwEayQrKg1fBLIH/Ag9LK+jbOuR/y6ESuubk4Qg62
 Xu6uf2qJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY8BGsgAKCRD2t4JPQmmgc1/ND/
 4v+GObwwQJ0B5N50mp9+s+fUPH6lM5J8yQ2LrA9D0KBmeCLBYcZnQgoNAMSWDLuLg9+AIYHvvlyDzy
 rPO4l+UZpFnbKYIUfKZPpXpF4pvIJAcjjl7lCJzNCerjJbmPWvEULd5a97uOxMqECScgfurVYrfPMb
 oOsBJFJO7CHwzavV3vqRc2ZpxYrKVhNCrnakBqeyCMu+zUpCImV7fcjCRHXBlvcpFNAiX2D232dgVR
 aSzBjHXWzTFX1gXjPX2altHxIPYsCRIko4EkrxUOVspn49+418BaNCjS4YRxEDH/Ye6jE5TWRouVuE
 hMo6BOZuYv4K8W9E+IuBuAHy38JFI1MKmHlD8MrAMWeH5CAwgSHUVKrNrkfd9XTpZyWG6eWFBUjd0b
 vy/P3W/nRU2UwXHNApC3fpgn6kJpNPAIuyC8zjHHs68XJt51696qiiQoZWpuBidFAZ6dTr8EPuRCT4
 y3J0Xq/9bevMAk6uBldNrFMnMWx11tKeZapRGkoEGeIDkfxz4AwkggwKLWGuRD7W523yGpvsoWDPvX
 akmNFsOwK53zOjAaQERrFf7oAo8hmyvJzb6FcCfFotBpOct7wnS1X41sXp9g94BN/63CJd4JMLlj0i
 31/aftWgNI74VaaxXTATynQPz3Yw3g9DD3s86hAnsIW4pxXEQrYhbEQigSng==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

MPTCP protocol supports having subflows in both IPv4 and IPv6. In Linux,
it is possible to have that if the MPTCP socket has been created with
AF_INET6 family without the IPV6_V6ONLY option.

Here, a new IPv4 subflow is being added to the initial IPv6 connection,
then being removed using Netlink commands.

Cc: stable@vger.kernel.org # v5.19+
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 47 +++++++++++++++++++++++
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
