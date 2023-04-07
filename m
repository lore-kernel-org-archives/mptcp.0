Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EDC6FCA
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 17:06:59 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id l12so42766059wrm.10
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 10:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680887217;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPzeNz4zKaIRLJUttjurYcvxC7ulBEdHQ6/xxbF5bsM=;
        b=WyMxU7OcIm/U+KXvj9hxor0DGEguo0+mw5rR/8rTV3fusdDycqfNVlrJqSFFOP6uah
         0UTWjmFD1rZnTyRmv6pNiwZi5aoV9Kij8luHE8+gFz1Hh/Uqf7fpdJi+kDaojcFrRwga
         O5TYLbnfXTf/IkEla1pe/b4/TOVG/PNAXW1l8W09V/bW/+iPXm9P6L/vteiiB/XR5oLO
         wT4JMCZA0dx8et9J5LtSqLQ6wmG0Tdx+BtcjxgpwqPtcPLvgBbcECETWHHnRJ5I2JlcL
         hOQeYJmqT3PuL68It9PPPc4u1SpPh3+rI83uULQrmNeGBh9rRDoNGy1jgg1XdR4aHT7K
         m5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680887217;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPzeNz4zKaIRLJUttjurYcvxC7ulBEdHQ6/xxbF5bsM=;
        b=0z9VKAkCnlpre8upz3nAEfF3mMETe5TCKM9iWqG6V/ODpY8amN9ka/pB5ThIjmV4s1
         tb/UDKpmqc+6pEoEZTmkoOyylXfD6+0v6lhA1y0w60BbCvFQ0O25rJH85jOSxDaqG+O3
         qjmXX+yi9gm3WNwy5WbLL2uhHurSr+2NyY2BgzmYKcJYYJ0kgcfSN1VE2Mw++5wFbRV4
         GGTEZoHslaqf+/GSARJXGffbWfpbzGcji7IYBfJeE8olBQHBn8e+PsxYOUNBQMTXL5Yb
         04kjZqcAG63wts0HhUQvGajHgCP5gGxZU6a82TBtPUNHXm1MlF6FC0ym9fMzjkG8Kkbb
         Y9mA==
X-Gm-Message-State: AAQBX9chCwTFNSykI3AGSpInokuVKCqg2bn4kuaqHwgjwSal4s5eZGdO
	Gs+wdMO5RRKGlGsF68mwT31O8nl+p6ml5SDKGsUITg==
X-Google-Smtp-Source: AKy350b9weCQ7lx6iS9V1gekM6hrr7FUB500s0pAjnwxOTG7ivu27aGKlYlLjh0caoP9i/w9446sCQ==
X-Received: by 2002:adf:f2cf:0:b0:2ef:b596:3f71 with SMTP id d15-20020adff2cf000000b002efb5963f71mr725964wrp.51.1680887217581;
        Fri, 07 Apr 2023 10:06:57 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id t5-20020a5d6905000000b002efb4f2d240sm908360wru.87.2023.04.07.10.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:06:57 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 07 Apr 2023 19:06:41 +0200
Subject: [PATCH mptcp-net 07/13] selftests: mptcp: userspace pm: skip if
 MPTCP is not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v1-7-246ac567724d@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=zg/b+j2ljOqZD0PGnYAJtZaieQpiMecPLbX5LAyS7oI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkME2qp8BhpHWizctQUq7m/xtFcetcxStiTVIxb
 AP+mGzDUG6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDBNqgAKCRD2t4JPQmmg
 c2DfEACJfQHSQZwol/a2BXiUcxZx31t+KK7kVdxAb70+rLs/+UUo83a7BMto8k38IKnuYohlueX
 rJxeHv2qoWddf3h0e/4/vvvKdb1Esz7eMHD8bpxzaymm/A/oa5MQph47d4AFS5dgZQ5I/xYZCW2
 n5A15/IAeFmEvKjcCVuDSG745bqNM24lirQl1Ngeglf5JdaYfX+69bdpvzML2v9gigB6THHxb+o
 lUGKZdBI84L6XuuLtH+lCg534SeKSp5sn2Etn7SmNF6TxoG6ARbUlN1uDf2osXQrcvyjwmEoP17
 pFtzdT9gVxl6wVCx8PgfMhnspnFMXEJ81WlIV1vIMKnxY3k9Q8LTdky7msJR/TUNSlaqPFkFTyP
 29F7UHqLlYpcG9YGQqVhtta9brZXujJG70+3qUB/v4KEaaYdwqNQDa5fGPYz2i9lRjwfJ3CH2O9
 RvBM3bTa2Q0gH6BmyTQqt8v/jJUTF5/vje71wDZ16L+KBWSmurUs3hxff98I3sE4joEghQThUHG
 weTTtzwTUjCmpTWvMfnYzjVBTECgN0auGkL+s17cJiW1HP0T1/bSDM1JZCjV8OZMXs/C9dafTG8
 c/t4am24zKkD7EOnmuoLec2dWhwWezWvgfaOlbbtwIms51Vl6lR2foWzmHEkX+rF4J2ddV/hgcS
 OiZl2dXX5TGIg6A==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped".

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 259a834fadda ("selftests: mptcp: functional tests for the userspace PM type")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index b1eb7bce599d..8092399d911f 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -1,6 +1,10 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Cannot not run test without ip tool"

-- 
2.39.2

