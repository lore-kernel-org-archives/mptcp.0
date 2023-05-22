Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C25B13AFB
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:14 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3f41d087a84so26976405e9.1
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773492; x=1687365492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1LbVrMlXn6OtSKSuj2cDj/vMRLBYoDLsgtRwlMCY8Nk=;
        b=BxOQHx28/AeVScmfVzBZO2r346PA7WG3DORrtBCqWIgErG/JQcY6aRhqmq2ez0eyR4
         tQgDPCGi5IpjjhdG1SWSIwrgtapUtpNGLJ5Efqf+8D7KZZk9QuH5Cngshg5hNyEkimNb
         lOV3MylvpsB0cO8DXLJL4H0gAb8ql/sgXKvqyK3+4UdFnqgQJOSl+sZG+1sR1CqoDfXP
         rGB5ejHY43dVo9x/C1W6O+fiuXDJAX/zkYt1A9JTnx3KUMqq8IGfoGhHl7TF7h94hmO5
         pN4D4myt+ZKow0zbM96VfpqpSITTDrDb34/ZT/3inGhSg0vQSk7qqMiDSt9Rlo/eZoNu
         my4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773492; x=1687365492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1LbVrMlXn6OtSKSuj2cDj/vMRLBYoDLsgtRwlMCY8Nk=;
        b=XEwYejoEUogXU73xCFwC5HLQGFIHl4xNFv7hx47YPqRnuv6C9TJ7BlwIs82LyeBAQg
         HRWbZCNAthysamSI7pQoLAPyg+YHmjrmwoyFtSZy6ChibnD01fC/QO9lEcQ6R29djRUg
         M6hGX+L5mD1i23yf+Brl19Cx5Rg6Fo03aifL/TqUl561a+8TcVLnPuy6vX3ovYMeviV2
         Opp//TD2rKut1ppq47lXDjoOVClBsiNscF6fiazCeX6rMnP+RHefLfAjruesLecP/crM
         DyokNau2CQ8GdqXE26p6Ft4zxLcVW8Z2NS1fjqlHwyiDcBoOfZipJKRKc7PAb3ZtNw9r
         gbKg==
X-Gm-Message-State: AC+VfDyHfrUx/FlPmaHHlScCHOMTfe2MClk4kokyLAcsaoJgftWypn++
	yzYEniPNVW65GIC0G9oNJ6fDyf8Rn2mnDvx54hQJyw==
X-Google-Smtp-Source: ACHHUZ4t2jhMNnk3HGa66z39dhbhnaC3bblPrXJq6BXNNDREp8WBFrn+Ijq40jolbJd1EBoZdmAQug==
X-Received: by 2002:a05:600c:3483:b0:3f6:80:aa60 with SMTP id a3-20020a05600c348300b003f60080aa60mr4549389wmq.8.1684773492150;
        Mon, 22 May 2023 09:38:12 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:11 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:34 +0200
Subject: [PATCH mptcp-net v2 02/37] selftests: mptcp: pm nl: skip if MPTCP
 is not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-2-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=/idUvO+rOqbR7dE1Rxuj8uTcrOAR0nnW57Dj67WcElI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pvE7lMHJ6uzmG7UzA3cMYpZ0wpNqPKURxGS
 mKhAJjFp1SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuabwAKCRD2t4JPQmmg
 cwPkD/0fqTdlm2DzBRx4RZoNuV5wKd6l5l9PPD902Vk7+jwWbsXwzNUedM5gQCySo3NU0XnHMa6
 MPiKEdx5wZaTL0zwurCynM5nXWtqxMrCBFCsxc3mDsy+o9SeoK7aPvh5wg3hw4jvY3kJhAnY7mK
 OBpXT73PIi0MztpN6WwLXg+NxkxT4rnrd24DBZjav8Ec0miN87l1Ad2ly2RFmqulRd+kOBwz4mI
 mYRqloWDM1LnmT3tGwg1xkMAJEVVqN/WELo6lMtMbcjLdgTqmyrBohzDWJEy02L7n+8tH2uu/sD
 vaOTQUrOtfN9yraZP7HxqvBiHDthPQ3YDiCWqDeBz7Pc1jv39cL5tb34/ZhkjjLWqtepbwKuyoP
 VN8l5PvwgnYqMV4fLknKqChmeGiwaE+EFr2gP5GNn+kV+oDy0+YlL/t2P0CPCZ+VcNPbTe3PfN6
 J6sh010sMxdt/QfWOWm8vcf+ce9JMcn81eh2l4R5UGrUFpAmdFs28XLU+fmrJb5ekaWKNu+4Huw
 8HW5DVzTaTtS4q7vpP4tx6JaXZnLknuESE8deSrZQqAdBIgqM35sdMbxoHER3q4fZHoAiml4m61
 vlbSmmP/L8HXsdF/JqAxJSe39ee2R2Jb6IinMhOubIl5jki6bt4ofU9JYfpz+/2JcFH41XDk2NI
 qeicBidmKbxvN5g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped".

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: eedbc685321b ("selftests: add PM netlink functional tests")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 89839d1ff9d8..32f7533e0919 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 ksft_skip=4
 ret=0
 
@@ -34,6 +36,8 @@ cleanup()
 	ip netns del $ns1
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"

-- 
2.39.2

