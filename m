Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810CF15495
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:50 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f6d38a140bso8611825e9.1
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542609; x=1688134609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0iFvq8h1CJbhRBbrJrXNTZZwEqRe7A4t129kHfJRMY=;
        b=auJoxzF+WMpZ9qeSxDrnHEOefss/m2E2fvPKPUQqqUL5LCfZOknn+baHPfZmVwYGp7
         ceMi4DsUTwVwa1vCR4ajV2KzGw/YV4gW+Viym1kUNzwzWUD/G5Vt8CB8HWQyi2PuN4wr
         kQTi0P7zPe0kQFJ6U8pcQVOhAYSzUK53md2PxBSLydaCgxWiIZyNuF/t7QFwP4uoW7ej
         Kj2+PsJNgNpyj2q8Gj1NyUeASxIQDsMfzFcgi0Pp95JO/8lwjjkXFTJYpqbMVGlM2rz5
         Ugkl0W4WXWdqwqxYzqyCGCQ+T//r5FUeYMd0Z9q09Z8noCARYF85peqg4kqT2k/ub50U
         VCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542609; x=1688134609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0iFvq8h1CJbhRBbrJrXNTZZwEqRe7A4t129kHfJRMY=;
        b=LmSrqenHW9Sb8KQuup95Bsg0nj026XDt09XE1xC4Ni4NMNZEZlnFUUVDsfXCu+odp6
         XOVamahkmmCcZTZZINPxLhs1AECv2mXaYRfxFST6V2zuADxULncxXKvAvl90w7qenJfx
         3ohmGOY5EbJt5FlSdIKnVGPX1kVf/nk3h6e4o/c/29c7o9i8bssY1Vku9p+QUbLT2pZN
         M8clRobgL96SVpSBM1RxOSB+QgTRvbdt7mWZSGF+XAS5lZbBTjB3bF+HZpsWCQu7tgBi
         sRF364tw3NyK0Ur5Mfy5AlOj3n2G8KWR2h2UBx/EZioNAv2AHWCF2CokGdhrMUrgu6Oq
         N8PA==
X-Gm-Message-State: AC+VfDyBiw77Cr6wkuvYtrhifL+9MQhmS+JKkEkIIhQvoLRBFjmYqtaf
	eUt+NWk2Hz5INccrIaZAmTZP0g==
X-Google-Smtp-Source: ACHHUZ7ixbwv3Zhk1JL63PdTErVxIm+D5XPNPtcODXag8dwLpcQ9cQAT+YQ3NAIK/TAQMrgQqyFO0A==
X-Received: by 2002:a05:600c:4455:b0:3f6:46e:b221 with SMTP id v21-20020a05600c445500b003f6046eb221mr12166441wmn.7.1685542608805;
        Wed, 31 May 2023 07:16:48 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:48 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:36 +0200
Subject: [PATCH mptcp-net v3 16/32] selftests: mptcp: join: use
 'iptables-legacy' if available
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-16-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2293;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=agSsWqlwCJ35SHuesHY7WLa2KEf2Ptj9PDK0eZD7X1Q=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bDFyplsX0s15FJRO17xTCyD8iu2KPRvaMbY
 OVZL2W00X+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwwAKCRD2t4JPQmmg
 cxEdD/92Xx5qQ7DdGGZTLmNhqokb2Bak6YB/ka+zZI/A6DNzik3AdqDDwrWeGwnw/rhN0ldxgX+
 QgkfGPWu8D9N++DdPodEsmr+ccOHrZGiwWu1ZUawIS1qHVB8vecpEgSyiaitbIYxXdp5jPk3KCU
 /tv89LJEN7L0l7Ehy9dXKJQ1dgCcZk02LTN9hOs633m4cq1X5e8hTu936heqdMRkeUbQlVBh/Sf
 g3YI43mpkRmKG5JX/TKpeQvNzkPYYudyBK68AT3UgTnSuR66xg6ROABX3uehU9okOP6UhlQ6Q7d
 wbPMWUgQ5Dqx9/zK5l2KzwEYErsXE0ISszLIgKGwfrVG9iXuyOyiivPkl9aiVZoFGTpV0g9gb1U
 B5BMpdnfRJ4rUL1J/+B1um2rvIVyg4T54QoXA7pBklFsg+sTKCkAY3hL3ie4czMKyKZOmteZrZ+
 1HMtO4qD7kVP7lEy395AOtunqWJuKTxmb++AwbrnEXYe2J023oQ44pI32Zl2JOrYArMRjN463p+
 oAnfQck66/BQ00KzyyaCweCAbCb+1Vo4ihu0vWN7jDxoCml2NT+Cd92/wKwXH7IWrRdHYALAKNT
 nl4A4xRVEke8fhZ8svKxgBV46ih+7rYr+s5VM5JfJzPMJU5Xct9tfAMsQHFnaj3QX3lIMD+4gZA
 GcXOnQSd22zMt3A==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

IPTables commands using 'iptables-nft' fail on old kernels, at least
5.15 because it doesn't see the default IPTables chains:

  $ iptables -L
  iptables/1.8.2 Failed to initialize nft: Protocol not supported

As a first step before switching to NFTables, we can use iptables-legacy
if available.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 8d014eaa9254 ("selftests: mptcp: add ADD_ADDR timeout test case")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 85474e029784..4dc529d95da4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -25,6 +25,8 @@ capout=""
 ns1=""
 ns2=""
 ksft_skip=4
+iptables="iptables"
+ip6tables="ip6tables"
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 capture=0
@@ -148,7 +150,11 @@ check_tools()
 		exit $ksft_skip
 	fi
 
-	if ! iptables -V &> /dev/null; then
+	# Use the legacy version if available to support old kernel versions
+	if iptables-legacy -V &> /dev/null; then
+		iptables="iptables-legacy"
+		ip6tables="ip6tables-legacy"
+	elif ! iptables -V &> /dev/null; then
 		echo "SKIP: Could not run all tests without iptables tool"
 		exit $ksft_skip
 	fi
@@ -249,9 +255,9 @@ reset_with_add_addr_timeout()
 
 	reset "${1}" || return 1
 
-	tables="iptables"
+	tables="${iptables}"
 	if [ $ip -eq 6 ]; then
-		tables="ip6tables"
+		tables="${ip6tables}"
 	fi
 
 	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
@@ -316,9 +322,9 @@ reset_with_fail()
 	local ip="${3:-4}"
 	local tables
 
-	tables="iptables"
+	tables="${iptables}"
 	if [ $ip -eq 6 ]; then
-		tables="ip6tables"
+		tables="${ip6tables}"
 	fi
 
 	ip netns exec $ns2 $tables \
@@ -709,7 +715,7 @@ filter_tcp_from()
 	local src="${2}"
 	local target="${3}"
 
-	ip netns exec "${ns}" iptables -A INPUT -s "${src}" -p tcp -j "${target}"
+	ip netns exec "${ns}" ${iptables} -A INPUT -s "${src}" -p tcp -j "${target}"
 }
 
 do_transfer()

-- 
2.39.2

