Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AFE611B
	for <mptcp@lists.linux.dev>; Tue,  1 Aug 2023 09:07:49 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3174aac120aso4965171f8f.2
        for <mptcp@lists.linux.dev>; Tue, 01 Aug 2023 02:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690880868; x=1691485668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6lX5JSmrO+d9PQMfUwrcKSo+nafwxjzZsg9aEr2HoE=;
        b=DyWyDrX1awJE7AVLaSZ6Quf1w8chLKfd5AWVKAVl9UW7YdQIWFQdS1Ju+9pA6TPy2z
         GHEyjIDJH9M7mGxG7BXcIiKL1Kb5HoPSKmwFdxYmxupRa35uvbxi+gstVwfOgOaKAeGQ
         6MP9/2Di2H9Jhjaf9i2WOT++BELosSfURVJKxYyT8MDHMZ9Qbw7Zygvjzphw62dp7Z7M
         Uw7eEKlkaPEaVdgunqe2S4uEVhZPaIMpplNpOteaAAU7L3iidtB0uu4BaANob5OT8zFB
         eUrdcgl+Atqg9NRk3OJlTYaYrKM0YmZj0XhF5hW2w6DT4guMHbuQ1RuidqCZQx9BFzfF
         FnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690880868; x=1691485668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6lX5JSmrO+d9PQMfUwrcKSo+nafwxjzZsg9aEr2HoE=;
        b=KLFCKopXRv5dSDaX8YjM6x8KeWZq49HMGVniaW9W79WkC/9AKuWNyKZZ6BjHVJtcMO
         5uxhm/UAOO0XfBVisb+FRsfAVR4gwDy4/x1CO+iOe2eETzOQiOZG00l459EO3AOAkVVL
         dOVEy03I0p+qE6BzXNDMosWzpm+UuNEGKdQXaOv9FLOEVjAdXbdADhbuldQBiIvlIHxi
         ZMVLnkxpvXrK99WealiKRr+NSMwLiZ1GN3+QEfb2HBmweSk7EkznHIyx05TL9RPN5ZwK
         5bBOLn2HmS5t6VEBGhPKOQrc+9xjh8ck9h/CTQxsge0H/YOXi21DER9EGphOI1cWUbf4
         YUbw==
X-Gm-Message-State: ABy/qLaBe518tQoVzdlZaVt4GvoJmWpejjVWYYI3afpb5Z9oSiKAqxjC
	ptYDbMw/hkDNGnLxWC02ABQmug==
X-Google-Smtp-Source: APBJJlGowSw2WZ1lITT/LFLe0mm6d8vbpj63Fktl2fbGFGP17o0Z7OgYko+0SmYlt2jV5tZXkDo7Ow==
X-Received: by 2002:a5d:54c2:0:b0:317:650e:9030 with SMTP id x2-20020a5d54c2000000b00317650e9030mr1725878wrv.57.1690880868106;
        Tue, 01 Aug 2023 02:07:48 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z17-20020adfec91000000b003179d7ed4f3sm7307266wrn.12.2023.08.01.02.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 02:07:47 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] selftests: mptcp: join: only check for ip6tables if needed
Date: Tue,  1 Aug 2023 11:07:16 +0200
Message-Id: <20230801090716.2234574-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023080104-stability-porcupine-fbad@gregkh>
References: <2023080104-stability-porcupine-fbad@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1810; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=HbBvwlpZNub92qq+jNFTV6MP033UqCgIXPfIntTVvEE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkyMtEk99F09SOHVHXq35SDl3f+WatS3YHDdqDb
 d8aT0oRmciJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZMjLRAAKCRD2t4JPQmmg
 c/ZHD/9HeY1exsbgVcyHbLvTxX2jagdmjPwbTflT27M72wkw7DdRGcbDI525qG2AvxqQa4dsNoZ
 z7Hb751YKxto+AwEATAGpboF50m1JYgKh2bb7b7dLuGQoq4ocNiEn9abMi0gjYnHaBOKW5m+hoU
 xWsClHUEv2TVHcpfrgSrwmpKNTO1LAHfW58hFRfpN8qUFzyiK7ZGMQeRqWjrxVT1/N4JP1zZid3
 E4WLDlIL+VbB9ue5Kc9dNMnVB8gIvAyguxsTIzAPCPMe1s8rUbCGb/XqJfqVTl43RTGw/+FwlPQ
 N2CmC1dMqK0o376PyAW6KcAM0+fhSF9X+GGlvzcdkDipRCdf6eginzSFQqKBITAfN5/WFpNJmkM
 z/09d9ISir2v3YZeLgrTszne0Z/if9HRCFsw6ABKckCGESLNrFaeP5iKmGrjSs8/uDwhgINj49C
 Xq5Hu6N4nOzCSVF1RbZlwGAKR5J4pzDEJla3D1/QPdJpQJtOgRmWvFOqLETR5mWKBdftocjswRF
 OAvrMNr9Q3OUAYWSqPs3ErEyzQgXyWxUQcdH8RpJeJLlpXmCkKTi2ZbyJpUphyvQV3Zm7wyvqXt
 W1BvMxq9H7s7qwQDQdcNDVUQwv+L2H2uBM/+H4NZPqFcKgssxlYgG3zfOU8ca7+rWWw4oM4VoL2 w8GM3PE9z8kubsQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 016e7ba47f33064fbef8c4307a2485d2669dfd03 upstream.

If 'iptables-legacy' is available, 'ip6tables-legacy' command will be
used instead of 'ip6tables'. So no need to look if 'ip6tables' is
available in this case.

Cc: stable@vger.kernel.org
Fixes: 0c4cd3f86a40 ("selftests: mptcp: join: use 'iptables-legacy' if available")
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20230725-send-net-20230725-v1-1-6f60fe7137a9@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Backport Notes:
  - It was conflicting with 87154755d90e ("selftests: mptcp: join: check
    for tools only if needed") moving the code to modify in a dedicated
    function + checking the output directly.
  - I then adapted the code where it was before, taking the same style
    as what was done in the commit mentioned just above.
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 368fae525fea..a68048f1fc5a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -179,10 +179,7 @@ if iptables-legacy -V &> /dev/null; then
 elif ! iptables -V &> /dev/null; then
 	echo "SKIP: Could not run all tests without iptables tool"
 	exit $ksft_skip
-fi
-
-ip6tables -V > /dev/null 2>&1
-if [ $? -ne 0 ];then
+elif ! ip6tables -V &> /dev/null; then
 	echo "SKIP: Could not run all tests without ip6tables tool"
 	exit $ksft_skip
 fi
-- 
2.40.1

