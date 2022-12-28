Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884DA1103
	for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 10:18:10 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id ud5so37417433ejc.4
        for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 02:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09g6QqktahkBKWabGA7JntIoRRWNFTXK9Wy8Tqe6jNM=;
        b=wm1QC5Z3Ta1OJtYazVxRWP5yS8ve4HKo+t3KcAZLHNIbxn+jitprWGmTScZivgBd17
         o9krbxAZBOtp2KSl5yjd62E/7+KZiKU/p2qWRpuFQK2DijruhAbEJlqP/bWd3TABDeio
         YY2G0LnXm6jo+0dti1dkhlJPgLsoEZdEI942eFBNAXSf21NTzgk+fIqFg1NGCVVSiaf8
         urtsNXksJe0MPmQE2uY/MuOXMEEtNCiaF3j8XAiJ2TIQz2I6yLlLILD4oMmMYhbbEzFE
         +RlexAnjEofnVPh9h2PEs0rbpPKnMTu9MKcYrW6zmZb1shlQ6wJoYosJ/GeAUonMXYBB
         rIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09g6QqktahkBKWabGA7JntIoRRWNFTXK9Wy8Tqe6jNM=;
        b=QHrjPjexNuGv1YBDQO+Nb0rP/CES724iff/7PhWbtepRN2+bgMaoAiVRFqMivBPd/A
         eX2bpfGwVoJdft++rLNr5VJ9Ak7VSwCT1Uii3sWEZkgA40ZeWf/nsq6doMTg/HQGJrAH
         K8M1ff4nPJc6D6mhXYbT5pdyNPBEXJD+vv+MrkfYcdH+tnz1E/jUpGzpf3n+1DR09zv+
         s6mGv85KZ8eZ1gdghDGreJppoGTHU/7sF/qGWfgp0m+7qVy9TMlbYiudlF0AdWZpseBo
         fcBMSUBAMenIutez6K83Fo1lJd4KENlF/BGi5M9TXh+3A9LPxLV4K3hxxkeOTohgfkkE
         QHdg==
X-Gm-Message-State: AFqh2kolNP29udgg6OxSB5rPCxQoFZh5qAsVJ9NJjo7kSQyUgYk2/bc3
	4Qe//IEzWWfsvozCYIGVBCY43RMy04lyZwiE0F8/AA==
X-Google-Smtp-Source: AMrXdXvkpk14FMAmsig2OnV3M0+deiC0vrDPg8E9YddVzEn42xBTj8Zl2Myx87wzLDS6uQJwQOjtiw==
X-Received: by 2002:a17:907:a0d0:b0:7c1:55aa:2e84 with SMTP id hw16-20020a170907a0d000b007c155aa2e84mr19226512ejc.1.1672222688661;
        Wed, 28 Dec 2022 02:18:08 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090676ce00b007ad94422cf6sm7174127ejn.198.2022.12.28.02.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 02:18:08 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net v4 03/12] selftests: mptcp: userspace: validate v4-v6 subflows mix
Date: Wed, 28 Dec 2022 11:17:39 +0100
Message-Id: <20221228101748.2518303-4-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221228101748.2518303-1-matthieu.baerts@tessares.net>
References: <20221228101748.2518303-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2908; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=m9HnWTWgGp3tGRqYrsvJ05oHQXHp33ZFVgSd1l16S0k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjrBe+qeU9rN6zHcQ7Q7UWA7LRvHLxLx6pOBXUAjBi
 Ydw4d26JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY6wXvgAKCRD2t4JPQmmgc1xjD/
 wMaaOGVi8IUK5UZTTVbjg8hWQrH33GBpJvvt1pLwEVwf6Vip9yJcVXmVOH0uVafgt+CCL4vMj/zQeN
 XXbzsuamxYfpMhCMZqW2leEp0rhvhgujU2kT5Cq+LVKic2m/draB9cj+RPF5BQO5cVsY7kpmbBYTXO
 64J1PUGehGOtFlqOFGztvvo3nFugbHtpkkabv9LAelFUDEdyG3CgFTsbMCQ1QpJigVlbOpGuEGG3Gk
 eJMhz0bv39gln4iqq4oaMWEJgL0oI0hsk1DRaxuTK1YvRMLeX1kx39n1cokPHQx5ftNy9ejsH+hAje
 +vkh0IXKCNfgO+Jee0vX6eQiGBq51WdSr3epqDAGgTwmoQqsRDSB04S8PLhvER7FJBPPV72SAynnVD
 4AGJ3BAXVhGdmPGURNvtMlff8+WeV42UPH+YrH6tPPNO0i47UQmahVJ14y3hlZ9wJh1IC/g3L0hb06
 LZ79+wLVxv9Q+YI0AtrsUPU13SErXx5rmu6EX9Wg7ayCQRquwlEbFkfb02o0Jo86sRPL8ToiiyinoI
 JMGG95xwOP2nRa1w3+iP5RQyJBVDyhfgZ6WlMHQpzkDBz1zwfhNVNolRiEC33N8LYkFCOoAxt4Oxal
 34CBQhtw+J+c4pvA77ydrCoMivG6Wkkv+2r+eY3FGvRi2WFMYj1ol0yd+KQw==
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

