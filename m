Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6A4BA5F
	for <mptcp@lists.linux.dev>; Tue,  4 Apr 2023 16:21:47 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id j1-20020a05600c1c0100b003f04da00d07so961116wms.1
        for <mptcp@lists.linux.dev>; Tue, 04 Apr 2023 09:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680625306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LxYQVLrTgRH8FSiX6h7WY6NNUgtJXJNUDJlBump9yvA=;
        b=4P3Xni9w72gv93g1JYXI0JfUlbeNGKv8RgLQZ4ozaBr6qrUAAc6jl0VHynzdIB7Rz/
         DHd/B2e1zQ/39ty7xdhZPqeHvbaIMXBXelKVNJb0fUlcWP1h8K/qdCKT8ElEJte4HLAn
         fUWUver/uANeUsURQlb77/Q9RzoIyk3xtReXrCLV3YxK6XtbEfmIh8tpRcCUkW4lseBY
         4r3JBKSOzcx22br1as6d19MLTuQK1rArY+x00GpFOxn3Z9cPCD7inhJCNvsYcsv4mMrC
         lOan8OhsB9rGLLBrrU2Qo9P3e5dCG7JGgljzp7uKtQSBkfaiU8884gsdA6Cnas/O2UKd
         H7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680625306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxYQVLrTgRH8FSiX6h7WY6NNUgtJXJNUDJlBump9yvA=;
        b=1WgwPv+ux6nVGX721jy3BA62rMDd4gofzwyZh3ojy/cJOsj7Tq+Lwf9VFqAE3Y2LJM
         3n1PsNyIK67w0FZ008hUkHUj3LnpOz5lRSPZ7sH+D9ow+wmkbjhlwB0klIq08eSVWvJK
         TPJ6rRBtabnA6QcHR3jOx9KomYlGQB9SwwarO+WPFdVfuyLFsGUBz7HIFafgCmp+m9hm
         8b1T8qB1ORyUecC2gAyyPoHB3gssRR3fWXbnwJHgi94ZlrwVdLvt0V2VOosVlm3sQyO9
         VBmlsCcB52R725nYCOKDAqLTuUtm3gnAmZbTqtyGp53Gw1QucXrQX8bSnp9r4D1i35ME
         6Odw==
X-Gm-Message-State: AAQBX9d3GSli8TcLKGu721njm210blc9cGX7EaBCJPnCx7s29FWYOome
	7M97DsuP0DRdoFQ0I94a3B2Ujh0nobVRzsn7NKV0gf6l
X-Google-Smtp-Source: AKy350ZdppyxL1fZMqTNEhwU/HOlgqnYqDZaQkAw2Y1VeiajjAM04R5wE2sVDoazdW3In9PHkg6+BQ==
X-Received: by 2002:a7b:c40b:0:b0:3ed:a82d:dfe2 with SMTP id k11-20020a7bc40b000000b003eda82ddfe2mr2528360wmi.29.1680625305987;
        Tue, 04 Apr 2023 09:21:45 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id u14-20020a05600c210e00b003f04785699asm12379689wml.43.2023.04.04.09.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 09:21:45 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 04 Apr 2023 18:21:29 +0200
