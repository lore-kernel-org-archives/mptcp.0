Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197F312B8D
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 16:39:08 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-30ae901a9ffso832153f8f.2
        for <mptcp@lists.linux.dev>; Thu, 08 Jun 2023 09:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686242347; x=1688834347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOuYSg8J4w1AyHg8USLMCe+g5bUzTKHHhFPUeoHmJUk=;
        b=6W8hni56+3CAISFHLE0+aKfDczVpe3GSsC36gdTSCbo77FUGrxOafMNwf/aZA0P+lp
         0FjNRd6v+dFm42X//HP0dujYr+WFpb5sSkoc1qr6z0z3h04DYSIF2RV5Wg83Luzawvii
         C9u2Oh1aQy81go4yVeJvKLbWBtiUz4qjvhkguIOhfrH6FQskup30X5/DUx/zthL4Lkcu
         QEzSO8vytbsAKig5hGaAG21gVW0MV+Kc578GebqoPcjGH+pHywu1/yPgmbPI2vqkG2kX
         IYeXjgKxLZ0UFqON5AipdWeCLbPeNc5YV/5Aih+YVfvc4OzqJNYpleQCEmp2hVb3FVqe
         t6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242347; x=1688834347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOuYSg8J4w1AyHg8USLMCe+g5bUzTKHHhFPUeoHmJUk=;
        b=jsoB6vPZTqxlmhvYOfGQwNAUmUJkV+qulXmomY6FsDQgXczZtQY35CB3dfh17jjZ/L
         FnyOYY8gomtqROnUP4kLCWhC1di4EaFQKN5BQgpuQXgPThJv08FmXN7ac3oqf5VyUlaJ
         20aEnAIGEGlvPSmZ7BVqtHFMdsHbmbt5Jn1HEFO5GTtSbibWlLUFzC1cBtzxl7Auu423
         hqGncRba9beAHOBXQ3YCKLJ90k3FYCk2rmBpQ4gvohPrd2wtmfbt7qGSUiLrjqTblSGd
         0Vu2wU9UCwK6KZzhQU1Ju1a9uGVa6xqcS6SWxBBYkyBubHijW6xZEZ1G/cBIpdb3H5kX
         CYzw==
X-Gm-Message-State: AC+VfDzkegrvOf+uohxg58rdMLNNdN9rSGZF3akSTx+KZVfG80Lh+QdU
	I4eFgbLqBdXMsf8QJDz2XLvR5w==
X-Google-Smtp-Source: ACHHUZ4w5v555r5a47h8fcPCos9lMeBsunv8Hu1oUvXPAQm+qb6ALiRc0oXrG0SBcb2lupTKB4xVtw==
X-Received: by 2002:adf:e2d2:0:b0:30a:e479:66a2 with SMTP id d18-20020adfe2d2000000b0030ae47966a2mr11007108wrj.37.1686242347447;
        Thu, 08 Jun 2023 09:39:07 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e13-20020adfef0d000000b0030aeb3731d0sm2038215wro.98.2023.06.08.09.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:39:07 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Thu, 08 Jun 2023 18:38:54 +0200
Subject: [PATCH net 12/14] selftests: mptcp: userspace pm: skip if 'ip'
 tool is unavailable
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-12-20997a6fd841@tessares.net>
References: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-0-20997a6fd841@tessares.net>
In-Reply-To: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-0-20997a6fd841@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Davide Caratti <dcaratti@redhat.com>, 
 Dmytro Shytyi <dmytro@shytyi.net>, Menglong Dong <imagedong@tencent.com>, 
 Geliang Tang <geliang.tang@suse.com>, 
 Kishen Maloor <kishen.maloor@intel.com>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=974;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=LgQePFMCSt72bRADkX0FG+ALuqpXJ1DkTpc7juUL6uE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkggQaOPetE2lDIy1IfFY1CDe5VbXKJ63o3Gq1I
 uzizz8sM0iJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZIIEGgAKCRD2t4JPQmmg
 cx63EADsPoFYaIZvExp5hZTyExQrpDgNrCt284Hr4s/PMWfWJO5IhB6YBXDFrAH/2x6a+yeS9AM
 FeJ0RRhC3ATqR6M5D0zKgvWDDwn7zaxewmaIPzg8vEWBwL3It8pA62eIvUvPaMxa2Vw2edfDK7e
 zKakE5/9rrQI7Sw2T94n8ob2NPoqHX8GK2w7ZEJKjubDFCYjqMUf19S8d1TGSbwp9nQtxTmuFUR
 Evsolbryd5zzyvW9Lq710epCQr6ubnGsinRpRasAhDdypYxMqaGVRCIjiPcFqyxvoA+n0SsBwFv
 dlGqlJL0csZpGsM9mC4nMLyHE7qrH9aFthb6WT4WZAAD2EcxHpyxRGrgIrDwo5col8mt/cpP+Rv
 3Bl67nCJB7u3uZ1wxNTLAkn/Iy0wxzphM+OfprLFnuuwzgdOpGLw1DOoPTGBY2RUzG47qLgoeMK
 JXw0Euu6MY50IPJqrVDkcL+bWDPbH6nmnaFyLKRaqe+l3IqVeDa2lykiXbtPqM+rNE/D6JsoQg0
 BEglw9ycobAWVKiZylxQYyxR0wdqJQMxYTDOaoS9tcw6Fuoc6M7WzbqUG8z4rTHYNQwT2CscWQd
 96yohKQ65y0AG+oAZEu2Ay4BLu36bpJE9hlg2sE8SSu3EXW4AyNOD47tMF+dx70JS+sUQcwe+MK
 6gpbM2JvwkpJ78A==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When a required tool is missing, the return code 4 (SKIP) should be
returned instead of 1 (FAIL).

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 259a834fadda ("selftests: mptcp: functional tests for the userspace PM type")
Cc: stable@vger.kernel.org
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
2.40.1

