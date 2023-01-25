Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41BB1C33
	for <mptcp@lists.linux.dev>; Wed, 25 Jan 2023 10:48:06 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id k16so13414652wms.2
        for <mptcp@lists.linux.dev>; Wed, 25 Jan 2023 02:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQermjS6R/5XAyAu5/q5M18B1G6CnrMggCM48+JT+NI=;
        b=ggZDxTUWMIwQvaTBH2CZcOfeTvRCdWuADNjhZcfFap1M949alWd3/4b9fWRaM9tH1K
         ghQ/wiXkjQKkZaq/i1aeftBsmFznh7bBBzvn+MJ8sNwonGzt48c19jki/2guEt7Zl/25
         /stBVVIg8ei84QtoHPZs9xXShdyrNwFf96apttX9xHyDpE1apgQSfRrT/bTYd0/fHx70
         uRvdUVvZwUrm+ZDVVB4ZzyRDka387efi+CFChL0oUzjjES2yU6fb51fbF4WLNjSJGnvh
         eNKEo5+ik/vQSQlj6mKcYkUlDj8Trdbd1cfUiqolXdu00896na0LxaRi7PjgMYFHKRKm
         zjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQermjS6R/5XAyAu5/q5M18B1G6CnrMggCM48+JT+NI=;
        b=sRiZ5Bx8bSkMf1nHa3Q5x+tg7VJzzlGBFh4rUrhrHmWthsjMNspBJb9JrIpNKd5q9h
         oRP5Is4zBUqYbpwZcgdJ/F496aXA0qypdFHJc3YLsTsvUWCQzHtq8kaJPa/cvFPsSUXF
         TbcI4t0//Ct4htX7gzpH9fMM37GmPmvxEjSIsmgWxz2TKey3w04xq2LqSYc43HaRv6Z0
         605X/n0vbKBo8gH0DnWmGP57B4XpB8YE50Y1F7CMie6s1Xl8WDsQpsJtXqCKqsKWA587
         qkMpEwLXda6DZiNgFuXYY2qna4DrN+o2I1PoEcqX1AuBdpPpScTMZBzGmIev56pAucXN
         eRHQ==
X-Gm-Message-State: AFqh2kr50REwkewWXmMK6dy/aaI6eaAnqfAcuAup1tt5flGDA+pbBDRn
	P3CrpSwwZwBeNTxKnLgYOnELfg==
X-Google-Smtp-Source: AMrXdXuui7o5XomraQFAlr7lyLVPyS9M6wBZA7G6RnRCu1XS4gQi7YwZWKtbpcdx771dtX7zXn5UIA==
X-Received: by 2002:a1c:6a10:0:b0:3da:f665:5b66 with SMTP id f16-20020a1c6a10000000b003daf6655b66mr31652426wmc.6.1674643684973;
        Wed, 25 Jan 2023 02:48:04 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id r1-20020a05600c424100b003d9a86a13bfsm1423692wmm.28.2023.01.25.02.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 02:48:04 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 25 Jan 2023 11:47:26 +0100
Subject: [PATCH net-next 6/8] selftests: mptcp: userspace: refactor asserts
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230123-upstream-net-next-pm-v4-v6-v1-6-43fac502bfbf@tessares.net>
References: <20230123-upstream-net-next-pm-v4-v6-v1-0-43fac502bfbf@tessares.net>
In-Reply-To: <20230123-upstream-net-next-pm-v4-v6-v1-0-43fac502bfbf@tessares.net>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3530;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=m1DWBx6mmyT/LHJ7/zf16MtXVb6plkJtMvBgtaF7t54=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBj0Qjd5OjtyhttPPtPx2kgV8v1cOHuklyXsgPTPqaO
 kigK4kWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY9EI3QAKCRD2t4JPQmmgc7nHD/
 49UjDr+Utp/YdqroKfnfrSFLdVtSuMSge9A7+yIwV+68DIPDNtUQU/I6i5q1+OBPjJWrDcN/Acxnt8
 e1E8IMVlIZi0uGk/YeJ+h+HXPLfjFCU0zEKBRe0pank5fJ3aAo+YWVoFf9faGJY8/OM8QxjLmpaFa5
 2aD/M8K9itFbM+xvYpCrwZvsTnt8x7E1ybRFhVw7l9chsz5KPL7jAmtbVmxgLC/5GidpnKGDhbCxDY
 w6b73VjH6fZYE0GBXl+8DMvJ8dMlz4UciuitK3Y4J564eVqCoMGZEDB0ZUSZ+ZX+V+m+AYl58TMS4N
 hZ8WeT05bvrS4KZe+WVlY70VnhgdkOWUGy8zfEILGZa3MZIgP0kHnWah7k8mR0JMB8GieqG03bv49d
 +wCH/o6oHY7ynAS+YU0EQknUBGvClWrn24znxEaDn+iEnTKBiToJ9fKt8YgRtsIzsL2SmmnHU/Bljs
 OUTWMrny1oYS/QugaFp+45h+BtbXvWrrCE28T2m/yj/F7+EadqZU+zmO0USriKT5CocAax3poLy8Dt
 wSDjmw0FQvQ5I2C/LEVjsumQ2BFeUafewPL8qNjmWkZV3KDw6IBdA8MyahWahWH8d6LIhNaF1qh6wv
 xlmLHW451210sfawI+uU29kOSGaT9kT12S9ATD+F+Gf17AQ4NpnUAtPbyr5g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Instead of having a long list of conditions to check, it is possible to
