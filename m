Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD36CBA29
	for <mptcp@lists.linux.dev>; Mon, 17 Jul 2023 13:21:48 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so4590368f8f.2
        for <mptcp@lists.linux.dev>; Mon, 17 Jul 2023 06:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689600107; x=1692192107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3swvJblXFY7hepLBKVBwcTERoJ/lBHHAZ93IzbSTQjY=;
        b=B1LieMi6ssPJ6jk46giSdZsI6Tg+Pu6AhOJX7PpJakn5AlzLtdlEZc2DShoKW5tBga
         uw33oR0TTXnriONrH16jPtdmF/wpkd9ckyMpa2X+RXTyd2qD6VJOuqPsNdHV/Lbz6a02
         8vNKICuKsEO90ny1gYraZttYqPiUL+r++lYuCQUZIX06gMiheUzqFuGL7hC7bJ3ldu0i
         43Lj049E1wKRJV1G23AWRRQCb1mlEadrhdfqPtNzAnKySudVSa6vmW2T4bTPI1Po1xwt
         LkDBbYAtgjSCPHJNunupxAw7+eMmspJv3AAM1a/K54YFv/EAwY7ThbyaUAMYpUy7qOBy
         F3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689600107; x=1692192107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3swvJblXFY7hepLBKVBwcTERoJ/lBHHAZ93IzbSTQjY=;
        b=Q8PtHrF//Qg9gcLKXNhoiUR+7ZtHi+QzX9wYdaAz9+4YEkT13Efr8tSHKN6oS0qyg9
         Pqbl9IuLYn4jiZFAYHXufyzWboDvNq97GzF648m5wJq6D/ore0LxqDpUV0+68fIxtzNG
         xxncUP4uz4hTdYWIK5XFf9YOmzK9qo8xJw6GNjb+jqVOV/XPSk7HTkTXn07rV21y5XNv
         llSnPGEgwomWs3hiQ3N6guo/n+EdDj+Pe6HjBi4NmZLMHwI+JPMU4Wxn56g7j9Nju3uV
         O4GWhxhagvxZqdNDLPS9T4aOXh5Js8EhH/JhVCnLw+6Wzvn3Og28iHeCeIXkMr5UcESe
         oP+A==
X-Gm-Message-State: ABy/qLY4egCMVXUBFpatoX8dvMC+LdJ08W6olrMzkUyMSCiIRy+9gfl1
	/2geZjg7CiEhEaO6K1futuIlqA==
X-Google-Smtp-Source: APBJJlHgqSF5fcJ+5E/hmltr5E2vBzYHvG+Fihohvt0b/KBDtXxiDjKfH2dC7wrqbk71uzAjm4UPsw==
X-Received: by 2002:a5d:5107:0:b0:313:fbd0:9811 with SMTP id s7-20020a5d5107000000b00313fbd09811mr14268710wrt.3.1689600106919;
        Mon, 17 Jul 2023 06:21:46 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b0030fa3567541sm19249836wrx.48.2023.07.17.06.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:21:46 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 17 Jul 2023 15:21:33 +0200
Subject: [PATCH net-next 13/13] selftests: mptcp: userspace_pm: format
 subtests results in TAP
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-13-695127e0ad83@tessares.net>
References: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-0-695127e0ad83@tessares.net>
In-Reply-To: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-0-695127e0ad83@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2658;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=O6m1LM84cxrhhzI8uWlZLQYgX+bS7UA+N6Jx+FLdCoQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBktUBdvgkqpMjTpRYU+Ynhi6pWe5f+5yr3Y8IC5
 ZB2gwG12gaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLVAXQAKCRD2t4JPQmmg
 cwvjD/913+F5NjBK/NaWa6bzohUakXQmYfy5cnrNVwS1lbjMgcVY/nMkyhC504v3AodOd2+cx+D
 QKPBYsWhHcWruoVc6/xBqVJP0etAq07k+DD3TDeBZ3oN6APa+X7iMre55R7I+82QZvhiwV6ITs+
 vLl++8X7rcsEzD4sdeMlT7b6AvlDpKRxzrvYacamSlYl741L9pNFBHI+/iXPQvfID9mww+mCVZE
 oABkUyObyyWB2a34yQcS2ItCP+Aex08iUWuRb45wk/X7X16tpdOmp9//FkUI7PdzJKGaixl5GVD
 Ecx8/hxzkCA3z1NsLmYoMf0v2l1sgxtHda1yH9UbTt4CIa3ZfP6GgDFhKnL9QiWH3LJ21COVBqW
 xpGtITHMaxJCQzDaTfx60bY8HNKFXBYmr9MVXJEl7XsP+JjpiewL+bloHhOyuwSsmoLnAyBeOXX
 uW7pSO4kElxj2KpGMwdjvrM5EmWPcVskMddbgyqu/GijABePDGr08JUO40OcWMiLN2nJwYHAHCE
 ebWAzOcZRvpnoRfcci3M6cuJNkJ4myykCWy1U5kJZx3wgdEXn/GlZFTyuJacP+Dc8R0AlKThhr3
 onHe3OORLV6YxAoDg5cISzeC2TLZdZYsKIrO8Egpq6p+NJdOCcZB5BPFprrxXOSGN+HK/WBS7Uc
 HijGL6iTslgB+Ig==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The current selftests infrastructure formats the results in TAP 13. This
version doesn't support subtests and only the end result of each
selftest is taken into account. It means that a single issue in a
subtest of a selftest containing multiple subtests forces the whole
selftest to be marked as failed. It also means that subtests results are
not tracked by CIs executing selftests.

MPTCP selftests run hundreds of various subtests. It is then important
to track each of them and not one result per selftest.

It is particularly interesting to do that when validating stable kernels
with the last version of the test suite: tests might fail because a
feature is not supported but the test didn't skip that part. In this
case, if subtests are not tracked, the whole selftest will be marked as
failed making the other subtests useless because their results are
ignored.

This patch formats subtests results in TAP in userspace_pm.sh selftest.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 568ddee1d102..23f8959a8ea8 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -59,6 +59,8 @@ rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
 ret=0
+test_name=""
+
 _printf() {
 	stdbuf -o0 -e0 printf "${@}"
 }
@@ -71,7 +73,9 @@ print_title()
 # $1: test name
 print_test()
 {
-	_printf "%-63s" "${1}"
+	test_name="${1}"
+
+	_printf "%-63s" "${test_name}"
 }
 
 print_results()
@@ -82,11 +86,13 @@ print_results()
 test_pass()
 {
 	print_results " OK "
+	mptcp_lib_result_pass "${test_name}"
 }
 
 test_skip()
 {
 	print_results "SKIP"
+	mptcp_lib_result_skip "${test_name}"
 }
 
 # $1: msg
@@ -98,6 +104,8 @@ test_fail()
 	if [ -n "${1}" ]; then
 		_printf "\t%s\n" "${1}"
 	fi
+
+	mptcp_lib_result_fail "${test_name}"
 }
 
 kill_wait()
@@ -255,6 +263,7 @@ make_connection()
 		test_pass
 	else
 		test_fail "Expected tokens (c:${client_token} - s:${server_token}) and server (c:${client_serverside} - s:${server_serverside})"
+		mptcp_lib_result_print_all_tap
 		exit 1
 	fi
 
@@ -990,4 +999,5 @@ test_subflows_v4_v6_mix
 test_prio
 test_listener
 
+mptcp_lib_result_print_all_tap
 exit ${ret}

-- 
2.40.1

