Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415D219BC6
	for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 17:18:41 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3f90b8acefeso43195235e9.0
        for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 10:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687367919; x=1689959919;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PaKDV637bWzZlSeQkWzUA6xTOGBkY2/gSgiK7N2MK1s=;
        b=g/0tGw9obqPdD8z2Oeg5hpmKLOXovpL4moPo5uBYqLAh9bkdc4B1/1L+RdXl1IKhg9
         YySn4PTTxFIjFMTVlpeiJTFulcejuJcpMvVsJ2JKgop1DzIzJfOTVYxKe8gaT1INGphp
         Mv7lm0T5NiyI4yBPYQglUVMSgIJpZvpYv7B+mba+obQMFCbVwtZNjH+y2aZ5DJMAeOSG
         kYwn+zJc0EyEDt0k03EXalWQOX+waLwYXqghey3kK3RdmATzs6i5xe385KRtGPwG3Qu7
         Nf81+gikiymGskzuBQZ4cOCHkOb/+m00RXOcPH5uyQHVua1BmVwejQ+MiO/sDrvoVg2O
         DXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687367919; x=1689959919;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PaKDV637bWzZlSeQkWzUA6xTOGBkY2/gSgiK7N2MK1s=;
        b=GczojAtNcjFhQ8BAzHn9OtYWJ1eKxuS5oHi2Hvwe+U4852gI4xPtjjEgE/vwd+RBQJ
         jORvtlghXvLvtH7YV8YXo+I/CrJl67WJcJFxR+0fZg9dBaDCY9mxrdGJ6tCQMO2FUGPu
         KshC36nJYs6Qj5SbjrvOIplmMjwnhhxMFBvZm+8LFbUdYLuh8MyHQFHct+vSF+iWwLIv
         ABJ/KDvkBzODIN5Z+frytpKynNBghoQliawhOJz5/6Jha6VxtlH4dVlMrmC+EVT9SFWF
         ydPFdIUFj9WxfcDt4/bTWIM1k7ZfgyBmhLiDcrI7/UZjzhMUQVS5W95Zq6Rm0QDJI7v7
         FJKA==
X-Gm-Message-State: AC+VfDzI0R9YW35wYNy+T6+jnFOd3BD6SdDD0Gv1XKsYDLe3ZWdOsTbS
	aNlXnoXeFC1Dh4IDRTlfFZfKebQVMoeggM471dvVPBaz
X-Google-Smtp-Source: ACHHUZ7X6tHhGAkihpC0VfpcERt6+teVGAEOfwvUn26pPh72WMHJ0Gk4GzlW0GvdDSCOk03IQU04hg==
X-Received: by 2002:a05:6000:7:b0:310:7341:77fc with SMTP id h7-20020a056000000700b00310734177fcmr11260757wrx.71.1687367919240;
        Wed, 21 Jun 2023 10:18:39 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id f1-20020adfdb41000000b0030ae499da59sm4930027wrj.111.2023.06.21.10.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 10:18:38 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 21 Jun 2023 19:18:14 +0200
Subject: [PATCH mptcp-next 13/18] selftests: mptcp: pm_netlink: format
 subtests results in TAP
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-mptcp-issue-368-selftests-subtests-v1-13-0cae453ae1fa@tessares.net>
References: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
In-Reply-To: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2199;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=1HhSdQccxk0WXr1pWFoJ9DJKu2bvw4k4+rohrEEu+w4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkzDjUwR01OmS3gMkMH5/96hOcW7e0UKtGKWEQ
 MEwOT23vxmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJMw4wAKCRD2t4JPQmmg
 c5SFEADWsm8Y9zQoUD94DWeEHvSnim/EcC4O0XunX+UMHKKiGwLcnr7Fn2o5w2zC1aipLSAd1jF
 01udph9xhyYkk6p8FBbyT0pPQT166NxQwSJ1QWyd2lXXzS3a5BuZEDEt4tg2KOHajJzjQyi+kzr
 FtW2KNOW+YoejMI+sEpIQ9fRvLEkACXn1pc2qO1xw1GNr3DqJC/+IBetYlIA3UEBKA7qMOPsE9H
 itNwKVeVfY8fujtK8idh4ISNhCFD5kmZ8TGApvvqptz0jgp1DBA9KeZ58IRPZoZ16o+o7/BcVEJ
 BxI38CnTtpTRzvPiv7Sj05X/OhjZQGwGiGqQBv923gfLo38C8r0GKGdOMoYOtxo5KPRdMMFboOv
 rceH0UUiSYjM5Rf9PQWMh++SpmHDuy/RL9r921BPMMyALfRaykcVg1/Hy5XA+55uSS/G2lvgTsL
 hPvRHq+qGgKakXQUBKsboQaxARuuOsIoSGFQdD+bcChBJrQxfA/BeTmHii476ZdtBliAly+q0Hn
 kSe9PGQuC28ZivZfIVf7n5AMTv0FrkuSuz2eoh20VGAHxPw7YYS1rm2CsHT/4SG7OyR9ad2x7bV
 U0Dw0uCXzHCvjKhNg2/JbLAl11SYZSUCxok7lOjk22aTbbjzz5+7tMzi1nFFwwY7k+vqLVgR/dz
 eStYQOzMb54kNMw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The current selftests infrastructure formats the results in TAP 13. This
version doesn't support subtests and only the end result of each
selftest is taken into account. It means that a single issue in a
subtest of a selftest containing multiple subtests forces the whole
selftest to be marked as failed. It also means that subtests results are
not tracked by CIs executing selftests.

MPTCP selftests run hundreds of various subtests. It is then important
to track each of them and not one result per selftest.

It is particularly interesting to do that when validating stable kernels
with the last version of the test suite: tests might fail because a
feature is not supported but the test didn't skip that part. In this
case, if subtests are not tracked, the whole selftest will be marked as
failed making the other subtests useless because their results are
ignored.

This patch formats subtests results in TAP in pm_netlink.sh selftest.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index d02e0d63a8f9..f32038fe1ee5 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -58,16 +58,19 @@ check()
 	local out=`$cmd 2>$err`
 	local cmd_ret=$?
 
-	printf "%-50s %s" "$msg"
+	printf "%-50s" "$msg"
 	if [ $cmd_ret -ne 0 ]; then
 		echo "[FAIL] command execution '$cmd' stderr "
 		cat $err
+		mptcp_lib_result_fail "${msg} # error ${cmd_ret}"
 		ret=1
 	elif [ "$out" = "$expected" ]; then
 		echo "[ OK ]"
+		mptcp_lib_result_pass "${msg}"
 	else
 		echo -n "[FAIL] "
 		echo "expected '$expected' got '$out'"
+		mptcp_lib_result_fail "${msg} # different output"
 		ret=1
 	fi
 }
@@ -193,4 +196,5 @@ subflow 10.0.1.1" "          (nofullmesh)"
 subflow,backup,fullmesh 10.0.1.1" "          (backup,fullmesh)"
 fi
 
+mptcp_lib_result_print_all_tap
 exit $ret

-- 
2.40.1

