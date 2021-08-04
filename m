Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365FC70
	for <mptcp@lists.linux.dev>; Wed,  4 Aug 2021 07:26:35 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id o5so2341654ejy.2
        for <mptcp@lists.linux.dev>; Wed, 04 Aug 2021 00:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wzRUX1Y6AYR1IEs92qGf3mPo2hZegN9VoPzUJuStMXo=;
        b=nL19tNy/pJ98BjbvASCCxKKi5WH4l0GqXsdvvQIp3qonpgiGMODCR6gTqYh6XwDffQ
         ICYc2DHLIlXpMuR6hIKVQs0qJcgbnbShKX7JQcDWnI+apaGesHg0Xh4D0Sq/B4G0GxGu
         F3b56KadhX2Ir/WmDw6Fqy1JnzU2C4vZ5r9iqMIULmlaF6sKLSbuVma9mc0+ciJNifH3
         8Oagw45Fl4tHE4vLWMhtFwJVqzuv5vVw/eo8XP9Pddqxup63itrneKbySdb9XeClzQJb
         zjkjCzgdVuwTeDd78wcgFc4U3gRKLDYIgqgwHuGs2x2jsVRVnnSL5sqa8MvdwDzW3dSn
         46Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wzRUX1Y6AYR1IEs92qGf3mPo2hZegN9VoPzUJuStMXo=;
        b=SlU20/kgA5OK3ou4Z7dInlXGGm0MDA/KvVmELWmVGfYt20s6nSqBoFgqZCjdLH/wkK
         szftghXoqGpC2a9lgSoFseDB1v6mXW+iig0xOxCeyp9Rq8rr0fpOMtNp2N7o42zkP2B9
         +82g7nliemc1s9K1O2/ipaRTRLSsZEQAclQe+ILnugtsbXWjtRb4LnW/fWCIcnCmZUYs
         00s7kwhJDDQfSL9qp9j1rQ1b3pM1yx1oE75ekreK85/YABVPTlVaPBWTwW7MBA7nsdpd
         4pQQDEYkOcaqWC0howHqU37Z/rRi0sMqo2f2pS6GVdv4nn8zOTdiZCfdGTDFxjfn891S
         tXmg==
X-Gm-Message-State: AOAM532I1Z52XJ6DgoSPhnxHEXWjwTlCVBZ6rHya8iZ7YbvzlWbTuqdV
	H3ZTJNxFTuAd0CEy3RiTtuoRe8aV3XrsK35iruE=
X-Google-Smtp-Source: ABdhPJw5Fh6r9+/Ch8IoMDF8bl2htBdBDU7LT6LBN24XiKui6BT7s05sGUCJeE+hrvd+pBlktIDEXg==
X-Received: by 2002:a17:906:8751:: with SMTP id hj17mr1181375ejb.511.1628061994076;
        Wed, 04 Aug 2021 00:26:34 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id o7sm393940ejy.48.2021.08.04.00.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 00:26:33 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add fullmesh testcases"
Date: Wed,  4 Aug 2021 09:25:56 +0200
Message-Id: <20210804072556.664287-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid using the >10 numbers for the fullmesh test cases and comments
around to make it a bit more clear this is a workaround, we can pass
'fullmesh_X' where 'X' is the number of addresses we want to add with
the 'fullmesh' flag.

If we detect that the parameter is starting with 'fullmesh_X', we add
the flag and set the corresponding variable to 'X'. Then we continue
like before.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    to be squashed in "selftests: mptcp: add fullmesh testcases"

 .../testing/selftests/net/mptcp/mptcp_join.sh | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index cb5f9a43baa1..57370f4ab81e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -366,14 +366,14 @@ do_transfer()
 		fi
 	fi
 
+	flags="subflow"
+	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
+		flags="${flags},fullmesh"
+		addr_nr_ns2=${addr_nr_ns2:9}
+	fi
+
 	if [ $addr_nr_ns2 -gt 0 ]; then
-		if [ $addr_nr_ns2 -gt 10 ]; then
-			let add_nr_ns2=addr_nr_ns2-10
-			flags=subflow,fullmesh
-		else
-			let add_nr_ns2=addr_nr_ns2
-			flags=subflow
-		fi
+		let add_nr_ns2=addr_nr_ns2
 		counter=3
 		sleep 1
 		while [ $add_nr_ns2 -gt 0 ]; do
@@ -1724,7 +1724,7 @@ fullmesh_tests()
 	ip netns exec $ns1 ./pm_nl_ctl limits 1 3
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	run_tests $ns1 $ns2 10.0.1.1 0 0 11 slow # 11 here meams creating 1 fullmesh subflow
+	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
 	chk_join_nr "fullmesh test 1x1" 3 3 3
 	chk_add_nr 1 1
 
@@ -1735,7 +1735,7 @@ fullmesh_tests()
 	ip netns exec $ns1 ./pm_nl_ctl limits 2 5
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 5
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	run_tests $ns1 $ns2 10.0.1.1 0 0 12 slow # 12 here meams creating 2 fullmesh subflows
+	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
 	chk_join_nr "fullmesh test 1x2" 5 5 5
 	chk_add_nr 1 1
 
@@ -1747,7 +1747,7 @@ fullmesh_tests()
 	ip netns exec $ns1 ./pm_nl_ctl limits 2 4
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 4
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	run_tests $ns1 $ns2 10.0.1.1 0 0 12 slow
+	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
 	chk_join_nr "fullmesh test 1x2, limited" 4 4 4
 	chk_add_nr 1 1
 }
-- 
2.31.1

