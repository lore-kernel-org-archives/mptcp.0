Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028B863B9
	for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 18:21:45 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id tz12so33576008ejc.9
        for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 10:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7p7LMcZCr67MTI56xnF3QP0ztYrIwIPiTqDadCdDv0=;
        b=f9oTr8jHD+eWn9Gp6g4W3R3NZiKwhmixLBQ1Sb7kj1Qcoqx2R+hd/qLnaIrHqSllrQ
         Rb2aSlbDEEHSMVzxGwgKCSuICqfGhBfG2HszmfIjHK1GTeIOIDbPpG6W6cdZ5b1b0Wbh
         BQL1u6W5yPlUPJ6sl8q6D+O6scplqR9hlL7UADrlZWWIWu3XmasESYE4ncirhw/qxo/7
         ZvB+2FZ7C0p5leOZ46eMvwxi2Lus5CL7IKFJeO3P6hoeYN0nHdE7eZjOBPslFtNDMNR8
         wn/YbXlxQ9orcLsxixRxI+ruwbrjVvEz1bD3dV4esg9SqL0mg3lFtDqCX49HRui1dgcF
         J3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7p7LMcZCr67MTI56xnF3QP0ztYrIwIPiTqDadCdDv0=;
        b=vNEufXjjgNYMX26ua5fKvlDTZ138J/O7EQekBSCt6R05Met7D/yhUBUODaZ9axsIu1
         8andHv1UVfB3rpHU8Yy5H4gp9/0uMHlu5tqoTDyrUkYVTH+7roqNujvL62+8KLeYVftN
         hkLD2rnpgq8BF79gnZfuJrHsxiCn2ZEvjftgy4tjnPSP6rDreIlkHIZiS3Kbw2Jv6hVB
         AN8aZlOavPEQPTx7YK2vQtJzio+PYqd5jt4dXOYfppEivSR0/jOXYnTdwgeliou/Qz3l
         Fhoi9mSwBCwuosigYK4rwg7kezMSd+TEefmlYCGy6jfG7y7ByYf3HsJvunk7pEqGRk/M
         R6Ww==
X-Gm-Message-State: AFqh2kppxYtWKXnvcUBESME7HbiycPnL39kB7ieaMmdhYG7iB1YYUyWC
	SB0IkFIz/OT1bfeKeuIWfbucoEHLOMfBu+1yqGEHAQ==
X-Google-Smtp-Source: AMrXdXshP6WJk9LIlaS2rU4tA01+4etIC7sS2ji5vvlMaf7CCoxRibcN/UcuJTOXK9s0KPE4jnHAbA==
X-Received: by 2002:a17:907:209c:b0:7c1:41bb:70ac with SMTP id pv28-20020a170907209c00b007c141bb70acmr18460498ejb.64.1672165304078;
        Tue, 27 Dec 2022 10:21:44 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o17-20020a1709062e9100b007bd9e683639sm6336612eji.130.2022.12.27.10.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 10:21:43 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v3 11/11] selftests: mptcp: userspace: print error details if any
Date: Tue, 27 Dec 2022 19:20:57 +0100
Message-Id: <20221227182057.2288816-12-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221227182057.2288816-1-matthieu.baerts@tessares.net>
References: <20221227182057.2288816-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3188; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=jgD8NFThY1ikqtaw9FfAvbwdd1OEov8zgqa4cyP62jg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjqzd6BXB2UR97OAt5No0hcPS/ZeAOpL42vhKu71zM
 7+h5q82JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY6s3egAKCRD2t4JPQmmgc1F6EA
 CsLevyvMgHwFU0TTuSN9AHhdTtjEHvAi1eZ16b6wM4fdkzfI3aK2t90bsUdOotBSqVLttaUznc76mX
 xVgfIF6xR7gwvAfBQ15d1w8L4k2Or/0Es2hO/xlrB7sHiqNPn+D7dNms8usL8M2aC1XDjmuy8S+BoH
 Vo4+h465pbp8ebVoqF+lA4HXucKk2qal8PXtDM60smhBmrzJlTA+xT8rwvFvpynCFRhHQPyUiVkUjK
 nIAvTnSv6E//X1/rVlAG8jz7aOUG2XevpfTIrRKFb/dYN1sNxbEv6Xel1+CBOjIq3kOMpDWcNDtU0t
 IBliETJ/9+xh4qYjaYhnYHmioJay9Er4SwNaNzD27vCHAxc7tbeNSwZDNnZTQRE7QZW0Sx5jqLQK7h
 Dz+t3v83F5NdEvMrxmXhqkb9RY0bmfz1RF3JNnjPEvbNiQMBDu2+BQG+NuICt8QpwfvZqHD2VNQyTy
 YfEpeJlk/xI/hWgvi1LiQ7kMC5gbV92kQAKEc+b/1h2lNR1tFhKKZNVYIFu0U/0A1Xwv3gORB38T+0
 f8v/9wKDRZHZoRb2aATeQ8eIBj1768m+3Kq9WC+mlAOvN26YZLhBS1sZWJoH2O+woOSujq8x7U4K6a
 OASol+AjQgO9+R6JROodAFA+2A8dA/qiPaDtMHgppSLASSSP/zU+HO67ObJg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Before, only '[FAIL]' was printed in case of error during the validation
