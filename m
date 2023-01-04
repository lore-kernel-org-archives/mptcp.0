Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C84AD54
	for <mptcp@lists.linux.dev>; Wed,  4 Jan 2023 17:16:03 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id j16so16949725edw.11
        for <mptcp@lists.linux.dev>; Wed, 04 Jan 2023 09:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzgwuk3oT1wcb+cjhzp+JEGa1LQuxo5IR5KHlk0bApg=;
        b=N8tmmXMilGorUJF1d1+CSJE+BjqSI/aa+1izv7iohp7VJmX7fOZL1y2WGKzdig7042
         MVlTfrEdhwuJYJ3g4qeHawUB0F30UgO9VMTIaLKQ/CpxBxWqKxnOm81LvVnsYS0hFvRu
         M9nnW+BNolMMUhVSXAuL3NicB92MgpS+GnY+9PviEyKxP+PXjIvZTBm1F4PeyOKh2YkX
         c9SQencMjUuTN7kLrbWgkbCLn4cOQMkjp+WpyC2pcqIsc7OxcioSPkilcrJ5/NcGdqJc
         mI3Ll+vbtr1OoNSmSF8CE9FLpxF3Lm7U/S9nis1Twsx2T1Fy9QdLLearCznox3IFHkeO
         wDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzgwuk3oT1wcb+cjhzp+JEGa1LQuxo5IR5KHlk0bApg=;
        b=SOhm9wgJbFQ+g0f95FLlqF9d90v0LkR3KMQVdCVju88W2lk1FE1kBCL/g/pcYxshHH
         mCk2/ZMYrt1EfnFdwumD4cjY8tqMc0CgHw4/XO1cS1NAqFOTe+Hf0AJ1AA0FLddzFhL2
         pxNcOi1PyHDQ25hiTH6J09XpRgIMoDpjfYinqu/oyd+qLQnIdnyPwFlERTUeAD0ZNwG1
         PFwGtOHqfAPp32ye925TsMTole25R5tBFwGRdIcMeNRmg2bZmNEsU0ZuH+lWmeD7pgIS
         EJ6/Uz9ofZP8hGmbMvPIVyYIliKQEFoeBWwul5oOL6TAtYtnd2ExNSa+xXMRel3m9kvf
         glSQ==
X-Gm-Message-State: AFqh2krn4oo7mYJQFU7uiN22FoqjEVWOQKf1RvTbAsXTB8q+5yfdm0Kz
	E1nO16YEXQUvajwatqlBs6BxS3YoDV6oH8DJBx4=
X-Google-Smtp-Source: AMrXdXuu42xdwXSb9sdgsuzI6f3fOFwoNtYdwkGlSDreqPBUxm9R2ChUXFfpM9OqQ7Gz5l/rXYSEmw==
X-Received: by 2002:aa7:d601:0:b0:483:87cb:a5df with SMTP id c1-20020aa7d601000000b0048387cba5dfmr28985691edr.30.1672852561660;
        Wed, 04 Jan 2023 09:16:01 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m11-20020a50cc0b000000b00487fc51c532sm9258074edi.33.2023.01.04.09.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 09:16:01 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v5 11/12] selftests: mptcp: userspace: print error details if any
Date: Wed,  4 Jan 2023 18:15:25 +0100
Message-Id: <20230104171526.1416746-12-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
References: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3188; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=rV/UnDzrHn8cTDUEj5YH6yx2iAn2csOj/Jmdg6Gtjas=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjtbQIK85ERLHf1zKKOY6N5xQQkTcCFBUQhZd6hU0e
 A6EQ49aJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY7W0CAAKCRD2t4JPQmmgcwcGEA
 DKLf1Hh0x+KPhb05s6UMrC+kfznWW4s9XckDc5w88AHW27KZHWdun2NIqGdqqRwnQ4wFabPEXxduCQ
 46YLQVTeioFnBOjz+kbC2IuOrHR2DzwWnMNds+7Tik83G+bjXKZ69HhMs4OaM4tOvj33fdqvE04A/O
 FGFgMyBsB1+1dsSLU1h/tXPm9b2ZdK/4IIq382tdbqzcZ/1thc4sTCYg0lRlo+u7rzxamMJm3sFk3J
 1cv3bSQ//SWsajO8uNSPl7HHTmND4Bq4FyVNocVA7UH1My6LXFaYmKEc/aMuLv97Ezvc4kGiQzwVAI
 5Pn3c4H/pSMQRv1ns5PARQVzcPstM6BAavsdK7efVnEoP+wKav8pn34n0w56Yh9mUSwJGxh7LYSjY8
 JDOhBaiSTPfwJsbjtHLRNFA7NuEefiWK5Z9i9QplmdE74y7frMed1TRVMszzNBtfCdhflxLetrjyr3
 +Kv9R3hVfslgvYI4kpiISqXxrJgHg0Tp0TSo0ZNfBNZhPqrOxgQfP7dXhsfxtpM0hqkHWQmIVByoxs
 r4GP5kv1ViEceUyPOLEJ0Su4Kivl0Ea6WH2VQ0VUgcfMnyPodea7IKVIyGbNGRgfiLxQORvrobvJ1Y
 YhfDQxUakBp11b4sU3BBA673g9HiF3QyVGLemnzq3dI6q1U6Fh0bNldvGliA==
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

