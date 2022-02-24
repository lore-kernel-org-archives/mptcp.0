Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13721B67
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 13:56:54 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id bg10so4537133ejb.4
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 05:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y1zyXHQk1+jEpS99rnso8rg9mp36ZSXVqs/Zs5TUKAY=;
        b=oHp2pW/NMVzsZ9tFQHcGJT8+e4fYTmeuaiZMSuP8a3hWbDweA/eMg3QiWxHqAj6hHM
         IGBlqPQO9jasDSDK/IpVEIZdTRLsK/enjE9qFvBFPCvWqauBH1yAMjEZwUYur2IeZGSF
         eMU3cMxS1AScR88YR/Bsn7DwT58W45BWYTinL7zqpMuMDfjxfb17VN1X7gb4rKHv1qSQ
         hoYU2GIbu+ZIbN8z5SYr9BA0zFsCN9tJ/sCcsGOh7Ac1O0ZzTbx4dLM+sZTmfOoAK+RG
         FYn1/IBaSl/C5hFH15SMUG5CBqqK/8GBLIOQjTaU0uhsva5l2ixeH7D74t5pTvJSa0n5
         2ZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y1zyXHQk1+jEpS99rnso8rg9mp36ZSXVqs/Zs5TUKAY=;
        b=qCiaXqvu2BnqLE6kp9CGVQSSnsKuNt2rga/JQ40muae3xiJZj2r6R1fwx1rlZGKHA/
         Ml0dFEe56wKTx0yA0CP4rPdtnvCcMGi1cocGEPJXOLaO86ol2WFSEXCEELR+M6egohkN
         R6UFOYnBTEk7/gRDmC3eymDy8DjdETFwq2E9rEhgA3Wuq8U0Ba/gtpdwq5/W2iuzlAJ3
         CbabTtuQECTy1GON0zX2vm+PrcPlPQHpLOnJ2gPmnF8MEWeOamfmaG9uocR7zv/7makH
         Sykp6ivw4w5Isk/5y7gaLAMY76icfJm4dL+LYg35r6IRd8wKIYd0j3ymdoWFQ4BN0vnu
         CA4g==
X-Gm-Message-State: AOAM532t+sWJRE9cNP366zEpeWY4oVoB3EcHKagxSHkNUsm7Hq/zB+YF
	onxm0ef8vFAt9oxjTH5TH62CeBqJpKWpPUGwGjM=
X-Google-Smtp-Source: ABdhPJzq+ivLfy4ohCWfe7KtAVnOjmKStEzuUSmk8qK6W4jHslEbV/1j343dScHmkjZeHgJPdBO3cw==
X-Received: by 2002:a17:906:e10f:b0:6d1:c535:439b with SMTP id gj15-20020a170906e10f00b006d1c535439bmr2362265ejb.637.1645711013067;
        Thu, 24 Feb 2022 05:56:53 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id 7sm1360733edw.37.2022.02.24.05.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 05:56:52 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v3 12/12] selftests: mptcp: join: helper to filter TCP
Date: Thu, 24 Feb 2022 14:56:19 +0100
Message-Id: <20220224135619.2523272-13-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224135619.2523272-1-matthieu.baerts@tessares.net>
References: <20220224135619.2523272-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is more readable and reduces duplicated commands.

This might also be useful to add v6 support and switch to nftables.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 20ec31b05990..977e5eb28ba4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -624,6 +624,15 @@ pm_nl_check_endpoint()
 	fi
 }
 
+filter_tcp_from()
+{
+	local ns="${1}"
+	local src="${2}"
+	local target="${3}"
+
+	ip netns exec "${ns}" iptables -A INPUT -s "${src}" -p tcp -j "${target}"
+}
+
 do_transfer()
 {
 	local listener_ns="$1"
@@ -1653,7 +1662,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
+		filter_tcp_from $ns1 10.0.3.2 REJECT
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 		chk_join_nr 1 1 1
 	fi
@@ -1664,7 +1673,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j DROP
+		filter_tcp_from $ns1 10.0.3.2 DROP
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 		chk_join_nr 1 1 1
 	fi
@@ -1676,7 +1685,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
+		filter_tcp_from $ns1 10.0.3.2 REJECT
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
 
 		# mpj subflow will be in TW after the reset
-- 
2.34.1

