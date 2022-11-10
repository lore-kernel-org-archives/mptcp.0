Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C731CA490
	for <mptcp@lists.linux.dev>; Thu, 10 Nov 2022 16:00:39 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id m22so6053710eji.10
        for <mptcp@lists.linux.dev>; Thu, 10 Nov 2022 08:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hriuBsJq6Dv11gWCf+XU+En904IFvPCdild11UGSTb0=;
        b=7xQgzPNHefdjt3PmuLgFKA8MK1SN3adHd1MM8c2u803Zd/UXvF1ZZPgdOpUhw5qVKX
         N/3PVUwvGDAweMJ7TBvijo5o4uQVhXjgsyAbR3KIP9uJGlg2q9YZJua5dcFDXJhCxuCL
         iSsl4vuYra56FP08eQDC+itEl2T58w+yAnr/cccYfoX6AgajWNduB/NwxYf1Yh1qT37M
         bX2wHSVy2p7DjYhFBCs8/B5/6mB4GVneUgHVRh+PRu334PnhiafuFmvmlfqB+1SC5T5j
         /kTUsKplhoFbTc8ylxdn7rqlhe2DgE+5Ai8EBp5W9cM9lnfJ2Um4ST2onn40rVxsMbBt
         Ra1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hriuBsJq6Dv11gWCf+XU+En904IFvPCdild11UGSTb0=;
        b=HOTSrrOwbkl1E0EwNdlI2AOooYbICIrHTIjz6iuSWelDEHslWfptGbpRtFVe5jc5Oz
         PMYnzUIfTgdcU7QtvZFiVvGT5e3gQ3m9xJYehD0TkWtNIVzrUdvxJTnFP4t9hKKRzNu/
         w7iaX6THL2m5mAJkBGK6uWaBD+DuCqpwk68e19venfXWJXRqZrjNvQcTEzizHuY3AoCc
         aj29O/mH83HBN2rLCRyPFXoxeZh5+dU+7zmuqTjFCeQfJZxnY5MMRCSv4qhYVlXEqPAK
         ULm6c+jRvGggf2mMI9Zp08m0VrFDPUmu+3lASS1MbS1f4GJBs9Al9iUW9Nl15+nTiqxw
         vcUQ==
X-Gm-Message-State: ACrzQf0/RU5pyWnsfm4505IJVIeyleaWbnAEWFXRbaDY+QCWx5Fodn6b
	udFvIDczraS+2GUnKxRtTZVYzDfcvQlHaUcLcqE=
X-Google-Smtp-Source: AMsMyM5VMtRnZc8rYWxiptePBtp/EMNjy72ZTBqmJr9tY0bSrJCLoPge0r5JJYORMWqbRpfmYZdunQ==
X-Received: by 2002:a17:906:8470:b0:7ad:aeda:f47d with SMTP id hx16-20020a170906847000b007adaedaf47dmr57207387ejc.139.1668096037017;
        Thu, 10 Nov 2022 08:00:37 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id v24-20020aa7d9d8000000b0045c3f6ad4c7sm8639503eds.62.2022.11.10.08.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:00:35 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-net] selftests: mptcp: fix mibit vs mbit mix up
Date: Thu, 10 Nov 2022 17:00:17 +0100
Message-Id: <20221110160017.3641527-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1544; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=5mMBbs8dJeaihckVLwjgcKY7c3vEPzrGXbHKF1dGLHw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjbSAHaMAZJRbacwN1t5tbaKPegMOBU+LH90mgSipK
 Nb9v2V+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY20gBwAKCRD2t4JPQmmgc5qTD/
 4u2nuerXZsRumIMR67q9klJCXtQlwJRKpqhrFb/mNyufQfXz3pg0aCRdKoWz9YqdVyfnQCWX+/Q7re
 XoXBR/PaiU8HT87yve+3UEGTi9PclmdHKzTaxj+9md80KQftWeuYD5gXD5l3Q7Y1wxLz8D5szULK8G
 x8jKUOXXq5N40UOeiPt1s6AY0ckdKOz8lKXO5OC21Mz69XKrXsnZlSc4y4ZRu13an8nGzj9WJaFCyp
 HSyD/R7tA8lOA+kj6IBiIUsb/YZcDv+a1aLSJhDnT5P++QkXnd1OFIt6SKBibqw35mlAzbdUbmxy76
 LhscfBS7msK/0r5ivwjawxpSKe0RstakLSm7viRDX5daljI+hRC60Tt/gfM+DNgCnTpDL9d0lR2nMJ
 gwBKIsikEZa3LfCuUIkkF5NvwYf3VsKuyoMFuk0VGWw3cfWVKO03eknLCrDUqheNjK+pPcVuHi33q1
 cK04HimsHrIx+3Jovl77FzQlkgIVu7D68Huzl4XicMiu45LCNBxO4DInhc0NNH/BC+9CUrKUHF68T4
 xRCaVaIFVLLmHDs6lfsG5DY/dpgjOcjbwxMJ2bOCaFdcXXvQVAjTZrbvJ/fYVkYkZXDfX/NAI2IIBi
 67m3k2GKDo9vnXgLFJv8KFd+zpy+D4sC3tJjfKbF6Zoh455gSi0IJfKGA1wg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

The estimated time was supposing the rate was expressed in mibit
(bit * 1024^2) but it is in mbit (bit * 1000^2).

This makes the threshold higher but in a more realistic way to avoid
false positives reported by CI instances.

Before this patch, the thresholds were at 7561/4005ms and now they are
at 7906/4178ms.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/310
Fixes: 1a418cb8e888 ("mptcp: simult flow self-tests")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index af70c14e0bf9..34362c4644ff 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -249,7 +249,8 @@ run_test()
 
 	# time is measured in ms, account for transfer size, affegated link speed
 	# and header overhead (10%)
-	local time=$((size * 8 * 1000 * 10 / (( $rate1 + $rate2) * 1024 *1024 * 9) ))
+	#              ms    byte -> bit   10%        mbit      -> kbit -> bit  10%
+	local time=$((1000 * size  *  8  * 10 / ((rate1 + rate2) * 1000 * 1000 * 9) ))
 
 	# mptcp_connect will do some sleeps to allow the mp_join handshake
 	# completion (see mptcp_connect): 200ms on each side, add some slack

base-commit: 9c6870ffc2198874360447d04eb79c5f578b0f26
-- 
2.37.2