phase.

Now, in case of failure, the variable name, its value and expected one
are displayed to help understand what was wrong.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../selftests/net/mptcp/userspace_pm.sh       | 33 ++++++++++++++-----
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 942b1b341c5b..f38ceb1346d9 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -199,11 +199,16 @@ make_connection()
 	server_serverside=$(grep "type:1," "$server_evts" |
 			    sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q')
 
+	stdbuf -o0 -e0 printf "Established IP%s MPTCP Connection ns2 => ns1    \t\t" $is_v6
 	if [ "$client_token" != "" ] && [ "$server_token" != "" ] && [ "$client_serverside" = 0 ] &&
 		   [ "$server_serverside" = 1 ]
 	then
-		stdbuf -o0 -e0 printf "Established IP%s MPTCP Connection ns2 => ns1    \t\t[OK]\n" $is_v6
+		stdbuf -o0 -e0 printf "[OK]\n"
 	else
+		stdbuf -o0 -e0 printf "[FAIL]\n"
+		stdbuf -o0 -e0 printf "\tExpected tokens (c:%s - s:%s) and server (c:%d - s:%d)\n" \
+			"${client_token}" "${server_token}" \
+			"${client_serverside}" "${server_serverside}"
 		exit 1
 	fi
 
@@ -223,13 +228,26 @@ make_connection()
 	fi
 }
 
-# $1: var name
+# $1: var name ; $2: prev ret
 check_expected_one()
 {
 	local var="${1}"
 	local exp="e_${var}"
+	local prev_ret="${2}"
 
-	[ "${!var}" = "${!exp}" ]
+	if [ "${!var}" = "${!exp}" ]
+	then
+		return 0
+	fi
+
+	if [ "${prev_ret}" = "0" ]
+	then
+		stdbuf -o0 -e0 printf "[FAIL]\n"
+	fi
+
+	stdbuf -o0 -e0 printf "\tExpected value for '%s': '%s', got '%s'.\n" \
+		"${var}" "${!var}" "${!exp}"
+	return 1
 }
 
 # $@: all var names to check
@@ -240,7 +258,7 @@ check_expected()
 
 	for var in "${@}"
 	do
-		check_expected_one "${var}" || ret=1
+		check_expected_one "${var}" "${ret}" || ret=1
 	done
 
 	if [ ${ret} -eq 0 ]
@@ -249,7 +267,6 @@ check_expected()
 		return 0
 	fi
 
-	stdbuf -o0 -e0 printf "[FAIL]\n"
 	exit 1
 }
 
@@ -301,7 +318,7 @@ test_announce()
 	then
 		stdbuf -o0 -e0 printf "[OK]\n"
 	else
-		stdbuf -o0 -e0 printf "[FAIL]\n"
+		stdbuf -o0 -e0 printf "[FAIL]\n\ttype defined: %s\n" "${type}"
 		exit 1
 	fi
 
@@ -835,7 +852,7 @@ test_prio()
 	count=$(ip netns exec "$ns2" nstat -as | grep MPTcpExtMPPrioTx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ $count != 1 ]; then
-		stdbuf -o0 -e0 printf "[FAIL]\n"
+		stdbuf -o0 -e0 printf "[FAIL]\n\tCount != 1: %d\n" "${count}"
 		exit 1
 	else
 		stdbuf -o0 -e0 printf "[OK]\n"
@@ -846,7 +863,7 @@ test_prio()
 	count=$(ip netns exec "$ns1" nstat -as | grep MPTcpExtMPPrioRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ $count != 1 ]; then
-		stdbuf -o0 -e0 printf "[FAIL]\n"
+		stdbuf -o0 -e0 printf "[FAIL]\n\tCount != 1: %d\n" "${count}"
 		exit 1
 	else
 		stdbuf -o0 -e0 printf "[OK]\n"
-- 
2.37.2

