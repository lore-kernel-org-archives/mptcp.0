Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF9919BC6
	for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 17:18:43 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-311367a3e12so5272792f8f.2
        for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 10:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687367921; x=1689959921;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnC9E9znL4xb87FoChND93I1HB6BMnQvNBpDOQn5PiM=;
        b=ulCD1dy7tYzHBtrrIKLH180z9kWyb3CVmykkqSGZ/J8G17igAWLCaGwaRJnN3m6kOf
         XsthmwdmA0K5bilTmDUun6rDVgp4qBmwW0COoRUOk4xi9GmYnQWoC0pSuD2PvgReMSfU
         ewyOwzDf+RMmVMb8AeQJut9ryloQd3ISdzbtL1GvGjgJVT8v8dpIjZrvI7wqcQlh6Fku
         BY+kXW36XGMKShNkVjfu+HjqJr15EXGKvCO+HAeJ2BiJHwtaEPfA3BuwyyjO5HUnEXjM
         CP5TRRB72wXU0RWBXWuUHROT7UudEYR7ak8KWXnp2oESxDgU/cqHFLGrRP/AoOkuRGje
         WrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687367921; x=1689959921;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnC9E9znL4xb87FoChND93I1HB6BMnQvNBpDOQn5PiM=;
        b=SjyCE1/ury54swWEG82edgG6Va+nlj078bpkQ8slUnV7Wy17AB7j15AgovYcGTcntV
         raGuxaR6tzhNWqe4qUottr+Yk0GrYJG2+xoLZ3x2ZnyYdNYaXYXnj9LiTPxaUAA28NQf
         1ksDEh4V8eBXQceO5Cfw/D4ZwdaQsdRpA52DSA1zegBx6P0ITIWTTCyEpKO6fjZJ4MHd
         vljemKPsc6aKUUMrdv7Jz+wCIFuE8E0XL6PHEUCvTwspsHa/Wucws0JVDHajli/1SNcg
         bASAYhMgqPknMO5sO3926eYSu0IscGqUvyTwZK91EcLu2JRAaoHg2gx5C/q5n/2BjXgs
         qB0w==
X-Gm-Message-State: AC+VfDyj1ZGI0uiY91a4ktNj/NaVI/d8H6fXzV43lMoovNk05K8Zw06q
	xv4qgv3AR9Xq6kvHQzQYmWNcJWPc5ze9meMjwNtstTI6
X-Google-Smtp-Source: ACHHUZ7G9i0seWjVpTkdBhiz8LDfzkIWNJrQX96BklCPNdgrg1oGY41o1oJ70np/8giex0P3VMYgig==
X-Received: by 2002:a5d:4643:0:b0:30e:4a21:808b with SMTP id j3-20020a5d4643000000b0030e4a21808bmr13452686wrs.55.1687367921381;
        Wed, 21 Jun 2023 10:18:41 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id f1-20020adfdb41000000b0030ae499da59sm4930027wrj.111.2023.06.21.10.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 10:18:41 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 21 Jun 2023 19:18:17 +0200
Subject: [PATCH mptcp-next 16/18] selftests: mptcp: simult flows: format
 subtests results in TAP
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-mptcp-issue-368-selftests-subtests-v1-16-0cae453ae1fa@tessares.net>
References: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
In-Reply-To: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2252;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=FdqKLMK/dFIBrNHYnVz9G9+n1tvdWIxcRpx2SlWMalE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkzDjL8P0wBV69rgnU09xuYaCNnartbcybu68E
 Xywf0ae9oKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJMw4wAKCRD2t4JPQmmg
 cz4mD/9FE9p2NOxgL826LSNhzfuCAaVSU8gt9FQNryY7qpjDPQ6q/8SknzQgVoKuouTBApAIwDJ
 U1t7iR3xY5Qw62l4mdw0GbaF9/7jJ4Ysh9sgMWt/dFnOAhjff2GhcRlgP/VEupNPA/2ijR6yZhy
 0C9arDKp5UvR7ezEQOBXIRj0TaNFZctgsMOp0DlUWflxEs59nW8JZO0kMhJ5H6j+kkaymGoz03x
 Njuc5NioNocJHP3Hnckw1l8GjufpdYCSRpvru93TsMTwT2q1VCh0Nkn9rRvrFWSi8IXRO7P7v3p
 dwfO8oslEU1jrs+tLWc6VrtrpoAC/XyJYT0S1WHBS0iUpxnDKqWvmg27en/vFq2CPy2V2o/Dq6H
 XM83bU+s/8wEIWGA+2j9qdA2M54PBz8DqZlx5FTjjY9oZW60J5pd3Kj3wvPfyeHlO4pBI7yU9vW
 8xL3DNuOmBZmHIRFCqbGknRxk1HVz/Ut7F1+im69Ve3nYZC90xxss0J24ZA4jIu4zT6qLalJI/P
 naxkqQFeGo06RD+OH4UFCoK9yJGAh2/PFgXBhrRfEHqkm5OlsBBNyZkmHaAlT/SrwZuRRXyNoj3
 W+Xc0AfxwARINQXCPOMTXbczo7zQ7kFzb3yWf073ipt0gp2USvd/eQN9br1Mb8cBJUUJdrr6Fen
 oqpXG1DS4XskN3g==
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

This patch formats subtests results in TAP in simult_flows.sh selftest.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 36a3c9d92e20..ce9203b817f8 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -261,6 +261,7 @@ run_test()
 	printf "%-60s" "$msg"
 	do_transfer $small $large $time
 	lret=$?
+	mptcp_lib_result_code "${lret}" "${msg}"
 	if [ $lret -ne 0 ]; then
 		ret=$lret
 		[ $bail -eq 0 ] || exit $ret
@@ -269,6 +270,7 @@ run_test()
 	printf "%-60s" "$msg - reverse direction"
 	do_transfer $large $small $time
 	lret=$?
+	mptcp_lib_result_code "${lret}" "${msg}"
 	if [ $lret -ne 0 ]; then
 		ret=$lret
 		[ $bail -eq 0 ] || exit $ret
@@ -305,4 +307,6 @@ run_test 10 10 1 50 "balanced bwidth with unbalanced delay"
 run_test 30 10 0 0 "unbalanced bwidth"
 run_test 30 10 1 50 "unbalanced bwidth with unbalanced delay"
 run_test 30 10 50 1 "unbalanced bwidth with opposed, unbalanced delay"
+
+mptcp_lib_result_print_all_tap
 exit $ret

-- 
2.40.1

