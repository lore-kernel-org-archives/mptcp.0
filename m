Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1A21953D
	for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 17:18:42 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-311167ba376so6138910f8f.1
        for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 10:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687367920; x=1689959920;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yckCihFXiBNEkYpZIKeG/GmSl3WPo0LriqolIYq1Hw0=;
        b=ftMoWhIsgRHKnl4I6wT2iozaquxPUzUiergfY1GCGvC17nBENj24YBU50O5S99Pol3
         zsw0B/C3bNWcK7cyH03PFKFohuVcB+90341uboO3uAa0taDj6oO+Wo5lT4bBp7OkNtFt
         Oz6kRB0AtaW0MXkbNOKZ+zHqZvwSXcQm9WIZIMf/wzqoGpZoGpnAL6xYUIVGv50wdw8o
         tCtyzGc6tUYh+Cn3rmNMoNvTdImgjYL0Pcmy24pm97wTGclycmCjOudBMporuELuuzlS
         5dtsoI1A/Qbdueo42c1jUlMSAkI4CorqSYVfTJREDZtZvSRjShFhd5bAuLUfKEDXcDHn
         eZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687367920; x=1689959920;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yckCihFXiBNEkYpZIKeG/GmSl3WPo0LriqolIYq1Hw0=;
        b=ChgdgC912U6IUoEfnEmyiPir0U6MDt+l3jrXp8+Lq3hVQjim11713oZhPf3XctMy7C
         +uI91f7w+n9S6rwn5jAfXuW90i7kIFM1fkm0GVWauykzHxyc4pW2I81rbi+vYXfwBE87
         QMHm0VNVwF234WgDTd9pg0M6j3OziDKdRDErRceD7bmASV+fRu/Ph8XrCrjuqfTVWckv
         K3X3sClRINu4cMLijg58MvgQmcjmHcZx67wqdF+cY0xjbE9Y+P8RNLcSiKkqpVe7dc1q
         fisFhxggHLZjAG+NbFPUDkQ5HOgYXly/CY9WsShUB16cdAZ0ZO05BCecWuqj7w8Y2APj
         lDxg==
X-Gm-Message-State: AC+VfDxsGwb5/imEiUzjF1OEDkDw0zmUlrWTK19KFRsBJwdjMhxsuSnx
	mIxYHG93wxI/KEXgKHEVPQHW4e6H/5dVb6b6kHW+Rf20
X-Google-Smtp-Source: ACHHUZ4xZ1DWs3bplTvtE9OExvdc9e89skhStpQbB/HvLYGg4qUGOwso9+M9cHtmuO+POjHtxP/k7Q==
X-Received: by 2002:a5d:5541:0:b0:311:abb:e377 with SMTP id g1-20020a5d5541000000b003110abbe377mr12381004wrw.39.1687367919982;
        Wed, 21 Jun 2023 10:18:39 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id f1-20020adfdb41000000b0030ae499da59sm4930027wrj.111.2023.06.21.10.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 10:18:39 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 21 Jun 2023 19:18:15 +0200
Subject: [PATCH mptcp-next 14/18] selftests: mptcp: join: format subtests
 results in TAP
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-mptcp-issue-368-selftests-subtests-v1-14-0cae453ae1fa@tessares.net>
References: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
In-Reply-To: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3661;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=QAhij1elYa+WaiGBjefKnR3MW4aK/GQSHFrZI2uliG4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkzDjhUe6m/5bY67up46rxt0Z3NSaZoJah2s7u
 e+blA7Hgx2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJMw4wAKCRD2t4JPQmmg
 c5z6EADZzRUqv2mhr61OLkejKi5bIG/h7m2egukdOb9j/FxYKi5wtDZYOCP6OfT8eE6HqfipvbX
 a9dmvnAqJ4J/3XEi31QlkRuS9gQkXWujIWgzWMSLQdjhfABcszUaE2n5KhVnlakTfBSVac0Qvtn
 yh9TFJhE0QEm5ndPYhx1LI88eoZL8E6muLKVY/cG4HuuGL/krMN56v6a4APzJnxuPm/zgDR6DiJ
 Qu8qrk5ZCt6IBOf2zTGAkziHS39B9LV1/JF+rD4ZsPOS9PfLQCYY48xBhxhjxudsSlSpT9G6cyM
 ZUUmjFgytFzk5p6pYFtvoOxR/HZX2PNGeXgJ02NuGnc3Tqwskt5nwxAT7ECgpx++DzsYJsSjD56
 VFVe4fWKCYus+XuPW8IRtYqHmfKQHQB2rQbZBbbfg5TuFSKqvGbRriEaGXwIPkHszBb8oGTUjoe
 QcbhEwBKTKB65D7DBeOkmXcRIU1fW+Xu0uYol3D4ysC5urtafKMfLtNowMU/hvz9li/E0v6FzZ6
 ditwoeJDutP8FVwh5gwcYWd8PreCOPr/dCh4F59Lp59PZT1ZV9gWyUyX/WpqR2vWB6GBSKwbbLz
 ZxPnVCZlEmvF7ms4GjkwS6soXqo6LFpP3KlYxIMZVfkwBEo65IiSa03lU4hdw3wm36co9C9n4tS
 fm0hZwLfxA5IaJw==
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

