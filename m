Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DC413AFF
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:14 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f41d087a84so26976465e9.1
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773493; x=1687365493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqRGW8VHJiR3pfqDy7ZceTC043sd4P5jTOMhgIa2dlU=;
        b=wDmbAvHLXT7N/gjXrg138o7CllPHbbdlmho6mxFUSqfaDYJxfdzNp/W4Sdphm/lUzH
         LyXHs8RGWEfiAuaZphgIYMXt/Cx+n9u2dIvEpkHysHSDXO0XraEpCxm7KfDQv91bhDtz
         JTW44RZNPrgHaR+T0Vxh64X8mfYX9D6ut54mU31ooKN+xKOSVF3v0lpA0Ym8AXwdqRNZ
         QJQEp7EyYyvJsLM50iKqubF0kpCMGmjJpGyQXWnis7apiUSr3DFXX5tBQvKf2ZLlZkDw
         xnDiaTXU3VVDq8a3rtYzu1Ke/KzaltA7HzJjZUgyFmvxnOm7g/ITuSDU2Rf/nAReh17C
         KXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773493; x=1687365493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqRGW8VHJiR3pfqDy7ZceTC043sd4P5jTOMhgIa2dlU=;
        b=CHzc9cJNmgbWaVP2X0lbpdRMLhPxukmYEy0GFiTkU1SpG12/nZQ1+KxCIM2yG5PUWk
         vto+pY34AqPj4a7tRKbniX/0HuirQzcbFvi39bU+5psRHcYOEnA5mExOU5ZsV7ghK/vQ
         arVdXiskajA+eYq+aBkbAe40KVcmZ9kwvGq6mqOBQGkJFAr/fBAXtiH+7lhwxTzt/mQu
         yBwNiJjBx1St60D2Tlm1PtGFIbPQuqY4PDj9CjZhj7z/kYxJI/JgGjwUFzT3WEB2NgNt
         SpIb+tb33zQiYYvAgscL2BHbghwBMjNQLAaZOMvlKhm5zkxWk0rCVdA6ETh8KomVIGVy
         QEhQ==
X-Gm-Message-State: AC+VfDxPrVaCZgD0lFEuqIFlv69I/o8e6ebNG7SFLdUpl1Qm51IFb+2z
	0+qOXJwjs7j+TCBQ4QgsdeHeRvH8aMKQOfBuacaz3g==
X-Google-Smtp-Source: ACHHUZ47TfVOipzCDZnqcKru8Nv8P/MqV+4wYE9C1RmXKZaFdZYzJCmxP6R9q/o4HCVE2nlOT6FcwQ==
X-Received: by 2002:a1c:730e:0:b0:3f4:2d85:bcda with SMTP id d14-20020a1c730e000000b003f42d85bcdamr8115679wmb.19.1684773492829;
        Mon, 22 May 2023 09:38:12 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:12 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:35 +0200
Subject: [PATCH mptcp-net v2 03/37] selftests: mptcp: join: skip if MPTCP
 is not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-3-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=GWxRgWKHjZN1zQFc1IkW47CcjV/pU5haL1GSEweQqVQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pvYiYFDNKrSoOufn1p49yhZOIi0cJ6jsZx2
 AbDyXjvFgCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuabwAKCRD2t4JPQmmg
 c+UtD/9UwicMtV50pzXt0aW6xUX5D/gHoFOP4fDPWf9YLEjxnY2VAaJJMCusdKD5Hk6An2q3sLd
 J2djFUyy/Uf+Gnt78z2X77w3AZQKtp99966yHvYlDuNc+rcbwEQmlxW1wVK97XyCKMFBBECnbQ+
 iG4LiyBxBHOxtkGBM7fxA+L0fEljN2kNnKrWKGhynxx49koQ6/tak/m/tfphPWOy2TV4Ihc4kGr
 xk+4/1hmoh9k1QA2yUs8/gV7Xgxvyl7W2CQi9TdwHmcpJDVsQahIh2a/S2+LWlAbVSYPkvuuasj
 1iFRCia0QjZaMCBUCGDRLDmbleK1Mb53rcZsWHrKxbv1D8wOKeR+7jRYZXqtKFEgLCCnN83NWEF
 qB+o+Em66thXPvs1qCHtV2lvme75mgJHp8hFMU3B+opdzh9MTlOLUwPNSgNT7yItBmnULh6Nz1j
 jJHXMvSz66Hu41j5wVQDfW1j0ZLhIPHwes/8SVpwnKqzl5tUbEy6Wv33atfacUE+FZ8cO1rWKfc
 0W/4RiR+Wawpcte8rGB5oIuVUszMMt0LkN/hzsSPpMpxDC49iHpQl6Bhu2WPxiaYCUr2yMuKI4T
 rOJepJ0PERDR5BtisDQgZLzU1VMxVpvBXD5HTLEn7jidOD3FISxMzIB8S4dg4bgTWJlK6t2Ji08
 iLYssIEbA2LyMuA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped".

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: b08fbf241064 ("selftests: add test-cases for MPTCP MP_JOIN")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0044d87556dd..07f6c104fbe7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -10,6 +10,8 @@
 # because it's invoked by variable name, see how the "tests" array is used
 #shellcheck disable=SC2317
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 ret=0
 sin=""
 sinfail=""
@@ -139,6 +141,8 @@ cleanup_partial()
 
 check_tools()
 {
+	mptcp_lib_check_mptcp
+
 	if ! ip -Version &> /dev/null; then
 		echo "SKIP: Could not run test without ip tool"
 		exit $ksft_skip

-- 
2.39.2

