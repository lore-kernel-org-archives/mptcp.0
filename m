Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F358EA4A
	for <mptcp@lists.linux.dev>; Wed,  4 Jan 2023 17:16:02 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id i9so49471172edj.4
        for <mptcp@lists.linux.dev>; Wed, 04 Jan 2023 09:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Effoef+23AA8q569t3z3FvYJYTOw8TADOT4dKKnnPz4=;
        b=ykcK8oLECEUEtxW+A4h+ziCVqMUKRBV5ZyUGec1LhZdfqyKayxQcLkUz2odLy/UIva
         5rjFgI8rb2LhhP9F6Z27fKSb3c38f78xhrrVnljtMPasWmc1khaiGT0X1fggASzh3NCm
         r/SIz7WCuvVSB7Dksqz5iIkIhHaa2Gsj9oLBHN9UTpVo2rQjMsGxwlU2jCvRwXlCiujP
         LGOxcRC2PwlwDC9HEqmqANilEfuRQZKapAe9jMejN+is8MXkNHtDHBbvkeoU7Ar9YM+C
         JSIzR9H1hHKWPQIVTLaPe7tx1FzQoFkiM/V3s889wlMrdTbzSvjEf6ibNlR+j9LMqmNj
         BXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Effoef+23AA8q569t3z3FvYJYTOw8TADOT4dKKnnPz4=;
        b=MmBTivYANveEGXxuYMSPevtyuE7uzBRbdCzaFWXSopVuYLteLDC5m713rb6JSfM+tW
         TL0bts0yS4qUluDnIuw7T+7RBm5a8N2ebMxRQN0/D3JhWOp/wbZwytrltkv0N4C79fSz
         Qlf5ApJ6gtaxZMfevl7TCqlUz1UQ1XV3N+E/pL8dPfSRZV8Kfkn0TqgWyem8tSh28FyI
         lnO4CLV/FF4HHLYkxxqMmjDpeMfDnXAGG2/I1ZyN+telxgZDPRoS4kmkkGsYwlkX9VKb
         9bwKnlSLCM5YPaDrEi8OWDIAu94LYVEut5FZtqftlmlUal3/oqahT5JJARJ+8rpBamXi
         KVPg==
X-Gm-Message-State: AFqh2kqo8vekZntkBRORVQF+0m/W456A18BpTGt2iBYvi1qZ5BZe/xtn
	/bSjZ4EpHIyf0W45T+p5Nt8t/4Lu9wqxyNc3cWQ=
X-Google-Smtp-Source: AMrXdXuUj71Qv1oY1UcYVqBlC1PfRzc4wjF0kOieC5RZMy5FAQUURD6+250six2CJBMBCoYvjYBsUg==
X-Received: by 2002:aa7:da5a:0:b0:48e:f12a:2986 with SMTP id w26-20020aa7da5a000000b0048ef12a2986mr3520144eds.14.1672852561072;
        Wed, 04 Jan 2023 09:16:01 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m11-20020a50cc0b000000b00487fc51c532sm9258074edi.33.2023.01.04.09.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 09:16:00 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v5 10/12] selftests: mptcp: userspace: refactor asserts
Date: Wed,  4 Jan 2023 18:15:24 +0100
Message-Id: <20230104171526.1416746-11-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
References: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3455; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=ROj86lyIiRGetvyo5Qdh6lfFZ8/hVlMOitwP1IlR0lI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjtbQIas0W5dDXxbQ4x96m34zESntwoRlmPRbqg4Ye
 COC9rKiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY7W0CAAKCRD2t4JPQmmgc2JPEA
 C+V87PzIupZJx+P1z2dlJMtUPAV+zkRgKVpXalDcEynyf1SmPBlwCtk2ejSLsCu78z33DbOXt6V3dj
 Xz6ITJyXn09hbgvYQEz8BcNa0XEcdbee9tyD4WFhXag9+tyxLw3zzSuZkdRYxZxOttzju4IaJMA+ZZ
 JHApNuEy3utxF3LS6MEBC+GqPOQhnxETe3Bp0RlM5SLhwnVBUgf4ZRpsJV61Fd/40d9TVqERRvHj7A
 h9wuo71rs8SSevNqe/t9I4Koox1lqNWyAreXO5Z6Ku9hztW9GWXjf4mFEA5bVVsCtukEbCdoCtgCn1
 /GNUXeEqkMNsc3Co94tpRVg6bBRDjFMyYIfLVDKj8YwJoUY4WFSDvDo7Woe+pZ3K95+RnqJ8MFKBs8
 rwdkZfKzZKYedC5H/vwTZHBinnZ6tCobxqpauaD+h+AvvmCQuEWOBRTUGbkzD1hlvpGb2TeGhRNSqb
 U7bO/FShwaeqrtsby7egKhDDBxkic7nqb8qTdpq4grmYODZXC/jqOxPwoe+a6BiDgoaEF/Vqp9NgKR
 uz7aDIVuU41V3gJjks7Lcvo6jNC8Tn8vNN16IDvREblcXYtLftqc9s3gpX6dBg/dRiE4hVDkItX8ci
 Xj95HxjX0lUFQ7vgACuavOIcuME2BJveQsbVylHkZ3QU/Cuq84dSxKiil/ew==
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

