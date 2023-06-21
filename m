Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C841953D
	for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 17:18:30 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-31114b46d62so6417584f8f.3
        for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 10:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687367909; x=1689959909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQa1TW50ng55egfUjgHkNFvtrJkxUHGXd3+xQuWRT5I=;
        b=Fcl6/qXzUmggYGHE3KId/OYEYI8EgTQu7nDWaatVpzehTmkisetP54sbJNop4pthMK
         nEdtiaW9H9ZC0XiggHUxscCoSNdGtOYGpkjD2s9Y56a9WgYj0XlHLHnscC1HKOEWbJZB
         gIA2Z0q6kPwaQMUuDSs0ZNFq0kIz20fE+XuoGB31BYKnr9zQbhVLrQ+VY4eCPbQ2dUTh
         WdvNc4PQ4ANcHcjyQBEbK6IODJJTJl13bY5f9pi6OSlVM4RhKHYkrsLFOXOXQ7rQORjv
         N9onBdFyTLOpFf04HePhEBzypO8XTYWwcEaoFEtcFxvKNtbUM7KhWY1aua1LkLu05nnr
         TADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687367909; x=1689959909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQa1TW50ng55egfUjgHkNFvtrJkxUHGXd3+xQuWRT5I=;
        b=ltpYXYmEXCDKjuvF0d4HXfAcdirPcmaOI1zNYKeWsAchVWri5tafnTrMyk6F2JbtoF
         UzOq3yZ3Cspyohh3zsg8wk7a4WsrJ7Q/zpgSIXrDal263ULixo51EHhBbShccK/CPF8D
         PpCfrpZsoqsM9AXKOmY/Ho8pPl3G1KdhpgPYJ0PZhyDXqy9HSxpR+2OiCVnJwALvlZ0T
         EQ8qv7A82yVCTZGu+usF5RXFRBVMiPxJ25xbPYusoKoPuygKua1pqxjdQJcGYaPydjxz
         96GffweUirfB4eSrAMD6LrzSCAYAT/k5qXAl3uA4fR04B6Zea2fuXPVc7wDt8i+6NhTB
         IVEA==
X-Gm-Message-State: AC+VfDxHOsumOdb45XNKEfFOhidD2hrdHsOGlM7WORbqw5HR/TxyiYQe
	8116XlpQgAQV0CItkCAxwaEpzOZxX39O6nIp/pyYFwbq
X-Google-Smtp-Source: ACHHUZ4N+9rI4HP5bHVOpayrYP8p65wgW6g0p5TXTX8jIMf2k9vnX72m3k+gJir/Xv4Clv3IkqJdBQ==
X-Received: by 2002:a5d:4149:0:b0:311:1b83:e1e4 with SMTP id c9-20020a5d4149000000b003111b83e1e4mr15278690wrq.5.1687367909022;
        Wed, 21 Jun 2023 10:18:29 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id f1-20020adfdb41000000b0030ae499da59sm4930027wrj.111.2023.06.21.10.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 10:18:28 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 21 Jun 2023 19:18:02 +0200
Subject: [PATCH mptcp-next 01/18] selftests: mptcp: connect: fail if nft
 supposed to work
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-mptcp-issue-368-selftests-subtests-v1-1-0cae453ae1fa@tessares.net>
References: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
In-Reply-To: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1664;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=klmdFirllUiXh8mZSKs1Gp/kh4aYgIJUmIhH/mSzGQ0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkzDiu3g1IjmMzZzUjgFbaOKxjVHTxAA1CC3EP
 ag3+1bzViiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJMw4gAKCRD2t4JPQmmg
 c073EACRFXF9QpPuJBUnoEuqUDrpomJz89bEAedLVll0Ry4zK0PGU0C3UJX/SSD6iJmdm9e1pXD
 FwFixsPd+lvQnrEUNshtnbKiM8bgY7HoX4jpxLyHQ3tC7vRbd+UF5sT/kXvHf08vW6snu1VWfWh
 Ehe59YIdDv8AVPNBMkZyHcuHIy+3aJC1bDUwm+QeRnKzL1miHTJC5JixhCq61mUCy+UK+V/Apwt
 IV3pcxlSnsASKHGTtSxF0B9oe6a0TLVeOnUOBNW2HS6mHowAr+FA+WfwD5FSBYl5L1j+97pslUH
 ZW6N8uVODkV4xfR9FbTbKsHfnwMsBCWc0nlvfYxSNBxRPMjWsaklKV0WMoy+pK3Yz/8gTmdgJ0e
 onY/tv2C3EBYTLGT3LtEJXOuLRGRaVRytDKUFBMG/AR9BQhWyNDaDK90XGTNYUA05HZNoPqWBbF
 n3K8mtGn2XE/YcKW5/uFJodwwalHkMQ0PJP7+uJceWmphbbiGZVw++rJkKAoSwRwf7ExPlclAWX
 AXx48CHjeI3QHojmvGuILSalyC5t6U5yXjbIn7XE+DWBNG77x3ScMmeXa0naH2Hj5kc9kOyLUFz
 9nf+WGgfa5kAjssAEyJ71RFsrtKEiA1iUpvWFANgtKx3cuXCJLnsJL1MUouoibTAm6oBYCFEhK5
 SK+QnXlxpGOXuSQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In case of "external" errors when preparing the environment for the
TProxy tests, the subtests were marked as skipped.

This is fine but it means these errors are ignored. On MPTCP Public CI,
we do want to catch such issues and mark the selftest as failed if there
are such issues. We can then use mptcp_lib_fail_if_expected_feature()
helper that has been recently added to fail if needed.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 5fb62e9cd3ad ("selftests: mptcp: add tproxy test case")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 773dd770a567..780b8fef2261 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -718,6 +718,7 @@ table inet mangle {
 EOF
 	if [ $? -ne 0 ]; then
 		echo "SKIP: $msg, could not load nft ruleset"
+		mptcp_lib_fail_if_expected_feature "nft rules"
 		return
 	fi
 
@@ -733,6 +734,7 @@ EOF
 	if [ $? -ne 0 ]; then
 		ip netns exec "$listener_ns" nft flush ruleset
 		echo "SKIP: $msg, ip $r6flag rule failed"
+		mptcp_lib_fail_if_expected_feature "ip rule"
 		return
 	fi
 
@@ -741,6 +743,7 @@ EOF
 		ip netns exec "$listener_ns" nft flush ruleset
 		ip -net "$listener_ns" $r6flag rule del fwmark 1 lookup 100
 		echo "SKIP: $msg, ip route add local $local_addr failed"
+		mptcp_lib_fail_if_expected_feature "ip route"
 		return
 	fi
 

-- 
2.40.1

