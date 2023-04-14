Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DEA322A
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 15:47:26 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id i3so8660527wrc.4
        for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 08:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681487244; x=1684079244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qzxt4XcM4tuKu37taRV5Ugjl1Cb3GZa6ByEPKZjvm68=;
        b=insrqgRzM5WggRlz8B5pv0UziSsf4Bk9QYU+AO+KzFAuqcBNEQfCS26+Tj+MjVpCPL
         uP4cMmOfcMIkznI9FbQi2i0ZqSSx1UFKdWnalX1Ug6m5PBIPJDQIFphg7yUxhEV2ivcD
         M9ofn6TCMlSEDu2NlD9l6W0zpNmlqjPG48oC5E9h6qNkuvq8EgkhkTf0ug4ZxZs7KyJ9
         meB7e6gdS6S30/zAYV20930f0NRg/RqDN2wYo0qD2BrPx75U4pcQEcZUotJ2Zm55CSXX
         IO6Jt3pvubJmtlv0lwzX8KuSBplshzeXLXRhQOuoEs50g6VBfAqoL9gGomBhW4PAPCn3
         seLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681487244; x=1684079244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qzxt4XcM4tuKu37taRV5Ugjl1Cb3GZa6ByEPKZjvm68=;
        b=JNqqf5Wb3HZyd/GX8qu3yhImtVMTD1ZiMH8zwPAxwZHP2TzjwQCxTwNS5TvV9aF6Vc
         5wvQNXH34H66rX5eyVKsniCT9zXrNL7at+edb964V6pBMiBr+otwQ4kA+N4ihY93xxUc
         RQcfo6sn2Iqtc8qO7tg4f+U339qOJ1Nl0+dsxlVWiw8CFoFJOZHU4rzKYDmxnrdHq5lO
         ZUF0Vi9YsRlIeQAuCQToPx4DumByjj8WKoU1ZmXgWazzkLCAOdN+BqE3f6YfSmQ6ltH7
         0x0RvWfw6hMz3QScz9l0LTZQaHZoEL0xpi5nv/9Nhs4HAYyYqaJRcXemzZZ5lc7VHnM9
         MkUA==
X-Gm-Message-State: AAQBX9dEACdI1YOPDH0jT0AFVstbRPB4gk0P1g9RXxrFTfqzBIxYuuYv
	ManfSlEzgI5dQbs5K0w2DT4Kcg==
X-Google-Smtp-Source: AKy350anVWsEzpcDQkwD4VfavS5OSXHWMTLonpGNhq7ef7wjmNN7vxgvbaWECHBpitBCNgJ0zo4sNQ==
X-Received: by 2002:adf:f709:0:b0:2f4:e8e3:ef62 with SMTP id r9-20020adff709000000b002f4e8e3ef62mr4561531wrp.65.1681487244500;
        Fri, 14 Apr 2023 08:47:24 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id x2-20020a05600c21c200b003f149715cb6sm1034298wmj.10.2023.04.14.08.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 08:47:24 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 14 Apr 2023 17:47:10 +0200
Subject: [PATCH net-next 5/5] selftests: mptcp: join: fix ShellCheck
 warnings
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-upstream-net-next-20230414-mptcp-small-cleanups-v1-5-5aa4a2e05cf2@tessares.net>
References: <20230414-upstream-net-next-20230414-mptcp-small-cleanups-v1-0-5aa4a2e05cf2@tessares.net>
In-Reply-To: <20230414-upstream-net-next-20230414-mptcp-small-cleanups-v1-0-5aa4a2e05cf2@tessares.net>
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2487;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=5FlU9MokKUitrXSC9YGwxuWrLrcBCHiaj46QcbM+33c=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkOXWGyZxITuXwckR3HbIuXnkVm7W+wSc67dzLx
 OqLJqwqrtuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDl1hgAKCRD2t4JPQmmg
 c/XiEAC9N9r9lk1IJXEOk06iElSNPd4XvWvMdxKFRC8a5fiRwKfffWvBq83xIqjvPN6lDECghch
 CfAefrERTjAFWIxCED0YwWTaJVZPL7CTRv3gVQsmtwCmaJtkS9GgsHxdL3r0RrUfjRqH8ut/Qny
 K/3m2zTdH1tg/2vBHB/Dr2ojGfwPAQnyLoxtLKk58CFZkTgSGshZx66pjSYvoCM8HsHwx7fRi7r
 DueOR1eS1vGOO4aupDJApFqpDG/ezuNyrOhWfwpoQZX4eTYzky/g2ZHB1m+tjgvgbZc5898o6D6
 j+Sw+5c/8/1EM5aZNcI3uQcIFgKFXQTFddSfuZn79KzBAdeo8qgOAUVzlLmz5fnJnqTaZiiJprD
 bjAQ01Yf0ADWyNM90DBOXG3GoVRYZdixwj5d6zGUmA81erWLFSChK34SDfulHISMbOvWjT5GXeX
 MRlzifdNAhXKtTbfm7r9zSg7lxBNdnqToMZnN07LX+DivSlR+tv2pjmK9k8P1fg+NSVRQrRo4IG
 YaMd4dgNsCCOdwzdic3nkmOvjfx5o6wyO3dLBBE8eFcwW3dLXQt0DRe3rRMN/ocQdWG3DUV4Pcs
 WRDOlOMJ4rBMfbcKDo4UkHyKa2pWSLiAdqztAQCLdUVev7wt3mfFKi8o6SGxzNvMjIDVEhwA/pa
 TCyicSCBV6Qm39Q==
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
index fafd19ec7e1f..26310c17b4c6 100755
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
@@ -500,6 +505,7 @@ kill_events_pids()
 
 kill_tests_wait()
 {
+	#shellcheck disable=SC2046
 	kill -SIGUSR1 $(ip netns pids $ns2) $(ip netns pids $ns1)
 	wait
 }
@@ -1703,7 +1709,7 @@ chk_subflow_nr()
 
 	cnt1=$(ss -N $ns1 -tOni | grep -c token)
 	cnt2=$(ss -N $ns2 -tOni | grep -c token)
-	if [ "$cnt1" != "$subflow_nr" -o "$cnt2" != "$subflow_nr" ]; then
+	if [ "$cnt1" != "$subflow_nr" ] || [ "$cnt2" != "$subflow_nr" ]; then
 		echo "[fail] got $cnt1:$cnt2 subflows expected $subflow_nr"
 		fail_test
 		dump_stats=1

-- 
2.39.2

