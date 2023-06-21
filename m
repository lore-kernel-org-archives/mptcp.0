Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3071E19BAE
	for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 17:18:36 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3112f256941so4129050f8f.1
        for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 10:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687367914; x=1689959914;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jd1BOMbJnFLwt8Atjjr36zRC7VcTomJHW26m34zzNO0=;
        b=VAqmd8ZkDT4HeOjrGFsQRAEfCkWcIXNfQOpS5AADMDeYV6yLCNQP0XyZJVVrO8KGuy
         wIesNstWy9Vouere+FHBlYv1qvAoPIwvxVtw0QnUsOv4P/uuvPBw3hRjSCfOT27f8inL
         OfaoxfAdoNzsONIa8ILK0uQfyVindN2wSsxXUmp1ebRiaIEb7KXyIKSj10sKPKOPRhxr
         FudHJJ1D3bln7YyHkPSFm8Q8btmg3yt64poxOBgliS/Suq1T/4H9Qyk+glku/EfeGDve
         YXE5gXHlxV7EoofwtR92en+3BmLMaHRzNsQm/55WaNx/VvL1K+oo2hpjVStMqOr+1opp
         TnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687367914; x=1689959914;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jd1BOMbJnFLwt8Atjjr36zRC7VcTomJHW26m34zzNO0=;
        b=YmHNjwNsOKz0gq2+ZC4njeO1ySUOYXvtw85IbXq7K6IGvWh5H73zGlnFqKaTO6Xvls
         vdIS7ngx1njPtvOcqxs6Azs4FvN6MV3SpgavyGyBkc2xLr2ax6BqaQVhyD2agiCHOVw1
         DBtYtERA8ZHEk9LFqshfm7MU/YV4nwF6KL5Tj92tsXkcz+ew29bWMQMAamHqKN73Lbd5
         MMsxzk9pXzj4+Sh+4H/a1ykyh++V8ZazzF1YATLZ7ljPPRgP0gsAAbeaVInDGYfciCGZ
         OI7mxoMjgWl6jT4rBnW3L8M0EuCtxLl8PngN+1ZXg4s9M0MfA+2eVRNDhBZ5y0TJIjqK
         q5GQ==
X-Gm-Message-State: AC+VfDzbx2PWytMTORAco9WUoA+ARbKDoUxRQRf/KTUb/imWSHPBkR3J
	mMaB0n7nnAvh1MGfmSrrVnHD7axQPXDl2xMTgToNsEry
X-Google-Smtp-Source: ACHHUZ6khoLN23TrqphyJhG+jo3ndX9B7JuYaThIO1+X5D5gwrqJ7mpovMnin7gRF8nD7OqCSQAK6A==
X-Received: by 2002:a5d:4cd2:0:b0:30f:ce60:a3a with SMTP id c18-20020a5d4cd2000000b0030fce600a3amr10609405wrt.10.1687367914179;
        Wed, 21 Jun 2023 10:18:34 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id f1-20020adfdb41000000b0030ae499da59sm4930027wrj.111.2023.06.21.10.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 10:18:33 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 21 Jun 2023 19:18:08 +0200
