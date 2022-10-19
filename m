Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8FB3C15
	for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 16:20:09 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id b4so29923214wrs.1
        for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 09:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlLW1J6KihN8PYm63k/YXvl52ryJ0bQpxJCDZTZEo3A=;
        b=DAbNmpB8iP6TkUWgpeZToMD9UWfbUgCOuro4Bcn0Q7zBceMJsMpgOJlsi1RjX/GCLQ
         Du4VALghmu70wL8jIQOWiWCg1qPXauMbRPMRSKJs3o2V5Mb9xkhUewL7QxrPktMszqS/
         cCnvwvcGGIU7m4Bck+uobY8O7Ia7S0F0dxI3Oz5bYNuV8oShmodmN3O5QTc+tX3ttExc
         iG5ByI0YVNV83NPTvxySYrdRG4zzg8wTJHj5Ye6GonWBRoW+hJY4j+i46aEStNrgbRgP
         bCysg28+749vD1KUlK+IiXK5uH3XqFpb8fjbJyz4kZobr453p4QJz8hDkVVoD14RrzZw
         wXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlLW1J6KihN8PYm63k/YXvl52ryJ0bQpxJCDZTZEo3A=;
        b=1eemOeoVkgyyijhmEWD2Xm1DLGIw+oYxs75WE5hRQBA+bwOSyVCNEE7Eis8XAUoJyQ
         V7kLT8wDFDUmeKR5+KyA5bG/5f1lsBxfDGBlbeH6rG/wFBGfBUb9cmh+3eguUgbKOpS1
         s3M6LrfXfj4RZBU8IAaR7cWAmvTs/EbViiInvbyCVJb+STbGP/ScBGAB7y18Deumc1fW
         TDM1R5XHiAL7x7UqXGYBaVGOmyzTeDMyUDpiA7BmUXEy6ISPo1PNCQcGeVceo6br0jpm
         yis5+52nBxEoKNAdKo2aJksymMSXU7LkNepXBLsyjuq8hfYSdLu6z7NPPtl9LMjfOC2h
         ZajQ==
X-Gm-Message-State: ACrzQf1LrwPnbDrIzKvAcwCjp7sQrTen4f/oLxGQDi6t4JGl8gM+8P3X
	DAzLLZlrHsPqDUBhD3CPjYkt0lpGgyAxMG4Ig5k=
X-Google-Smtp-Source: AMsMyM7irnfdnA/Wp5VjfEdonEk52L7FjEOSyDxuedXr/GoWItmjtzpx0jmJ0Fg+gnpZZEl7PXFlmQ==
X-Received: by 2002:a5d:64e8:0:b0:231:a71:1eec with SMTP id g8-20020a5d64e8000000b002310a711eecmr5769901wri.59.1666196407395;
        Wed, 19 Oct 2022 09:20:07 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m1-20020a1c2601000000b003c452678025sm433717wmm.4.2022.10.19.09.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 09:20:06 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 4/4] selftests: mptcp: uniform 'rndh' variable
Date: Wed, 19 Oct 2022 18:19:40 +0200
Message-Id: <20221019161940.3178393-5-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221019161940.3178393-1-matthieu.baerts@tessares.net>
References: <20221019161940.3178393-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3556; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=5MOPslV8E5h86a4qDeXeU1c402U1r4M15OsyxIUwJ3M=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjUCOEjZvnx77HRvQL7OpWZVthz3FA9mqOsK+sZq5k
 SJOwuLqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY1AjhAAKCRD2t4JPQmmgc/kUD/
 9faS5HiotzbVH/so5YOWeVf5KD136mWAu/geG3l1j3AGrwBS49CMrOzAZhg/juKt2ufSURpT/n7/lf
 d0op35tRI3DlTtbbRSQt3hIGaDCf4N4PxRU/CsW5qRFuz9nPVbaYWw2sdFA8odfdSswW5tFfw8KOsP
 ZoaAuouOV7889G1aVP8m4Niji+CdN3v3fWa3ZxqaGz8+xnNJOJie29ilJhZa0hNfi19ml80ncFlUvq
 a5BWLEKQoJJ20Yh1MHOpnVeFm+irRLZvscbyVNoFg/5nZ9dXiuFELobRCUPzKkI2Ke81Q5vuD/anRN
 T+pY/Yp0dpUuj9b2Qmz0FswI3yW4VqFW7dPeh+5ghl9Qhj8SGET2wWnkQK5Iwvhi8PWouGhn0KFZYq
 IZ/88UY0J58Mqc5b+hHMft9+2x9y4Jv7jTUUN9FB/PV8kqGBDoi/rYc3P7ZmFSYlYJb3w/BNX4u6S1
 e7dgwPPYlIhAlh7ao8fuYVLf2EBPtlz/rN7mLJiJcvxwIOVL4lDCpc7Zr0Tz8OXuYVBPhvRIAiscAl
 BmSTSm9o00fbKmSG5WYTw707kxwEl530fxD9BNn4jJvqo45rD6LrbJq1KVtyJXlvGDBq60YOTanHOE
 k379RRbz/OxCvLYFaKwysW9a3vAgzkC4SaOGFF39gG1z3EpBR5ExYDCcY24A==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

The definition of 'rndh' was probably copied from one script to another
but some times, 'sec' was not defined, not used and/or not spelled
properly.

Here all the 'rndh' are now defined the same way.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/diag.sh          | 1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 3 +--
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 5 +++--
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 2 ++
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 1 +
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 2 +-
 6 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 515859a5168b..24bcd7b9bdb2 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -1,6 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns="ns1-$rndh"
 ksft_skip=4
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 5942a16736a9..800adb4467f2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -274,8 +274,7 @@ check_transfer()
 
 check_mptcp_disabled()
 {
-	local disabled_ns
-	disabled_ns="ns_disabled-$sech-$(mktemp -u XXXXXX)"
+	local disabled_ns="ns_disabled-$rndh"
 	ip netns add ${disabled_ns} || exit $ksft_skip
 
 	# net.mptcp.enabled should be enabled by default
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f3dd5f2a0272..53ecc8d4dc8a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -59,8 +59,9 @@ init_partial()
 {
 	capout=$(mktemp)
 
-	local rndh
-	rndh=$(mktemp -u XXXXXX)
+	local sec rndh
+	sec=$(date +%s)
+	rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 
 	ns1="ns1-$rndh"
 	ns2="ns2-$rndh"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 6e8f4599cc44..dbee386450f3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -30,6 +30,8 @@ add_mark_rules()
 
 init()
 {
+	local sec rndh
+	sec=$(date +%s)
 	rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 
 	ns1="ns1-$rndh"
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 8ae7e0c004fa..0915fb39afc3 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -1,6 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 3229725b64b0..5dfc3ee74b98 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -33,7 +33,7 @@ client_addr_id=${RANDOM:0:2}
 server_addr_id=${RANDOM:0:2}
 
 sec=$(date +%s)
-rndh=$(stdbuf -o0 -e0 printf %x "$sec")-$(mktemp -u XXXXXX)
+rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
 
-- 
2.37.2

