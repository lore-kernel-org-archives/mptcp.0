Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48986FCA
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 17:07:01 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id v1so42791213wrv.1
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 10:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680887220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzVj2jS46RKCHXMMWdHdwHynePTxdjZ49eFuggVzylM=;
        b=fX0tR/YNFttMVshaQNd+WaVNPgpnFlu5pCDd3FCNyTrQ44+CEgBN3flMLePvuIjPUU
         rTLqWizEeIoZQJ4KEqswcCQTaZw0K/xFWXgiz4Cp3dBsTIcI3hLRcdgpOtY0czqUzxlP
         hLOD9RT9gMgR3umEsccbRycvAPzRybvJU8yEimVe7wtIW52Ik4qB29QjZcmfZjPE1w0W
         FgJki4pQHB6Kq1zIUvfGblOC2jdCSQd0sQCJXN96wSbqKKyxoH1H1en7ge3GSYfGoYHi
         SwQuqWzaI9AMokSXvbK1y2JPNVvPjElcP/ZUlXIyV/IT7zesLoaEG62U4w7YlAFdVOqC
         ZcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680887220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzVj2jS46RKCHXMMWdHdwHynePTxdjZ49eFuggVzylM=;
        b=ZzPunoWv4o8fin4aT8e4INsiFVIH9ybYm1tMeJqPpo1uwlxCSZkRHZR1RbXBEMTEYi
         k43KsD6nRto6uuUPQoIvivW8Dm+srAukD4HAhmMUTvXMS0GjY5hJxubnocXF4vO8fjQ4
         hdpF+r7s87yV7pTO8qMOEmoQPYjWXiQk2IOwQpML63bXG9QG3xXZY0WCx0nLhVoS62u7
         HtMhwAACyGe4iNBgOjJS6LA7ZEytN7XbwqMZNOapWDgpJhb2UEEFgkEH20sR4z8oeRD4
         8jGdEMR17P3XZ5myCHLrDajfCn83y8r+OMqR86q3rrdn72oJVo9rP+P7DmQMplvvzjTO
         kI3w==
X-Gm-Message-State: AAQBX9exbPU880KhYj+O/kbXAYNrhoaRKdqDUdlZZtAuWCDSMgxH6fMc
	QU7YddE7JlsonciKL9lT2s9PtToYX8xjLvFQOkfZCQ==
X-Google-Smtp-Source: AKy350ZSE3S6dLkOxy3f4HnQZpijZTx9ezYHg0lw8t+l6aK51CKd7jESe08u+jMLYXsvc9WXWE287w==
X-Received: by 2002:adf:e4c8:0:b0:2d2:1195:bf9d with SMTP id v8-20020adfe4c8000000b002d21195bf9dmr1784758wrm.22.1680887220176;
        Fri, 07 Apr 2023 10:07:00 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id t5-20020a5d6905000000b002efb4f2d240sm908360wru.87.2023.04.07.10.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:06:59 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 07 Apr 2023 19:06:44 +0200
Subject: [PATCH mptcp-net 10/13] selftests: mptcp: userspace pm: skip if
 'ip' tool is unavailable
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v1-10-246ac567724d@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=924;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=rmiyUXE8j9q5wswhMTcVhVwN37ud7yZhRKSf2SLIXtg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkME2rb55mudjhr8JiGJi66kkFYzNYkKjgTm2Oq
 L/sKTVc9OOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDBNqwAKCRD2t4JPQmmg
 cx1CD/9JzE8TmGJfdFrMuJMAB/XPrwfV5cDiN6IFeG/e/hYhN2259bE4zOEPqqbFRHiAsc7A7IW
 CtGam0B+q0BmlpsIObp47k3NiSgXSHFZCuXG8yOxWN63i4/gDRb9rE0bRnuNhfPB8TUE2Zg0ro7
 IQblVMx9U/cHlqFUi7UqtH2TF8dOpiRLiq2M0k5Rn+VVIbz89VuEF4IWplMEOI50Rn1kNnRrKp8
 joEYjPb8jCwblAMA05DHdi0QWuyjfku/PW9cC+RGIVVjHZLFkyMbWgRsRcMPcb2V3SiDoj0LcVe
 KF2wuAMYXkMhJFfn0r80jv7ecR2yCI+2KR5wKxH27pCO4rRouV/L7cGvYAKj875QCjWgHSCpLx9
 EOLSmFWBCn5Rdj9e4Srba63RztiQox1W3Bv1T/QIXIRP5eZjCTsLe5urULYFRFqKn1l76wuvfJd
 IuRDhMuwWIbhyI9ozIeIbqIwLRnkQsA2HNMBlOjYOGyC0e/gYsb2fAefOK3Pd9SJhptypTP+NXs
 WlKTsrbW91q0vIqgXBZiV9u0ePJF3IACw5crvbqwZmbQOQE7mRZnOO6ZvIe4bZDwiwuW2TPoQpC
 s5E0oxQ4t/Da3PAX+f9/vWf1gC3+p3wr6hM/PZCUdRgUCMyA5RjjhAFZl9Z+r+p7qo0cRfQ6IHz
 AyYdJF1/FxlPrSQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In case of skip, the return code 4 (SKIP) should be returned, not 1
(FAIL).

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 259a834fadda ("selftests: mptcp: functional tests for the userspace PM type")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 8092399d911f..192ab818f292 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -8,7 +8,7 @@ mptcp_lib_check_mptcp
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Cannot not run test without ip tool"
-	exit 1
+	exit ${KSFT_SKIP}
 fi
 
 ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED

-- 
2.39.2

