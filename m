Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15D815491
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:47 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3f6a6b9c079so44038375e9.1
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542607; x=1688134607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BfALGkbdeZqYn7xN/5Z0nHmjpPlv4+uPxFOZ58/bR6w=;
        b=oD2EJXvz5VSK6ey/Tp4e2thr1mszBOq0QI5O1kdvCkadUsKzF9R1xD3AyFSGMweo+h
         qnMO9ElLm3WIWXLVkLanmZsuInwpuCwIOcQ2GtMd+CRr0V9+ga7OmUtuN3nCmosZHjDy
         jgwJMFT2WfGwFwWk2DAosHc+NWumQnA24Py/2dUmiRnHHdFAtoQjm90KLVJQ3YgRlVSn
         89clejzTk5zMIgqZ9kqmwgJNR1DqTQ7xZmB99pt2aOrL8cioYRnMO7TjlZJfHZGWuOeG
         OZQJ3aDIHMut8DLVg4eRhhwGLrvnVt/J1iygDuB1cL7AIl+Y+UNLLstmzDoMWUY4IPes
         0ynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542607; x=1688134607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfALGkbdeZqYn7xN/5Z0nHmjpPlv4+uPxFOZ58/bR6w=;
        b=SgR8qAS0Y3MIaUREP2Qli6mceLVkz8pVl8j6yHaXBPRjpmIrijIlQw7s9AiIml0jiW
         EiXZDQ9sP9RUnrZzpNDWDQWtEtLbcqdq7jmQe3gJSdjfmpOPag7gIqW+h09mXBNqRDdO
         P1fr43FUmaztkGj7qosh39qEmXVytleAR6i75ESXK7/Sxj15TCjwvxKBEcSgM3esGQpm
         FwPAIrLuom6ehEkX98mS/MooHeDAwy+qbJriuDT3t2Xqh3K/5ZTvyd6ahkMyAMhNWqnR
         arjAJUStguPBx9ZFQHIewp607zeevEUa+1AyZjA3Vtn+P3gx2/WNaqey21DdzM4HfFZ6
         NYbg==
X-Gm-Message-State: AC+VfDySVPG7a814uekHHjfg36RW4YSc5SPKw3p8CIOaTdR3gu6mYfJc
	byqvRP19oP/5vA3nB1YwK28a3dETnnF8I6llhWRlx2HC
X-Google-Smtp-Source: ACHHUZ7fqdq6NP7Ogk5FN6j8LlFlmN04w+V0/Ii7Z5PKOPfSetMBShGZD3zgddDb0pQJQHxrA41Kng==
X-Received: by 2002:a1c:ed14:0:b0:3f5:aa2:288b with SMTP id l20-20020a1ced14000000b003f50aa2288bmr4250543wmh.0.1685542607363;
        Wed, 31 May 2023 07:16:47 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:47 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:34 +0200
Subject: [PATCH mptcp-net v3 14/32] selftests: mptcp: userspace pm: skip if
 not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-14-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1277;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=JbY9QbYLXxn3OEIxSLexF1YjsYYuO9zJrwO1xHi6YGI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bDGhgkBQO2/bhE85SFjAc3PXY/bvzjEWNxP
 U2iXj12E6CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwwAKCRD2t4JPQmmg
 c9iqD/9p99Q5Sj2KW8tBOK5zTJAJ8XmGS5MLgc8V3BpP7upQ/c1dFyt1IDNa8k3HL/YNimdjDYz
 KsM+FEq6uRWH33CzJIboVXWFs5eOGBxC1/LJ26Qg/O4hzVcJ/sL0l2a0Wyg0zyv0NkBnBWZkeGO
 gS0J8epqWcllTbQqjX7VWKAW5ErJ0yMKef4dfV3ezGyYs07tfa2BF5DaXnnvxZjxhbYWhG7VTsk
 nMuB9SzdApNX3L9BN0go/DfwJBBdiLmZnFLiB5QCgcTscBDXk55uYrr6aK93NscbIGlyHVsFa5c
 5tJqUnuXvmth38xGZhtVAZntme0feasliDfeOovOHufm1888AaAy3zhJdQyyyjuHbRRARLPiD/3
 dGke+XhM1G0bsuj2xA851gv0OHuKnGx3mJv//DEtUb3FXHCbRWiujAx0eZN39UOG4HhovbYWGWh
 ID5zEVm2TBgaUKCT6aBtJPnC9gpNyh5AYF+eePNfaXxviewU5vKFAKqVWdVlwrr8oHojvZya9Oa
 R1s+UyxpqeEDPr6Sn9PKYbGE8xqLK5SwDAgBzTvfMcIa/N0Ca0u6TP/rzLAoEpjdNHIBFsRN/3b
 /kwHIizNsWiFf1PAvv17tJd5gOfwK9YRHhXVoIvVdaWt07lwNv52S5mPQ5OI+cq/cR4hrLmM14w
 IftRrkjplyL3hFQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the MPTCP Userspace PM introduced by commit 4638de5aefe5
("mptcp: handle local addrs announced by userspace PMs").

We can skip all these tests if the feature is not supported simply by
looking for the MPTCP pm_type's sysctl knob.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 259a834fadda ("selftests: mptcp: functional tests for the userspace PM type")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 192ab818f292..38a1d34f7b4d 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -5,6 +5,11 @@
 
 mptcp_lib_check_mptcp
 
+if ! mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+	echo "userspace pm tests are not supported by the kernel: SKIP"
+	exit ${KSFT_SKIP}
+fi
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Cannot not run test without ip tool"

-- 
2.39.2

