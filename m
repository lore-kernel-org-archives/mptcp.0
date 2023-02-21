Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29E179C1
	for <mptcp@lists.linux.dev>; Tue, 21 Feb 2023 17:54:57 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id t15so5481217wrz.7
        for <mptcp@lists.linux.dev>; Tue, 21 Feb 2023 09:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pfiDGjIFJSr9puXndsLPk/Tj9RVlavuvh3GNmS/1cvw=;
        b=tCMqT3V5pDYZ8KV4JYDbZVHl6u4qrmh2Gi7GQvB+46+0RTGqxe0Og9+rmkIOitx1or
         71K4JoxgtcB1VVeclyqo43XPdR9jBSo6smqQLGVH/vRDOodqcbg+SYUJoMWoSZ9zTGRi
         Nz7Ns65fJES+R/dh0cJckb00mwXext5J/yULG23TAw2jRuRTBRgbLEqYg0FNJNcDo0jK
         EVwmpPLo9o4CngMGYddJWzjSZgqyttGltZDam6HVP2/3ld92lBm4nqgWjpgZjZqEFvc/
         XbGHGCULNpC4LS1926zIknJaee+Pcc4DFr5deIaHOJKnNhs9dhqgE6hTyiIxCm6bgzY1
         SWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfiDGjIFJSr9puXndsLPk/Tj9RVlavuvh3GNmS/1cvw=;
        b=Nw0sOVibbPQT+VV5iSNuZs9sXJ+RKGS/lt7A+xiBeencAvs2OQLtnoKvi6LY56Eq7c
         K3z/yckNULaG3EyDW3Z8TFTmBH+T57wyIrwApeT321uKlCIb7HJE+66/uEi6Hs8e3Lso
         LRycZ5TeKfH+0zbcGwes9egMRYk2hFU4N/4/eFIOzQ26Z8XmJTPrsrkqqYPPYT9ks0qX
         HkDtpbODrpT24kEzR1AmiktQ3INfhidX6NUDbXz6pr1Z0yHCtMs7PQfcBD2Al6Gs31lp
         KOvTx5yI9s/BmOv5ZFUpPt7pNkkFxbc32nw/427SzL5S3w4AjqEBg9UYqvHAlaNVWPS7
         W/Sw==
X-Gm-Message-State: AO0yUKVv8Didvp55J2TvbwoPkJXrQRDtOBFYLTynbriYPM3eyu9h+PsR
	r9v0+qHfKrO6D4JSQPoxJz7vgwj881yUAzJv2GVcGA==
X-Google-Smtp-Source: AK7set/IgYM0/IQAWRJVdyfQwE2hUBdqdBUl8TX7Pbg7Fwndh+nDvCmACvBWpJLYI9tpsxzvzy/avA==
X-Received: by 2002:adf:f208:0:b0:2c5:9ab9:60f6 with SMTP id p8-20020adff208000000b002c59ab960f6mr6033599wro.62.1677002095291;
        Tue, 21 Feb 2023 09:54:55 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id t23-20020a05600c2f9700b003dc521f336esm4780228wmn.14.2023.02.21.09.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 09:54:54 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net 0/2] mptcp: avoid tcp_done() on already closed
 sockets
Date: Tue, 21 Feb 2023 18:54:38 +0100
Message-Id: <20230221-mptcp-warn-tcp-done-close-v1-0-d248242b29b6@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF4F9WMC/yWNwQrCMBBEf6Xs2cU0LSL+injYJqsN2E3YpCqU/
 ruJ3ubNMDMbZNbAGS7dBsqvkEOUCv2hAzeTPBiDrwzW2MFY2+OSikv4JhVswkdhdM+YGXkcDNn
 x5M9+hNqfqJqTkri5LZTjmnJRpqWFSfkePr/jK/w3hQvc9v0LSQn28ZMAAAA=
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1095;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=VqoFD9jdj61D+pKbP8DJthpz8i+5WCqh6SOOkBYLMIE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBj9QVueBOwjQnefmGBFpIXZ65ThnWlpkLS7yXRL
 v7fe+46k+CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY/UFbgAKCRD2t4JPQmmg
 c21SD/93n90PrQDjYPRagst1/whuFTz0z52HoIEVY4unjFZnDFj7AnwMWHAuCpP1D9euCFXWlmA
 cB0zKfOmM/bRcb5tOW2zN3oS+exliDtbpgRs6dl0jCRO3ch0aBUJVTzavFdzIA2fTveQXhRKzZy
 ZkflxTTprt8L86b0Eow7wCiTyHd9RgZTIkhkxGcIMAMZgKCggnLLCmdLVPBTomFrVcCtQe8jXxC
 bM7l7XGklUSUX/XZUwV+SM1IvgmV5LLp1sJjwsMmYwx+Hk7zl/jFW8M6XoflrReooSacpqDwhTd
 FmRvEI9PsP4vwPoUNjm+DExyafVq6EBaR4tOKaDdS9+n9GmpPQE3WMH2SnNjDbMHNIoto1f0WZM
 NfrT/66/K9h+b0lrE3HV9b67PX6OLzy9wXBd+o2QBURzcghYbyW8e9ie7KTRsR8NRrpP8E0kj2q
 9O+YWIUjbHoz9tKrflfpfWcZcEGWlOkfDtkt+QzduOvM1gek+b8lEAFE++a43y+zqijmuP6Hb22
 b5JOrd2GWxT5Sm/maY18MQgwq1v78fm6CCji6jR4EAzMpu0YB/ihAUC85jEmOLUz4u47iGdFK43
 r62ArfBLfpYaHb4nq4GzZjcwpBXVHvxLBE5O7oe1t94g3vYHSyc2em3UnSIW8jj2iQriaVxtfap
 obgOvwDqe0FqheA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, Paolo noticed[1] that tcp_done() has been closed on an already
closed socket and this was causing an issue reported by Christoph[2].

To prevent such issues, we can add a WARN in tcp_done() if the state is
already TCP_CLOSE, see patch 2/2.

But before, we need to remove code paths leading to such situations, see
patch 1/2.

[1] https://lore.kernel.org/mptcp/29f3677f2032145ac2b1c1a90ec96ef0d61e4269.1676889558.git.pabeni@redhat.com/
[2] https://github.com/multipath-tcp/mptcp_net-next/issues/357

Link-to: https://github.com/multipath-tcp/mptcp_net-next/issues/362
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Matthieu Baerts (2):
      mptcp: avoid setting TCP_CLOSE state twice
      Squash-to: DO-NOT-MERGE: mptcp: use kmalloc on kasan build

 net/ipv4/tcp.c      | 2 ++
 net/mptcp/subflow.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)
---
base-commit: dfa25741f79ebcd03e7a69646111ca18d600e562
change-id: 20230221-mptcp-warn-tcp-done-close-e430a246d8d4

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

