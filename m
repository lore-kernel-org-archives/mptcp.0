Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0BC13AE5
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:16 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f60410106cso10082605e9.1
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773494; x=1687365494;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2moyIEpgMC4mAHvK5C3jCKDi9tp9AsGCBR572h6d2LM=;
        b=MUDYAQSdjdz5Qc2EzpRVqbG4EqcMeTWMhrw2OvVCC0yl+OB1ABY34DRlKDGkY933jz
         LMyWN4KJ9ZiwSCEl7uh7TGFhAUpInOHvbZ3Es7q5jYRkznacIsRtyIcT5iqpIkazkR0i
         wfuM3on1O6ik9Eqvpn0HIp0RBZ6fvF/qF4DRV3IWuPtEtCXyCFmpS2W++r4dh0hf1hfg
         WjcSXxncHGoQNXjXxcTELvaprAQL8OimKc4nWuXhZltCr0XSRbuC6YgIJ9ffB5QUWTqS
         V2O949xYnhlv7RyVQAlhn5mSROFg9mlkdao3JK2nbKH2G6Rgbv3P8pgj0CUflK8azWkM
         0DQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773494; x=1687365494;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2moyIEpgMC4mAHvK5C3jCKDi9tp9AsGCBR572h6d2LM=;
        b=MQmIjsOE2JYYR575Kmw5iNpAWxC8XP23ZuVfHxqMid7FelHK8V0flrwlPbIkOEG6Fl
         n2WizBziDGptvaCPCZYytJH7wv5RlCpgnYtuXm2Kv+s1UFX0oGTSV7CTK0ERh2TXHwfC
         tfyKfNpWpIR92ba76Mq82Unuazvlmlbxm7tXga1txoznoyF/KT13XwUmURTfYdiKEod2
         HKnRBbs8oW7Afnvmf20qytlOBHlPhgIXMEn7bFB5C2AD3a+sxK0eMFydUPlzD5AvwOl0
         tPfvEfxNOV26ruNTdmdro9xsQSvDJ9oex7pqWpOka7pFNCLjcMdnjUVtp6HgzWnK6Nzd
         p7xw==
X-Gm-Message-State: AC+VfDwTJEnskZfzQ/8M3c1q886Xahqhn6HXNMGBY11bzwTLA/s4ZwXz
	QZYgfpXP/tY7Ja01BuDa8nyoSbAJ4UDxFK9guGon5A==
X-Google-Smtp-Source: ACHHUZ6VKUhfcmNTGTgp/smXJAST3Fcwt/2PoAZvdEY0KiaCz0bTLtJHSX+n21hmDlDOP1UP2JT0VQ==
X-Received: by 2002:a05:600c:2286:b0:3f6:451:63bc with SMTP id 6-20020a05600c228600b003f6045163bcmr2694200wmf.2.1684773494499;
        Mon, 22 May 2023 09:38:14 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:13 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:37 +0200
Subject: [PATCH mptcp-net v2 05/37] selftests: mptcp: simult flows: skip if
 MPTCP is not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-5-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=uQrhrN3VLtLshSxxi4lbPMHbgQWWhmUdbF/7BUpdA1k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pv8BQpPESwazikBGN9fmAQsxjZvbXi3o8n2
 pkEw+h3FYWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuabwAKCRD2t4JPQmmg
 c077D/9SIA7+qSvTdr4gwOBCgz0pabqRbC9q6qZwHINO1QirQHrZ0tBoQlgNRug77BvBbhr8T0G
 kZujZhE0ovg5lCuKup5gS99BmksHzScZI1QKYz92FbT+ahWf2Kn88TN+ZuiY88En7bvwU3nYVrz
 pVD35jTqMr3dLjnNuYncNcgI9Qinx5YwT7mKgu6en0J0HqXfFl7fdcViLmWaqJUndTMGUFylvAc
 Rg4MVfcyxhoGHz9J5yPQyGkjv1XLfT+36w/ERFpg6XbGM70wT+l1Mf/jep2GIXsUPO8ehqHLCQT
 bqyzBcJfbIZz7clKM1nJVUdgyswQMancYZMKzYLZVD26Os4HxJ84vdSNJ4HKd9Cnm8p3gbhwUMr
 In0eayzpTmsKDjiybxpmmkg8/pk1UVjRtDdUrClVpjoFtm0V6NZWAPUgwVZO1EgrW7ENtkoiG6q
 1Zpjfx4xFZeJB7nT2dgOItb1IBVeCkxInmw26BwZOoRppDyxWArF7HCLbn+SpK3WMDHCxzmIUvQ
 Jblbi6wnb82+LwP7ogloObbtf+wUxbUTFnl/xjHSdKTMY/w99lqMdMy0MvamyMCo9nv2pf2j62V
 RfLcsmxftk1ffeY6UOFDz7xUrwHXH7XvbVMBGBLzuS0C7UkytiBpIKDpjn8+AcUGhHbgHZOH8lN
 XXCdy2ljH5Tcw5w==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped".

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 1a418cb8e888 ("mptcp: simult flow self-tests")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 9f22f7e5027d..36a3c9d92e20 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
@@ -34,6 +36,8 @@ cleanup()
 	done
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"

-- 
2.39.2

