Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E5219BAF
	for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 17:18:35 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f9bece8d1bso9714335e9.0
        for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 10:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687367913; x=1689959913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dPp0ofcUyqkhAjCDcbfJCpnUAodJQAp8o3E5VVr+9DQ=;
        b=M6am/+BsP/VLGCzqGlLH1bcY6aLP/WEaFoRQCsjBB6r3ux69HL5A99SgF+6s+nKBYZ
         4KLugkENw3dhDmbHFCEuaXgAZU3mJJNVTiEcxgKAS1LhPeAXSwbF8oh2CZzta2JGyjNB
         h7GhIfp8FV+pzGU6rpQqMv3xCssA4nuSspgeNdeoUYA5NUtnY5qSCYy6vtQmeQQ+oOtZ
         qrMo/nSme5T+ZOpbmSy0unnK6QjncEXcZ+dZ7RQ4XFdAq/jTlrgcCr8YFl7yvYBSLQGv
         S/i9Ig/7YJ+9BLLfaCOE0nt3Ro2EaF+2CdwpOUsq5LhzHmPCdSYkVziV3lxm9N43r+m/
         bFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687367913; x=1689959913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPp0ofcUyqkhAjCDcbfJCpnUAodJQAp8o3E5VVr+9DQ=;
        b=Clmc3TjKXvMLqhP7pIJys4XprXZAgc53D4xIByEZ55KPy67jedEb0Qy+IQGnUfm2E/
         rzbNXZuKiwCkRr/Y+8GAI6pGo6rdl7dhj/NS4JJIjDTw23YJhKsgdFPNTnGB8pFevfIt
         puOZACnzRAtveP5lmNjZcovC21JYgcP1VEkW1j/dGTwJFRvEo5q9vDmXVt+Rir1uoFQU
         eR8RMJXWSXH+evakvnbHMZJ8Hbgu+pWIPcHzJ0JlfNgeo/fIPw78ApPWQiPx8mmHxzYS
         qygTSHd4Iv0woZeJ0Vwzb44qwRpX59Yk/ImYEek43kH5gOtxCAI1QK3ZlKAIBUWVoQ4e
         i/Pg==
X-Gm-Message-State: AC+VfDxw+m50Tl9fAJ8U9sQmegq9n/W5wriTurYYgPOfmy8A8dpfPlV9
	r/ekKPkyQrsR76/dsy6/Iyn26Ql6XOTEPlXMv9gqi2sV
X-Google-Smtp-Source: ACHHUZ6C8tbw6KXJtA90PxpNml8d5XMrqcE343H7itcuyuU8aeVFGDR8ybzq3b8EG/qUPLZOxU+PwA==
X-Received: by 2002:a05:600c:364c:b0:3f9:c82e:9d87 with SMTP id y12-20020a05600c364c00b003f9c82e9d87mr1394016wmq.13.1687367913274;
        Wed, 21 Jun 2023 10:18:33 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id f1-20020adfdb41000000b0030ae499da59sm4930027wrj.111.2023.06.21.10.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 10:18:32 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 21 Jun 2023 19:18:07 +0200
