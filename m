Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525AD19BAE
	for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 17:18:33 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-31272fcedf6so3167530f8f.2
        for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 10:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687367911; x=1689959911;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9RqGRI/B/YItKhReSPR/OXWduSMRpWckGJNnLbWPvb8=;
        b=1eI3O6UkkvPq/xjIiedFz2xYM+nY6z3zr50XNf6Rq40cfptBZXMOSN7bYuoZD51Udx
         WAl+NhX3b4cK+MofKJP4T6fns1OXU6LFozjLufAZmc1B/1DgXF4d0BMpW1E7bZM/zm+Q
         fkjCEDlHFDkZZQkwXPy3LF7TglXpF/koM76TeV4IIXDXDRFtFeUMcH91NkrLcgZu7tW6
         8NsaOmCcJjNijfH/U3CvJPfITF32uTp/f3GIu+GQjV0lE54lemXKiQDP9mBG9AHhz2fE
         2d/ibCO75Gtk5m02jTIAYFhIYTzVZC2g3FcY8dgLIisBX/N4Lhub5cSwEvmvoE6IrqdF
         NLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687367911; x=1689959911;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RqGRI/B/YItKhReSPR/OXWduSMRpWckGJNnLbWPvb8=;
        b=TsW1faKRnZYgDS216eiClsXMkzpHXtZYElQgduAuVEVvZkmyxuqbK2z4ytbckIm1qI
         Nu66Ldt2MoZLoiZ/ySd5cP0gmVqi//9sk/5RB79lGK82qEUQA+DpvQi0/AnmYpIkbKlL
         n4MLrz/SeXU2h/u6mqdkjuWZU6Z01yFfncVUfy7u0VyEvlfOdNm+bBxiZlCvWKZrEONW
         ePP3O3Ai9EH1OjLe6vFFR1qnqtd3RzNB/0xPm5hA2uc5XrKppTyWaueFS0qANoBojTkz
         niBn/FQSz4HFjBo/R7It1J+A3eIf7mQb6qg+7frzdIDC9IhW9O5P/pTtPGFeCP8r5xTW
         pXpA==
X-Gm-Message-State: AC+VfDyguLzR7CUgcmrlgHrZX+CbmBbEc5Mham+N85joq53ZnuYgBQYd
	CMDM2m5FDM9WaLr0pawD37csEkvmDUVJ+SBKhuE+loGr
X-Google-Smtp-Source: ACHHUZ6A46P+ypMcgtq1dkw+Q5xiguRXK203Ukdg8gmOmIIvCYfVB74KK89YFLMntmwR3Ro0HHnYUA==
X-Received: by 2002:a5d:5259:0:b0:309:303b:3dc5 with SMTP id k25-20020a5d5259000000b00309303b3dc5mr10640452wrc.7.1687367911594;
        Wed, 21 Jun 2023 10:18:31 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id f1-20020adfdb41000000b0030ae499da59sm4930027wrj.111.2023.06.21.10.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 10:18:31 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 21 Jun 2023 19:18:05 +0200
Subject: [PATCH mptcp-next 04/18] selftests: mptcp: userspace_pm: use
 correct server port
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-mptcp-issue-368-selftests-subtests-v1-4-0cae453ae1fa@tessares.net>
References: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
In-Reply-To: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=FQa5z10gzlOU2HJw5oPCa/iZCc9Z9jUtiydDOM6oeRI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkzDiVx/lo3ziTmAJ4XOJU5zmFDrcDP4ugobTl
 ZuyNxCj/EuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJMw4gAKCRD2t4JPQmmg
 c24mEACV7n7aRbVMhIlYKzWBBgOI3KY1khJOPuHyINkaoGJpZIs11qFbfWkxd2RIpMtCNmHgSOp
 tmt/pezJU6XUZ3dhJTuuvkXPBL44p0m/KyQe60wwqDtG7qpuGN+z1MSGd2bdqcnm67vVOAsqsGZ
 xhrQWDqBijAvIKQfP3Qt590rN3sye65m6cKIfZxfDrc9SnJ3ilRz/Dv4Yq0dgl8KQmp4dyEsuKs
 F7I4+718KUFtemcIY0rv8pKmUdkWHbPZGKSco/EfaD0pauEoVr4iWVcOSwjanxOa+cOBTiPrEOy
 KuJBRI+6xvYX13ivKq9eRDpuWYLo0FvKlgQ2C5ksRd3BkdgV6S0npUFwCo/agSRchFgSwmt+5H7
 Z6+yi4+Mj3Rq7uDuaVbuXYew2xjwtv+W4rlJGgBK5mKTvBFxYmqtIbK4Tp6oWzsNP6QD153iUOc
 akl5gWwF8fJoIYu8fivtdD/aJIsHSZ1NkpgKaWOv0pqVofrEgm4TOifXW32HvCYyMLeM1exeN6X
 Puh8Dnq0lcoH7YQ1y+tZFQ+ZHkypRs74rfxuKsZ5q5ZGDzTbYrgE6VK8sWf2GvKHFcQj5fXS2hU
 fHW3AU9HN+OL+rzOrkREnCwkHzR9YbUuXies84A2Mk7g2cs6s4fF6EX0uIiw9APEajWKdKeZ1Cp
 ghcRlGZY5PjhLZg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

"server4_port" variable is not set but "app4_port" is the server port in
v4 and the correct variable name to use.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: ca188a25d43f ("selftests: mptcp: userspace PM support for MP_PRIO signals")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 98d9e4d2d3fc..841a67a7d524 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -848,7 +848,7 @@ test_prio()
 	local count
 
 	# Send MP_PRIO signal from client to server machine
-	ip netns exec "$ns2" ./pm_nl_ctl set 10.0.1.2 port "$client4_port" flags backup token "$client4_token" rip 10.0.1.1 rport "$server4_port"
+	ip netns exec "$ns2" ./pm_nl_ctl set 10.0.1.2 port "$client4_port" flags backup token "$client4_token" rip 10.0.1.1 rport "$app4_port"
 	sleep 0.5
 
 	# Check TX

-- 
2.40.1

