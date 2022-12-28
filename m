Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B4010E9
	for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 10:18:15 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id u19so37368037ejm.8
        for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 02:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzgwuk3oT1wcb+cjhzp+JEGa1LQuxo5IR5KHlk0bApg=;
        b=TFMd+O3HD41iBX5zvkBZeAHjE79HXRsJB8hsaaDWQ5xVkbgjA6Sfmp/sKmCVEQb+HS
         qqK5zZzIOr7hPkNF2iRE989ahdMv3nFMakSizrkfLtLrkywNnXdV5eC7wraxkrSdS9zu
         /+bpqgdeTIbUNIVZ0YyH+BChBwdu4nRsxlVrEfplGSBocPR+avLjXo8LhRLEloCp1Xx6
         bbu5ASF0in1h+mQAMJGVzgMAStccVhcilDyE597fmI65oE5GVrBfyFrscRweVJC3+8Gk
         18x7uS8fr6EvWHD6Itpus8e/b07bXbHrZYjTE1ylSFXpUIAQRFGjzenBOBqCEeT+Snma
         dJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzgwuk3oT1wcb+cjhzp+JEGa1LQuxo5IR5KHlk0bApg=;
        b=w8nBdVTMw0ds/kMWPAfz6PGXDnTLmIXKZPua0BwSbFJiAu2mB7Hxyi+lbd21o5rfik
         1uAIxtmJM/1ZbaeIItLb/fl61HRsbTAD8GA7E9L4XRVgJ4oGRjyC1VHuzmEFJuooWDl0
         FCm8EzeC1oIy+/cNEC5aFeLqqhl5P3X4dF/QVtgaorKB7MHeiQMXwdOrhrvzH9KnNLfL
         WJYtgEJZ8dzpBsrYu65HOphb4pvARB6aJ/Wvc3wSFclQ3p5AOZzX0Cm/5u0gIhG63Ji/
         iXZprMtl83s6IB8fLcEukzLqMBuaU71U4ampv4slejwr3uKbyT4eFTMifC7YDl7uEY1/
         dBiQ==
X-Gm-Message-State: AFqh2koHrJEiuHTySao4khrpZ3H2NEMFrDbeFW8lAGN358GbRdvHxUwM
	w64tyDGcfwJKjBpRs8AKpQzFaSdP5iWX/oLvxT+stw==
X-Google-Smtp-Source: AMrXdXtTr0XEuRGF0x3xgjt6oqfWfkx59Q0uGXgSnrfeXEsKtUqS4fLPwbWYN5wBwcWHMtDR9FGDww==
X-Received: by 2002:a17:907:a08d:b0:7c0:dac7:36d8 with SMTP id hu13-20020a170907a08d00b007c0dac736d8mr21104174ejc.10.1672222694562;
        Wed, 28 Dec 2022 02:18:14 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090676ce00b007ad94422cf6sm7174127ejn.198.2022.12.28.02.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 02:18:14 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v4 11/12] selftests: mptcp: userspace: print error details if any
Date: Wed, 28 Dec 2022 11:17:47 +0100
Message-Id: <20221228101748.2518303-12-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221228101748.2518303-1-matthieu.baerts@tessares.net>
References: <20221228101748.2518303-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3188; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=rV/UnDzrHn8cTDUEj5YH6yx2iAn2csOj/Jmdg6Gtjas=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjrBe/K85ERLHf1zKKOY6N5xQQkTcCFBUQhZd6hU0e
 A6EQ49aJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY6wXvwAKCRD2t4JPQmmgc1pAD/
 40lLjdetukmV8USQ0jR4ep/+kArndp8+3eqdx6TLp0R45xYmFWmiRh+djQfOdsHtGNGaxr8RHY/Vi2
 UfWBVzlJcrXnLsWQWa04/LZBA2hboPgQRkkhMuGqZy6ELKic+We5EDPF1Fvwr8/LCOIofQYSSJkC6S
 C3bBoEGh/ukpWgvHYwGCJEOXLKGs15+1dYUCBmn8EAivbseC9id6rwhULD7bM+dmVvs49XBIqthxL5
 m6+bFRG8uDyblETqnSwlYr/hdheFZzmSNUb5kQKy5kNjDVisKBQPSV923VEqK0TqH/wCiqg2CEVAYT
 YxQdpwe4ZS/jpgQ9lMzNoAb30qAakPRJ5ca2InAo7xPgN2Q6TBjHs+NLYVl2E5ONtJMXcWjBhFGEYE
 Q++3X71bnLU6/SVzjfNOvQ61ehEyQIT387MsgrLSfZiAb230rUZas2SMlYWbaRxPf7aVIbS54vEUS5
 7md9NDzcQIZpNUWR73ohBXchfQyZ3JYzpOCK44R4T9+6Wu/fXu/FIqkS4MDy934BTVH/UsDI83QaTz
 HL7cLMkqY/qeSr2W4Cacje0XK0zNvWT0l1rltJzE1EzZtNNXpyzOVyMo2YCQq0RNjofFp8Zr1bWxD7
 r4xaMfINo8Z0rD3r4axkclg9xnR/tcJJon4UHHjgjONreSFhg6ID2stu8pCg==
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
index 9edd1abcc067..0bd35768c1aa 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -201,11 +201,16 @@ make_connection()
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
 
@@ -225,13 +230,26 @@ make_connection()
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
@@ -242,7 +260,7 @@ check_expected()
 
 	for var in "${@}"
 	do
-		check_expected_one "${var}" || ret=1
+		check_expected_one "${var}" "${ret}" || ret=1
 	done
 
 	if [ ${ret} -eq 0 ]
@@ -251,7 +269,6 @@ check_expected()
 		return 0
 	fi
 
-	stdbuf -o0 -e0 printf "[FAIL]\n"
 	exit 1
 }
 
@@ -303,7 +320,7 @@ test_announce()
 	then
 		stdbuf -o0 -e0 printf "[OK]\n"
 	else
-		stdbuf -o0 -e0 printf "[FAIL]\n"
+		stdbuf -o0 -e0 printf "[FAIL]\n\ttype defined: %s\n" "${type}"
 		exit 1
 	fi
 
@@ -837,7 +854,7 @@ test_prio()
 	count=$(ip netns exec "$ns2" nstat -as | grep MPTcpExtMPPrioTx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ $count != 1 ]; then
-		stdbuf -o0 -e0 printf "[FAIL]\n"
+		stdbuf -o0 -e0 printf "[FAIL]\n\tCount != 1: %d\n" "${count}"
 		exit 1
 	else
 		stdbuf -o0 -e0 printf "[OK]\n"
@@ -848,7 +865,7 @@ test_prio()
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

