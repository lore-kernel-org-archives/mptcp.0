Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F8C63A5
	for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 18:21:45 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id t17so33592614eju.1
        for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 10:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFrwfO0U3J+sx34kW8QI9rGrLqRX414oIawZFVlbbX8=;
        b=7iDp9NpwQa2oor/3o5gRnZsNTH0DIQyu/Uxp3y45/7gQL8G5qot5RD9ht1xSiMXiBI
         Aw3POllwJ5UbhFXklDHtBgYFTomaIsAHUfVcYcfKaGmLvzyN9oHcOtx/CE0VlVCR1Ai9
         B/tPCgzbg8OwW/H+Ec1e5EwrxV1ME8waM5XsIBghZ6eM8sBGh+r7O6VWSs77IxCnxd1u
         EAWrQQn28/eD8Kk6G3lDUR8YXRK+fFbHe19B5rLox3/66ADu3pK6YeD97xGOciJBAAih
         0+9drJn+t/DWooUdCezFmUeASDU4WSMq26gVAYfTTFFoIaij6VHc/fBPXhLEWwcWtaUw
         8eNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFrwfO0U3J+sx34kW8QI9rGrLqRX414oIawZFVlbbX8=;
        b=ev/m7vUjRSV9zLAu6At9ZYO/M7Bh1qvlc2hYIQWZux4oY3F/zkMH8AvuCYfogbyu4N
         HkGyRmGhjiB756Q+POSlem48zOLn4XZ3oDRJgnVGfV9SAG2PLZ15WGtcp38ygKdvxSWe
         oAGcFFxIcLIdxBtw6imUIFT+WPcf1k2a6hE1ckkU0WgY1bStg+Zl1p3YN2+vgxDBcUL4
         JEyaofRQoWFUQdCoqwILul0K+74Oz12lkcprN6IgoGFvCZuCgZDIsjIEcP+5+/CFuR62
         M3PmWSwl75xf434I5HJYiYGsLOwiUjKYz7IVnb8UOdCHiB4MmIeq+xG/xDrKLGjt+yLO
         e0bg==
X-Gm-Message-State: AFqh2kqpg5W9jKucJrXKPA8GfGVn7MG78PhibYoUnuygfvtQd4jBsXyW
	H4ta1hxXXKw+TiSGPcIIj4zpk0Pi9Rir5rxi1Gob2w==
X-Google-Smtp-Source: AMrXdXtD/i8uQWcqcFV5ZZzkRWSFIGnX8q9+uYax+lQ2KfWivor0h7rKd42zvdD4684CfmyEo0DQPg==
X-Received: by 2002:a17:906:d047:b0:78d:f454:ba46 with SMTP id bo7-20020a170906d04700b0078df454ba46mr19122080ejb.69.1672165303231;
        Tue, 27 Dec 2022 10:21:43 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o17-20020a1709062e9100b007bd9e683639sm6336612eji.130.2022.12.27.10.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 10:21:42 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v3 10/11] selftests: mptcp: userspace: refactor asserts
Date: Tue, 27 Dec 2022 19:20:56 +0100
Message-Id: <20221227182057.2288816-11-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221227182057.2288816-1-matthieu.baerts@tessares.net>
References: <20221227182057.2288816-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3455; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=LWH+Zbi9mHpSVcb37MxwobKpLqFWvY25Gk0klmSGlWs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjqzd6+wZBqmUgCJ7+Dqe7/YQaUzxUIdQuf452U02X
 nIKZyeyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY6s3egAKCRD2t4JPQmmgc0biEA
 CBRQ1feLELbTDKmzt9sunUAMCzE/K9F/mZm/AfCODD5m7N3YaMNtNw1t0xpTXqSD4Xl2mdQ8HVHJl/
 ktQ4/Q7ZBLGe0UWWGanieLv4GW7y+CNQEcHQoH+4wc/G/fWBoFkrN9/gD4L1SpzAee6t1ka4Uv3g1W
 IiLNfr/5nc8+wE07zwIblfoWNXtv1/sW9+CA82YYxcXtnJCXH72BE+23zt8Fd6LmmkXBi+DMARUvg+
 KkJqwxkXge/gbRrM0HdsS5JRBLsvLlSvG6gF8nBbW6L0LZusPYooekNAAxWvPhJ1GM9ImQvK6ApCFk
 nAEGAr3TUBXZ3Yw+iSjYKaAaiYfPL99aJqBEyG4sMDwUCWNU3rNaW5IntMmGY1wtxPgelootsXxldv
 4iLDuqof3HKsWw56GjibR21zgAvgkJmzY/Oa8WDmcoXOymyGvLyD80GxtHK1Abc7ccqwFSgN7khhUj
 9EYY5tZ82sSqnuSzu2lrSQ2DKAzwOkXQ22kwy3VDlUYlDZPLaf9733Zma/iQ6mSe5OyAJFAkNlicQE
 EBiW8acwIiNCzbdwxH6vubkvqnmw4C6ua+/Ch3m0Hl0dw0Zv9SULuoqiGK0ChnofmwrsdqpZQVLs7T
 /arroVA9AWobS53idy1zJCL7pyYMzO5lGPt61v7is7Ov2oJvkUnee4t9PMlA==
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
index d2d7452d0d73..942b1b341c5b 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -223,6 +223,36 @@ make_connection()
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
@@ -248,15 +278,8 @@ verify_announce_event()
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
@@ -355,14 +378,8 @@ verify_remove_event()
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
@@ -517,16 +534,7 @@ verify_subflow_events()
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
@@ -879,15 +887,7 @@ verify_listener_events()
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

