Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD09616405
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:17:00 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3f6a6b9c079so44040995e9.1
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542620; x=1688134620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2PWnAIyHsMeh+ChzPcXB68Xq0rUI72tzvmqD5rZYmc=;
        b=vvYP3YbIvo5S3onPZUVqbuc20dXnSxQXXqZCk6BIta9Q0wRIGP23PzX9oAiPt83szE
         TqN3l36pxrCCcNhE3/B3tImELgOGds+kgJCScUiCcnTgBovsLuZczEg6kC3K0IjRuXt6
         5Kkn8ELA1EkKbpC/mjHTVlPHyZRZG6AHmabIQF4wLeuuv/axGKcHAO+Pf53XfrXdPU3W
         t94j3LZSrqZSktSteN68CCUsrKs89fBPSzoYUZc+tCnW8sJp8i4966q8h0RKy7k48WAa
         U1HznrcpWRvW22bSyx9ml73nn3qvwLopMtjyNHL80ussJfOWKef1HjPe5jr6/SxJDsQv
         vZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542620; x=1688134620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2PWnAIyHsMeh+ChzPcXB68Xq0rUI72tzvmqD5rZYmc=;
        b=ltpcZvwTbbhOui+GB0Iju3SiVQ6Mvxm0uqQZjX82YcrDbV5PbhB6I+/youZEadr2jW
         b8CrrlC86U0MEhizTzMk4VmSOZ25HpIKd1oWJYyNagwFLbXvBUFyhgBOEyRqhc1YBGGr
         xVNL6hOTonEqOeQig7YtF8aNdTqYmY3swbxSdzyeM2tZ9jIPCxZbLJVLYqCoiqipLlGm
         OI42o18sNNQZXfMXtD2b5Ih9p28Kvu0qjVpQlL4dG6swFsOgjFrfa4R6dn+YeAlmwxZx
         Na92bLvxyI9n5L4VvBWmD+IRMSTCSnfjujjQc4QQXQ4iUALrlJg3Uq56t8/FJeklsGCb
         nEng==
X-Gm-Message-State: AC+VfDzlTTQuyWVmacNOBJMki0luKcbn+a4q+3J/34/WBnFKvmc0ehT/
	FL2Ch0yZBEcEASLrjbA6YiExew==
X-Google-Smtp-Source: ACHHUZ7ERgysvzfrcD6qLIwk5aUhuxqgdAP3AE+kZ2ziYAX21E3TC/kiEWmuYVASlXiasDl1qeSpwQ==
X-Received: by 2002:a7b:c407:0:b0:3f6:1063:e4fc with SMTP id k7-20020a7bc407000000b003f61063e4fcmr3977203wmi.40.1685542620157;
        Wed, 31 May 2023 07:17:00 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:59 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:51 +0200
Subject: [PATCH mptcp-net v3 31/32] selftests: mptcp: join: skip mixed
 tests if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-31-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2806;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=QTGaNrAHWHang0LfRbw2N0hG9ZY7rFkfMzpAgTQlCqw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bEjT+jcBd4ihPD0yOPEw6+o1GDVyqnYeNNx
 X3EWOEnl0uJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWxAAKCRD2t4JPQmmg
 c7E9D/9xS9pLR6e7cgR8k2/PvQeBOb97LUPP0KXEyjI4rOw7WDpYqo+EsOl3Vnr45o7HIR9fEfj
 SdJyPB7+VUGqLrziPICDg7qzpIkTB+Af0xet47yvlySjEmFDXUMpHe+HYKs7fiD8w5wzvrn/idc
 MqIa7AM8wPdNJ1cgmvbgGA2pNTIAchNvjNJdj0CxeW3f/TFY8LbQ69tPtwqhU+3wSUQJvlMBWgC
 VviGi9ALsezi8c671C2aR/qaoeqOP5c25dksgHzi2i8nUicR3BlJclKb+IAF4/WjYHyNReMX5Hk
 d5jozDqcnNir3OP/dwU8RyMuQucN9b3AOioWzcpyVjBtWbbG8nGEd+koDYDfDYT25CoHYKVoxFu
 8+8WuY/r2wks4DVCIizTxR4jZ5XEfUylXljbsrG4TOC4km/tDgAkiYyirm62Fbp8CpgehH/FaoP
 hB9gOf/7FnloyfGdO1PzAo9SyJFmagd5Lb7WrG88S41/JooQz5rR0vrXMoWM0eMbYzbnD4mKVlj
 0i4snCP1ERpJrx/FfVZdWviQBz//JqRspA5PKdw63ieSdgL2l0tRHna+3rpHZv2y/1qC0MXZxqt
 buHR/jLW5PXPRhUarj2fEQFSDU38ydAr7Xf7pUNbjwlzA8vDUdWqgm7Pgzrnuw9KrfBSQDP7oj8
 kFuxFFgufz1qLSA==
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
index 26721ed7b797..2652640be323 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2646,7 +2646,8 @@ v4mapped_tests()
 
 mixed_tests()
 {
-	if reset "IPv4 sockets do not use IPv6 addresses"; then
+	if reset "IPv4 sockets do not use IPv6 addresses" &&
+	   continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
@@ -2655,7 +2656,8 @@ mixed_tests()
 	fi
 
 	# Need an IPv6 mptcp socket to allow subflows of both families
-	if reset "simult IPv4 and IPv6 subflows"; then
+	if reset "simult IPv4 and IPv6 subflows" &&
+	   continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
@@ -2664,7 +2666,8 @@ mixed_tests()
 	fi
 
 	# cross families subflows will not be created even in fullmesh mode
-	if reset "simult IPv4 and IPv6 subflows, fullmesh 1x1"; then
+	if reset "simult IPv4 and IPv6 subflows, fullmesh 1x1" &&
+	   continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 4
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow,fullmesh
@@ -2675,7 +2678,8 @@ mixed_tests()
 
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

