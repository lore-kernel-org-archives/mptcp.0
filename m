Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457F786CE
	for <mptcp@lists.linux.dev>; Tue,  6 Sep 2022 18:04:44 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id u6so16140234eda.12
        for <mptcp@lists.linux.dev>; Tue, 06 Sep 2022 11:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=LVyWz9QjSr71K78QY/khwjiVlTkSeqPk1bL9XsiAab8=;
        b=Re5zgjEeBJwrtp6COp+yqdoKd0kJxgGB9EP8EM4lHbOkdRlFx+tG2KqkBItnfXBGLD
         0tJMg3b8rYTWqe5f+cbyWHxbMaF+qobw27G/noRRFH1el11lb0fzZER/R8A3G8NTFxEd
         j3LmcYlQRRgWYrLvdFaXMxGByfC3JcMtsiavJn7M389LN+Z5VjN8SjSvYZ4g4/iWxkhM
         ohI3Jf0X6QW6PyVWIKSnJQtEJOzMIPOhC1gYRpxgCXt8mtZxmxNF/UQf6iuv3w2xfsPh
         54aQrCsU7j7XYCmXDQj7hGzXURi43HqGgm7Kpr09I0t/QXcMQ4IHbYHBgfZFp8LDLCkx
         AQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LVyWz9QjSr71K78QY/khwjiVlTkSeqPk1bL9XsiAab8=;
        b=6tQLuFgrqhqwg7tJv+P+ZH4JQoPaeFrAyFpvAl8p97zVOyCblq9+Etd0Ot7sWi/+XN
         JR1jzHur7KxTozdYRzMB3JzXD4SwCjdHEc34JMMeKbwNFeD0DKxGRn3FW+VP1tW094LL
         kCar2tSB77sL5hUodCmEBQKts/xqrunIvoLwMcZZfktz770UMx1z34Fzfq2m6n0nJ5D9
         r2MoNfsUZ/hISnnWwSOmIbTjapJckgzqpt1wncCXhnn8oKALQ09cI91bF/tc8PmILMIW
         pHm5gmRiaLY7ZvJs5HMDJEz22BDyPLZ9sd7Mq5vHQlsQ5Yau2xqJ3Qn0kSaM4heOTT5q
         RM9w==
X-Gm-Message-State: ACgBeo0V9xPrDZXzZ3hLJREXzYMyKmPmqIgsSeNYPYI7HlxS/bh3Vrk/
	/r3EQFp4sBbFSVh0cCYule4o+g==
X-Google-Smtp-Source: AA6agR74kDMSCpJxhGlyOhnVWcbezEO1RBH7czD3h8FziyPXSo5pBqCBmmaucK+Bmgt7//B4Wn9b4Q==
X-Received: by 2002:a05:6402:415:b0:446:230d:2b82 with SMTP id q21-20020a056402041500b00446230d2b82mr48496731edv.200.1662487482513;
        Tue, 06 Sep 2022 11:04:42 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id t6-20020a170906948600b00731745a7e62sm7007845ejx.28.2022.09.06.11.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 11:04:41 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH net 0/2] mptcp: fix fwd memory accounting and doc format
Date: Tue,  6 Sep 2022 20:04:03 +0200
Message-Id: <20220906180404.1255873-3-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220906180404.1255873-1-matthieu.baerts@tessares.net>
References: <20220906180404.1255873-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=628; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=cJSBkCmTFkNb+vTncfw1kpPps+aLxPT32YDqXYY6lw4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjF4uE2d4DWi8yvA2+8upFVesEuDDIHcfCBUtQV2ge
 XrB2+pqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCYxeLhAAKCRD2t4JPQmmgczOeD/
 wIMnPNtrhZbg4tgRD18zm7fDyFZYITI3h1PCNF+6KwWJ6lmiQYWV0XKSMIk2NAmK44K66TL9XtcY81
 1QEtaKMawaIhqrhIFpAwqrcYye8HigHyMswwTtBX/u7LONhb4ZFvC0Fe7gKLhDHMcPeCF5H/DZMcld
 wS1Kqk6zYx/6JHLJDFp9TFdeABiOkR0fKXbuZr41hNmC+qPOKeBy5o0/SL2B0BrQwmE4vqGhD79V3L
 6dPXK/qsjfgD80EYOkg1kHvehBoAk2rJuHlDuOlTfABRNwB4rC4CiPo8N6w2o877M5Yzv5jD5Nv5wQ
 k/rCi3FDp9A9w6p2tbYL1168/DxoczkmDHOyuO6tohuzwn+ddCFBhJ3VeQqIsPgBSLYz0gBzB1v19V
 iBE5pq2cf1oQ+2hYK55m19T12y0ULKZwZfGd6+xgx5Kb++qYF7NTpSeqZo0X99hctnldRK8U8ARQTJ
 RNWaQhzPz3TvpOWjFtdMryRHm/LKSrB5uaDmHR9WlVfsXCUioQd5+FktBHaaZIDjnnNMH/ALEX6ECX
 QVVthel6qGBySl+oifBPvxxvwEW8l0OGNzj+ZMSyPUtyOxW4On0vXJqX26iNuG4+/v8Sxv2ZBEP7M6
 4gFyBE7YGdiQFZRsRMHFLGKfw4vKz6duQsDdeZ4vu3Wi8Y6J5L6GVYDKHbjw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Patch 1 fixes a memory accounting related splat reported by Intel's bot. It
fixes a regression introduced in this cycle (v6.0-rc1).

Patch 2 fixes a formatting issue in the documentation. The issue had been
introduced in the previous version (v5.19).

Matthieu Baerts (1):
  Documentation: mptcp: fix pm_type formatting

Paolo Abeni (1):
  mptcp: fix fwd memory accounting on coalesce

 Documentation/networking/mptcp-sysctl.rst | 1 -
 net/mptcp/protocol.c                      | 8 +++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)


base-commit: e1091e226a2bab4ded1fe26efba2aee1aab06450
-- 
2.37.2

