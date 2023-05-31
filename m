Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1EC15495
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:56 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3f6d3f83d0cso61761525e9.2
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542614; x=1688134614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5ArPrF/2OcorDXlvKGbULMOHntlWsP6axbs/XoR+uw=;
        b=YHVSG2wpaqGbfErvwVFZcRk+EijWTRQQ6ofz0ZmXTxEEITRqFfH8nXTSyqtawmX8sB
         LPC5IVoQMkgCvX8Sil6N6lfMmZgTQavKk6c4bKRllsgYfRU6rq4XqJ/EPedJiVzCgqc5
         K86EA7YZOvf1bk+zDSqYXaMCsvCWrgPbw4VTbXSR0B2bgMJWVbD7Szg5/7Ntq7DO0/3w
         gPR5CqKE4oh1qkgMoRXRpoVMy23cVEeVAHmBKBhM+57SCR5bDS77TW9c4Q9+103ViyJE
         eAup32rUjI7rbsTeWUT63dQSz6KUVDshvXWBLo77nEqPkbTwxYZn/kSJ/+JjQGNFgCvW
         W9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542614; x=1688134614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5ArPrF/2OcorDXlvKGbULMOHntlWsP6axbs/XoR+uw=;
        b=Fhylrak0Bg7zV8DX4tJj2zPN2Sv/h5DRhoNlv0ZxHZzzRYful454gyk3yG7sFTccBu
         3G9diyRoaXVqx/E1+wqGg8N/CfwsNmzrp0WOoAt70UtE789xwSlUkbqyQwMgUwyFm4Jg
         rlEaz7faL8Ik31js5sZPqe2ijW4W8gXR9/cuuW8bfNn2ih79yjfQw302f0kiI/6PLKVK
         TE3sb24al2ZoeYZIOB6zrW4jfxYIORWLmPA4n9b6IBWdps6f8d3y6t03DOs/zX4crVA8
         H72kFO0lRqLYWExeWiDpXy9G/KIrgEk3PCf1/nQyXJfKI3aJqVANv/LVR7lGRvjC8gq1
         5R6Q==
X-Gm-Message-State: AC+VfDxpo2sax6w8PBt8ZjdSfMmMwcSjYe/ZebHlRPvi9Jnm4qJoUxlk
	uDgMqPvXbBeuEw9qNDhUtL0dkeLRYHWJv+oHRcsQEody
X-Google-Smtp-Source: ACHHUZ4HIN53wMIDQsvzX+YsbKGV1BERYW8Oi2dfVVr8DGv1IaqqH00YnFwcbd710VbapNXkhsu2hg==
X-Received: by 2002:a1c:7218:0:b0:3f5:db0f:4a74 with SMTP id n24-20020a1c7218000000b003f5db0f4a74mr4128778wmc.21.1685542614630;
        Wed, 31 May 2023 07:16:54 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:54 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:44 +0200
Subject: [PATCH mptcp-net v3 24/32] selftests: mptcp: join: skip backup if
 set flag on ID not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-24-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2322;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=9ZN9eWqd8DvYUaw9pLNVjAxVwXL6RIt87Dm8RHf/cGI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bDh98UASFq/qr2wRO9iiqfsrP8x3h6o1lJ+
 1o3cqyxDdyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwwAKCRD2t4JPQmmg
 c6VaD/9Wy3sddMsiT3vpvmSUPJ9h2WaBxHK8sLpP90OvAXifmmCUdHVkUvJepxaEWtHGmZCS5jF
 ckE73hvX8yipWcngP/wCj3PsrxEDNshJ9meHcN4CPp7oNJKLIgOJVSFJX2ahg3i6wmVG+JhnD7h
 9twI7qPDT6R0abklPqvLzi2iqK76FIQlM25ZVgN5ESDmDFnKyhGSceFYgx9M0LM0Mi1QdxVTAkt
 XHl3nVFl+CqW3HqDneETI2THwHIJN2pyc4B1vL/REha9LmY3FNkmQTtkXnigmNRKRCzHGUDuPpr
 rvNthXDbCFZT1TNRQMjYWNdJv/JFqnuSfKfyiPQ6Df952Ig5QQDIvon0VL4OPx9CRjd5kp606iw
 tjccyjKgwFY3atXcsA3xH+YBjF8ecwd4jxGA8VsL+oIqruS+ZMExZf1mkfFQQrqMcVuSU6hKuCf
 af/Zg3VxttUmGSKpLDQZ2SeT7AQNGIJcKw7g9CZsP/Pvrys7slIeM2WPBYd/PQ8mgfZX2OUno3i
 VoFlUKl6L/3A7EVVDESUF+8XoodlvVG5D3hQ58kelHLiQm4XUceQ9MUKCWT5VPQGhpA7CdvIz8Y
 21SpKlCG9sRXlR07vul9s8PhVyHABAgcxDnu7rt9J6eppYbjOFb7aFCWPxCMNmzUdGsEU14OPZQ
 d40755uhh/NnuwA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

Commit bccefb762439 ("selftests: mptcp: simplify pm_nl_change_endpoint")
has simplified the way the backup flag is set on an endpoint. Instead of
doing:

  ./pm_nl_ctl set 10.0.2.1 flags backup

Now we do:

  ./pm_nl_ctl set id 1 flags backup

The new way is easier to maintain but it is also incompatible with older
kernels not supporting the implicit endpoints putting in place the
infrastructure to set flags per ID, hence the second Fixes tag.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: bccefb762439 ("selftests: mptcp: simplify pm_nl_change_endpoint")
Fixes: 4cf86ae84c71 ("mptcp: strict local address ID selection")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d02f715feb62..529c95cf7fd3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2688,7 +2688,8 @@ mixed_tests()
 backup_tests()
 {
 	# single subflow, backup
-	if reset "single subflow, backup"; then
+	if reset "single subflow, backup" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
@@ -2698,7 +2699,8 @@ backup_tests()
 	fi
 
 	# single address, backup
-	if reset "single address, backup"; then
+	if reset "single address, backup" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
@@ -2709,7 +2711,8 @@ backup_tests()
 	fi
 
 	# single address with port, backup
-	if reset "single address with port, backup"; then
+	if reset "single address with port, backup" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1

-- 
2.39.2

