Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9780D5689
	for <mptcp@lists.linux.dev>; Sun, 28 May 2023 17:36:09 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3095557dd99so2487304f8f.1
        for <mptcp@lists.linux.dev>; Sun, 28 May 2023 10:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685295368; x=1687887368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AX0sr/PbmfXMRT0E3FKR7vPpjL8rwaKTtVDAJqhMqgY=;
        b=EY+2YTKvShTyvWZoi+qEzRbIh7STaLYSxenN389oH5pyQ3B+M6jSpEI8GNpm5CpraP
         09RcCudi4w5jNwK0MOlckZAwUlm3hacHFR2OmuNNhyTHNaHquEseO6Ua2wNKnOf7z8vk
         0CQjiXnQ/ulYYqxXYEuZqqg3QynYsLTFWrf+qBfEj5MMiGGAuDhGJOato0aChAVOWYmY
         FBAXMmloa0jrqH7V01MYLn0CyzCw0qOqqxWAvMCn/A76Wmh19/J4Z3BLwlcTCizWspqZ
         bp9zeWc+d9MSA1swO9j8agu031xbqLLEpAZC/aHWFh5TUsD1PZUELh/BQfcLoWRRoXif
         Nhyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685295368; x=1687887368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AX0sr/PbmfXMRT0E3FKR7vPpjL8rwaKTtVDAJqhMqgY=;
        b=Le5k7f8hH7991tMI22nYV8mV55ksN19WtMSclt8yce07GA2S26AvEe0FqAICRcDNst
         3GNTHfZKFwZY0lGqlRr+WKkIBC2xTJ4M/7YlcIL3VgYYcrtidQ8VxXF0AFlbRhEWNV8U
         cYW9PKmMR1PSYQgL+cn83AEbYBYOZVsCvh9RElp++izbkXIhdMmVaHs5w5oKNo1rH6xR
         bQlVVTeK875FNFJBwaLJtJVCt2/tZ7G/ZUu6ckg1kKXzeem/PVDTLjhPfESoMHQAmZiV
         JlyJs/sjRTt5F7lefwri91J2w+T3DdVIKxRlRqEYU29bR8UcFm9jsb8kUMfTQ8vG5W8v
         Wpgw==
X-Gm-Message-State: AC+VfDzLN6b1kyGraaDqmulU86i+oIOpOWlgNuPPsU4RocOCJJJVzW0v
	tSvJdLRHiPmk1r0OyK8NCeDiFQ==
X-Google-Smtp-Source: ACHHUZ7KAR8RXl6O+5H4v9gJJWlzSY/1hej76B1j5B7n8S6haKDU+hOJztCZ51pMTxrr47XPx0UCdg==
X-Received: by 2002:a5d:4ac6:0:b0:309:54b6:33b0 with SMTP id y6-20020a5d4ac6000000b0030954b633b0mr7315737wrs.44.1685295367931;
        Sun, 28 May 2023 10:36:07 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z10-20020a7bc7ca000000b003f602e2b653sm15334523wmk.28.2023.05.28.10.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 10:36:07 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Sun, 28 May 2023 19:35:30 +0200
Subject: [PATCH net 5/8] selftests: mptcp: diag: skip if MPTCP is not
 supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230528-upstream-net-20230528-mptcp-selftests-support-old-kernels-part-1-v1-5-a32d85577fc6@tessares.net>
References: <20230528-upstream-net-20230528-mptcp-selftests-support-old-kernels-part-1-v1-0-a32d85577fc6@tessares.net>
In-Reply-To: <20230528-upstream-net-20230528-mptcp-selftests-support-old-kernels-part-1-v1-0-a32d85577fc6@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Christoph Paasch <cpaasch@apple.com>, 
 Florian Westphal <fw@strlen.de>, Davide Caratti <dcaratti@redhat.com>, 
 Kishen Maloor <kishen.maloor@intel.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=2XieG7aH+1H6UjQufr7rYq3MJt3yeF3n93mM9qxyF/k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkc5EBVsy9726j4G9jjMrxnRAZd2w+eAda1JbfZ
 BSSWuPepeaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHORAQAKCRD2t4JPQmmg
 c90rEADZxBUPh9w2TPif0/EokmXKrf1ty8a3RmkE20WglnJTTAowpUPzIxTQnA2mMH6G4T+iD50
 f/vCtbr8xigVWUf2mFE8RY+ijac4XnuctSmaj1SY8L3xTE+3+1k6G/XC8COwJrpcQVE9o5i98Z7
 gO/j8Oh47+FMeaUB/xyXEO8T14bbG8w8JnRpy6n3olvwbvMqtuVGEre7BoyuvWpV05Nqmz1DLA0
 S5fYqrf1BHCmobd7JGoiFlIiYkuaxee9qm/fi/dEIw0QUgVMq8NSVouzi4kIp6WbPvmn4lMJdre
 iiAvIO84IN7unWkXg9nVefl8u0x22W7IYsPAByQUSRyIBYAghF0S1UouHO952bCpC0ZF+Nczx25
 Rzs5Q2vJgOAdZR3hutsfSeO5YGeS897blfYpL8xW7EDY+CKDvzHaVnFHDvyt2Mc5dcOWXgPUhoE
 71AfIOvO+8qs6f57QGqn8T/Kg8EvtrWYXxVbx1iIqi6Q/CkqNlvaLi/KenhiXDOQyO8Fza6Y8KC
 WBcZvy3JNBOGQA9VZ6d+05SB9vJta8QyZkiSoO6zkVwjsYt1NLobmuv2nkXCHYpaRJzetj3tC7u
 tW3xlwCtqwXYOAnOPq65RmKtfv73nLWaJ/lsB1GwqXXfxjIwvmrfAXaM4B6eVAunAEM6sNY84Bj
 VbNoHru1F33zdYw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped".

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: df62f2ec3df6 ("selftests/mptcp: add diag interface tests")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/diag.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index ef628b16fe9b..4eacdb1ab962 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns="ns1-$rndh"
@@ -31,6 +33,8 @@ cleanup()
 	ip netns del $ns
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"

-- 
2.39.2

