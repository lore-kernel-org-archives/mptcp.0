Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0C114293
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:26 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f427118644so62946165e9.0
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773504; x=1687365504;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDDqMjQYOp2wFxeAFFqcvQbYk09WfYCq/KJQagEy/6E=;
        b=NHdeR/x+0OufMoEr7+Rqbe5HKB1Pnmc0fjcOk2hBch7U4Vk37M8RACtQjcqvyTJ5ew
         qAXjbY/xJ/mR8HF8S41nFPULrNwnwZ6PhfBp0DJuzTmQlJAGDNxgrFH9uOg28YoNF1af
         eaBUvPDok9pHmPZBhdJAmaORtzbX2+rTw8g9TOnTwlndj3NYi+aGggOBpaz/CyrwYbAJ
         NaxWUyLeRvOTcPJQ0wrz8NdjhXToaBlidiQp/YS/cE5qav+FT5OOnsfxlM/uW39WhYVH
         Yqt+FGJhs5C2WWc/1YU/qLCvGqNqhpjDPf1YbxiH/cS+cGbX8bk+MTDypcUzz4gMTQEr
         eDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773504; x=1687365504;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDDqMjQYOp2wFxeAFFqcvQbYk09WfYCq/KJQagEy/6E=;
        b=jQPToZiPiSIN17rj9086Q4PPkYMjIcnjE0SBrmGejUWf90XFPRlBOGKjmXaq7XVuc2
         OGtAU/YqFJe1qx0EZ6Ro1Lu7Dt5rczrpaclzb1OsG8/piiZY0DaBpQezZUCtGPcwe0a3
         DEmW+BcGYkB80A2Ok6SeoHx28MpJzzf2sME8bcxC/MRAo/bFHMzvr0vhbkUKSdmPF8cH
         ExL7z7/PEcLCDou5TNMB46n8nBa2/CxzdGYkd/JrB8yrlSTYG+V96UC96oJixB9DDpvJ
         ANgDWoj6n0tI57l92KJ3bjkzTnfawPTCM2Bzjc0EjyopYupy6TGML5kq1v29mg1RX8LH
         rudw==
X-Gm-Message-State: AC+VfDx0qCO4WRr7Oxh207F1e8WoKVIyOuUM3CnYfH7K7etiLfC6x7WW
	LgFwtavT0uKZxq6DpCbFonvDsZ5Iaobidt+OGEQNzw==
X-Google-Smtp-Source: ACHHUZ7z+iNSl5ftLsQpeTuovv39+mVCqnUN52dvZm+x7rQBguQrjrfIiuVx0ugttC3UGv90bq+qWw==
X-Received: by 2002:a1c:7203:0:b0:3f5:faee:dace with SMTP id n3-20020a1c7203000000b003f5faeedacemr5489601wmc.32.1684773504447;
        Mon, 22 May 2023 09:38:24 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:24 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:51 +0200
Subject: [PATCH mptcp-net v2 19/37] selftests: mptcp: sockopt: skip TCP_INQ
 checks if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-19-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2105;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=jNMlBxSyx3VTiSARezuDvvNOfQso1SFAQGcty20ihVc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pwCIdECM7QngxvzJtSPHy9BwPYeFQEUgiRm
 0o9o7wve+WJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacAAKCRD2t4JPQmmg
 c+BIEACEvC+DXLQIPA+tumfOdprO3eot00tHdoUhwEZQNEgoo8LAX1PXJYXej5YF74JyS6S6f7x
 Dc04OJRtn3AOrjrRM4qJFiguwqVSstk+rAdyBEQuMlJw6iui99gCnnrMZ3bD4DXRRXAQcurTb2p
 5bsRWnA/VaKEkQcVH2IpCPjL1wwuSHFmdq+lhDWfvmsL89HdnNnKbq9jmxL4mzvd6Cf1MK/85ap
 jIuQQ+hKlhZkF/Ldl3ND5dYe35jShHha+3fTX5nC3t5N1LnMalIJLskJIev+F8GKLsnjvWQakew
 hNCiEDpi1w3pp8WBacukgcuNe+H2gsie/pj6Z2eB4f9BCdawWEWYdf1dGV6dqMrzm9ZRtxQRCuQ
 s2+2lXgs5V4pVqN3YfL0+2o7SSBrGNBO1RZzEyECq7cCMXS730SGdVuaLogKl9bzM4CH5DeeCM8
 Ng33ef8esVIKuqRzKs6KFJGcmQYQjA7uh4m1WthOfa7+Nu93DeACt/vi9xcqpZul1gpG5fMUzOg
 rKYr9Xpy1dqQZCWqaum0c1bX4aJ4QGrQsPVP12kNKt++nvW2KUo75dlHfMkYyd49JA3sPWTII0N
 UTOHdUEhJAghW36Eg5MxNNJE+CHNlEfWmhV8Rybopilx72xHdeNyyeuWN7b4Y2zIrjr5iO+8sUf
 Ns/LPBiU72J0SFg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is TCP_INQ cmsg support introduced in commit 2c9e77659a0c
("mptcp: add TCP_INQ cmsg support").

It is possible to look for "mptcp_ioctl" in kallsyms because it was
needed to introduce the mentioned feature. We can skip these tests and
not set TCPINQ option if the feature is not supported.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 5cbd886ce2a9 ("selftests: mptcp: add TCP_INQ support")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 1d4ae8792227..f295a371ff14 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -187,9 +187,14 @@ do_transfer()
 		local_addr="0.0.0.0"
 	fi
 
+	cmsg="TIMESTAMPNS"
+	if mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
+		cmsg+=",TCPINQ"
+	fi
+
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
-			$mptcp_connect -t ${timeout_poll} -l -M 1 -p $port -s ${srv_proto} -c TIMESTAMPNS,TCPINQ \
+			$mptcp_connect -t ${timeout_poll} -l -M 1 -p $port -s ${srv_proto} -c "${cmsg}" \
 				${local_addr} < "$sin" > "$sout" &
 	local spid=$!
 
@@ -197,7 +202,7 @@ do_transfer()
 
 	timeout ${timeout_test} \
 		ip netns exec ${connector_ns} \
-			$mptcp_connect -t ${timeout_poll} -M 2 -p $port -s ${cl_proto} -c TIMESTAMPNS,TCPINQ \
+			$mptcp_connect -t ${timeout_poll} -M 2 -p $port -s ${cl_proto} -c "${cmsg}" \
 				$connect_addr < "$cin" > "$cout" &
 
 	local cpid=$!
@@ -313,6 +318,11 @@ do_tcpinq_tests()
 {
 	local lret=0
 
+	if ! mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
+		echo "INFO: TCP_INQ not supported: SKIP"
+		return
+	fi
+
 	local args
 	for args in "-t tcp" "-r tcp"; do
 		do_tcpinq_test $args

-- 
2.39.2

