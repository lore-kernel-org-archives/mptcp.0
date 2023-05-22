Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DDF13AFB
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:23 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3f606a80d34so7025785e9.0
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773501; x=1687365501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQ0/sONYGaemYjF6HodoV0Hl7EvG7+/XEdGtw0LdLXk=;
        b=ZCWrifTEgCcI0PXpcuUab0fUb2B73k+sDBPg82PQhxZSUO6qOm1u3C4yCQszPFPrfX
         eVZ8gmMoIiCBIJhvH3XRylj+wsa12uzHx3hjEkDZf7OjNzVE8Cb5Q++tlMpZbr9KAioR
         W0lxeSnqIAI+FdAX1klZSmUwOfNxsit+poETEMqw7CzFZLUGcnA/LRqfxrQircI9H0p1
         KjW07zo7b8AxSz2U/QHv1/zayNq0bDkoEKSd1fcX177RpahM/b1lU1Yd+yhSSvJg0wGa
         lhS+Lq+8nT4WsmkO6dTIwWwbwus8MePP4c3qiolv35ev6QGuC3BeacUCPzkzDWCRffD4
         wJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773501; x=1687365501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQ0/sONYGaemYjF6HodoV0Hl7EvG7+/XEdGtw0LdLXk=;
        b=BNlJ4K0TrgF2c4Ho8ZbEVM83IoQL0oPk/Ew3YRhVFhACkjbi8/SQDAFjOr6vFnpFzg
         sdawauR3Nj6sbhpmjWoMgbmoD7xPUjs4zfiN5tqZjRFNALqV1ogmnG/SrRaII0AcYby+
         K1hD3gKdQYoTdO/IfmxeBwD2QCUYXeEiBl2mxCsDStE/RUOYzAstNu5ygY6ytm+4z6AO
         xHOKCexaTC36JsZC1AlDno0CC1HQ6m7F7jjF0CeVhKFZoXjFUZ9XR9oOIPLxbE6m9KGe
         11YO83mQKNjEl8ew8rWX8PgxYz1N0fZPSzTblz3JKVbfRng8l8VtxycInPNrF9Dab9Vo
         Q7Sw==
X-Gm-Message-State: AC+VfDyh7gjHuDNKRnoLEGtar6ZgqsrN2k881GSLUZqysGTCsPBq9gWB
	sd146qhhEgiwYbbXOHQXRFsDDAYPMVHdKL47MHFXWg==
X-Google-Smtp-Source: ACHHUZ42EM9fTl8NrcErE4GUUXgJzF0akSu/rYH0Gugkk5eRSii1yzQM5rxS4Q2mF/45jM4onj1CZA==
X-Received: by 2002:a05:600c:378f:b0:3f6:20c:db83 with SMTP id o15-20020a05600c378f00b003f6020cdb83mr3876285wmr.16.1684773501595;
        Mon, 22 May 2023 09:38:21 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:21 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:47 +0200
Subject: [PATCH mptcp-net v2 15/37] selftests: mptcp: pm nl: remove
 hardcoded default limits
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-15-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2349;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=aVuU2oyLjzTS88MYhN2EnnAYnefqP09EdnhSEtFCMng=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pw/zVmxyrbzVt+G0fauRBLr1qlmZZf+6gnB
 s9eIZWrYGyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacAAKCRD2t4JPQmmg
 cwNpEAC6IwMMevNUyrBx8dc+hLnAh7iaNz6CKBgG4rlMEvG54I2rHHTFNzdLRimK6YdhqfhODml
 TP3feoiIzOQKv2dWMl2v0cgn/Cc4ZhGaLP7bQCYq9V2MG2mFMfhcUi2zruxvBHHV0SRH7TtklFG
 uIDP9LGAWUHGmwekICsSCTNzf9vcUD7JxSlBG2qm26BH793KoJ3tAy/vu6vvFzxqhqZCzcX64l3
 dOvZyQOw7iEDGqItU6CPpiLZy0/68aoVTS6uk2CnS8d+eKsGUW6E4IuUkL1LAKl2mU3OwQycEDT
 YSB4NeTrOeo6g/6fIQE5D6UvQa3H3qHffQVUlW+enTLlP1+XKqGmgDgYjResPhygJwuRGgpW5Mo
 QcFDWzD9IrwslZrVFTbG76Ct7W4UMpIi9ELZAwjxoe3RV8lzoQFakSRMQE2yonPyH1I874i6hJt
 OfyOjc/RerarYkXcJ0O67bwsdv6O5tLsuHOs+hj1xPSLKP7crf5WqWE4L7iQCzUZsRmQPmq3jbZ
 mSg3BU3Du+DlYfplVC3f1O4CFmmXSQLrA6fm6z2CNqG6l50lmddT593Yja8UsDDHmtH/+rwyqa2
 ic+h0m8XRMQXymgy9SpQ9wukrEZqz9S6kb1mxtwPpVd/nJWmSMeFE+jZsHjydQlVE7zOmhk6CHG
 pDYRXbvT5JF0t2Q==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the checks of the default limits returned by the MPTCP
in-kernel path-manager. The default values have been modified by commit
72bcbc46a5c3 ("mptcp: increase default max additional subflows to 2").
Instead of comparing with hardcoded values, we can get the default one
and compare with them.

Note that if we expect to have the latest version, we continue to check
the hardcoded values to avoid unexpected behaviour changes.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: eedbc685321b ("selftests: add PM netlink functional tests")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 32f7533e0919..664cafc60705 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -73,8 +73,12 @@ check()
 }
 
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "defaults addr list"
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
+
+default_limits="$(ip netns exec $ns1 ./pm_nl_ctl limits)"
+if mptcp_lib_expect_all_features; then
+	check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
 subflows 2" "defaults limits"
+fi
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2 flags subflow dev lo
@@ -121,12 +125,10 @@ ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 9 1
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
-subflows 2" "rcv addrs above hard limit"
+check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "rcv addrs above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 1 9
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
-subflows 2" "subflows above hard limit"
+check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "subflows above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 8 8
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 8

-- 
2.39.2