Subject: [PATCH mptcp-next v2 2/2] selftests: mptcp: join: fix ShellCheck
 warnings
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230404-mptcp-selftests-join-busybox-shellcheck-v2-2-9113fa4d2ce2@tessares.net>
References: <20230404-mptcp-selftests-join-busybox-shellcheck-v2-0-9113fa4d2ce2@tessares.net>
In-Reply-To: <20230404-mptcp-selftests-join-busybox-shellcheck-v2-0-9113fa4d2ce2@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2487;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=cQlFZXFsroLEoKbLTcxhsa4oBC77O4itdblpKD+ud4g=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkLE6Xk4sHkE1XCZAKx6L16OejAriDy0Qom30wH
 fI625du/mKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZCxOlwAKCRD2t4JPQmmg
 c80OD/4i0W4E4asHMFXdKCj8JEODfc3xFQlkqARlVhBjp/zidb4FQkyGYiPMyBbkqheel7eCEOL
 qi1MqGJ7SiXbcGocOXLjv5q53KQ9dmusYAaxGN3B3p7niZkfhKn8bk764J0cb7TPMG6Lgo6Qumv
 NfZB3ye8Lv0K4W6bEmnfWc94bc3FKAv8MUFKNX/WmYdzFN1QZ1v5XFi44n+usVc08uuuqrRFm+k
 YyBGHq8S3aOrvZnWqVvvUeqT9no88p0CyTSWBtdKJIEbZQOAcEvyKve8jNq8+UuqHzwMsig8cg9
 G5RsPrQRKsYpXjXA4YyD+FvW6Eg/K57edegdu0QWrwXdc0y0nuhvhjz3vbKZoVHO+r4Ir0h1has
 omVZ4kcIHqRFdkoxcVs8lcVgHdGPZVMNswrKzF+dld1BxEpPo5HX46MDNqHI1WbBl/ENzJcheNr
 LUUDFnw1AxaDWrz4+ppWVkVY53s28/j81eS/HOMMwdpQUtiwgi+mWmgJJWN1pOJpH+WndO6qpfm
 FP2HNlXv76J2mXYD6jpYGHMuQQer8wSrfDlAqK44hdIO3wtShMSKRKBh54Y6N7uGjNY7jl/4vUN
 9s9Bh5WuPb77evl7LWa+BW20Q8JSaQSQ+i9/AIaMxbsN3HRl+nsbAQ8mhxXTAwqx2vHkSAU4OQ9
 JZbM0XNNFoS2BJA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Most of the code had an issue according to ShellCheck.

That's mainly due to the fact it incorrectly believes most of the code
was unreachable because it's invoked by variable name, see how the
"tests" array is used.

Once SC2317 has been ignored, three small warnings were still visible:

 - SC2155: Declare and assign separately to avoid masking return values.

 - SC2046: Quote this to prevent word splitting: can be ignored because
   "ip netns pids" can display more than one pid.

 - SC2166: Prefer [ p ] || [ q ] as [ p -o q ] is not well defined.

This probably didn't fix any actual issues but it might help spotting
new interesting warnings reported by ShellCheck as just before,
ShellCheck was reporting issues for most lines making it a bit useless.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index bb26c406f09c..257c5773ec54 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -6,6 +6,10 @@
 # address all other issues detected by shellcheck.
 #shellcheck disable=SC2086
 
+# ShellCheck incorrectly believes that most of the code here is unreachable
+# because it's invoked by variable name, see how the "tests" array is used
+#shellcheck disable=SC2317
+
 ret=0
 sin=""
 sinfail=""
@@ -371,8 +375,9 @@ check_transfer()
 
 	local line
 	if [ -n "$bytes" ]; then
+		local out_size
 		# when truncating we must check the size explicitly
-		local out_size=$(wc -c $out | awk '{print $1}')
+		out_size=$(wc -c $out | awk '{print $1}')
 		if [ $out_size -ne $bytes ]; then
 			echo "[ FAIL ] $what output file has wrong size ($out_size, $bytes)"
 			fail_test
@@ -509,6 +514,7 @@ kill_events_pids()
 
 kill_tests_wait()
 {
+	#shellcheck disable=SC2046
 	kill -SIGUSR1 $(ip netns pids $ns2) $(ip netns pids $ns1)
 	wait
 }
@@ -1712,7 +1718,7 @@ chk_subflow_nr()
 
 	cnt1=$(ss -N $ns1 -tOni | grep -c token)
 	cnt2=$(ss -N $ns2 -tOni | grep -c token)
-	if [ "$cnt1" != "$subflow_nr" -o "$cnt2" != "$subflow_nr" ]; then
+	if [ "$cnt1" != "$subflow_nr" ] || [ "$cnt2" != "$subflow_nr" ]; then
 		echo "[fail] got $cnt1:$cnt2 subflows expected $subflow_nr"
 		fail_test
 		dump_stats=1

-- 
2.39.2