Subject: [PATCH mptcp-next 07/18] selftests: mptcp: userspace pm: don't
 stop if error
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-mptcp-issue-368-selftests-subtests-v1-7-0cae453ae1fa@tessares.net>
References: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
In-Reply-To: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2540;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=PsozxEb4SxEpdyVzTQmz+Pia85BGsPww+pdoW8KjXRE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkzDi7VMsCvLXiCZklKYcP72OCQWkp9bbPDZfq
 YWAJ3rtrnaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJMw4gAKCRD2t4JPQmmg
 czgLEACidecNOyqkTZH9n2NebGAXpM2I0uYbgLogK8wtN7wEBEFssRNnii0eqrsJoKJ2P/+P6z/
 QnJKnTKeXnrFD3D9aBwMZu3iGQ+PDys/dQtaXLosjWS4QHpYv5C4q3ZelfNnnX0cWPTfhXMePAB
 kJRD/I7/Ay1Ydw5VQOFRuzkhqCR9Ba1CuZrfGGgZR6hl5JTmSVF7jmQGplDsUD3bRBJaIWMXo2D
 gbXEq0CzMmzhclLlt6o1kfhtxamd78AqV86jmnFiS5CiFU10r+Cx/SK43T6AG7f6ngK5zSOJJOe
 4G6mHUK0iUjkAQ+ldPD3uCLkXtDDo4QxtCbgtldIN8w28JbTYjfBHgqgb1PTFfYcWieGlfeWF6k
 5AUVhOFczYbuALlayfkvGX/Rxpdb83ZwYQ4mXDm0dPFisaMDZRqWfbFT5/eo+cjqQLdlpt4geWp
 6Ye0z2LxqoXVFUkLtxh7Mm04wx8deQbEezl+x7BpxhJWl2C9zGvBKKNVbf9/dIPMxO3tXWtxILm
 t9WsRANfM+PcInQ8ctRwsdzMC2qL/e5cyw8VkWqQeCNKV0T/eQkTV2CZ2e9T+eesgE5Jc8raH+L
 lnXvIJtwV8+mJsegQ23+XepSCqZlSZXVilZ7stXZrbzMjUFeq+SFTF3czKAgVnh6qTMCXQqN9yf
 QNwYvWcx2IYBQzw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

No more tests were executed after a failure but it is still interesting
to get results for all the tests to better understand what's still OK
and what's not after a modification.

Now we only exit earlier if the two connections cannot be established.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index b180133a30af..c57ce4df4973 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -52,6 +52,7 @@ sec=$(date +%s)
 rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
+ret=0
 
 print_title()
 {
@@ -257,21 +258,21 @@ check_expected_one()
 # $@: all var names to check
 check_expected()
 {
-	local ret=0
+	local rc=0
 	local var
 
 	for var in "${@}"
 	do
-		check_expected_one "${var}" "${ret}" || ret=1
+		check_expected_one "${var}" "${rc}" || rc=1
 	done
 
-	if [ ${ret} -eq 0 ]
+	if [ ${rc} -eq 0 ]
 	then
 		stdbuf -o0 -e0 printf "[OK]\n"
 		return 0
 	fi
 
-	exit 1
+	ret=1
 }
 
 verify_announce_event()
@@ -323,7 +324,7 @@ test_announce()
 		stdbuf -o0 -e0 printf "[OK]\n"
 	else
 		stdbuf -o0 -e0 printf "[FAIL]\n\ttype defined: %s\n" "${type}"
-		exit 1
+		ret=1
 	fi
 
 	# ADD_ADDR from the client to server machine reusing the subflow port
@@ -423,7 +424,7 @@ test_remove()
 		stdbuf -o0 -e0 printf "[OK]\n"
 	else
 		stdbuf -o0 -e0 printf "[FAIL]\n"
-		exit 1
+		ret=1
 	fi
 
 	# RM_ADDR using an invalid addr id should result in no action
@@ -438,7 +439,7 @@ test_remove()
 		stdbuf -o0 -e0 printf "[OK]\n"
 	else
 		stdbuf -o0 -e0 printf "[FAIL]\n"
-		exit 1
+		ret=1
 	fi
 
 	# RM_ADDR from the client to server machine
@@ -859,7 +860,7 @@ test_prio()
 	[ -z "$count" ] && count=0
 	if [ $count != 1 ]; then
 		stdbuf -o0 -e0 printf "[FAIL]\n\tCount != 1: %d\n" "${count}"
-		exit 1
+		ret=1
 	else
 		stdbuf -o0 -e0 printf "[OK]\n"
 	fi
@@ -870,7 +871,7 @@ test_prio()
 	[ -z "$count" ] && count=0
 	if [ $count != 1 ]; then
 		stdbuf -o0 -e0 printf "[FAIL]\n\tCount != 1: %d\n" "${count}"
-		exit 1
+		ret=1
 	else
 		stdbuf -o0 -e0 printf "[OK]\n"
 	fi
@@ -961,4 +962,4 @@ test_subflows_v4_v6_mix
 test_prio
 test_listener
 
-exit 0
+exit ${ret}

-- 
2.40.1

