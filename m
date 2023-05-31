Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1759A15491
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:49 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4f3b9755961so6701265e87.0
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542608; x=1688134608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hlWfw88eYnHZQLPYDvP0JzIhuYT6IbliwX/cY1enyT4=;
        b=SKa/J7muI85dCNlJyUwE/pQtRlTwpdXW7EJCpxuJMj6k6yRStt8N4evLrWc9gcHSRg
         suh4jQiGfPqim0c2aK3ALzdoW+z17b3OVdXkxG/WLf49yVAPgMZrdwqGx91QHwWX5M3F
         ZVDtPAjhkGnL3i5MGogDexTg9ToLFjQ3Xz7P89IEjteorDhlTz5ALLUHTTrNj3YIoEWQ
         KWZp0vMxK7VuLwrZq5zxCzXhUOqmRas95FBQu4m9FJOXjs24lBTKsAKglYz5dTndlQQR
         kXq4Q2z8N18kR3OkI5ysMp7gY0Kbhh2JU/vK8z5v6mLzgc5DGyFazSLZhIaiHScAxzRx
         LrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542608; x=1688134608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlWfw88eYnHZQLPYDvP0JzIhuYT6IbliwX/cY1enyT4=;
        b=Wx++oGGLnNKjf+fowKD3GaMsVopM5pei0njuabnCcoIS8P01iJXIdpRYHJvuLLj93o
         7E6mJQ5mC6daxO3TLwlWyM2JbwGKIPgAfAob/YOb1iLsaYhOkt5xqWfWy/XKWcnJaH5D
         sIgq7HHhUrzrcy6YPcXeV9qsYhMYE5SsNBb6WLgB8WE7cjPFgEVT1UVTfVR+e/izuucA
         mAU8Icq8dr2BWR2L84ehtRo4Ua/CvQPr+dcIJ52JqnakAUAvzok285Y9eKRbo9NcLoF3
         +IDXZc6vku0tAUlbNqgXKGWE5wDTMs+dJGM3mcp1cz3ecfmTTMAGqfSotGahF8v72Kmz
         SpMA==
X-Gm-Message-State: AC+VfDwtWWHn+yTY5HIrR3sHVqqL/ohWBBb6BURvPvIIbfLpUAzrndch
	93CK748eEUheBk1VBdnhZonxYg==
X-Google-Smtp-Source: ACHHUZ5Cl09DQL+WUceqbbgPCvifpCFMzBx2244YAevU43gH0aB2u/B9NIUZ7P6uaQ2xexZNScqU/w==
X-Received: by 2002:ac2:485b:0:b0:4f3:b49b:e246 with SMTP id 27-20020ac2485b000000b004f3b49be246mr2901183lfy.5.1685542608108;
        Wed, 31 May 2023 07:16:48 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:47 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:35 +0200
Subject: [PATCH mptcp-net v3 15/32] selftests: mptcp: userspace pm: skip PM
 listener events tests if unavailable
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-15-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1621;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=wo1JLrvXXpEhA/1pGr2BkFQUY2u/ZSynFAbghLPp0/k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bDA/0Cu4adZgJ5hYyXB5iEaa4qOaF4z2SC7
 YPlTN+sUMGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwwAKCRD2t4JPQmmg
 cwMYD/9Z3SkBzLjFOJ8I8qGW5upmgslz3KjMioEL57grWJ3HF0vcbVHrUWblKAITpTt443Y6khB
 wwIlOFW+CeC7lZnbOBhRRbUh62SPPuY+YCYPU/pTnMjuARPivk64ioBaQwPIrLGMwRoiV4ZEaLf
 a5CiLQbs1HcyLgX1Td4OhsFGCAs5tnd2DII3qFzfs8l+VugZv1cFwB3VRi1aIW+e5YzvZJusGC+
 ziJ4on3BfrNd+eE+oLdB/9YGa8bZk0doYb7wQjtXsIqGpny6YelvvQcyW+t3L17g6/wnWwpHM7B
 Nnoq+5gOk7b8wKjkuAp/p3D+ioC/w1NVRpwbgwuFpZZyINr2rsj85GIj9MMyaEJN5efAjdF/Y2K
 q7kuhLsIbhVoz38RpKKiwuipNVSsarEaIvgndeQQeXXY3r/tkkNUOGtDEnu6h48jDlKi1s54Et8
 US4Hnjoozun/rq0tTPLlu7/BjNJhXHdlT4XL0qJ97r7XUu4NGlHZQvpQmA2Mt0OuaXVD2uS8uyY
 KEC1QSdmwdCPeDHFJRyXexVtOqDOhpDnvdBSa3XdaUwsbWdD/F+PNACrggp/HJDc6+Eranzjs1S
 Clj1VTmakl86vj+UpHRWTpK49eCciKTbbAOHHXbhgMBczEDCMiLj4Goa2Ottd0ICt5aUdXwDWG/
 KFLeTET3VAkedvw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the new listener events linked to the path-manager
introduced by commit f8c9dfbd875b ("mptcp: add pm listener events").

It is possible to look for "mptcp_event_pm_listener" in kallsyms to know
in advance if the kernel supports this feature and skip these sub-tests
if the feature is not supported.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 6c73008aa301 ("selftests: mptcp: listener test for userspace PM")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 38a1d34f7b4d..98d9e4d2d3fc 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -4,6 +4,7 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 mptcp_lib_check_mptcp
+mptcp_lib_check_kallsyms
 
 if ! mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 	echo "userspace pm tests are not supported by the kernel: SKIP"
@@ -914,6 +915,11 @@ test_listener()
 {
 	print_title "Listener tests"
 
+	if ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
+		stdbuf -o0 -e0 printf "LISTENER events                                            \t[SKIP] Not supported\n"
+		return
+	fi
+
 	# Capture events on the network namespace running the client
 	:>$client_evts
 

-- 
2.39.2

