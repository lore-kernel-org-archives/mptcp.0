Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4667810E9
	for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 10:18:17 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id bj12so37342768ejb.13
        for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 02:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/jHKBQFqn7bUxdd3zFAuj3Z6MLFTXhPHtnSVA/ZQLI=;
        b=sSRRL2FPl7spcpKvTKw2Jlz1MnsAyLz63Aaaqdv3QbPKzl/aFlG6a7vIqDe5xUAmop
         GosrQ5nJUmJwY4jHFvW2EY2iEWMflSLN2DSpfeceJ6vprOxWMAe8GwbZkClbdmR1oICj
         yFTWHkCD5orBNyJ75mHXmMe3yDHe4KhN/d5d+ohGI5MvdmoFeCjIq7WKxTpDlv7O2ziA
         y/de2Ss1mx9Ecl307fLnwzLrhJTavYicvhlxJKKE+Y0tmqBCo4i9UETRy71OCZs1F0ZC
         nPfrLbh+R4TM13qAKEH68qWetvUDyfkGYDAncyQxDM3/bFOcntyremyVwVgJf5x6+Mmk
         q1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/jHKBQFqn7bUxdd3zFAuj3Z6MLFTXhPHtnSVA/ZQLI=;
        b=YIT6T3UMxA27YckuUC4u8XvIDiO2VpDf6PSrdWOwwCR0uH2suBJmlpfBTv1NwXek4F
         /6o/uQPN0MUPcXTw8Jp+AH8Wctu3Q61ILDlY+f2VbJwblI3ZRrzSCtI039biiSPyqcDG
         kpbnjRogvKcisjc3nq5KniLO/2NzSeoZHRItt8ic5VrYO21SmdVsmS2Lt01pGx0Wwe7i
         nwnIwKZssV4okkMH0x8BHUypb2j5Y7JN9Gt/8SfapeRZYDdf4IVg6xh1zdmjVSFIayVn
         Nol8WM8CGsE55xuIy1jcjABmxJik9CTXGApVUJyJht4/ikfIgc60/ERNm9abPMiuROCR
         XiyQ==
X-Gm-Message-State: AFqh2kqU3Z3R9ZP/S+iM/nPIMjlbWuD7aUrwgmJlIvntUaPZi6T8qBLs
	VUVl/NAow0nGIfg2hRpTCLENvbeIleTha5x/eztU8A==
X-Google-Smtp-Source: AMrXdXsYvk6o5PzMDV8IMC/gem6NS10P11rlYyV7usXUWZjjp0UF5BdII4jey9zZFIi33lwjSesEuw==
X-Received: by 2002:a17:907:d302:b0:7c1:3472:5e75 with SMTP id vg2-20020a170907d30200b007c134725e75mr21978377ejc.29.1672222695169;
        Wed, 28 Dec 2022 02:18:15 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090676ce00b007ad94422cf6sm7174127ejn.198.2022.12.28.02.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 02:18:14 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v4 12/12] selftests: mptcp: userspace: avoid read errors
Date: Wed, 28 Dec 2022 11:17:48 +0100
Message-Id: <20221228101748.2518303-13-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221228101748.2518303-1-matthieu.baerts@tessares.net>
References: <20221228101748.2518303-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2046; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=R010oh46FcW31/7ZHEGi4EYd6Lvb3u6lx2QxCCnXZ1I=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjrBe/cxyi6f2f9eDjRxyGAWuZ1HNAmTZYz3tkM20t
 xLGCznWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY6wXvwAKCRD2t4JPQmmgc4GsD/
 0QjqCUFvlLd8fBqiC4++fqjwXEUP5HcYs5jqxuiqDnCzVbXAA14aAR1vXrFQMDJo+XgiOh3jgWeAFY
 ofY/fF9DQh7g+ODtXNhMI3eZl5w+3Dy60U82+K3K9JQdztDjIxX3XZYgI6ZXrtjvOMOgS3+OMhTpS/
 /CCG7WTMTTZtst19SdSkNOEByBYgZ/+ibDmoPs89TnIJWn/PTJz69afJeCsedJlk5fwgxfD+2mBUi7
 oTLgNdYVx7jqqLJmM+hgLA6FyigY51DzcdCcAf3eMzfjoeWhWdRGuIurlZF8FUWN0FMg2Q7s7LmbdT
 CThj+EWTkLLG4K3CkdgujFFzHOwuflzhU1TBNpGmlGO/snHik17AyBLYvB1oCRImi6S4Dmc2ooVBQw
 44quGOxCd4rX+0foW+KyR7XyqqbNjBi34gJ9V3NZdbkb6C9Q3v/eSipsWTeRBRYWMcfG3//7jDyalw
 0/SeRpW3Xh4hzw8sVoH4ZPoTjpZPDf0LcJM3tFR++9vy8XPEsZnRSyQVIzcdmVqXbha4G0sKnDmTCJ
 U2CzyJSQcm0pRNyiiO+nAjZm4Gp+FC1L8ojKbRq/KkiVTePl7Irlc2igivrlzBXgAYKCeeyCVwybqb
 0Mz+NjDLXW66LxzePJvLqqx1Bdxm9qxgjly7vnxVfad1VNyIexXExPEnrR8g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

During the cleanup phase, the server pids were killed with a SIGTERM
directly, not using a SIGUSR1 first to quit safely. As a result, this
test was often ending with two error messages:

  read: Connection reset by peer

While at it, use a for-loop to terminal all the PIDs the same way.

Also the different files are now removed after having killed the PIDs
using them. It makes more sense to do that in this order.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../selftests/net/mptcp/userspace_pm.sh       | 32 +++++++------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 0bd35768c1aa..8b4f130800b9 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -50,6 +50,9 @@ print_title()
 
 kill_wait()
 {
+	[ $1 -eq 0 ] && return 0
+
+	kill -SIGUSR1 $1 > /dev/null 2>&1
 	kill $1 > /dev/null 2>&1
 	wait $1 2>/dev/null
 }
@@ -58,32 +61,21 @@ cleanup()
 {
 	print_title "Cleanup"
 
-	rm -rf $file $client_evts $server_evts
-
 	# Terminate the MPTCP connection and related processes
-	if [ $client4_pid -ne 0 ]; then
-		kill -SIGUSR1 $client4_pid > /dev/null 2>&1
-	fi
-	if [ $server4_pid -ne 0 ]; then
-		kill_wait $server4_pid
-	fi
-	if [ $client6_pid -ne 0 ]; then
-		kill -SIGUSR1 $client6_pid > /dev/null 2>&1
-	fi
-	if [ $server6_pid -ne 0 ]; then
-		kill_wait $server6_pid
-	fi
-	if [ $server_evts_pid -ne 0 ]; then
-		kill_wait $server_evts_pid
-	fi
-	if [ $client_evts_pid -ne 0 ]; then
-		kill_wait $client_evts_pid
-	fi
+	local pid
+	for pid in $client4_pid $server4_pid $client6_pid $server6_pid\
+		   $server_evts_pid $client_evts_pid
+	do
+		kill_wait $pid
+	done
+
 	local netns
 	for netns in "$ns1" "$ns2" ;do
 		ip netns del "$netns"
 	done
 
+	rm -rf $file $client_evts $server_evts
+
 	stdbuf -o0 -e0 printf "Done\n"
 }
 
-- 
2.37.2

