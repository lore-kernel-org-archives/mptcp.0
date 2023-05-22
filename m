Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A253D14267
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:15 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f603ff9c02so10493145e9.2
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773493; x=1687365493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tk0yVDpEs88McJbg0HZXb6YKKY66/dBMHpeduD3eqHE=;
        b=I41+heYnFMvfZMB4IcM3bZalRbO1qW0xUht5tjo9xkPBgKHjoTwwugaTI+nikhuMAa
         jA80zxP8Hmg9IWYtqzuUoItnOI3f6EY2h6eNk0QN5khbBGuCFbodmnZbwltO6bkgTFt2
         1Wvq/N0LiMkxA7fTutBVwYLuDk+VylQGhQiAqyyDgQuPHfR7vS+NPy6RjESu+6kIO0L0
         YLLzhvVoeu1LtBdsHXhWDneNCqKCfvNSSk9wVTxrsLpJqf5h6BNHza/oGDH7V6gMNq8k
         OyEQxjoKNWOFv2RY7kbd6DuJ9JVS3dZH9GRhJFP/kOu3XUjFWC5753/gd29IfG6XThU5
         hMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773493; x=1687365493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tk0yVDpEs88McJbg0HZXb6YKKY66/dBMHpeduD3eqHE=;
        b=jwBR2r+pnynojmu4R6+fryIAlSVsIEV6+pffLq1veU8OgmT55YwQ0nkjblHPs+o+15
         Lf4HIINCZ7d4NN5K0osY3mXpsL6rn2VNOfknLpEXKbRmmZOjMeqScr2U2B+T6/WY6Hpi
         jLXPqJzOxmzOl7PssFaitTLIkbcsqy+ppYKxiZC9fmWFUOj6SaLTY3ADODuA6m1y7kr3
         Y1FwQGozA3+7AdPyNFoFauFCKVN4KY7Vzz2llny4uPEbtD5oiK8BBIqgFNce1bas+DGi
         l/jXe+Hr4Tni24cWpFRGRUaO5O0l8IWPELW2G0jrlGh2aL+YH7zA57MugZiN1Q0yRqFg
         4wbg==
X-Gm-Message-State: AC+VfDxUDIpX7GbrDQziQwaD4jYXkJhWZi21KltYlPzv0168KN/pD+6u
	+RWYwVcZdTv/B4m6av0WVa8re2iTjXE1GW3m26eIIw==
X-Google-Smtp-Source: ACHHUZ4KY4JwUEdwFf1p5AH2tOXdyepdOt1OIrQBxljkKgd+EzUeh1bjr3nU/0DI+XB3/eRPLRsleQ==
X-Received: by 2002:a1c:7709:0:b0:3f6:244:55e3 with SMTP id t9-20020a1c7709000000b003f6024455e3mr3701788wmi.35.1684773493676;
        Mon, 22 May 2023 09:38:13 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:13 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:36 +0200
Subject: [PATCH mptcp-net v2 04/37] selftests: mptcp: diag: skip if MPTCP
 is not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-4-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=eSP1RheZ+spFnZ1l17hgUmXgc90z52t8DvEZ1M4S+6s=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pvQTDc7ifyMuL66bS9k1dYBzWf5jUzkqLuY
 riGmkM0L7qJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuabwAKCRD2t4JPQmmg
 c55QD/90BmO51BvEQxFIx//EU8AkP+T3WTQ+ObquX84QkJXuyq8VzINkXzi5rBlyXRGOdMmaRzI
 l0yUhVGQ5f47cOBd+uSDUu6k532mwl2m0rFiw1Yt2bTZD06zXw7eVKsEASM2G25cqfRtRMc/DEe
 pci1Ya4oU/tRDPqSK9BSeD5sRixzpPs/pZjKlPuk3GRQDYNn78Tc/bhreo4QcTmSzUFGNV5hcgx
 HrROxxeh+IJr6mj4Vp/DstJksOPqR80upGMIR6BFl1WBZqtwinVT0CXZ8WH41L9zLf/0zDmDYMD
 oRaJhgykzWU1qmkyTJFnDSlca8cFszk3Lm/pP2MOXiMQCw6+M+ihQm1LhHz46Ev+OOpL0Gg4QyZ
 JnAv6BXrKZMVWG8poaBuo85U8tNbpmG2ifASlUYSIWp0jQUKPACM31Up2VcBEae3my6gDeGOJTW
 0zilKISxa3x4frqEPmNOYptVRpHpotjjQOF9+wSSBCpuf/NbMcV/esSy0tbQcjK3LfedlgtLuIk
 9qCWhGMu7mgqvK5mHeLFJsm4LmsTVll/kO94OU+htqneQQjKXALzU26slMvUsfZHpIukn8A2EsF
 yzOmy7pPMWyrx92B/vv1UmQ1krq4lVSVa8FtrKDTz2bhJ+xHNfn8vnX5BjwGqqh75hwp6aYnrEE
 HApV/CzjMV4OMfQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped".

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: df62f2ec3df6 ("selftests/mptcp: add diag interface tests")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/diag.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index ef628b16fe9b..4eacdb1ab962 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns="ns1-$rndh"
@@ -31,6 +33,8 @@ cleanup()
 	ip netns del $ns
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"

-- 
2.39.2

