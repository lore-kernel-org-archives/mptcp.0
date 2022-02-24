Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A6D1373
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 21:35:05 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id g20so4726304edw.6
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 13:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j+R+ymD23qsxjKFAuKBBrGlPBm/WI7osxpNx6Vr9Wdo=;
        b=ikvjkV2poEBngeX+xjxVnmsS7bBH4EUdNI86QFqro3XPdWHSMM/EZrDeGhT7tNcvAd
         sIgvr6dPEe78ohgLTIQQJ3hLlJAPOfcANhQvw8L3InDbqIFdyJPdkywlzrCY58STR2pa
         jO3okIoI7VYKF8V2uzn/5uC4GVjdf+Kkd8AXUj13RGkfjvlKrfS8dMngQ37SPmUMg/NI
         rx6nP+QSsNAENVh496oQvs+wTIS1EymQ0gOVam/51KpYsRtdo/645nJ53AxMyZiBmD8y
         4tJC9H04L6hgZRsYUCoK2n+X1Slhpe5vrxcTe4q9xWTGL8Y2/vsWIb6lfo+z7yQGA/QG
         ptEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j+R+ymD23qsxjKFAuKBBrGlPBm/WI7osxpNx6Vr9Wdo=;
        b=uRw3alL+q6SuFvzg/Kb53b3Uo4XkViSKjAvBj9coIoBW+/hTmw4P0dc9CzBuHt1Jww
         ghjgOWgUt2f68xfq68A7OMfzXAsZ2RTne5nTyJ4JMR6O8tkANk0AhhId3rFsvJzJ7rqn
         BovwCcmu2z6uqa9thzdyajLftmZmlQ6VVT0eZJXPyUHquMwTpsk05JEfXFz7m0MnbKtC
         76ZXaII/D5BXQtmHbd82Ml1TyDB+TIwbhD2bLnvjgwN9ERguXXMqyUvpTFnQzl74WTsW
         VDKtC64jjtU71VKa1w/gbezp288w9vte0n+bL4z6K01Bi+XyBY8pHXuB5qXHnDByp51H
         nE2g==
X-Gm-Message-State: AOAM5303C6EukMgQQXHe58/evmdbP/KJ830o2lmMtOU+JXFweKpGadfY
	FWv8/l4Ez/aMTe/J+hbMyc7SQs7DfMr3ds0eCp4=
X-Google-Smtp-Source: ABdhPJwzkx9B4bPMR1LToxxvGsugtLUgSMsWWChUmE4ROBJCYjT03O5l0WeyyVrqjdAr3Oxh5JyZkg==
X-Received: by 2002:aa7:d453:0:b0:410:d407:da20 with SMTP id q19-20020aa7d453000000b00410d407da20mr4265048edr.351.1645738503860;
        Thu, 24 Feb 2022 13:35:03 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id z22-20020a17090655d600b006d229436793sm175195ejp.223.2022.02.24.13.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 13:35:03 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v4 09/12] selftests: mptcp: join: helper to filter TCP
Date: Thu, 24 Feb 2022 22:34:03 +0100
Message-Id: <20220224213406.3127061-10-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224213406.3127061-1-matthieu.baerts@tessares.net>
References: <20220224213406.3127061-1-matthieu.baerts@tessares.net>
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
index 5be9168dd7a5..31fa04c257d5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -612,6 +612,15 @@ pm_nl_check_endpoint()
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
 	listener_ns="$1"
@@ -1618,7 +1627,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
+		filter_tcp_from $ns1 10.0.3.2 REJECT
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 		chk_join_nr 1 1 1
 	fi
@@ -1629,7 +1638,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j DROP
+		filter_tcp_from $ns1 10.0.3.2 DROP
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 		chk_join_nr 1 1 1
 	fi
@@ -1641,7 +1650,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
+		filter_tcp_from $ns1 10.0.3.2 REJECT
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
 
 		# mpj subflow will be in TW after the reset
-- 
2.34.1

