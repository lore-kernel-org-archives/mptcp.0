Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BA819BC2
	for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 17:18:44 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f8fe9dc27aso48161245e9.3
        for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 10:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687367923; x=1689959923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVblpBeNWGNB7fDwVHNlCBY0uXQgNiMcdlCz7QGtARw=;
        b=M+8iz8Pz3rqMDFKamANtWQ/kd4QPuPMIkpyqUxvF4FUsp2D6C0SICz13yO+GGapa/H
         mCe3BgV/ud60eo+IpSLsAdMhLOHlGFL16F0ZHunk+IyWpxdEBeqWc5cvEN9Nw9mVz5GU
         5xkewcGtJDQQUo3IeFAQ61vUwl8hps6G22qwq5RlBurvZd+6qM/DaB10RQWAhKESAbD5
         pc6USHu7OmyLeBuHkVXc2Rp5X3vr4m42N6pIVDt2q1xR6xH6vVw0wewoqU9kkNxeg0Gk
         CxkHWVmKT19MsiosGNUjKUvdU7qnFuxTJ46oCsUzBn1O8IsDE2bgQmHXs5rZMwF6+5RB
         5ErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687367923; x=1689959923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVblpBeNWGNB7fDwVHNlCBY0uXQgNiMcdlCz7QGtARw=;
        b=mEOLQUkdigsM+JPHKP0d//GYH71dCplcyY8NUdCjC9u+zayzW4DciHNXnfE2SpY24h
         iZRDkzQGaj4/me/yfVcHeKFaBpKnHHcM49eHfN6Ffxph154fyYd2CUI5T4+/x4zRwSqI
         JwOV91van+bZ/EeA4jc6FwucmXoCcriZZ3UIqtw/jsmX/9qGjQrESeEhHCOC0s/5L8LZ
         HZfUyzdm9ID9S3KC9S8I4FCgECxfS1SnMb8J6KkIjTpmTBdZiIrVJ/1N3ldFwUkIh+8U
         HnpZFrTXi1gb6C/yh1ds9m3otDCFKIwQuIqco27Aq8QwYeBqecT5rCc4cKjCc4h7lk1A
         zDWg==
X-Gm-Message-State: AC+VfDwoBeKoLGCaBGmzxY2F13nic0FBHJ83C7UVG+38WXcLZaL1yZ27
	8W42Ff17/onCGym5JXNRTmLZVQivOyUI9sihTpC4q4Gg
X-Google-Smtp-Source: ACHHUZ4YxtmLpJIybkFCNCyv/Ibl/TVr6rxyZAb4sbg9Pf6pYLiuyI0BFgkbZwU/0g5akxU+QSHPKA==
X-Received: by 2002:a1c:ed08:0:b0:3f4:27ff:7d48 with SMTP id l8-20020a1ced08000000b003f427ff7d48mr11542501wmh.19.1687367922840;
        Wed, 21 Jun 2023 10:18:42 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id f1-20020adfdb41000000b0030ae499da59sm4930027wrj.111.2023.06.21.10.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 10:18:42 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 21 Jun 2023 19:18:19 +0200
Subject: [PATCH mptcp-next 18/18] selftests: mptcp: userspace_pm: format
 subtests results in TAP
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-mptcp-issue-368-selftests-subtests-v1-18-0cae453ae1fa@tessares.net>
References: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
In-Reply-To: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2615;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=0exLZEpTNm5SOzHjFuvb8uJ9afZ7LL50RdiomlC7Mk4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkzDj7qYLFOzVm1+ShIkJJLYobujxj9/YayrO+
 P/jtbMp+U2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJMw4wAKCRD2t4JPQmmg
 c9hvEADdwpSkCK9U+oytWX74eOcxrQCybOOCtuZW1L+ShGfchIJihklU41qEIZWpg7XaxJU0ca+
 apV1J5sxXfoWgv6SsfrWPOyZgsoMMkVY9fOnYCxcr7tIkCL0eKEt+qWjQy52vICdGQkRArXpnYE
 YwvfCbv2f6vvoDEgyyTqLhPdZXp63q0p1Hf/b2JXe4BlUoQ9/gSJcuGZ7c2id+bLIhqfZmHNbn+
 jXwC8lWrL+YFYPI+z3tn0Ikz1Yp6Nn3eEpKy26ekjPHHNWZBFU0fSPUE/dVhfXbhKxqauw1PnH8
 Q9K4NScZHMA4AbPGClOoY/3z1KLYKCvWHZX6T4syieb3APczG0SllyBlyaDOeYhCBYHKa9rExmp
 pRUCZLiUoGd9C6g3lZiweNOI9EiXJLo28Gl7MfiE3HFlktJ+9/eBymE64eEaQWqAbc9BuSGuFZ/
 m8hXmFw9+u1B4j05cQCOtGs2f4KQ/HseFtz/FSm/dPm9KA4x5WlAE/XhogaT8h6tBcfhoLdwR0x
 +7gTAcUTcUKD0EiR9X/4Dznfv9U33L3N3lkTXnKfzmQjvnBN5HXNFlVRZj2Hr4gy3VTTXVXEINL
 niTrl6S133BudWDSkifJAgYq63i+CnCVhgt6fE1BWIosNGOhU3OOwC8bVNTRkn9dXGxKFb3gQXd
 57dp5xGXqAPw03A==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The current selftests infrastructure formats the results in TAP 13. This
version doesn't support subtests and only the end result of each
selftest is taken into account. It means that a single issue in a
subtest of a selftest containing multiple subtests forces the whole
selftest to be marked as failed. It also means that subtests results are
not tracked by CIs executing selftests.

MPTCP selftests run hundreds of various subtests. It is then important
to track each of them and not one result per selftest.

It is particularly interesting to do that when validating stable kernels
with the last version of the test suite: tests might fail because a
feature is not supported but the test didn't skip that part. In this
case, if subtests are not tracked, the whole selftest will be marked as
failed making the other subtests useless because their results are
ignored.

This patch formats subtests results in TAP in userspace_pm.sh selftest.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 568ddee1d102..23f8959a8ea8 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -59,6 +59,8 @@ rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
 ret=0
+test_name=""
+
 _printf() {
 	stdbuf -o0 -e0 printf "${@}"
 }
@@ -71,7 +73,9 @@ print_title()
 # $1: test name
 print_test()
 {
-	_printf "%-63s" "${1}"
+	test_name="${1}"
+
+	_printf "%-63s" "${test_name}"
 }
 
 print_results()
@@ -82,11 +86,13 @@ print_results()
 test_pass()
 {
 	print_results " OK "
+	mptcp_lib_result_pass "${test_name}"
 }
 
 test_skip()
 {
 	print_results "SKIP"
+	mptcp_lib_result_skip "${test_name}"
 }
 
 # $1: msg
@@ -98,6 +104,8 @@ test_fail()
 	if [ -n "${1}" ]; then
 		_printf "\t%s\n" "${1}"
 	fi
+
+	mptcp_lib_result_fail "${test_name}"
 }
 
 kill_wait()
@@ -255,6 +263,7 @@ make_connection()
 		test_pass
 	else
 		test_fail "Expected tokens (c:${client_token} - s:${server_token}) and server (c:${client_serverside} - s:${server_serverside})"
+		mptcp_lib_result_print_all_tap
 		exit 1
 	fi
 
@@ -990,4 +999,5 @@ test_subflows_v4_v6_mix
 test_prio
 test_listener
 
+mptcp_lib_result_print_all_tap
 exit ${ret}

-- 
2.40.1

