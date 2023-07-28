Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE7813FE1
	for <mptcp@lists.linux.dev>; Fri, 28 Jul 2023 14:19:02 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-307d58b3efbso2091446f8f.0
        for <mptcp@lists.linux.dev>; Fri, 28 Jul 2023 07:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690553940; x=1691158740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ykTQVzSGehPKnaWlQpSul5qDwfIb8UR7DghO1UbhJE8=;
        b=lpC3LjQGL/MAlqoYZuUBKBpF44/SxHohsAMGcfKp8Wk53bKdQEy4sKQbaSOxXnM0nr
         cAQ3I9FmHeS9vK8wAZMazaMiArHG9HACoPylUQm9FDc58+phfhcPRPzNzIavqErlT/Oj
         WVfK4azOLVuKO5iuxNcEwhmQ9q3Zr6UZJjMV3gExqIrejctZ3vbLdDQaNlCwzJJQc0oA
         HbaL+qVl5+YLFl0FfVa3hAH7XdRfos7HX0AMtOeb9n0Fozl1v3PfSHOb0Cmqip1tw58b
         56v6XjbJ3duA68B2fXVi3PyNNQB5CzNYpZ0bBCtvomsQOPWHtFEb/VWkvWMdhR7D+6Uc
         GuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690553940; x=1691158740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ykTQVzSGehPKnaWlQpSul5qDwfIb8UR7DghO1UbhJE8=;
        b=ZOcE+lpI2m4H7fSDvdGp5Cl8nMorpQkjS6YoojlGfDeGau9yCl/BMz+HE/cqNE3aG+
         yRMbb/ItwLDrd+YnLlfEbCBC7YKobz0RMIbb+GlwgkHt8OGTRE+/JQOiGxn+HCn2gb1+
         al1JwWazwfxkY7wJJz86qKgYn1e3NnwlIjqw0CDpkq3tigi0ZebwyPBCv1XwOm+mq1Tj
         cLFrfFcK2CfIGhWO0SCOb9yqCDYQAxulhU6omVlksiDYkkgHc1sEDnEcAzHj+1cfjo/Y
         FwsFVElGXlH5ptb37PGhMMJ/A+rVGAHBL1ILHv1FqVvmVrwyta/h50PKWfK1RfD647fB
         /1LA==
X-Gm-Message-State: ABy/qLZQZcCfOqnR8eXhFrpYQRL7XI8cL7Ai+Ik/8bvxaxxm7et+Szom
	UHDEVgzAF0vuDgxYfkznltkSN25aXBoWv8KJ9UA4vA==
X-Google-Smtp-Source: APBJJlH/b2AcZ9KdAA0+vtkz2TsED7ygllm/0i6JBGOYfrqQ6Gn1CN3cPog2X0g4TvHEhiWIvzr7sg==
X-Received: by 2002:a5d:4282:0:b0:317:5c21:a287 with SMTP id k2-20020a5d4282000000b003175c21a287mr2077999wrq.29.1690553939877;
        Fri, 28 Jul 2023 07:18:59 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id r1-20020a5d4941000000b00314427091a2sm4903486wrs.98.2023.07.28.07.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 07:18:59 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: join: colored results"
Date: Fri, 28 Jul 2023 16:18:33 +0200
Message-Id: <20230728141833.916787-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=Y/0WvrAPkUJ6ggVq7VaOSV/978OvDPXE09BkroCxcfU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkw845Abg+TIL+qVb965oSZHblmLSUnE1zB2Qcv
 /SX8WDADLCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZMPOOQAKCRD2t4JPQmmg
 c797EADMp7GncdY7yziCxQQOtSjsPwYm54g7jM8em3FqVLsSmp9KPHqohVwyktUtJvPBo7ZGXDS
 rDOlsLQjuzujZyFQ4o7z9XUMJ0xEK19VBsyXLUZGClyeXItkc3Zbp328ynZqe6kVI4YHoSWigxp
 NwRKwU5FEDIGV3WqpITQlao2FZeZo6WvBlmHKINjvv7cHRjGlxkHqZ0G6T0Y2KVs3FQGG4XfTM+
 rYNvoZGTcuFkRzPTHUwMwuHcMGnKmz3Nr/Lz9Xd7DYKhLkEzEhodbuPG3MSxbbZB81RsxbxIMux
 lXFLV1g56Sn6sZt7aoygrbTlgg02p4PGwXguwSk+ik22WIb/5bMYUZeAlSBIlOstfpRDkKV4xdF
 meoHuw6bE+ZAn0ygJU+uU7Vtdk84hPjn3dMLuAtHMn+zxvm307BdmpeUBLm+AAKuR+B4JSEQbDh
 l4fYAggtz9V6GUO/93KIeS7pZdAUDnZIVYMBV1oz46m4NmIhJmcnaCoL3Jpa2tB00ClsxVPYbHf
 Y3iq1JiNQWMfewnMk0JU+pWjpo1S5bamFrYFTTBq9hdPFtlIRpg4tfp8vF/Sm/PSVC6dKBl0/vS
 uK02mzHEn4WVHnm3obqForhN0UU4cyuWljgTlQ/OmyTnlCXgy1PnRxrHmmCsyhxxE7V/YDA8hgs G3j9nJ1/DHBoboQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

New env var to force using colours.

Most CIs these days support colours in the serial but they will execute
scripts in a non interactive mode and colours will then not be displayed
by default. So we need a way to force displaying them when we are in
this mode:

  SELFTESTS_MPTCP_LIB_COLOR_FORCE=1

Note that it is still possible to force disabling them if needed via the
standard NO_COLOR=1 env var way.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    to be squashed in "selftests: mptcp: join: colored results"

 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 1080d5d2430b..92a5befe8039 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -10,8 +10,9 @@ readonly KSFT_TEST=$(basename "${0}" | sed 's/\.sh$//g')
 
 MPTCP_LIB_SUBTESTS=()
 
-# only if supported and not disabled, see no-color.org
-if [ -t 1 ] && [ "${NO_COLOR:-}" != "1" ]; then
+# only if supported (or forced) and not disabled, see no-color.org
+if { [ -t 1 ] || [ "${SELFTESTS_MPTCP_LIB_COLOR_FORCE:-}" = "1" ]; } &&
+   [ "${NO_COLOR:-}" != "1" ]; then
 	readonly MPTCP_LIB_COLOR_RED="\E[1;31m"
 	readonly MPTCP_LIB_COLOR_GREEN="\E[1;32m"
 	readonly MPTCP_LIB_COLOR_YELLOW="\E[1;33m"

base-commit: 18d38b0f6b8f3d12bbd55c179b87d3ab014fef48
-- 
2.40.1

