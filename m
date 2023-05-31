Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9081415495
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:40 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3f60b3f32b4so43291795e9.1
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542598; x=1688134598;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j7u0B0hbuIu/ofC1K73Z1f0g2o39fhID599wKY9GEnk=;
        b=A77ELhe9+Td3BTrcTyuJfxa0QQf7U7hRjDNLhla3o/JF77e+WkL2OyAMuXqOJ/sR00
         aKwW6aDosXLr7F5vBfxeIcVwI1jYUr4lHfVePTrZPCAtmNU0GNNKDS2UzgjPT2eZYzfC
         Lea02koxuryTkR8wkakmUAAqaUrgC7Ho9QsMYROMP5WaeZm1FYrxkR6TLlWEhW0LzZb2
         TOF8LZlM4MBIPKK/9fPeysDrXEZ9wq4mhTc548uby1EwD8tkuWVNbxNL1KvA3bApW744
         Vnl8FwGnzQ6BWkIqvinUwHrHWzvhRhyWCEYNGd7UFjeF2BkU4tg/f5H2v//WV1zAAhno
         X2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542598; x=1688134598;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7u0B0hbuIu/ofC1K73Z1f0g2o39fhID599wKY9GEnk=;
        b=KFJ0vrjyqIIOpxWKjv0pSd2aBEDRVlHBWZus7EyI+5bxriW02BXqz6OkWN8p7bE/oa
         VJjZHNNGHpWAzTvL7Vgfv9y1CnEX2WYj+k6e4D+OclQwdDmcbDwUuchhVMoURMgrF3xy
         iK1FGY98/Lirs+2xhk3pS2x+bkNEResRru2HzkLzNu6YI/4n6F9XQOVcxYF9dvwGIIuO
         4476nZjwjyUHTBqG7u7l4YCtc5oexeO33Y6YMHilsZJFb+HTwgMqHd6I66bKy0f0oXX5
         u0iMgOBbRxFlx/o1r4D/sVGYDUuPLqTZTburkIQgcn1VW81ozpNje1V/d9J8NJbcpxRz
         /Q4w==
X-Gm-Message-State: AC+VfDzrb4qy4M1Q2cginT+6Rq1JKvQwPindZUTQIYLfANGdgYQ4WXgF
	yy+blHR0tSn4Zn/dO0YvBDNEHF+fOfK3F9Be4b7JiBJM
X-Google-Smtp-Source: ACHHUZ4z4K2lVoLsTWPjZgPDm/ODvi21lc0TRV/jacW9kKQoGvMjGj+0T2GQvRk7B7qBtYzBvzKtGQ==
X-Received: by 2002:a1c:7412:0:b0:3f6:ae3:5948 with SMTP id p18-20020a1c7412000000b003f60ae35948mr4225416wmc.33.1685542598461;
        Wed, 31 May 2023 07:16:38 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:38 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:22 +0200
Subject: [PATCH mptcp-net v3 02/32] selftests: mptcp: lib: skip if not
 below kernel version
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-2-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2862;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=sZCgY6WM/myrDI9Y3wKCbXmTl62QCarqmwn3PxCHWUU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bCIK/x3tBBaJ/5k1ByTsS44DkQb0ZlAB0VK
 AI5TQ10/p+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwgAKCRD2t4JPQmmg
 c2JYD/9/D88S0f5FnFPlPcDdo/Sdwu8HdrafEVkMoyNbbFJmdiXE1cwXItIGqbJq00T9su0RGkk
 xztde/c/ePe/pySPZYl7xf8psFCUsLlnrcecY9cdKq/kxUOdulS/EFn5yGk4ss0NAiEOEsgpAX2
 3ONzsK8cWBatCYxix+34MjwCioOPxBG7YB0lkKeiLlOOGOgNvy5ShCnUDVq5VLsLBdUaIoVjuBu
 MW+qJMMhQWqRpd1wa+2fJrsu+b2hcn4s2Rxd+Tg2qaYvQxhVm/zAHBiuiLjaKA8VFHe+GLMPBbC
 7f6WG8AEbIFgNB9qNxUFHP3jmMkle8E+Z30hx62o1BNDRrbKioB1eyiAOgbbfcgYC5aOhUnBPpz
 2RpOwXzE4GtTAvyqHLP0dgsGZOFZWH5+BS6FAyG8u9/w8NiOBwZgXuZe5mokzr3p41KzmVBh+oo
 14ZSoOD+YMi1uDi1TIswqpv6tydxKNLzo0fT6HI2GZGeI0e7hr/+8UvrlpkS92A8ZHcGsis0zUA
 XaHtH79JELXBiy2Kla72SoPe1Nul+avMgdERshlwECSjDE/+q6nh426bA1V9npGtNPlfez6ZYrm
 9dGCzi/w3e1OGXMG1E1WbNqosa6NjwoL+7gvQaTx9WNKbYG7zX0UfchJz5WVYwlpAOHAMeolKkd
 zcyngjPYXelt0vQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

A new function is now available to easily detect if a feature is
missing by looking at the kernel version. That's clearly not ideal and
this kind of check should be avoided as soon as possible. But sometimes,
there are no external sign that a "feature" is available or not:
internal behaviours can change without modifying the uAPI and these
selftests are verifying the internal behaviours. Sometimes, the only
(easy) way to verify if the feature is present is to run the test but
then the validation cannot determine if there is a failure with the
feature or if the feature is missing. Then it looks better to check the
kernel version instead of having tests that can never fail. In any case,
we need a solution not to have a whole selftest being marked as failed
just because one sub-test has failed.

Note that this env var car be set to 1 not to do such check and run the
linked sub-test: SELFTESTS_MPTCP_LIB_NO_KVERSION_CHECK.

This new helper is going to be used in the following commits. In order
to ease the backport of such future patches, it would be good if this
patch is backported up to the introduction of MPTCP selftests, hence the
Fixes tag below: this type of check was supposed to be done from the
beginning.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
v3:
  - Skip the test if SELFTESTS_MPTCP_LIB_NO_KVERSION_CHECK env var is 1.
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 29b65f4b73b2..f32045b23b89 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -76,3 +76,29 @@ mptcp_lib_kallsyms_doesnt_have() {
 
 	mptcp_lib_fail_if_expected_feature "${sym} symbol has been found"
 }
+
+# !!!AVOID USING THIS!!!
+# Features might not land in the expected version and features can be backported
+#
+# $1: kernel version, e.g. 6.3
+mptcp_lib_kversion_ge() {
+	local exp_maj="${1%.*}"
+	local exp_min="${1#*.}"
+	local v maj min
+
+	# If the kernel has backported features, set this env var to 1:
+	if [ "${SELFTESTS_MPTCP_LIB_NO_KVERSION_CHECK:-}" = "1" ]; then
+		return 0
+	fi
+
+	v=$(uname -r | cut -d'.' -f1,2)
+	maj=${v%.*}
+	min=${v#*.}
+
+	if   [ "${maj}" -gt "${exp_maj}" ] ||
+	   { [ "${maj}" -eq "${exp_maj}" ] && [ "${min}" -ge "${exp_min}" ]; }; then
+		return 0
+	fi
+
+	mptcp_lib_fail_if_expected_feature "kernel version ${1} lower than ${v}"
+}

-- 
2.39.2

