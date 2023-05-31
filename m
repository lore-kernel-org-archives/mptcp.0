Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADDF154AD
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:55 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f601c57d8dso8799655e9.0
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542615; x=1688134615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5QFPITsENx/eoz/6pobnboWXG8zBgLu/ap7jQUpWeH8=;
        b=ewxvilg2o6q2e/KwmzkPOXqLbotxVbY6mUUZtO5qTYKLgEcWKR66k73TMs38BMeO8N
         3uoTJD+3ijPlXTqo91oR8dW9Oi5TeWtXIC7vArXJhYZpO56YyoNHVGBeRSCs43gymRuQ
         TUrfvGBpyadZnR4dgz35g+bBrVh73rnn5q7cbWmonM/hYmJvJJoZE0oOqiYZUmh+jqzs
         hnF8MOAPjBk6qiZtc9VmdISxkGxd6cSTXOOhS6S5LuGqv6PwFra6a/Fg0VhSPxVhkjFE
         N91s9kSaxJDfOwc6mrsWCWbqWnV9diTAEXNLI7W0sF8YOwd3pni3Bt4Rc4uRiVFy/+F6
         Pa1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542615; x=1688134615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5QFPITsENx/eoz/6pobnboWXG8zBgLu/ap7jQUpWeH8=;
        b=L8rwKz9r+sgukVR7SnF69W9PuwUkzPvzMh1+u7wGJt0Q7alLYkm1R3bnXFSqlPw9Gg
         hZ7ifg/7Zf9kzIl19mq0lBaqB+K+yX9CFouguS431fNnvfCZ8ghPx1sqNGomKBRSearc
         QNm78B6EmfUMkOTPoKnLL7w5mYgA84IjNXqVWNfb74naH76IysC8RILJPhMEmlQG2cgr
         mrBkjABkRCGVncdd/iC9vDr9XaPFkckI/K6t+nXmkfj5+gWFT1vBaHi8QL/sBgQbO1uW
         Znnvb8AKbi80pvdoaIaIm+hZzHXCWlWNBKFv6wEM3L7OFr4X4NfnkpPBIt9fZRUQ3QkS
         vDew==
X-Gm-Message-State: AC+VfDzUh+RRfuk1ie6BLRm6RhOTJYh0I17kHb6LqBZLELlXQlNKuy2i
	fEout2VGG8y0BytE1NRxXieEIg==
X-Google-Smtp-Source: ACHHUZ6UnJ1JxTtEE5duEbnA55df3oTb7cQZKXAbIrLHUf3vybrdCrSrHQprchsdVKNL3GqUl2rPkQ==
X-Received: by 2002:a05:600c:4744:b0:3f5:867:1aba with SMTP id w4-20020a05600c474400b003f508671abamr11875632wmo.15.1685542615437;
        Wed, 31 May 2023 07:16:55 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:55 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:45 +0200
Subject: [PATCH mptcp-net v3 25/32] selftests: mptcp: join: skip fullmesh
 flag tests if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-25-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2756;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=3SVRVcRLC0aGl0j/LEEx0eEQeofMyc/Rs6WIN02uSHs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bDs18KdSJVSDBX2z9y/lYNyzzv52B8zP2fR
 1xonCH6WfmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwwAKCRD2t4JPQmmg
 c5RDEADUKNNuBF/2SFqbVTGHs10Z/opqzb2oZF0Xuu+NnZj5T86Znx7GDxCnIJRymCU3FJI6hiv
 LHwW7bckzi1DRGbIl5ezxrnITwC/JUgRwuTFYLd2wOLR03twAhQLaZD7XqOgBS/NrPQeXjYinUg
 kDwak6ML5Eri1zFpJipG8y/cdK/s83whl2A6mVU8c9/ARjeQxLLDQp5aMgDYElx7mMF2+0bN3UC
 gv3eSupgYutDivMAG1RuRk5vnAc9tmrWvWU1psoMEmugKxhwkc8eezorMsGl8ffdbaX98C8Frt/
 mo4ZPYtuYMzQuSBq4NkVHSF3M20qzaIRy9lMMNiIibpQHV6tJEYBbU9HHwR8DHm+oK8ffqA2jQ1
 rDLn+byjNK2SuUt0Heaev/zcdJ65oZriQCapsT+Gzipy9GSINsVkFAa8F+miOCGLClq5sMypd9I
 EDyWOGu3WGRk7LFa4YxwpcpXBQVkS3FOufUCWRs5RXf6PEYyIQGmauS8T0feQxWi61ERWOpxztK
 b5cnHfqiNSfx+NY+Jb9MEO3ppbNKsC3+51MPbESs7AJUjhBOc01JJyyqsUAkGgjrugbPx8r5NQY
 sAhXTR+9gjMnUzJAOr/PIb/nFUcatNaT07bAcJGjG2nOSyIi3aiWzQ77orXgZVetYbxOSa3QIgm
 YTTatI4HzDioG4A==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of the fullmesh flag for the in-kernel PM
introduced by commit 2843ff6f36db ("mptcp: remote addresses fullmesh")
and commit 1a0d6136c5f0 ("mptcp: local addresses fullmesh").

It looks like there is no easy external sign we can use to predict the
expected behaviour. We could add the flag and then check if it has been
added but for that, and for each fullmesh test, we would need to setup a
new environment, do the checks, clean it and then only start the test
from yet another clean environment. To keep it simple and avoid
introducing new issues, we look for a specific kernel version. That's
not ideal but an acceptable solution for this case.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 6a0653b96f5d ("selftests: mptcp: add fullmesh setting tests")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 529c95cf7fd3..04464a73ac9d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3107,7 +3107,8 @@ fullmesh_tests()
 	fi
 
 	# set fullmesh flag
-	if reset "set fullmesh flag test"; then
+	if reset "set fullmesh flag test" &&
+	   continue_if mptcp_lib_kversion_ge 5.18; then
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
@@ -3117,7 +3118,8 @@ fullmesh_tests()
 	fi
 
 	# set nofullmesh flag
-	if reset "set nofullmesh flag test"; then
+	if reset "set nofullmesh flag test" &&
+	   continue_if mptcp_lib_kversion_ge 5.18; then
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
@@ -3127,7 +3129,8 @@ fullmesh_tests()
 	fi
 
 	# set backup,fullmesh flags
-	if reset "set backup,fullmesh flags test"; then
+	if reset "set backup,fullmesh flags test" &&
+	   continue_if mptcp_lib_kversion_ge 5.18; then
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
@@ -3138,7 +3141,8 @@ fullmesh_tests()
 	fi
 
 	# set nobackup,nofullmesh flags
-	if reset "set nobackup,nofullmesh flags test"; then
+	if reset "set nobackup,nofullmesh flags test" &&
+	   continue_if mptcp_lib_kversion_ge 5.18; then
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_set_limits $ns2 4 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh

-- 
2.39.2

