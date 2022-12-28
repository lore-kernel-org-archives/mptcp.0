Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83851117
	for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 10:18:15 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id bj12so37342640ejb.13
        for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 02:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Effoef+23AA8q569t3z3FvYJYTOw8TADOT4dKKnnPz4=;
        b=HkSlbjC+2oOKM7wGdhsVqDoe3GtLLsecbh2Foq54jPtiUu4stGLn4BJrY3YwlfIkfJ
         dmSVEm7WF09WzYq3lIv/+jc3BCB34nejHt29TPV90e7a0pBFdIeo/QN61LJQ77W/ibFU
         9Iy5Bhh093IOAhJrfVWpy95lsSvJ0HlluYUqhJqU7lppzcjU4EQxLcCxM56r+8TUEfXV
         GOcrDHx0v9TOcfuCo+s5wyXrxQXbw1iCfGzaL3dgp/vj6n126ylC/E6UOb3U5MqIS8er
         lNm2PZRw6bF39cOzfH4q/ts2MoAByKQx4ay3+HhHpSYSTxV30vDijtpw1maS9FT+HxbV
         oKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Effoef+23AA8q569t3z3FvYJYTOw8TADOT4dKKnnPz4=;
        b=xbmqsziWdQqRsjHBDSCTzGirkFp20au4nVvVUym0vQBP0skei1dlSzr+Y3MZMxfRdd
         b2NH4SVwjOP7AQSIPjK6sW1qF2qhp8CRsPH9M5cJQMTAdv1X2pZb+5WvTK7416H04cSw
         slZLyJHFCxBEAIB66txqM20Ex96HTv0BND+GObim3FKYuB1pZZkAd+lBycHUzH4seHfG
         ND9GDyxPS5soCLQc6SFRQVoR2azYEyEZPWdJ3aE0rjlsArRqC2MxTq/k082igMTXf9mo
         K9R8kgTf3bUqZu92h0OWMt5ME0uXgm3F+wiv3RxICbFdyD1YngZAXNgX8QzclPSbnLtP
         RUKQ==
X-Gm-Message-State: AFqh2kpXhpEainptLCSYqybj+8oa5WPRJAenWDt9vF6z/IOT3UwOk32H
	2hXeLlrwazrf3217nA5JWMJ3XxfNIDfQ7ECttdl2sw==
X-Google-Smtp-Source: AMrXdXuSZo2QVmw7aoBlXwe9Hf5jA1o47j9GC8IR1ZfFn3oKhcogNr8SzDYIWApsawiQ/MSeMJGCCg==
X-Received: by 2002:a17:906:d96c:b0:7c1:7cc2:1f1e with SMTP id rp12-20020a170906d96c00b007c17cc21f1emr24478259ejb.35.1672222693933;
        Wed, 28 Dec 2022 02:18:13 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090676ce00b007ad94422cf6sm7174127ejn.198.2022.12.28.02.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 02:18:13 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v4 10/12] selftests: mptcp: userspace: refactor asserts
Date: Wed, 28 Dec 2022 11:17:46 +0100
Message-Id: <20221228101748.2518303-11-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221228101748.2518303-1-matthieu.baerts@tessares.net>
References: <20221228101748.2518303-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3455; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=ROj86lyIiRGetvyo5Qdh6lfFZ8/hVlMOitwP1IlR0lI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjrBe/as0W5dDXxbQ4x96m34zESntwoRlmPRbqg4Ye
 COC9rKiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY6wXvwAKCRD2t4JPQmmgc7HcEA
 C5TDH2eUJhO04TNyv3dgCQcVAdG+BfyLZUA62O8p06iUWyF9FmIZiKz1Clk4AI6mNWP2xDWFiSEqGM
 I8YRBNWFYORysIi3wCxpSrKJVp6DoZDtE+bzNZsQjamCdfKtzDA8/RDrrU20qP9ez9zHgBVA6n9gON
 0DnBHO+kGZvuMHlfGXRv2wmSeHzywhbfaMdTwI5r6xfedTlXfpSEUEkkxK7VCpTnpB2SU8xnFL9ADc
 Nsr3Qu7BFo9eKxMNMppnhpSOiyFVqn5Qv58dhhVIqWsvGChXgqKS59ObrxotjQYFoaXyUwAhoOWBmy
 vSE5EseLcKBds7ufzEzULvv9rM10wifX5fyXXRWim9gwTwmJ3KCUELpXeZ7cK+f0iAknLIllSyJIlD
 OpPtGpof5QPXnri5ABONpoRSfpXIb2lDobwMz3MmvL5QEI4UZX1eOpWd7ZL9ojAL/O5XeHuCqFSTIz
 /BP6RaIsqtbA2YvUf4dxJKbpaljzYV/UHN0ioVrBAlqZTRvQ0i9foO1nVj1wA7fxZFRhAzvrKWxkuX
 lyMiJvu8JzjGWZ/Z3xyzbnqLWOc6NIPUCX68MeCRAH+GvoIZ8xzLMvTHx6/y+cBAYHKugnNuY2dsnK
 XIm5tyCn18XFbMKTI96G68Prn4Rxs0WOToOFFWtBcRtrEYRt2vvYsljqlGdw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Instead of having a long list of conditions to check, it is possible to
give a list of variable names to compare with their 'e_XXX' version.

This will ease the introduction of the following commit which will print
which condition has failed (if any).

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../selftests/net/mptcp/userspace_pm.sh       | 72 +++++++++----------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index f9a03e6e968f..9edd1abcc067 100755
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
2.37.2

