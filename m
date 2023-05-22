Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36A514287
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:36 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3f423521b10so41344815e9.0
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773516; x=1687365516;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2xLESG8dgMs5QEpA20YyibFT95YW4BEOdcj6E4R8Qj8=;
        b=KXvF/1/040sFnWYNn+Jb2K5XrcYN7siXEIfFtHUXS4l+HxOfPg3r6OF5+Bf/saxohU
         YIoVUVDpPnyLyOve8nPDBDO8wCFQLA/4Svf3DQkgE2TH/iiIe+KecYMdkFTAUS+qD9Af
         b5mhJadPE0I4NoT+gznttnQlqWPl78ukLwjUOcZ9TnYu1ciA1eWblKwsA62AGLNLrrZk
         H+JYZRdK4X2zm7Uaf/4t8HfTvUNhvWk1ekLLRyJK339VfhX6Z7asSodtojLjq2H9Xym+
         Ym0njJQXPSz11rVN3ZZkluHIvDrKr0s/Ky433cBTdcO48H2mDqC+NyLVvq0+aZuwXH1o
         s5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773516; x=1687365516;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xLESG8dgMs5QEpA20YyibFT95YW4BEOdcj6E4R8Qj8=;
        b=FUnq8TNruWYf/aY/U+pRR2X1s9XkvjrMmZkBkFJPUzviKB/xy+zMGTqFNCgz5i3bfO
         UNNt9tVKMl78inYmQdBX43mhNTWAYQY5MbxjnYTKyr3TPinK1AWMxXXHKj1Q5hZbeTJa
         /529Umm5PV4BFr+gjPsQ6rKD1fbfjRXycG3hv1IOQX19fO/AFzteBbEzoiEctCee5us3
         zkmttzHgE8IytlTlA1+OIV13+oAS53RvqHgHhCSdM2Dv5XUYxHGlyFHKPexO/oLiD3mn
         KXrhgC/iC8/5z4j2HuDCU5S+7iUk7BMhG76vwrXaoLiFrSMBPM/GZni5MjadAgOt5DtE
         wo8w==
X-Gm-Message-State: AC+VfDzRkUpBnJYQdSib8c+4ZKSlwqNuwWw5Ug/qm4AzRqUu5Y+82/O/
	V0KcezUk89jpYcDt5a3EUKVVWKoQZzhA+StMCRhM8w==
X-Google-Smtp-Source: ACHHUZ58Ufaqui2ZAF+UFcJbI1tkRUb1YVtcpSD/cZEQVvGmUek7V1WTW3z3pK2zUsb1CfffiOSuAQ==
X-Received: by 2002:a7b:c8cb:0:b0:3f6:2d8:4823 with SMTP id f11-20020a7bc8cb000000b003f602d84823mr3870125wml.3.1684773515907;
        Mon, 22 May 2023 09:38:35 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:35 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:38:08 +0200
Subject: [PATCH mptcp-net v2 36/37] selftests: mptcp: join: skip PM
 listener tests if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-36-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1296;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=6rasK+gTJqxtvPFCxx85tIUJBEIGiV0S1/qSHeUNrqM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pxghAHgNf3GhPqZ4xmXSFUQ8rnhXh1nGIN6
 yAK0PEVj6uJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacQAKCRD2t4JPQmmg
 c+oID/9wf6JZF0wJq+/U50ZHJ7MiX8oBkqChUZo4pTh0Hj0He9Z1gN4X4MWPQdtV3UNPofqgfK5
 qg90LLbFMH5CN+t8fMO4Vmm2yniTP2nrWLA2+h5yzrhUcEGApHp//0jRwHmQzXlwS8mEKxRGeuK
 nZnQkeHz80QUp9jl1chiMuXJY+ZWgo4AcyKEN0ROb7G0DEpQCv8XB4fay2ePD2qjU289zdV1XzY
 9+5adnQAp5Tw3XOz0noAW6Vm4W0lCzkXRI8nntDKNJ6Q+olxyv76rmPwplXfIzq1mZ6wCyjt4lT
 OcME9WFCViR60tsVqIoEUr6ZzbPz3iUHXde+0/gLM2409NL+5nw2znMHy2J8xsQhmNj8zv/URqa
 Y5wTd9ls48W12iGxnjKBZDBJvgJF12oxLddsyE4DCJCy61qlZk797nbryzqnc4LfoXZbRHQCsU8
 zUUReigkioUgwXOixq8gnvnVOZ+CL9VafZ7CA4W3Xn2H09stNPISQ072I0/mQILsYHQUb4CLzYx
 CRhKiy6XmNPI+36YL7sjlMbUGH6NYlj2n6rQHHeaRkDofhrRHSXf2o8jk1ncDzSNGRw7k6CZ21c
 vTYo3WdfofOihknXeRPHTA9j/Oad16HtskSRznY0ArOB7c5Q5Ds8L1F9f+Ln8JCGC22diQvZEfk
 OLHjdOPx4Xp0I8g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of PM listener events introduced by commit
f8c9dfbd875b ("mptcp: add pm listener events").

It is possible to look for "mptcp_event_pm_listener" in kallsyms to know
in advance if the kernel supports this feature.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 178d023208eb ("selftests: mptcp: listener test for in-kernel PM")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index dd8633e98185..48d0b7993194 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2832,6 +2832,11 @@ verify_listener_events()
 			$e_saddr $e_sport
 	fi
 
+	if ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
+		printf "[skip]: event not supported\n"
+		return
+	fi
+
 	type=$(grep "type:$e_type," $evt |
 	       sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
 	family=$(grep "type:$e_type," $evt |

-- 
2.39.2

