Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950A913AFB
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:38 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3f6094cb26eso152525e9.2
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773516; x=1687365516;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39CSsngkWCVlQ2979uc2zMYSnGebdanSV4IYgXqD+T4=;
        b=XRjhoVKSWug6+pAcprfl7SsiSpKQkisFndaIYz4XCxI29rMgPSwrvVwv5EuBOCad1W
         MXUWj6R5rI0zb3u+JUy7R4ascR8CFq0nIXut+oo9gKpe6gLoufMbeLg8tcOS3ZFcr+h9
         1G/5o5+UA04E1zS4XLsJ+m/AVWYk3oaQZR3CIHy8NS3qWhfzVoJ4QC0KP0l62iJDiqUZ
         1xdNL+SLzX6v4ggUe6JsjSXnjyv1gg5XuD1H4JJqDfew4THx85AMIFZVN3igDsY7o5BL
         P+9kSzm+8ybpU9rkWQ98XYZojbyK5Dgr+eTa/4+1LYzjSiu0pYkr472oy1RTc85kH2Rv
         vkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773516; x=1687365516;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39CSsngkWCVlQ2979uc2zMYSnGebdanSV4IYgXqD+T4=;
        b=V+1XdGQZcOGOY6i36aZBIRAcY6omLKHyWw3Z6ncncc/+G1Jtb/snTeNsUFAcZJiCH0
         2Crbx7Pnxc108x42pS0NmeieWCGeb2ztCg5aVRpb/HMEEMqLZpSAHXwOhpkbDhEg5vT7
         Qh86LO7vztV77Gthr/GvbIdWB3DjPeSP+StEyCsxJP9O2lyxBawhV7DRVWVQVxFWaJqz
         OZDR8LMAKdfioz2tKsT2E5dQ2jVE0e9aQWaLh4ZvzpqRdNA4q/+Dip2rEbhXAzUoAgse
         KW2yzVrtg0neOGac6O85G/jaHbjeUVLEJu3wl6c+oVaTWxtqFy4bNGevdzVn8An+6sFa
         P4KA==
X-Gm-Message-State: AC+VfDy5708OSNe+KcXZhOaMQLfM82+QSSd8Dl5kKELYhO8B0CNl+3mZ
	oBOTqmZrKwQrtSoZTw9j4n7JfAgve8oxaPoxnLLo7w==
X-Google-Smtp-Source: ACHHUZ7wCg6BoXNStFiv3tSi4SHXl1lBQLE7TreP4te4QCOwhlHQ7nfYw73Kp40f3Q+sH1gR1sWE8w==
X-Received: by 2002:a05:600c:b58:b0:3f4:2815:3afc with SMTP id k24-20020a05600c0b5800b003f428153afcmr7656093wmr.13.1684773516630;
        Mon, 22 May 2023 09:38:36 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:36 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:38:09 +0200
Subject: [PATCH mptcp-net v2 37/37] selftests: mptcp: join: skip mixed
 tests if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-37-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2806;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=aZA+/W/+9z1cTucuXAyZ2RxVsLKZg2UHOmTUpP+vsGQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pxXuWGl20/Wvtx1r/Ij8CL9Jhef4+CJvPLu
 edDzJFByf6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacQAKCRD2t4JPQmmg
 c/P5EACqNmk34Y84JYk8p6Ny1ZZJRWpRz3Ctxz/HZ/sbGyIMmAN5f76FRVndjiQVWvH+TSZK3H2
 L48+ARwHKVgvYNSecNeUqbZUnurIfFyqBtTbir5A+xm/Owj53CzaGaLcST8qf5fBFvjhq5HElVN
 DVnVKJ57GfcfTwyfL/SjOdyzAoFfZH84EitEwX5mFAOx15hZQQM7QhWxPrne7qghHVcuQthEExC
 Jd5rJH2pRCKicNxQGhwVNpTbGY1P2k6myt2pUvJEhun9GdB5Df9vpVvxLnI0QpPVTafgIa7vT6g
 IgEkyFdKnNfB3jawH6lUfT1bHKjfH2mBwIuZhVe5qrrVKjxGl491MxlBxFSThRJ5PglgStsbJWr
 ink9NuOEoHLqbO0NaU7HAAWbqKrFdmCyDETU3fB+xS1JARjMlth6ktfAzmIgynazYs83I5/dng9
 UTwfw5tGLtjcfnaVZX1qQzb6OPlFnaypjhQwGRm1Gvw7Ec0aW9e93g4B0WrDU97JFDiTQkbABMu
 /D7NSsPf+Tkuj15LQU7fxGMrObnnbEih1QMmixoXDYfeBgzvH7gg+IL7MYV2rnaUfOgSCWhM7he
 s4JEIBZU1dgOPzrPcnvW7HBBfW7wC9rGJ9kUspFUWWH7XV+GsECdHeR7L9z6VUVbedftZhjwZki
 55GaTzZIVD5fg2g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of a mix of subflows in v4 and v6 by the
in-kernel PM introduced by commit b9d69db87fb7 ("mptcp: let the
in-kernel PM use mixed IPv4 and IPv6 addresses").

It looks like there is no external sign we can use to predict the
expected behaviour. Instead of accepting different behaviours and thus
not really checking for the expected behaviour, we are looking here for
a specific kernel version. That's not ideal but it looks better than
removing the test because it cannot support older kernel versions.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: ad3493746ebe ("selftests: mptcp: add test-cases for mixed v4/v6 subflows")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 48d0b7993194..484838703532 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2695,7 +2695,8 @@ v4mapped_tests()
 
 mixed_tests()
 {
-	if reset "IPv4 sockets do not use IPv6 addresses"; then
+	if reset "IPv4 sockets do not use IPv6 addresses" &&
+	   continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
@@ -2704,7 +2705,8 @@ mixed_tests()
 	fi
 
 	# Need an IPv6 mptcp socket to allow subflows of both families
-	if reset "simult IPv4 and IPv6 subflows"; then
+	if reset "simult IPv4 and IPv6 subflows" &&
+	   continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
@@ -2713,7 +2715,8 @@ mixed_tests()
 	fi
 
 	# cross families subflows will not be created even in fullmesh mode
-	if reset "simult IPv4 and IPv6 subflows, fullmesh 1x1"; then
+	if reset "simult IPv4 and IPv6 subflows, fullmesh 1x1" &&
+	   continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 4
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow,fullmesh
@@ -2724,7 +2727,8 @@ mixed_tests()
 
 	# fullmesh still tries to create all the possibly subflows with
 	# matching family
-	if reset "simult IPv4 and IPv6 subflows, fullmesh 2x2"; then
+	if reset "simult IPv4 and IPv6 subflows, fullmesh 2x2" &&
+	   continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 4
 		pm_nl_set_limits $ns2 2 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal

-- 
2.39.2

