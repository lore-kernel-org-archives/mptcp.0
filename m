Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1A113AFB
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:34 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3f6077660c6so6715655e9.0
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773512; x=1687365512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUHMO6educz46uQFwz5OaXYsEoj2QPDBu7mBcZYK8UM=;
        b=2yHIkrubfOMgr13tZYhLmMLFmCZ4JXoW3DoWpYxKkGdSHz8XQ2H6f8b+VT5iO0nz/1
         Ri97CKT7eQHK9N8rp4iXZKSVHrAvO450xLu1N7o1QINCeDLxYSZl/XuoWarpDhwp+o64
         ArGHGt6sYx8QxqNarB8cnDwuUPTT0mTIa4OuKvwQyBS0P0TCyd7ZkE5b/x8VR66kw7c+
         osKlixnXte+lPlK/iIlAlkNDPhWJrGN8CLxUsjPOLbiFmueYh/JnBhXRTn68LuuKNsZ0
         1A5AkxEOx6NByYGBxRWnrpp1xJJ9CX03se1ZWmYYQF9Yz8p6yhAoPZpOgwD5TFhmtmkg
         r6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773512; x=1687365512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUHMO6educz46uQFwz5OaXYsEoj2QPDBu7mBcZYK8UM=;
        b=FHHYAOMgJg9WnTsdDASNbbieJTvyvH8qMQrFKxfqvLs/CWempRsUYQ8XqS7MVxyFaJ
         Z5vvcV4XxLUsv26CBWz7pTWL/CGT76ozvB6TC4GikTueeJzUtjil0SFF/6uUWaKXTb32
         zxzYQr02zlMQp7M3PYKAcQyz88VmO/dKNkYOBihDTSaTS59QTm4bhvkMcj2+JHJMcQ9u
         ipQ7uhxcqxXWzGRu0n2AycizPUeHfZkQsEFMjrKKfkiUew5DQzNJHqqKtS5dePlpbcLa
         USK3ydW6SPaOitORS522n+0wXfh1iJqBHfFdk8rkvhLtyXdc8A+hDF9H0BUdchvPNNDJ
         uyKQ==
X-Gm-Message-State: AC+VfDz89L0+T+Rrjqx32r91iEJFK5GhxykIva+7EpH48bWlNSPE5cEh
	lRAJPH03N4fZC1PwyR0iONVbnSxWnggFvaJ5nYtOVg==
X-Google-Smtp-Source: ACHHUZ4+9CYhmw9QRr2O65qtFCM3GUK6taHJMotLgEQIDRxIu1//tXD7GMC6oiqkKcCVTpUxSvsBuQ==
X-Received: by 2002:a1c:f213:0:b0:3f4:2174:b29c with SMTP id s19-20020a1cf213000000b003f42174b29cmr8625679wmc.20.1684773512568;
        Mon, 22 May 2023 09:38:32 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:32 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:38:03 +0200
Subject: [PATCH mptcp-net v2 31/37] selftests: mptcp: join: skip backup if
 set flag on ID not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-31-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2322;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=3BralDaceq7F438gvkPufo9BZbdSO+Sox09FJniefpI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pxFClnOqtddcgB1Y72yb1MbrRyYZSQd26C+
 olQ1j2DavuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacQAKCRD2t4JPQmmg
 c3vTD/wIFS4hrYSD95bG3rfKX+RUmJZ+x1L0Plm5riN15cT8uShinIo5OanP9ot4imUtLAYGzKT
 eIwRAW8ECWm4sb/ecAEtCK8aAqTf2JbnTIPLz852Ge8vUIkbgjyxOKem3wjPHDK7nZMkIjvnmoI
 F/Hi/qTyU4EVdbMq5lOk+Vpq9jSWaJ3i5OiEaexRhIPVsmEPPsJRk120r04zKZ760aIkdA4md+e
 WHmZ/aWoxbL54q3tTzmBl6g5WK9IulWS8xOK2s4Po0StYNreUB+3+gPX3TKMRbS9i6HZB+GDqko
 5xhsgibV43X1gMj9uWQ2ber2ymqMzEVcXk6wEyWcJ+bCKn7QgQMG+THPte6g3PlHtA9OeH5KCtl
 fhcELeYfWjw++q75k2srg0O6uWNqP3SZfodwzWA36D5KBYFAT8zH7LjeXCPTlkNGeCKAQB/9z0S
 edtTj6AHGoJDJxgYvrpC0lCWGmvssKh0gZtvdMFO0YNE71ZVKjwJzcA+hDLH2bZm5qL4TlRwgp0
 1SxfuaG5JPPyEVybIidfOA404Fa317RA9z1g0Of/IyEiOuPlJ+aTwE4z0ffDAlidX7tDkEebddU
 l5w9OrkgPoIgGBHdULtEErqPkaDdEAC7MSi0st392WrZLXHj54M4dZMLiU+g/H1cXu3e+pSOwIk
 P+GJd8teFaAEVGg==
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
index c19a1d0ce738..3453ef733a4f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2737,7 +2737,8 @@ mixed_tests()
 backup_tests()
 {
 	# single subflow, backup
-	if reset "single subflow, backup"; then
+	if reset "single subflow, backup" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
@@ -2747,7 +2748,8 @@ backup_tests()
 	fi
 
 	# single address, backup
-	if reset "single address, backup"; then
+	if reset "single address, backup" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
@@ -2758,7 +2760,8 @@ backup_tests()
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

