Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462823D74
	for <mptcp@lists.linux.dev>; Tue, 28 Mar 2023 17:06:13 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id e18so12961856wra.9
        for <mptcp@lists.linux.dev>; Tue, 28 Mar 2023 10:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680023172;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=McRhWE42irHlshGPa5H0qklu6LxZPZctIJ3HmvaG550=;
        b=viJBlb1xTq1egV3H+rvXjRUgDCaXon/+Xcw0K9D+3dE48dceweChXhskLTA1HqpFCo
         gc34tM8v5jdNM8bqDtt3Uj0h2NS/+HQeXUgQIojSHO+OhYF4DQNli7D6xSOoMeqljIYH
         FTCV2B47t1ik6xJCXiYXScZLkpdTFRPRDXk1ha0VkBHdErjiuHq+vpJN/0QLZQsUV0tc
         BjiX1bxjty/PzxpuW13SvIxw4CJZ59XFqBydifsN/60Kr1+yScruSGdcpQOCyfGRbVJd
         zd44usMeMUbN2Ympd2OG/MbGpN3V7BQ0QQDwOmtYEi2wrUQJdhQVhottVRo1mog1HVXb
         Gulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680023172;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=McRhWE42irHlshGPa5H0qklu6LxZPZctIJ3HmvaG550=;
        b=pSma5BXpfIjHmwvtuUfcqAD7/xMR5J4uFNFOcPVQSa8mJXSf0kGurANKOOtEQ94SUh
         m4m3fH4jagyFPV1f44iI5hXfK5U65IYS26V2E+b+OTiDGdYpzPBGN5sXmICIUie+/vW6
         3RDohg60zAjEGCeYezdHAKzFwDBAUSQZodhieopGNMnRPxZo5lMyMgPApUy15fjfXfPB
         0Esu+7KeEtoKDdtwABbj1v+9nfCWw7czm0hWHYXC27bFrdFpawHEiZTujaGjZAWCCwjS
         V2cpnR5TbTSR2zFwV1mOPK6WQBLiaGTukh9nv3cfvGRM7q5EnmNWQ1i4yGn9xs1EBCPX
         CMmw==
X-Gm-Message-State: AAQBX9fGnTlaEy2gxnQhyGFu83qHhin1SMdig1DbcGigwXfjXIS5YWWK
	DE0wzbnzq7Kdd3oSojCyvJ12J6IlleULSOLcCYQD7LdY
X-Google-Smtp-Source: AKy350a9Y2S3U0VK7BxNs2xclmI8bb52DpJKT4cyXPZmbzurOrQWiXkCjACRuLPTsQrqzuprteg/og==
X-Received: by 2002:adf:e950:0:b0:2da:1ac3:adfc with SMTP id m16-20020adfe950000000b002da1ac3adfcmr13972855wrn.60.1680023171899;
        Tue, 28 Mar 2023 10:06:11 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m6-20020a056000008600b002cde25fba30sm28175377wrx.1.2023.03.28.10.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:06:11 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 28 Mar 2023 19:05:50 +0200
Subject: [PATCH mptcp-net] selftests: mptcp: userspace pm: uniform verify
 events
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230328-mptcp-selftests-userspace-sleep-verify-listen-v1-1-2a4adf550084@tessares.net>
X-B4-Tracking: v=1; b=H4sIAG0eI2QC/yXOwQqDMBAE0F+RPXep1QrSXyk9JHFSA5qG7Cot4
 r83tsdh4M1sJMgBQrdqo4w1SHjFEi6nitxo4hMchpKpqZu2bpue56QusWDyClHhpQCSjAPLBCR
 ei+c/PAVRRL5623eddXV3HaiY1gjYZhPdeKh6XpJohpmPMmX48P6dudN/J0Lpse9f2E/t+6cAA
 AA=
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2090;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=SkU6HwVu6H6DY6n2AOnKrl+kBi8O4vw5xic5K1jhMuE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkIx6DRkeCpHc3nJY1dH8xFDqzlct7fFUuXUKV9
 YtvNjcikx+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZCMegwAKCRD2t4JPQmmg
 cx0tD/0RFlh6AU6HXCGCSNzFyfF3G3L+oxDKNIPqdaBjDwgXV0hWVxjFyXwF8ug1JhTukL4B5J3
 dy+Pb2LUeRKZYFh2vAN+HTOrGyjMlrrFQ6PQah1ysDhlVopgfNloHnq0Hkb/O2+GwFBvYOkBwK9
 gNOFnXELeCeY5gV9UNhf2Gu8JXj0SR7IeBCmtKeJOB5QMsEurvjkkX+c+zCWcmnfRgOjRKs8CTe
 pRIn/Mz2USS+mDThUnBi2a8CKEbElsDALOmmD0Zg7a/pUbujNE/fr+o0ONkiti2cYzxMWF8PN5j
 xxAhraYBBRC9v4BuQHKiyFOQ62+t2CbIfNG6w2b9WJGeDOicO4ZaGb0FapR0EpRvxbNh29+xdU9
 Y7hrwUYDejCU9hgpzBi7/2YEYys4g7+c3loIOHBdsbh0Dwz4TxRBngRwhqoKGCrY2nz7DsFU1wo
 gMxyxUeyiPTMWN/DpjSPFOgrkUAd7pGSNcPq/4yXK1TA41xa3m1LtJSzUV/MPiOO7Ep26LMlDaB
 5kaRr5rZTKPIBOpjRcELao+ZZ28JAwzs0/0LpB9EMHPMO4kGfoJO2t34COUolazLdbWbPqFLY2V
 7C50Z42cxcBztjzfImnRA/ejdpM3dppsckF0v06d1hPA7E01OWBwzzxdTh1fPM3EYfzbJEW17KI
 t1X7rj1Ub2Ak7Hg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Simply adding a "sleep" before checking something is usually not a good
idea because the time that has been picked can not be enough or too
much. The best is to wait for events with a timeout.

In this selftest, 'sleep 0.5' is used more than 40 times. It is always
used before calling a 'verify_*' function except for this
verify_listener_events which has been added later.

At the end, using all these 'sleep 0.5' seems to work: the slow CIs
don't complain so far. Also because it doesn't take too much time, we
can just add two more 'sleep 0.5' to uniform what is done before calling
a 'verify_*' function. For the same reasons, we can also delay a bigger
refactoring to replace all these 'sleep 0.5' by functions waiting for
events instead of waiting for a fix time and hope for the best.

Fixes: 6c73008aa301 ("selftests: mptcp: listener test for userspace PM")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 48e52f995a98..b1eb7bce599d 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -913,6 +913,7 @@ test_listener()
 		$client4_port > /dev/null 2>&1 &
 	local listener_pid=$!
 
+	sleep 0.5
 	verify_listener_events $client_evts $LISTENER_CREATED $AF_INET 10.0.2.2 $client4_port
 
 	# ADD_ADDR from client to server machine reusing the subflow port
@@ -928,6 +929,7 @@ test_listener()
 	# Delete the listener from the client ns, if one was created
 	kill_wait $listener_pid
 
+	sleep 0.5
 	verify_listener_events $client_evts $LISTENER_CLOSED $AF_INET 10.0.2.2 $client4_port
 }
 

---
base-commit: 1281a7eb9aa62b79cb9ad4d221ae31659ed892d0
change-id: 20230328-mptcp-selftests-userspace-sleep-verify-listen-4fb855bc054d

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

