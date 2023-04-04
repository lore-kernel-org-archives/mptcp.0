Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83E9BA41
	for <mptcp@lists.linux.dev>; Tue,  4 Apr 2023 14:56:18 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id s13so19189518wmr.4
        for <mptcp@lists.linux.dev>; Tue, 04 Apr 2023 07:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680620177;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=naEc1M79h9Rlwevdk9LN1zU3Sl/M47uvzfrvhY9XPHY=;
        b=dWzHfTjdLhMNfX7RHBvwO04bP+Hltl2uITD1S+0ulZ0KQ5uA/gWVjWfJCBpAj7DODI
         JX9aN1aup7AtU6XoYy7IHDzLAikOdr4gQiqHW9iF0lGrQeaqyx2j5YYPHvASCgMpIOjT
         2CZzwenGhyQF/jgpNw1ntrIwCeg4vTqFyxjuoC7Kx8jpphp7SOZ3skpKlx9lHyy3m5cO
         NHK1Ras2+U42AVQFnnuR9rOvhlxNXT4XmGPY8u6KpJC773MJOmtNSQ+QUxoYdvizmOM5
         Yg5EFJo3/HfK7kbq5uCJrgfbZ/8hd30H6/wiSxzI4LF+S9sb67QzYkVahm5gdfIbaj5/
         uU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620177;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naEc1M79h9Rlwevdk9LN1zU3Sl/M47uvzfrvhY9XPHY=;
        b=FhzwKKd1bQ6LYY6RVs7v7bg1pUqmL/YfIl4hvR+c4q+gLLciE93dih66WCYdSNBsgW
         1RUrhJ4wv8UO2qdW3Bwuu550j88KfSC3zFWMW3FZPFJIAVBBUEx8GevmZyISXr4kBj1G
         KIGGBqYs0daOT0K6Dx5UwIoNDqVEU1U0PB8Zosvehu0RfCeq/R6UsKQbh6su6Sb0hLgM
         9mm9HZuZnNdP0fmtXRLN9XLMepkDHe697HWK7AOMIM3tin70YwEYbaJyED2B3zqIm0vz
         H6MP2AN9gL0pQAf4u6Jtt3vIMUlkseg9zE0VGwAo/fajxhUrpZBdJjPPmaQeTwj3RNiq
         RLcA==
X-Gm-Message-State: AAQBX9egiSZhNZ9sWfJ57AldZPcYuyhTZpxB5/71LMglulBhGDhvZlsh
	6rvIWtJyGX4OmCoM3pnZ78FKCxYFIW4oYW6XnDIYk8kK
X-Google-Smtp-Source: AKy350Yc2dCobZNSq4LG8iNJXt5z2lv9UFypY0vImDmFOSa46e7YeIIEhYzkSzLjTrgFO42fLXk0Qg==
X-Received: by 2002:a7b:c7cd:0:b0:3df:e6bb:768 with SMTP id z13-20020a7bc7cd000000b003dfe6bb0768mr2408444wmk.24.1680620176718;
        Tue, 04 Apr 2023 07:56:16 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c228300b003ed2384566fsm15413333wmf.21.2023.04.04.07.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:56:16 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 04 Apr 2023 16:56:00 +0200
Subject: [PATCH mptcp-next 2/2] selftests: mptcp: join: fix ShellCheck
 warnings
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230404-mptcp-selftests-join-busybox-shellcheck-v1-2-65892428a951@tessares.net>
References: <20230404-mptcp-selftests-join-busybox-shellcheck-v1-0-65892428a951@tessares.net>
In-Reply-To: <20230404-mptcp-selftests-join-busybox-shellcheck-v1-0-65892428a951@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2487;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=AFtPkbP1aEl5H/rYhq3uc7l/goofFCO9VXue9lU9uqY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkLDqOfT/zGoqZMUFnorzvTQ2aj2eCL5F4ufY1X
 K8J56XbpwOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZCw6jgAKCRD2t4JPQmmg
 c9sZD/986r8aK++udkPr0jS/A7aPseDcgju83nHsPM7ITODr7FiBYRAsXdciqWOzUJ/l9P7KaBx
 ZHvp7ZIagYWVxcCvpazRo2EJjWFxModIUQ2s6IYeAJcKspD0NtHWlckdAdAfI7ANFqU3E6YdnE+
 w83t4/sJfo5Rvvg9HEzNbNcvOBZVxwnW1HMsxBTnUXic888VQmhnTc4EbcaSi9liLzX7XF1WWO6
 VSA19kGBUcPt9FmqQj3MvWv15HvxBLYyQKrDZGvIQdR7uRclxpjH3/iChzsrEl0US7ImkVKeOj5
 k0SCANkLr5XzsFzRcdKsnqRgqxYAKjyBu6zKSAXR7C0F4wTYUZhaX0UVUvDcITh9NmxKREmLfrr
 KGIRTu9sEVzt+dd54Z7Bw5fuhzJN9oVNp2Xfxo8/zo7TMb5AHTreU9SABdFb0ldt3xhe1Y0BZdK
 uiU/1JX0XUVzUHxeJACWiPuwdDjXu+pmBegC8XnmdI2VF1eCWAIx9AHUkAfwGMmTXMijICO+Rz+
 lSwkuwkHL4SURiH1a+3zbQYzVnsuEG4aN7/E514iuvUf/y+s6/tFcuqXIIPqkHDetbqkaskjyiX
 8d5gdvzifduR/5MSWldEu38SMh83hbCrpNJk9He2/hSLPfkmCHfnUXob5c4MmyYJl2hyTt/O4DC
 g+JKsJq0S6Fuvww==
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
index b0b0931379b3..c18981c8f172 100755
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
@@ -503,6 +508,7 @@ kill_events_pids()
 
 kill_tests_wait()
 {
+	#shellcheck disable=SC2046
 	kill -SIGUSR1 $(ip netns pids $ns2) $(ip netns pids $ns1)
 	wait
 }
@@ -1706,7 +1712,7 @@ chk_subflow_nr()
 
 	cnt1=$(ss -N $ns1 -tOni | grep -c token)
 	cnt2=$(ss -N $ns2 -tOni | grep -c token)
-	if [ "$cnt1" != "$subflow_nr" -o "$cnt2" != "$subflow_nr" ]; then
+	if [ "$cnt1" != "$subflow_nr" ] || [ "$cnt2" != "$subflow_nr" ]; then
 		echo "[fail] got $cnt1:$cnt2 subflows expected $subflow_nr"
 		fail_test
 		dump_stats=1

-- 
2.39.2

