Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8C46FC7
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 17:06:56 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id g5so2845253wrb.5
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 10:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680887215;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tk0yVDpEs88McJbg0HZXb6YKKY66/dBMHpeduD3eqHE=;
        b=cNGM3F+Nq6Pju9U3WEprAqZ4Xt031U/RGKkzBopfWD2h3G38ErAxolEUd7rOAOXjIP
         Hl5LaGVTdqPEjfkJ62uQslTxDaoCBaVvW3fUgxYPTZWGgpE3IWYMvjHT6VOfDOYlBWIu
         G/HNaqfb1U00Tp1v4HDltuV8Zdu2BU+8odQFjm8W+SiVfJ08mluMhBpmgjNdAhBf5Hm7
         vutlpRpjJsUQuotuyv9wlhZ4xaORRrk4k/2eyqdjEADYGanHAYO/9tHdGp2NJpsGZSDB
         6wPKe2+p0i7ztSHI6OoUK2DivQVouFKqj0Hj6pMZ4iCKL3zpyMlmwjlRv7Sn9TtSeCau
         pGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680887215;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tk0yVDpEs88McJbg0HZXb6YKKY66/dBMHpeduD3eqHE=;
        b=Sp0AelmTng6Y4o1eYZPjeymA2j1Bz2ZyzE8aHwMdT+eZgASIGjoACC90ERTyQuGzv4
         GZiyAmzNLDf8m5w8UkoL8bheTolTCXbxAUD2lU0dpc2bcB1QklVcpKjjSQXpCUVTj4tE
         pO7oWDKWmuRIFe2KjdjIZ3TAU6vTl3XYyMGppL46P6sZE2Ey0o8Vxqiv4QSEajWcsq9W
         lMIfxRH1bnOrmr5E6WDMGipFqAo5Mdu/e5Q7bcWKFiQ3k1+ezjAC68bXOCsrdiD/aQf1
         6XD8li2MCx6AAaz+4Cx/H1XH5zbXoeM697e/TKGUAShwMElEVb073oj+GOYmyqjCg4ZS
         Gflw==
X-Gm-Message-State: AAQBX9cFUPV6l6Tza2fB8HbR8NYQxhKixXcHdYkxuT5Pe244G/BSKO0R
	ZwTJpttf7YU6sB/hq32+tCvEJONqbOwcqzA1rtUvHg==
X-Google-Smtp-Source: AKy350YojGNvnygUV0vRf6AxLquOZOgIUae72DtAtHAxtHFu3+2gEF4tt+6dJFtDQWVrqzoCxqPcSg==
X-Received: by 2002:a5d:564c:0:b0:2e4:c9ac:c48e with SMTP id j12-20020a5d564c000000b002e4c9acc48emr1739523wrw.1.1680887215061;
        Fri, 07 Apr 2023 10:06:55 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id t5-20020a5d6905000000b002efb4f2d240sm908360wru.87.2023.04.07.10.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:06:54 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 07 Apr 2023 19:06:38 +0200
Subject: [PATCH mptcp-net 04/13] selftests: mptcp: diag: skip if MPTCP is
 not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v1-4-246ac567724d@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=eSP1RheZ+spFnZ1l17hgUmXgc90z52t8DvEZ1M4S+6s=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkME2q/LKFMXV4JhWIy6ax75Ix4g9yb+rH0ik2C
 X9lzpFFfUqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDBNqgAKCRD2t4JPQmmg
 c5OTD/9WNUNgst8aZS+/iRmTZtEUQ06wMH28AkeghAJt5NTbaSHcPaspqdA2z+R62noyYJ88nrY
 MHOyyt6tVYXhZ7SMs50DvWwclFyxi3HPkRUpLHRprw9JtINpTf8NCY9u5x64/p4daOhi3HXYdSV
 tiA7uWOriXeF97sX+GhMUn5bIwt2GlQziV6nZmsyAHRkB8rG7TmrGQCJlpKaHZmy6ocHCpBxwAh
 06bOLpUNed+NmgjMqZsk0Ho4GG8xyDDBZq3E7VguyAxiTkD4VajH2rOm5CQefI2BXxkNfReBVIr
 EVVyEc26iRV+/2GadQZjNeqrLvhm4ot3MSnxoafhyQhKXQFUJwPgLB2J32gblI+aqCpNyjGHT3+
 xpXRILEHQ3yaxItkpblnPPaKybAhkKtKo3J1JlSIJpdSTZG7OO/fPkDuwYAkdDiNW3Rh9tm21QX
 6AqcVWlvteBFn5ShGaW3BEKtVxvmoPl6iu/tAQvvB2oQhRmDDuRTvfE30pbWNPQRTALDLTe5Q1H
 CcVT7pi5Vtbe0pbZ+6NcJCo8mB+dqptbCseCT4XTAAlUDzGphehs3zlr7vhT7HNJvz73BLzMude
 7H/osYOB7QO6xOz9l4VkzI6CSbKHgXKKsvW0fQhbCOxd/pfLjiSlKFUEgTdgO17YiCNHdBM2WPx
 kYZ39N0qIQMlz6A==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped".

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: df62f2ec3df6 ("selftests/mptcp: add diag interface tests")
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

