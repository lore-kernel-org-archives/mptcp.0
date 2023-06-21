Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8623F19BAF
	for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 17:18:37 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4f87592eccfso4660366e87.2
        for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 10:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687367915; x=1689959915;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uHtNdNXNxG2F+yE5LQDi4hyKLHgfMHZ+rw8kzfXed60=;
        b=TH/qIhSFQxVWsSeC7M7oHflqDuETbDjZmMWKDC/K+LiZf7SGIvaFvusguaxpGy80Su
         OQq2+VAcY4X2KadAVabD8PyLhHWSDk2aFbYnrzM8OA+b4jAZr1m+znOuyxRmUmd48j5U
         4Hxq2krqHVfRalEjWwhBKEie+d5l909e5oQJlyV9n9YX8yWsbLreFust0gDMBduw9PVx
         0sw4y9Q/2sh8ZMPWt9twTwmcbwOLauuk4C9jk4cmlyLSq0Vx7ibb5Jufbn65Pu0K8t9c
         WUd2E+EGU2tWATuPW9oBK+TVPtZqgk6Eem7lQVeG7KG1ce1hcaCRVwBSKY00skfwWgeB
         6cxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687367915; x=1689959915;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHtNdNXNxG2F+yE5LQDi4hyKLHgfMHZ+rw8kzfXed60=;
        b=DMcvQGt+qkCG49oE3lr/m/s8siGpP07kU2uefvGnJ3R5sT+osAqi8OGtCRUlOjvE3r
         hI9CUX9suxGR6rXA7pwszy3eqfBliuulh9bZjeJOh7i8MkNsVX+ZVXbLFRwZvnCnTLXK
         4RZppf9CPcwznmzDf1Xre0eXaO3vo9M6KO6IYzmwKwQW8tXnttQvj7u6NpOcUpEYMor+
         HceuuSH4hys/6/Duohi1wJMXe1dNNb2f+qsncIkNzDCgf//0tLTB9krgeW7BW/1bmPMR
         PyRtFjJM27RzL6UcHJpRSv3ZD0P5Fc/O2b0r0/1qBhjlFyTIkHfLUeRLW7ytjZEoyJXi
         hNSw==
X-Gm-Message-State: AC+VfDyJqu+PE0FiGgm0k7AUzuv4Otu+kGZXfdvwfPwTjppvzG5DUZ5w
	wKMXX0z88nFZm0pqHWLhcn/U7qjhrD/i2Nd1TjJ1NJuT
X-Google-Smtp-Source: ACHHUZ68Z3f+iHBLoSFEy1pbNL1erONUP2UUl+BZgkY2BFpdOS8r3ppUxgRLmOyBFOrkjw6SO1il5Q==
X-Received: by 2002:a05:6512:285:b0:4f8:41f6:5adb with SMTP id j5-20020a056512028500b004f841f65adbmr10488463lfp.46.1687367915238;
        Wed, 21 Jun 2023 10:18:35 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id f1-20020adfdb41000000b0030ae499da59sm4930027wrj.111.2023.06.21.10.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 10:18:34 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 21 Jun 2023 19:18:09 +0200
Subject: [PATCH mptcp-next 08/18] selftests: mptcp: userspace_pm: fix
 shellcheck warnings
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-mptcp-issue-368-selftests-subtests-v1-8-0cae453ae1fa@tessares.net>
References: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
In-Reply-To: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2147;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=0wg20bPslBWqR1FAmrhezfTh+Cxq7VuoazXeHHb4+YY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkzDjbFbKj89W5uR2EX7hDuR2jv+sYP8UiERaG
 BSrEIlCmduJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJMw4wAKCRD2t4JPQmmg
 c30CD/4nZyQCVCELCl2JsuGxUc353c0mpqU+OCG0iMSx/GnqEjs2v8UZVVz0hIAjShcHEstzkXZ
 K1h8OvMGx6R4yLriqtFhIWtbd1r2zg+KbZT/D5xkw8sWgJfMXQ9ZYR9uOrrNeO0n9ldY/ZUUkwi
 T172pe+4JQP1RPPzRSVdULblXrkAys17Y8z8j8p66tCtFVxE8gujLXeshOlpMtGl9dFWQw5fgde
 EIUMiebqwXHdLX5ALvxCsZOXcXnpZMkTL4y9vpGEs5Hahph0B+UNirsQLXXEYinLt/vaDbzZiRy
 FlTXUYSyZf+pyfXwO3poxkY4dQqW609vSn5YjS7IakgprvvqIqFiimqXkX685ydxd8n798hFUKt
 O7qwW3uIbbSy1VXbakvuWaCrySc/prgHRa+nzvQj9YYi4nXionexz9kPhAGuA2k8m6qbV5EX+9x
 ztb+yyj/KRlaqailTobo8Ae5UXJUDRiaIXz1vGTKeCn0SKxhvpWOvzH/ijKImMtkqT3IF4bvW65
 +06dkvWB/PkQXLs9GbMWkx3CQt0JqG/LxqjuHgYKxFoneyrQ8Z9kOa9KqzFf7SXX7eO8mJWBG6/
 z6y41iv3JqZOUWNmrWAYdKbOeNxN6/m+hJSrSB/8oDs2mR/iwdJphhIpjihzhNwDU17W0jR9jic
 kZu88YZFgoJfG5A==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

shellcheck recently helped to find an issue where a wrong variable name
was used. It is then good to fix the other harmless issues in order to
spot "real" ones later.

Here, three categories of warnings are ignored:

- SC2317: Command appears to be unreachable. The cleanup() function is
  invoke indirectly via the EXIT trap.

- SC2034: Variable appears unused. The check_expected_one() function
  takes the name of the variable in argument but it ends up reading the
  content: indirect usage.

- SC2086: Double quote to prevent globbing and word splitting. This is
  recommended but the current usage is correct and there is no need to
  do all these modifications to be compliant with this rule.

One error has been fixed with SC2181: Check exit code directly with e.g.
'if ! mycmd;', not indirectly with $?.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index c57ce4df4973..63d348693e98 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -1,6 +1,13 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Double quotes to prevent globbing and word splitting is recommended in new
+# code but we accept it.
+#shellcheck disable=SC2086
+
+# Some variables are used below but indirectly, see check_expected_one()
+#shellcheck disable=SC2034
+
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 mptcp_lib_check_mptcp
@@ -11,8 +18,7 @@ if ! mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 	exit ${KSFT_SKIP}
 fi
 
-ip -Version > /dev/null 2>&1
-if [ $? -ne 0 ];then
+if ! ip -Version &> /dev/null; then
 	echo "SKIP: Cannot not run test without ip tool"
 	exit ${KSFT_SKIP}
 fi
@@ -68,6 +74,8 @@ kill_wait()
 	wait $1 2>/dev/null
 }
 
+# This function is used in the cleanup trap
+#shellcheck disable=SC2317
 cleanup()
 {
 	print_title "Cleanup"

-- 
2.40.1

