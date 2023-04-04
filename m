Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680C7BA5E
	for <mptcp@lists.linux.dev>; Tue,  4 Apr 2023 16:21:47 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so16864894wmq.3
        for <mptcp@lists.linux.dev>; Tue, 04 Apr 2023 09:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680625305;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ubx3MQUPWg6unx4LWqtyUQvZ1AR6jD91oSAls8W6oZg=;
        b=mUDU472xUMdXByVnpgyT28KUwHhkbm7DsFpFhzpJgLKKBPkYs8ASJmZHZWzHdHukUv
         Pg50HiDRqUOxqIQm7k7VhvG3F0uql83oo87ZbwZoiZnvKJdfjpfijt7F39EHkYuZtEFu
         MQUTUFnzc2Bc/zqFWO2CvbhG91vLFGeQ83qq+ZK21bxNeO0NiKrCsUt3ZioZvTWOZIeq
         0bY4gKn0IUHJbvHxft6zFVq9NW6CBQl1j/3dcDOvd6pxz30gM3O2XxHEQhWtmLDfLf4A
         sfl1f4AICUHZ9HtMV202Hz0skc85EKVONRABL3KtQp/ShjWpsvlOYhCWPLe94LJNLPAo
         XZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680625305;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubx3MQUPWg6unx4LWqtyUQvZ1AR6jD91oSAls8W6oZg=;
        b=fJhA5q2aexQWYlnuUDWtj7LcWoPQb2QCmdz+5xgaN3dqODJw6s1F1j5Ft11qJZctZ/
         KtRqhUoyb3ipkZZi+BcS0hkzSCGDIfpCYlqvOnaXE0iGCJ7RVslieHfpq5Q0xKvsW4Uf
         RnSD4WZFvXwgJCrCZKOmiI2uECAj8fpIi/MamPk7VcbsJckwQRSS4mfbkOSd/G6JwTiC
         fNqM9cE732snNjauUycMUUqjHoW/w+3qR/HCaOLM5wEMV5FphcQPO/2WQsTcQy9wPWKA
         S3PGdrhfbcxCcudPyUwvD8SAwD9xY8e0Dh/2+KyGYRYWsCenYZdfrBlRRmZoRuqopybr
         lBVg==
X-Gm-Message-State: AAQBX9fVYWQKcL4wnChDBw9ZiHd0nH7dw54CWVFIkUN5kSDrySFO4N1M
	AupYsgv8QE/rZVYYtc2Bax//2g==
X-Google-Smtp-Source: AKy350amYp7+Tl7Gx+2SOMER6SuYbEYzcirx3Jjt9LrziXqJEz3sN2yHB4tZAA9wF4yVpgB3E+cmNg==
X-Received: by 2002:a1c:f617:0:b0:3ee:672d:caae with SMTP id w23-20020a1cf617000000b003ee672dcaaemr2599287wmc.36.1680625305237;
        Tue, 04 Apr 2023 09:21:45 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id u14-20020a05600c210e00b003f04785699asm12379689wml.43.2023.04.04.09.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 09:21:44 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 04 Apr 2023 18:21:28 +0200
Subject: [PATCH mptcp-next v2 1/2] selftests: mptcp: join: avoid using 'cmp
 --bytes'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230404-mptcp-selftests-join-busybox-shellcheck-v2-1-9113fa4d2ce2@tessares.net>
References: <20230404-mptcp-selftests-join-busybox-shellcheck-v2-0-9113fa4d2ce2@tessares.net>
In-Reply-To: <20230404-mptcp-selftests-join-busybox-shellcheck-v2-0-9113fa4d2ce2@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2162;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=hj8xkdAAxtqOEHRfyYeQQDqXa8zdjQz+N/n++EvYKSQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkLE6X62Y20noRVBRyU9lTG6nedbCigIILFX8Nz
 SymZffzjMOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZCxOlwAKCRD2t4JPQmmg
 cy4oEADXfpWgLo0+dKeoImNflcZexzDtAzi8G6pVng5k2fuCH6dtueST6m6VaKqd/jgwD//IY8d
 t1XBZysZ60iJtQhp92SurxiyqjbT5y1A/4peqAd+cdZ7rCdBUEmE7Y2yvgORDPHL0Kj6h6TM5yb
 x1QASmn8RwA1Qbaq0vwUM3LzGvhkZTHc+D6z52TItHCN5Mg8105q4n9XXlckZ8t+EELOdMUMdw5
 621AHWXxHwmLslbnMV9dPz9n5uM9cb2VpVaCsn13TiXAKcQAbginpIHAAVxcODSZpyCJnCwkqnO
 4Os0tqlWbNSSbBlMem8M9bwcExQdeVR5LbxcGTqazA8CKt7MgGh9Xs2HPTdrF1/qkjnszGCAOy0
 76K+tEHIR/jiFNHWX13+x1REsqztB9po+FP3vSKLEHLEp4MAyyT7Z1NiRAuMKwwNypLAJqa0bRX
 1P6S+0M5MUyZ45Hcn4ewbsUptDQw9/xD85+ad0N2gxAAzq2UjoLCsET/TAVm15dlrW/1610nH3S
 1SbLCvuOdYU2GZCr7ZHZk0baJFi4ogPz7JoKIXfX25sDu2TzghFgwhnVU5VN+K03cP69OOly61P
 e9y64frEq01aYYEEG66uYWx4B8FEQhsv9bLJWemQ9i2bEwtzNLup0XEgbKzl4RRcMAjKDaVUV7B
 sr0yhUSycxjDGng==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

BusyBox's 'cmp' command doesn't support the '--bytes' parameter.

Some CIs -- i.e. LKFT -- use BusyBox and have the mptcp_join.sh test
failing [1] because their 'cmp' command doesn't support this '--bytes'
option:

    cmp: unrecognized option '--bytes=1024'
    BusyBox v1.35.0 () multi-call binary.

    Usage: cmp [-ls] [-n NUM] FILE1 [FILE2]

Instead, 'head --bytes' can be used as this option is supported by
BusyBox.

Because it is apparently quite common to use BusyBox, it is certainly
better to backport this fix to impacted kernels.

Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose test-cases")
Link: https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.3-rc5-5-g148341f0a2f5/testrun/16088933/suite/kselftest-net-mptcp/test/net_mptcp_userspace_pm_sh/log [1]
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
v2:
 - limit the input file, not the output of cmp...
   (strange that on my side, I didn't reproduce the issue but the CI did)
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fafd19ec7e1f..bb26c406f09c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -378,9 +378,14 @@ check_transfer()
 			fail_test
 			return 1
 		fi
-		bytes="--bytes=${bytes}"
+
+		# note: BusyBox's "cmp" command doesn't support --bytes
+		head --bytes="$bytes" "$in" > "$in.cut"
+		head --bytes="$bytes" "$out" > "$out.cut"
+		in="$in.cut"
+		out="$out.cut"
 	fi
-	cmp -l "$in" "$out" ${bytes} | while read -r i a b; do
+	cmp -l "$in" "$out" | while read -r i a b; do
 		local sum=$((0${a} + 0${b}))
 		if [ $check_invert -eq 0 ] || [ $sum -ne $((0xff)) ]; then
 			echo "[ FAIL ] $what does not match (in, out):"
@@ -394,6 +399,10 @@ check_transfer()
 		fi
 	done
 
+	if [ -n "$bytes" ]; then
+		rm -f "$in" "$out"
+	fi
+
 	return 0
 }
 

-- 
2.39.2