give a list of variable names to compare with their 'e_XXX' version.

This will ease the introduction of the following commit which will print
which condition has failed (if any).

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 72 +++++++++++------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 7b06d9d0aa46..2f2a85a212b0 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -225,6 +225,36 @@ make_connection()
 	fi
 }
 
+# $1: var name
+check_expected_one()
+{
+	local var="${1}"
+	local exp="e_${var}"
+
+	[ "${!var}" = "${!exp}" ]
+}
+
+# $@: all var names to check
+check_expected()
+{
+	local ret=0
+	local var
+
+	for var in "${@}"
+	do
+		check_expected_one "${var}" || ret=1
+	done
+
+	if [ ${ret} -eq 0 ]
+	then
+		stdbuf -o0 -e0 printf "[OK]\n"
+		return 0
+	fi
+
+	stdbuf -o0 -e0 printf "[FAIL]\n"
+	exit 1
+}
+
 verify_announce_event()
 {
 	local evt=$1
@@ -250,15 +280,8 @@ verify_announce_event()
 	fi
 	dport=$(sed --unbuffered -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
 	id=$(sed --unbuffered -n 's/.*\(rem_id:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	if [ "$type" = "$e_type" ] && [ "$token" = "$e_token" ] &&
-		   [ "$addr" = "$e_addr" ] && [ "$dport" = "$e_dport" ] &&
-		   [ "$id" = "$e_id" ]
-	then
-		stdbuf -o0 -e0 printf "[OK]\n"
-		return 0
-	fi
-	stdbuf -o0 -e0 printf "[FAIL]\n"
-	exit 1
+
+	check_expected "type" "token" "addr" "dport" "id"
 }
 
 test_announce()
@@ -357,14 +380,8 @@ verify_remove_event()
 	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
 	token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
 	id=$(sed --unbuffered -n 's/.*\(rem_id:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	if [ "$type" = "$e_type" ] && [ "$token" = "$e_token" ] &&
-		   [ "$id" = "$e_id" ]
-	then
-		stdbuf -o0 -e0 printf "[OK]\n"
-		return 0
-	fi
-	stdbuf -o0 -e0 printf "[FAIL]\n"
-	exit 1
+
+	check_expected "type" "token" "id"
 }
 
 test_remove()
@@ -519,16 +536,7 @@ verify_subflow_events()
 		daddr=$(sed --unbuffered -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evt")
 	fi
 
-	if [ "$type" = "$e_type" ] && [ "$token" = "$e_token" ] &&
-		   [ "$daddr" = "$e_daddr" ] && [ "$e_dport" = "$dport" ] &&
-		   [ "$family" = "$e_family" ] && [ "$saddr" = "$e_saddr" ] &&
-		   [ "$e_locid" = "$locid" ] && [ "$e_remid" = "$remid" ]
-	then
-		stdbuf -o0 -e0 printf "[OK]\n"
-		return 0
-	fi
-	stdbuf -o0 -e0 printf "[FAIL]\n"
-	exit 1
+	check_expected "type" "token" "daddr" "dport" "family" "saddr" "locid" "remid"
 }
 
 test_subflows()
@@ -881,15 +889,7 @@ verify_listener_events()
 			sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
 	fi
 
-	if [ $type ] && [ $type = $e_type ] &&
-	   [ $family ] && [ $family = $e_family ] &&
-	   [ $saddr ] && [ $saddr = $e_saddr ] &&
-	   [ $sport ] && [ $sport = $e_sport ]; then
-		stdbuf -o0 -e0 printf "[OK]\n"
-		return 0
-	fi
-	stdbuf -o0 -e0 printf "[FAIL]\n"
-	exit 1
+	check_expected "type" "family" "saddr" "sport"
 }
 
 test_listener()

-- 
2.38.1