This patch formats subtests results in TAP in mptcp_join.sh selftest.

In this selftest and before starting each subtest, the 'reset' function
is called. We can then check if the previous test has passed, failed or
has been skipped from there.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 41 ++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e6c9d5451c5b..5c5c8b5e068f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -39,7 +39,9 @@ evts_ns1=""
 evts_ns2=""
 evts_ns1_pid=0
 evts_ns2_pid=0
-stats_dumped=0
+last_test_failed=0
+last_test_skipped=0
+last_test_ignored=1
 
 declare -A all_tests
 declare -a only_tests_ids
@@ -97,7 +99,6 @@ init_partial()
 		fi
 	done
 
-	stats_dumped=0
 	check_invert=0
 	validate_checksum=$checksum
 	FAILING_LINKS=""
@@ -162,9 +163,7 @@ check_tools()
 	elif ! iptables -V &> /dev/null; then
 		echo "SKIP: Could not run all tests without iptables tool"
 		exit $ksft_skip
-	fi
-
-	if ! ip6tables -V &> /dev/null; then
+	elif ! ip6tables -V &> /dev/null; then
 		echo "SKIP: Could not run all tests without ip6tables tool"
 		exit $ksft_skip
 	fi
@@ -213,6 +212,8 @@ mark_as_skipped()
 
 	print_title "[ skip ] ${msg}"
 	printf "\n"
+
+	last_test_skipped=1
 }
 
 # $@: condition
@@ -245,14 +246,32 @@ skip_test()
 	return 0
 }
 
+append_prev_results()
+{
+	if [ ${last_test_failed} -eq 1 ]; then
+		mptcp_lib_result_fail "${TEST_NAME}"
+	elif [ ${last_test_skipped} -eq 1 ]; then
+		mptcp_lib_result_skip "${TEST_NAME}"
+	elif [ ${last_test_ignored} -ne 1 ]; then
+		mptcp_lib_result_pass "${TEST_NAME}"
+	fi
+
+	last_test_failed=0
+	last_test_skipped=0
+	last_test_ignored=0
+}
+
 # $1: test name
 reset()
 {
+	append_prev_results
+
 	TEST_NAME="${1}"
 
 	TEST_COUNT=$((TEST_COUNT+1))
 
 	if skip_test; then
+		last_test_ignored=1
 		return 1
 	fi
 
@@ -439,10 +458,13 @@ reset_with_tcp_filter()
 fail_test()
 {
 	ret=1
-	failed_tests[${TEST_COUNT}]="${TEST_NAME}"
 
-	[ "${stats_dumped}" = 0 ] && dump_stats
-	stats_dumped=1
+	# just in case a test is marked twice as failed
+	if [ ${last_test_failed} -eq 0 ]; then
+		failed_tests[${TEST_COUNT}]="${TEST_NAME}"
+		dump_stats
+		last_test_failed=1
+	fi
 }
 
 get_failed_tests_ids()
@@ -3568,4 +3590,7 @@ if [ ${ret} -ne 0 ]; then
 	echo
 fi
 
+append_prev_results
+mptcp_lib_result_print_all_tap
+
 exit $ret

-- 
2.40.1

