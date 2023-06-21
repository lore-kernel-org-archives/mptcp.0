Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DAF19BB8
	for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 17:18:34 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4f8775126d3so4140387e87.1
        for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 10:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687367912; x=1689959912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QKeuqA239CLSj2qvsrYqFrn6+p3vijXBy9Uy0RXsss8=;
        b=SfAYd015NTjuqjqULxIfgf9zqAIslovitFKHaaY1jNQDEngvbpUMfzWHOKNaC0hNnl
         ylseSFwMbIEzNWB4QAar0OfJ/sCZFahjD3gC0OLiSYBxINBM7E+zLiPYRmS5u4Izo0mV
         uxeIcA2iUzzqcvON4KNEEUvSgf2fglMTOxj6N+kjdKDxSsdUqDBeH82/3gUh+27FedNZ
         wTHVxKRnAP8JeUZIccqfsh0EhbHuqV/jYiqZ7MXCLUxG5XRcHmIf0Gq9UgZZuylyK/Y2
         /k4dwy2bqHdIQal8YMDH7csX+0Q+ylmdpK5c4qhcveZj7COn6NX263YzfNIxzQRcAgmq
         835Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687367912; x=1689959912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKeuqA239CLSj2qvsrYqFrn6+p3vijXBy9Uy0RXsss8=;
        b=PivrRa2FUmGRGRMyJuct5NJIqMdUX8h0MXwZtzYZjYWUajzRkdvL021+zl55R2IS+F
         ylgF9biHEUXrpkpLoRjuDH2/wxf/gI0MFOiDs29DdXQNzYZteGNALydm1MwqROpQGpeA
         UajforgKgNJ2RTFa4ljyHX2SF1F5rCLjjbYN97vJFEjUyQ9Yh4hmvjJLHMUB2+4Mk4eL
         UZMl6WC0f3pyGNj/jaN1dirsj0vyIndOmxx2MVj3K2On4TkuRd8FslWxGMXIgHOfzk53
         ysjixfbRFntFy0LIRB058Z+NrvJzvRQ4BVXIv2rWBXupaMsDu05VAyCy41nKCBfDKdQX
         xrzw==
X-Gm-Message-State: AC+VfDyfG0CV8NhXBAsBPthdryvHu9fhKrsWwgoL93ssjRMzmCrvsqSi
	MZWAVVfB40mHqOR4VN2kVs5W/tTlnWfNstgL9n9JIhLh
X-Google-Smtp-Source: ACHHUZ6K0DHJ64U8QC8UY0GanjRtEn6UfkgVOh+xqUyKA5xT5zRgZZnGehxDjc9WMGm9o+S41gVO1A==
X-Received: by 2002:a19:f246:0:b0:4f6:2e78:e4ee with SMTP id d6-20020a19f246000000b004f62e78e4eemr10034871lfk.68.1687367912446;
        Wed, 21 Jun 2023 10:18:32 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id f1-20020adfdb41000000b0030ae499da59sm4930027wrj.111.2023.06.21.10.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 10:18:32 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 21 Jun 2023 19:18:06 +0200
Subject: [PATCH mptcp-next 05/18] selftests: mptcp: userspace_pm: report
 errors with 'remove' tests
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-mptcp-issue-368-selftests-subtests-v1-5-0cae453ae1fa@tessares.net>
References: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
In-Reply-To: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=7n4lCE+ehC4/g/hR/ng1wq1I81Ib2VuFgi9sTdOIZHg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkzDi4IG50sovDaP3KTff57gZOo6PS9yhv3lNg
 +nR19TLV22JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJMw4gAKCRD2t4JPQmmg
 c92JD/98XQ6PAZvwe8lrI11xdTe21zf5NTxQGX5WehjFcEMwLHNL+HiQqzItj5hOKUmvumNbMpg
 n08pR1KtAl6IaxeKl7uDn21E1eJm7m/vcZd1y7uN4ezgnOyAY/o5iRY7d5pZbdWMA4XybZKwQxt
 Tie/w6IiNaWiaYjPYswV4jLjjnCnUEaYEVmrXbhDnnE6fPV6z1E8etBts2oLzbJPnSdG05rrPZy
 2PFgSiJbJBbejfXs3cjx6fnK8bexkCwDj/FmQsJzYK429IjFaxhdOgimkXSgGeiRHlHoo+Hqpzw
 MWwxBJzpfgO1TVfu/FDktO1IEVZKc25al1z9lxaDF/TBjI7H1M1ZVkdkdAFCrwxv/wpQNoM9BFg
 BM1SEj3YK5u08CfNVeYXw/m/nkQ8POoHLRs9QT5cGSQAMF47I7T2zmFKngPC79T83r7euwyC5pI
 qhAKQyPHU3s/qFPxa0W+XmR7agc+VQSQgJ3rXmtFNW1kPu8jgZGuSGbgRRPOmwuq0J7qIhvkAx1
 t/cgn+m5drUxudaqboxRN7L5n1Da1ywEsMEbf3E9x1jE93d9KWhVEpehybSepWhLgEqyrphHGL5
 izLEQQKLht9y3tJOk+YS/Q6Jj6H/V0a0DR9jKcrPNJ7Hq8zyqHDJdQGywCIqsn+mwqw2TuMO3QE
 UHbFZP0tLOilTzQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A message was mentioning an issue with the "remove" tests but the
selftest was not marked as failed.

Directly exit with an error like it is done everywhere else in this
selftest.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 259a834fadda ("selftests: mptcp: functional tests for the userspace PM type")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 841a67a7d524..b180133a30af 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -423,6 +423,7 @@ test_remove()
 		stdbuf -o0 -e0 printf "[OK]\n"
 	else
 		stdbuf -o0 -e0 printf "[FAIL]\n"
+		exit 1
 	fi
 
 	# RM_ADDR using an invalid addr id should result in no action
@@ -437,6 +438,7 @@ test_remove()
 		stdbuf -o0 -e0 printf "[OK]\n"
 	else
 		stdbuf -o0 -e0 printf "[FAIL]\n"
+		exit 1
 	fi
 
 	# RM_ADDR from the client to server machine

-- 
2.40.1

