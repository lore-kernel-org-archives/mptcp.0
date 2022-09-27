Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B6E2596
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 15:06:06 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id m4so1137393wrr.5
        for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 08:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=imoJ4JIQ9lGXdVJevFDQTKnqkGWYyTt9e70tLlpe5CA=;
        b=v4AM2KOy2yuSVgOxB5VRmV2UfZ6kPkr67C+r7F4O/xn604GJKNvKWa5t7+4i49OJO2
         +16OACoLypdivGx3b2NgwvD/h0YCV6RY330ghLl0vUD64CqyLr91M6RSab7yOvrA2dlZ
         Ms1bc7QEUm5glXC7gYNLC7m4z0/WO05YdW4a+Kb9odYGFqMa6ZdhoINnqqRcglHjdB12
         uQnH09SvAtDy6ZvRgI8uGd2Z0nZMNMTlqhfWecFG3FbzGPwG56edoQCIAcN3v4ojXvbm
         YnDJ5XBenNhf0t6jFHxyse5L5lr9kKWM5DG/7Bvq8aiOHPdq1uvdmGisE+hWgcfzzXqi
         i+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=imoJ4JIQ9lGXdVJevFDQTKnqkGWYyTt9e70tLlpe5CA=;
        b=LVMSFBf+lb1vhYoYLSEXIgQpcunWAZR/olO7fcYNOqQdNCzV9M/PTKB6y7PDYKvCnO
         meXGdpj21Y6bfNZMQbiYhaxY4f9+w50/XGJFa2MxGtWqlu6PRiD5b7fmUGaZzPEZA5Fs
         GNUd9sJVOI+vQTz54K6O344nh5jh97pC1YOjT/XlLy+QiODC/NyBP14P5qHQp1OSUGWo
         ditTfrSAu9c9IgJk9WOC2izJOI/Hb5R6t51OBdz1JgVZPS9aQ/QjmuKSQ16aIsNZWbv2
         yG5aRtYLjoDNk7D7GyDzl60dQ4vD1bMKv3rNKZeXKjC38exp9NPelA56vaJ79Q9kQYl/
         19Rg==
X-Gm-Message-State: ACrzQf1x39lpdolo/lm9amDmJxwfY7l819UjglUGJWFkoy779wVBLnFX
	Vw8t6NSRCLdIMXUpPqMv1ZsO0RC/XKgfyG/quBk=
X-Google-Smtp-Source: AMsMyM7qkW1qjXsgI68zqXTkuMH4swisvGjiLsC5hwgb8Xrb9d1L2oA0UnuJCVFFKTr6iMmhYpGIoQ==
X-Received: by 2002:a5d:6c6b:0:b0:225:dde:ab40 with SMTP id r11-20020a5d6c6b000000b002250ddeab40mr17383863wrz.690.1664291164777;
        Tue, 27 Sep 2022 08:06:04 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bx31-20020a5d5b1f000000b0022a2bacabbasm2101430wrb.31.2022.09.27.08.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:06:04 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 0/2] mptcp: add TCP_FASTOPEN_NO_COOKIE support
Date: Tue, 27 Sep 2022 17:03:04 +0200
Message-Id: <20220927150306.1552795-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=315; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=rzqgm1upIPn/Gzf165EN+Y/kiIoh8ztbaGJVMJKsEj8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjMw+1AnrV7GaXWhm0EXbqVgwPJV35OTrE2Y/bDL0x
 wFfm13qJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCYzMPtQAKCRD2t4JPQmmgc823D/
 9mlaPeceETkUEGRmf8i4tCC4ENIWcVqiy6hcJEnE9h2fqSLuaLnv98Tkl1wdFiY/1AEt6pq7QHn0Xv
 gYEJNWu89zm+vnAou9qzTusj6b+6LUozEoyNQUxSAenM4w1hpb+0pZBFl7Ax+JEjMXssUf5PyNpgcq
 R4nkRk+xmK+p8o3UBrM1PH3RupTe2TcUOG42z3fSbIf0x7kQjsiFoQZbGajjAbtaOB2o+I5YKNmiB8
 73ubX2vWnBTspjx7qWUhZ6FngNsJ2XNERCF9O0uhxqOuQPm6NASYrPRZcLAO5/fKYVEAyGRwhoTo2N
 D1PIUrinpUnNrnMpSa9KKJ8xanUQQaqLNJ3QanzRAcoz73LSIxQIFBCmO/1V1d2+EhY8fTIC0txPPS
 5k/KTSpnP04dGUq4cdGQscOTFT0bBNA4TQq1W9yy+ZAL35ay2NVHzAdgn6R/nSn5Refy1c4//8drCo
 5z1dDLQS9QIdYbzRfkZy+szLxvCieFV9tahykKTjaPCto6q4P2BvP0TfUy76+smzePRa9hZu8o8hwv
 TVLURgmHImruL99AktzEqFhSy9jti+3xgV4QAoRNKk5yQ2LKuNfLmfkMGgZIY3BLTIyU4Mn4HpiLo+
 5Cgd6KyXkYqE+4UWwxD8K17GxGgCvgo8hubiQAq4xIXehQ/yeqnHfeATn3hw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

This series adds TCP_FASTOPEN_NO_COOKIE socket option support.

The first patch refactors a bit a function introduced by Benjamin to support
TCP_FASTOPEN_CONNECT: the function is now generic.

Adding the support of the new socket option is easy after because the only
action needed is to forward the request to the first subflow.

This has been validated using Packetdrill:

  https://github.com/multipath-tcp/packetdrill/pull/91

Matthieu Baerts (2):
  mptcp: sockopt: make 'tcp_fastopen_connect' generic
  mptcp: add TCP_FASTOPEN_NO_COOKIE support

 net/mptcp/sockopt.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)


base-commit: 095ffd740bdb5564bfe678e5cddf5d1d7c6b7462
-- 
2.37.2

