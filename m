Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3136FC9
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 17:06:55 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id t4so37552551wra.7
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 10:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680887214;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsDba0/wax9/tdHmT0GOCCzvKBI2gaWOdnHmndnX19U=;
        b=TdnbwOydckr7q0OIBhgU7f7yVZn60/ETf3fljVhS8pmvp87WJHkMMop9nXsCTzyCFq
         ISmwVd7oGiS22vA1brmJycu2nv/e+GDb1hBjVHo2crzDH+B4um0KNXrvM85DWkMQwuRu
         wOiJ/DRK5Nyb7SZWWsr9ILSBThSFOo9lD42cNG/sIfIfluEkSlRW7mvnTI6DFa1N6y2D
         VAU86o5zkTaXMRdyWF5yAYd17iE0iDLUtbXf9enGOn7AqI6+5r/T67ejCA26RodEDpMS
         vzU2P0sTqYR0XxUtAnrgYqABteYST2YqxhQcOiJE/VDvE0rY+6lt/Cd1C4dKLO9+nBNU
         RYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680887214;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsDba0/wax9/tdHmT0GOCCzvKBI2gaWOdnHmndnX19U=;
        b=oELWL4g4lHeCLpxQ+uBc0GsdcBTWte/HlSdii1ygNQoa5WpfIT+HnHbDOFbVOoOzkG
         f/agynpdsJG+GAoSFC9J8FVe+qTtz+fT85HUBVZxsr2y1AqrNgrF8d/pkzJqsFTZfnoM
         mQz981PEDAXKOD6Z3nVUfmwWmH4rRbb7ul4WBPnISJB6C/vLpjwLWwC6F7sTtkXLVpid
         IigQUHP3JVSNGDNzdZ9/Sv0iPSbIXoACqgR2NGJmq3liVD3xeK1u+FcQaL6Sch1sjyQV
         J8JLmd78Ln7wEyOLjUvUjeorf7d52rmRxnzQze9qPJ5xONhiXb91RTUMzp9TPaMymKWh
         IksQ==
X-Gm-Message-State: AAQBX9c6BzAE0ubi5wvIhfPMPsWRiDMAWnGLVCup9pTvWuJbPfUNuXa5
	rFcrrf6jYae44GtAflQ+1jpXlgQL8oNB4+M95ysAFA==
X-Google-Smtp-Source: AKy350azaBqPDctcJn9ZJN55AOpbVUE71JIpQ/KJZ+x3A+mqFzuhSYQb7NNxH27j8UvNZaMFinSbHg==
X-Received: by 2002:adf:d84c:0:b0:2ee:e456:5347 with SMTP id k12-20020adfd84c000000b002eee4565347mr1407636wrl.13.1680887214199;
        Fri, 07 Apr 2023 10:06:54 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id t5-20020a5d6905000000b002efb4f2d240sm908360wru.87.2023.04.07.10.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:06:53 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 07 Apr 2023 19:06:37 +0200
Subject: [PATCH mptcp-net 03/13] selftests: mptcp: join: skip if MPTCP is
 not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v1-3-246ac567724d@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1158;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=Spoha4/RwCU8H2BJUejEnCzfTeW9L0Y6rFCYaApbkag=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkME2qfQ6gNoE4FI/qgC2ZskjzyOWuVK+pheCOL
 hzKwrxvhkqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDBNqgAKCRD2t4JPQmmg
 cwlhD/9rKINcls+cr+BzJbUwPsbwUPtJVrzs9mxEq43XVT3150POCdNMnPNkwBnkaqEp16+sBYn
 jc01EsxOzg03jNRbnzCU83CnpVlmkEPZJ8Hskuw60UWWcZjsd6aGivNaddfO8dnh122K4ilV8Oo
 9W5GJceE1So3Ax6bXkoexguVRpZWmt7zP/VWpbMvstzsCHft8bbCiGVKD8eaxaE6zo2+9wEJ5hh
 8CBkO2VBkWiqolRu0TpwdiPiRq6GVeM7IPDVyABHzagDVvGIh+887QYeUMjP9SRLKC/8Z2mRiuY
 AfvruUkho824bf/KAwfkgp5/lo2074TJ1kHDgLERvOaio2mHyqX83OMN76P5VxnYn7MCSRpPbbG
 YiiZWjgHvx/O5AoIGD+J4Z2Dnw5Ee6fceSqABep1RUMIZtKZ/jETMt0v6R8iNkkVoen/oaNGOI5
 OhKyfxSvXf7vtC0xd0u6ywXWvQKHCIlVmZVR9QFV2DkDuFP4gUBc58GZZnRzq9FQyJNq+dRz/yN
 80XQvAGQPuPH2yfQbdvjXjXCsD6qKCegU0V+qdHtaB8q1/k6AgP0hbV6SpWt6afkp0LlU73+9K7
 +O9xvehXlceWVVk1tt/+tX5MXROb9N0JVzDJJB16smWcg8+c5Gshrb+Py6D49kxzqh+O/6/KsHc
 2aeDzAa2Q2piy/A==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped".

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: b08fbf241064 ("selftests: add test-cases for MPTCP MP_JOIN")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fafd19ec7e1f..315ea136fe2c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -6,6 +6,8 @@
 # address all other issues detected by shellcheck.
 #shellcheck disable=SC2086
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 ret=0
 sin=""
 sinfail=""
@@ -132,6 +134,8 @@ cleanup_partial()
 
 check_tools()
 {
+	mptcp_lib_check_mptcp
+
 	if ! ip -Version &> /dev/null; then
 		echo "SKIP: Could not run test without ip tool"
 		exit $ksft_skip

-- 
2.39.2

