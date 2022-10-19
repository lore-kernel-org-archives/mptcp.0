Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F293B3C15
	for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 16:20:06 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id bv10so29894767wrb.4
        for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 09:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hn6RXOx3zKZieXK/u+qANY+FrRWHAGIuy9zpLICsc0c=;
        b=7zdtqwIFqVcYQHTJc7kBy/yXh0i/Uy47ROuQz9DSYwjncMbUYsy8pbDEkXBcMnlsFt
         YHw7ZJyeYYARVpAA/DajIKdZ3CsQ4QYH2bzozXENwx6RwfcmPu3MFXp6zsb1MPj7UtQL
         nrQEhaLRQF6oziDnuP4Ew8c58VIkL8CSVG6VG08RyoMqU3SWCko1VfwQtjLIwwP8HmLq
         sxHdbWIxGURO7VqrxrCNTzlE/+FaLz1qcOpAXKVI31+DkMdgUxk7T4mqnpvYgq0a/XUO
         9e3AE0cIg9l+mDmvUfZ+QlXFOtI8fnFZUhrnA7ZmccN/TCw46uReKUOP++OsqNMvoBLS
         A3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hn6RXOx3zKZieXK/u+qANY+FrRWHAGIuy9zpLICsc0c=;
        b=XA2Yr3OyDrHMird/4AKXr4PaUOJheJcpdRAZ/ghHtdTxDCcXw4qx8eRphYrC9p5q2W
         aHaNFSaA89OHWAe4qOanr+BWAbwyxBDdPHIxGgFMHuaampV8gTjLhPMVHQUWGIFU7GLh
         CKn8piJYBo9CTxw5/KMRc9Ik6NuQUdJ8TTVUYlsNiacONb/qUsQ0qbMKDzUG/BuNpZWA
         YyV2KRBt3JO9TrH29kl4lc9Jy4XIKIFhIRIsSvYmv4xh1k5a/j9jdecVOKrE8KikJ7+R
         i86auHAAgsOfP1jDqeCriLdBnTgRbdcVK1Vmc4CYWlk8LhDomZLYux3xBbm4DghW53tX
         1kCw==
X-Gm-Message-State: ACrzQf1asVIhzX5/trga0O08EJ8Urg/9pljjynH8Qv3T/GQU3xXpvlA7
	ADCkRE03xpeCTLa5ML7xqNLpoX8YiRbSTIt8+O8=
X-Google-Smtp-Source: AMsMyM7aP5ApxQXXXWbN6bT9DCNniddQI6sBWLMrrCZCNIjjCVOBfs855Atarvowzc+cryX7ZY1yZA==
X-Received: by 2002:a05:6000:144f:b0:231:2053:ef7c with SMTP id v15-20020a056000144f00b002312053ef7cmr5745710wrx.179.1666196404860;
        Wed, 19 Oct 2022 09:20:04 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m1-20020a1c2601000000b003c452678025sm433717wmm.4.2022.10.19.09.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 09:20:04 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net 1/4] selftests: mptcp: run mptcp_sockopt from a new netns
Date: Wed, 19 Oct 2022 18:19:37 +0200
Message-Id: <20221019161940.3178393-2-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221019161940.3178393-1-matthieu.baerts@tessares.net>
References: <20221019161940.3178393-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1861; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=7AVrEOnpLyEuo1LY7GYGhqkJxKRaehmY/atjGfWxS8c=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjUCOD9A+2PKxTtn/iQxOltJYchqsPqJatCeCCdk8a
 jwVklkqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY1AjgwAKCRD2t4JPQmmgc/ypEA
 CNuG3tAwh1ezjpuhZfoN1xi4IESOHy7hTqQ2T61h26O6T+5BqMab55hV2Gc1rtatGURzwTwkQ2Pz9m
 O3HQ6JOZSlCbbwJ6Rmx2tpbtfmg6FDbxSGHK0yf/qtmukN7q19YwThJrLNF4/FlzILnx/u2DRV3SlQ
 NBaqHm/bVotVYfY0vHyw/blNUCycl8tc2X0jikIYqiJHcJ8PcIEqBj7aw8oQLShT8XOZFLDj3C9uJ7
 wiMkp8JlXXM2mZBhPzUP0GdDHLkYx8OlLrufQF9HmpmdP1ikvLwH3pJB7SrR7GRSqUpJrjUUKvQHW5
 Pqs/CfHf3RnWD0JyBMKexnqNeAVLbLmwAUwhAISKljNgERx8uciKkcMLvBT1BgwkegW7oiMcs/FdaG
 5lgrIFDLkM81yRUFHEGLfdFbubmovszD+UgoC32R6+pCquGL+922ctctrkA7wQHMUyvCCIhaY/AhZ9
 L/6QryoF4Hwv2Eiy5wTd87oD71ebomstIG8BY8k/PCE1Pwpev5RcWQv9WKIwNRG+iPHQuAvmY73lEY
 28Iesba65kCXDgF7vpfDle/+lczXS5yPn0aAVAJfy0NDK7iZadyQ/zh+7k/8EzCPId5kh+Aof1IigF
 qUkb9T6qX/7DJRutjtoyhtLVdrXFBlQt6JJsB7Ypp36xVpcdvv3xobLnghEA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Not running it from a new netns causes issues if some MPTCP settings are
modified, e.g. if MPTCP is disabled from the sysctl knob, if multiple
addresses are available and added to the MPTCP path-manager, etc.

In these cases, the created connection will not behave as expected, e.g.
unable to create an MPTCP socket, more than one subflow is seen, etc.

A new "sandbox" net namespace is now created and used to run
mptcp_sockopt from this controlled environment.

Fixes: ce9979129a0b ("selftests: mptcp: add mptcp getsockopt test cases")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 0879da915014..80d36f7cfee8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -35,8 +35,9 @@ init()
 
 	ns1="ns1-$rndh"
 	ns2="ns2-$rndh"
+	ns_sbox="ns_sbox-$rndh"
 
-	for netns in "$ns1" "$ns2";do
+	for netns in "$ns1" "$ns2" "$ns_sbox";do
 		ip netns add $netns || exit $ksft_skip
 		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
@@ -73,7 +74,7 @@ init()
 
 cleanup()
 {
-	for netns in "$ns1" "$ns2"; do
+	for netns in "$ns1" "$ns2" "$ns_sbox"; do
 		ip netns del $netns
 	done
 	rm -f "$cin" "$cout"
@@ -243,7 +244,7 @@ do_mptcp_sockopt_tests()
 {
 	local lret=0
 
-	./mptcp_sockopt
+	ip netns exec "$ns_sbox" ./mptcp_sockopt
 	lret=$?
 
 	if [ $lret -ne 0 ]; then
@@ -252,7 +253,7 @@ do_mptcp_sockopt_tests()
 		return
 	fi
 
-	./mptcp_sockopt -6
+	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
 	lret=$?
 
 	if [ $lret -ne 0 ]; then
-- 
2.37.2

