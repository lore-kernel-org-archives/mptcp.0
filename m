Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AB313AFB
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:27 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f601c57d8dso13479585e9.0
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773506; x=1687365506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BfALGkbdeZqYn7xN/5Z0nHmjpPlv4+uPxFOZ58/bR6w=;
        b=xcUt8yJ+/Ivu20Zc/Ihx/i92T32pqE7DnbK+uRqYvEZxfYY1bLpIBKPZekfXnqiWW1
         kFnqQqFoCeiWwxOKtJAX5VEH/nHPDLLt8n/RmwU2t99EeIs1ROdI4lgcv2TqevCyGDN6
         19d15LU0v8bNFaADF2EU87OadxDS0uoJdhbzemjATAX+UsN1qA3RKVVFpF4Km04dc7/i
         /k64a+CoTJqFfg/awkI1MXEuK4fOlopBHreIS5d2OrUtWxfETCv9WQprNk9PleL4S/wM
         VtzkIwQCRDcDcQzXLUGPil78u+RVMHpZdLpkClq2vhFkgOb3+Wbvag4dwB3lOKS2lFzK
         QBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773506; x=1687365506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfALGkbdeZqYn7xN/5Z0nHmjpPlv4+uPxFOZ58/bR6w=;
        b=RzX8PQzl5e584w30JjzabgE34uWSgB7vZlxSDJlxOPZFx9tq6dmIi0pZtsO88JlvrT
         M0n9PKtZuoVeVMOV6jKcUjCFmi0AREpostNlYgnY8pgSN39xvDVtTSX86h8jhYSycaDz
         4Xb2VI56SWxT41UNinKkfCU6JBKJroc6T490ahc+JPo68YaTSPmPNPTlIVg8OAT9QHo9
         kHE6/Ch+owQ4l0DPc09kaIOsSTCMatBsXKf8THHL7tmdt8PxLzAQ/9krCRQTTEdAP2an
         gRpEWxGqJoliyhhX/YXoacHAkoJy8c4jsCDQl/QYjzzd+28n+0COFCw52pq8U7M/5uEd
         PSSA==
X-Gm-Message-State: AC+VfDxSSlavMMwNxaqFJXA7UrgllRL/dsbgvG3eBFYd2ahyLr8vnLYp
	Qg1/8HmzH7ifPzvZCgGdAwOFLviz+Cn2GLYTygACHg==
X-Google-Smtp-Source: ACHHUZ5hPMCBCx0Rz4yZ5W0r8UyIV7NKi4p08AK+gvUjSBwiERiGuebc6AaXkSmG6z5saNCZKv1UGw==
X-Received: by 2002:a1c:730e:0:b0:3f4:2d85:bcda with SMTP id d14-20020a1c730e000000b003f42d85bcdamr8116087wmb.19.1684773505854;
        Mon, 22 May 2023 09:38:25 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:25 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:53 +0200
Subject: [PATCH mptcp-net v2 21/37] selftests: mptcp: userspace pm: skip if
 not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-21-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1277;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=JbY9QbYLXxn3OEIxSLexF1YjsYYuO9zJrwO1xHi6YGI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pwwyhzyStGeeuaPSEXesFjeGWvBXg0yBIBs
 XgmCb16nAiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacAAKCRD2t4JPQmmg
 c1z3EACOzUOC7BRaeHDY1BQNaLUSjlQjjiO9ZMc0XXLybmBbAlHlMP3u+gjLeCbCOqnwsgQIBVa
 Y7yvFW23rg5Jh99jJT8Luv60HLVOVr0iYXuAFAQPOb7eJpOU6iOPBM6zGjkvj/u9Hwa4IVOzWZd
 rUZEr6Hz3L4XzdaCwa3PMwYCH72wqDy0ljQ+GT6RTG6+NTUenWxGDSnst5TWPBGCFD48KvJk7Lz
 ytJnxSojqQobSG6fYUH6oNpOGaBCA+P+q2tdgNOoy+Z4dQJCxRaJjLKHoNsxuy1twnpr1nvrgVR
 GysRfuaVvglblx7ml/ce3IOQa1FZMVLYM5AGKcZnqN+vfP0XYwRNJIonJ5kk44/Sf0N3OkGFs04
 bJNgGi/l7L8odHpDQ/jAsPzoQUTeVjLxyKVWapFeBJeRlpc7sFblhlBGx2qC4L2S/eBIVJ1rHGk
 X3gFp0Hcf/5QtQ0xAiWP9sTSB59eNUHaQ34zl0sdVdmvsnPklCYR01sQFarkuJcCsXBLQ7N2zOB
 lLuhwbCbMO0lMXKbUmb/D9pnnTL0wRIdKqFroCE9c6yHG9GKppeQe7sH06nO5FS3QZiJx+vktKn
 MFMaXWlKaFHpIJau6pqYLx7jBuK2E+qO70gRWHYPSRkC/RX3ZhgUtbDv5OpKfVwuTKatpXdlRZF
 Rc+Val04rj8jZ7g==
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

