Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3944414287
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:17 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3f608074b50so6725515e9.0
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773495; x=1687365495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EbeUnaxCToMYLf90EZg17RWGgr6qa3CnSSvyzF0rqyI=;
        b=S5Mf2ehvJOI/YbB1CqAnv3ac/atPGB0RSDJSm5x5WeFtz2BsNe/JsjfNaZEJOM1O1v
         adhYjnZGjBBQlw/V+bdbc6BsDVYyhzfSzSS0Ttd/97jPik03WdDm9K84wHCpL+2CIoNK
         0b1gtbIx7Ulttk5568tQjCoykffl5Hw+zVR3UwuDm7MsVQOFc7Vc0bGqAD7aXs9w2MyX
         +f0yJM0XbpGXMtJ40QLLbTa1tHbwEbVv1kVcGbwZWnPqrHCBv2J/yL4ZpEGeI1UvFAis
         PRLDlfMUUOMwPJcn0Cwsgdm/hTV2VteHNQrQbXPQAzslBYlfQhpTT0G/YyaP8WcFL+vj
         zj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773495; x=1687365495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbeUnaxCToMYLf90EZg17RWGgr6qa3CnSSvyzF0rqyI=;
        b=foj3E4tD1jhFkiOR7iAijv2bZ+aN7RjRdtr7W8up9RWaXyr0fxV5cpLwT8PlmjoNez
         72XMcT8+NNL55hYupy17nENniu4RVnDft+bS5AXFAgZcibVesf7kiVjjCzoZ0nNfE/c5
         3yhf6y5nPwtBl4o1CwPQekl2xgdDKdzK5JY8J3SjfRO4XLmig/JQZ3tb9xhQ/UtveVvZ
         42Q4BGX/aU3Pw0K+FbrOZ7egQBQTQdINafq5qWVPqqw2FpD0Z3Dg9KBY7E3y4dHvvycY
         UTCae19FmIvIgxW7RWwvPm6iTLB+0c+Dqo5fqEoeGDSGVAvOZavhEULBfhJA+kVyntFt
         kcKw==
X-Gm-Message-State: AC+VfDzDmGvxpzsQH4veeFlFa92quYnq+7qWevRYng5fyXumxg7s4Xas
	8wokg4JB18LWy0CVk/wY8G6P+kEPrISE69YJ5jWtcQ==
X-Google-Smtp-Source: ACHHUZ7h2ayKUahWR31nNiRHZou+Qd8SfCCh3OEgprMKhC5cWtkC/uCfaJNFYZWv0yCk8ni5tZYUPw==
X-Received: by 2002:a1c:f402:0:b0:3f4:23a4:7a93 with SMTP id z2-20020a1cf402000000b003f423a47a93mr8857574wma.25.1684773495172;
        Mon, 22 May 2023 09:38:15 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:14 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:38 +0200
Subject: [PATCH mptcp-net v2 06/37] selftests: mptcp: sockopt: skip if
 MPTCP is not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-6-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=f6gNm3LpzKNwEQa/BeQWxsJzjsjQQQdbyMTTSBpnCog=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pvZ+9Fg0PH2X6V6ECOMebknawAkghZC9RTO
 5pgbZgVg32JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuabwAKCRD2t4JPQmmg
 c41AEACLfqjJHfr/cFEYMTGWk58iZUJFZv699vbm8HEBOklkxBAA4aAmoPvodNs4FQOV8StYbRt
 D4AMTaUoy/d7xDCmcK1ymqxp5Fnr8WZ5dCs5zbsmx0omT2Mn1l4upvDYDWOBMHS55g97Lgko2AF
 62sR7svdhh73M1HfnwzAmiJnYXwTnUfymLLqZyxIGIfFXXp59JUAntP2DqK9JsaMADad8D9Btug
 JiA+L/uCLIvdGLMKwFgZEJjfp4KgeuTY+u71SDGFOItFHsWAdXKKpLf5pCHw1dVrj6EPeEZGiSi
 baoXjn5XhQqd61vGAeyhruzMPVXmo/BaKEMNauCY2VZpzrdZYoH5EHCAVRpuymqx0ldrJY4lGog
 zDonj4RsRPLJeYUfx831y1ptAb+aKgbhD7FMTndhxLxitzYf+JmnID8TUfXGe0b2E8yA1skUxKG
 ovuVGTMA+XrNmise4hrpNbfSWDyKEG+Es7rdDDlaW+BqB8gCp3Uo15HFRNR46CoBv8ZbaBFpXdK
 RpUK6kzXNDVh3zFoQ4LLiPAH8TvsvGlfE6o0SVoe6sHNvvZIs+sQ/7m7HAATf8IdZLKL4PJhbj3
 ddc5++xcbPBGsMk5djtItIdnjO9xlzgfkXfHuuAgEzasodysUtxKnvZqXEY0OERPeDQTVeb9iYV
 cX3UwjenHvoWROg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped".

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: dc65fe82fb07 ("selftests: mptcp: add packet mark test case")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 1b70c0a304ce..ff5adbb9c7f2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 ret=0
 sin=""
 sout=""
@@ -84,6 +86,8 @@ cleanup()
 	rm -f "$sin" "$sout"
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"

-- 
2.39.2

