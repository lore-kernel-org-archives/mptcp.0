Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF7714AB1
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:29 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f427118644so62946565e9.0
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773507; x=1687365507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKx+xv3nEIXuhA8bErb+nTJg+SfY8Skia7lFVKUSScc=;
        b=0AbUljBygkjbrn5curfpnUywdviwdaCwe7E7OXso/CRVcY/ESawLu/YjmY66C0Riol
         QplwcM6jdBE3KMPBrD+0PHR9X4hBub534FIs1T7+Q70LTYAOaeoH60f2JPMEHtiQP+v7
         16ti3hDMKQlQCjXnfUj32u6Ym5TVzMT5rmdXdWx4Vapwx4r2E4vB10DUVbTWp5WfxqmS
         b13QNfg+BhSz1qFh08vUZIC1EsCBpJItdiTvzkRMshOABAmZBb2DVn0VGAQF6CLNgM7K
         DTJAF/NiWYPbz5zq/q2ZK1CkzFVnZg+4msGWCjRm5cCxY1jii85Dyr3C/SoQCVNbJWaV
         IBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773507; x=1687365507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKx+xv3nEIXuhA8bErb+nTJg+SfY8Skia7lFVKUSScc=;
        b=lnvWAt8Hv6gPgkBlALuMP2zA5ag2J/yPEYa3Qoh8bDfwRa7vlAs+/zHb1OUyrBcBCD
         f6JR/LQl2fXr65OVOhwZl2nOXNkeQIcaVjfmQB0wE0YdQQ+SRQk3eNRC3KGhAwTJ+LxB
         YyDfaUSTMP3pN3KsrdtQyb1cqu6Fmzd/dAiLpmEfOkA6Cm5GG3Ec7wLKbRdP8aK4w1c9
         qrITM6LxOcQXymLZMQhYgEipgltmZ+0rAEXp0pNFj9udYK/MK4U9IefIQjdhXg4721B1
         9IXQRAyJCcqLq4Ia+GIIOp7WUcUuNCGbnu/UwTOhvBSaFYF/alNwDsJ++024eGtWxyEh
         /c3w==
X-Gm-Message-State: AC+VfDwuRGivvU4nlvAauk8rBcJadd7a+MadWAwrUnf4LKjFbSgrZBzx
	NaaAK9Vx3Cb6vnJaRKN/75QSQkGCNnmBSYD/eNezGw==
X-Google-Smtp-Source: ACHHUZ7YU803Q4ykqKiXr6nuULrFvu/ZFeO+PckQ7dnRNGIyapvOIFKZjV1pTChKejkNtkaj23qqjQ==
X-Received: by 2002:adf:f544:0:b0:307:a36b:e7b1 with SMTP id j4-20020adff544000000b00307a36be7b1mr9501959wrp.5.1684773507167;
        Mon, 22 May 2023 09:38:27 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:26 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:55 +0200
Subject: [PATCH mptcp-net v2 23/37] selftests: mptcp: join: use
 'iptables-legacy' if available
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-23-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2293;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=p+0Luuq1myegD/ZjZOiSrcF0FYNgwCvSKvoQ8bE6hb4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pwO6XSy2ajZSSk01CliVNngaEh6vQlNKOrU
 yUvsb+hxE+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacAAKCRD2t4JPQmmg
 c/toD/0fKaVl9da8aB4Ovo5rHc1RfxNVj2OlIdUcFHn8GMLdrkAD3S3M+9mfRMCNciRKFyzNvdO
 X9JppAj8IjTe+dBVC/Qns1cK7xEoFYSeduNL9dcYxsMQq94sncWhXr840EEIQHrsu/+ywwg3dBe
 m99jqAtff86ya68uG4mNmSiXnadd18wMvQ/I0lZ2ei1yurn4q2cAycPGYQzID2vRObLWRUfkZxc
 Zm98enXVk6wULWqr5Fzp8tdc8nOzxvRcXU8tCIURShKiZ26TaEHzD2RolDEbGwqLa2sOjVt7BAg
 CjlQMxYrJEqNNK1eQQ/iFCsaHfpflXtwYg7P/RHb2fIcBWtoKHi8IsxKPaBotviJD6iRr/QrHfX
 +Jv5/fFFeJs4ZWAg0ZEA6wU/T0GxvamszciPk44ZZBXbYEhuwImBVTYG+qL5Haay68cL5bPXS+q
 kDffjxQMVHE13+eH4H8o9Wq1IJa2Yu2Yvoz7jvocKEWM+0wshPzMwOg1MJ65r/hbvqIadl3wKSu
 j789AazV3HAZAT4/Gv0z+RxC8Vi88vyJn+U5fZHHfGhg6leOKuR+PZXeEiU4WIcJUfoRXrH/EyO
 W09zUynSr6iOQd0jmoNnXIXyu/7pGi3ywgTFtEoYVw8Ra0q8J45+0XsYKIvI6J3clK3p+cIN3XR
 OaQwRyZIYVCPYuQ==
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
index 07f6c104fbe7..6eabde9d1164 100755
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