Subject: [PATCH mptcp-next 06/18] selftests: mptcp: connect: don't stop if
 error
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-mptcp-issue-368-selftests-subtests-v1-6-0cae453ae1fa@tessares.net>
References: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
In-Reply-To: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2356;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=hCwZDxC/ahUh3GbDHB2wK455fgZOje1bl7rk8p+i4JQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkzDiTHrJFbouJaxuEv1Bc8Pvxpd5lSzcG5g+N
 LUTXAjp0CmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJMw4gAKCRD2t4JPQmmg
 c8wlD/94qq7NMRRb8xv4uWI0Powtq/A+why7/SmXWnXBkf8syPvTkUrPRdyJa/BERAwzKxzhqf8
 cz1tYrRZK9K6CKgZnJsFGKup7pMHx81hAO2GlXbJzD/Zz4X4nl17snwSwz+p219vFLj9KUYwoOG
 peZ3Yga5xQe/eODFblGVHnbsggAxJ0Bf/uNO8CKi5oSFRjjaWEQtJOQGQI7YkPUG8N2lj2s+kAp
 JFmqfZ/xLUjHlQEYHRp8vkYUKRG3LYtrmniFFh8UZXnchzeqb4Zs1ZJRMPYNj2wp/QQg75xN6jB
 fiIBob+/vNCLT2OsBlOhIhgCaTW43RPJxJB9ccLnd9MOvlr77qaSqgEdntVvLzxzYDRJUv3pW3a
 aveiiGD7vSTPC1+PtSyfSVMc6v0lxkbBiwDNeQkaOi1b3edZwGTde3Z6L9zfaLtW+92t0pDKPD4
 3NQWKpUIMkwyL5R2MGOotjdNfeiNBR7KFx5mPuXNJ2//J8vmamemGGZwJCPyBIwa8q878mYskx2
 3FY1lfzVOOkoFLZeX/iEs4aj4U5vvJtycd3y+Ugnp20p6UvHXZTFmtduznFyc9EdvNXBWNZvGER
 TS2IjB2CNz+boAqxV4nF/FY2tmbDkl96O6Ki9LZHJiFTF0AKaHCezSWIBmnoeFYutJhSPANH0dD
 KDRzYuuXqgDnySg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

No more tests were executed after a failure but it is still interesting
to get results for all the tests to better understand what's still OK
and what's not after a modification.

Now we only exit earlier if the basic tests are failing: no ping going
through namespaces or unable to transfer data on the loopback interface.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 27 ++++++++++++++++------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 780b8fef2261..dba58875ef4c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -7,6 +7,7 @@ time_start=$(date +%s)
 
 optstring="S:R:d:e:l:r:h4cm:f:tC"
 ret=0
+final_ret=0
 sin=""
 sout=""
 cin_disconnect=""
@@ -837,14 +838,25 @@ display_time()
 	echo "Time: ${time_run} seconds"
 }
 
-stop_if_error()
+log_if_error()
 {
 	local msg="$1"
 
 	if [ ${ret} -ne 0 ]; then
 		echo "FAIL: ${msg}" 1>&2
+
+		final_ret=${ret}
+		ret=0
+
+		return ${final_ret}
+	fi
+}
+
+stop_if_error()
+{
+	if ! log_if_error "${@}"; then
 		display_time
-		exit ${ret}
+		exit ${final_ret}
 	fi
 }
 
@@ -934,23 +946,24 @@ for sender in $ns1 $ns2 $ns3 $ns4;do
 	run_tests "$ns4" $sender 10.0.3.1
 	run_tests "$ns4" $sender dead:beef:3::1
 
-	stop_if_error "Tests with $sender as a sender have failed"
+	log_if_error "Tests with $sender as a sender have failed"
 done
 
 run_tests_peekmode "saveWithPeek"
 run_tests_peekmode "saveAfterPeek"
-stop_if_error "Tests with peek mode have failed"
+log_if_error "Tests with peek mode have failed"
 
 # MPTFO (MultiPath TCP Fatopen tests)
 run_tests_mptfo
-stop_if_error "Tests with MPTFO have failed"
+log_if_error "Tests with MPTFO have failed"
 
 # connect to ns4 ip address, ns2 should intercept/proxy
 run_test_transparent 10.0.3.1 "tproxy ipv4"
 run_test_transparent dead:beef:3::1 "tproxy ipv6"
-stop_if_error "Tests with tproxy have failed"
+log_if_error "Tests with tproxy have failed"
 
 run_tests_disconnect
+log_if_error "Tests of the full disconnection have failed"
 
 display_time
-exit $ret
+exit ${final_ret}

-- 
2.40.1

