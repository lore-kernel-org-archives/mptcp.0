Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334A9A42
	for <mptcp@lists.linux.dev>; Wed, 30 Nov 2022 09:45:02 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id ud5so39958607ejc.4
        for <mptcp@lists.linux.dev>; Wed, 30 Nov 2022 01:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yVn9EPOoKpy1Zsd2wvxmAfejMyZqMPRfugHODjZEID4=;
        b=S4jFtuljiQTVUcc60JbXMnnXtIGyVyxZANlG2nvDgiDoD2Nar4RaQTO39TQunxKCj8
         d1rhtLUznoPNZTdckUNPc8Xol/Nsd+AFQqWCy9ZMu2xvVfPasjweatpHsw/GS0SqU6bi
         ncgC9c0r6osBQhywF5vNPaaWDkWSnGPRf93nOZgrK0roYVXFuzvJZjc7EJQBkqBmgqi4
         A47CwBmah0rVU8OuRzIbrHQp6XRoKm9X8jrA+rTWyCipxiCvleAxtjk/LbCb5SPmLNYy
         2o2NRHJIZ5eniuPuU+sUHwlI3triFcHHdREYO5SnjQGNJJ9DFtl3lKcOUupcSRTLyX4q
         2nGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yVn9EPOoKpy1Zsd2wvxmAfejMyZqMPRfugHODjZEID4=;
        b=g+udvNmiAJa8OQhDV+HP4IblKdT8OkFAqDyaQW9n7nZNAJFKS2Z1yWY/HdsFhTipxa
         W4UnK7fXcS8enVwkzWwvjaod6gZh3BS8E274RGxACSiGsVCLrvkAQtsLInhdqnpw0qqb
         R5SaA9hxp03CgyyxSERDnkanIjstRQPHR6jYqy7jDg92kcvlwjiByb7/7zuqNlRj62l8
         /K38yF2zx283cGKU69tS/tEgAtNiKF23l+IfYfGL1celzzTDG6BPFPmsxvOt6ozDCFer
         1jTE5S6myH0F1WaGtzxSG4QXO0NaPlvehT2AsH+ZYswGXJXPj+/Ve+QCQZPsXAzIkeK/
         uu0w==
X-Gm-Message-State: ANoB5pmbnGRi6QlR+mCjQwK8Z0eYuv4uhjryLlVbsLWXgH5IcLNshaBL
	PC6cEGnQJEFDGr7zbNIzijv7lvvMdvsarXMd9YU=
X-Google-Smtp-Source: AA0mqf6jFM43arpRZEGmK+I+nwH2bJyjy7l7ByCxZw6rf5c+GhZ1MiPX0csfk/TsK0hFmF0xL2fCBQ==
X-Received: by 2002:a17:906:cc0d:b0:7be:bf6c:8756 with SMTP id ml13-20020a170906cc0d00b007bebf6c8756mr14394668ejb.62.1669801500800;
        Wed, 30 Nov 2022 01:45:00 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id p26-20020a17090653da00b007417041fb2bsm440374ejo.116.2022.11.30.01.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 01:45:00 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net v2 0/3] mptcp: fix request sock for subflow in v6
Date: Wed, 30 Nov 2022 10:44:45 +0100
Message-Id: <20221130094448.4119946-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1186; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=ATNFdGyLp19sTj86tTIvIeE8NYtYTJlVbV6qz32aGiw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjhyYPNf3qQ4Xnihg6yeMpQCX/bXw2+F+zojgFkXun
 i3SVW0CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY4cmDwAKCRD2t4JPQmmgc0XzD/
 4pBsP2SJVem/Stx4vcdgXoFTAddxQdVqqPu5iWpPvqiJU4BP/UXgq4+bjTeO58aC/VwwCWmP8/jmSX
 28oZJrWe7Hg2o0JVUFJ3hsgRjW3Htnt30m7WTOR3t73SKwekWHKs1VEjGyrY+kzFXV3nYa0mo8TLm6
 b64kUg+bShbvNYSjd3Jt0lTdbZhMKU3kgjlTmKoK+VVZN80l5tOhinau6Pcvoo91Ph9nt5TKfKWxoB
 1fpzg6jusKUMXSsglC70IfQDsbZNykVVcrO2OjQaRUtD3r1ZDua4FsH3/6QZVxi3+CMXpDVKbvxETO
 s7cfvBCAdndx77qS13uwLqge9aBaRoHb30beagOUY7sPPg0s9N3vvb+z7jPJf1wG513QpZRCsq4Cnu
 /jWrrNTYhWMCSxPfU0j5paqyAKQbov60eu/xpUOFektmKZKK9NVZh6JomX1sJjRiElFMttTMyQ5gk8
 OIvkkYvu6jupY0cANTaoib/Gi5mA0t5Yh9BRWwCtg8rK6XMFt9ALwnFg5FTTvbHOOzKGrjHLFSvgYQ
 er9w75TzOHC2uCrjtzdS819B0nDvTAzvzIA8t1mOX2zBB2nYQAo0O+avKu8LQz/gu6TO+eSeTNy89v
 dBmpiPGf0M8UfQgwsoZ5ytNBWGhhg9t1IjT0+k3px4t89A4Zlucn/zT28BxA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

ChangeLog:
- v2:
  The CI reported the structure I moved from mptcp.h to subflow.c only can be
  static (from 'make C=1'). While at it, I also marked it as __ro_after_init.
  See patch 1/3 (also in 2/3 for the v6 part).

When working on validating the listener part of TCP FastOpen with Packetdrill, I
noticed the cookie in IPv6 was not the expected one.

The root cause was that req->rsk_ops->family was set to AF_INET while the
subflow was in v6. Patch 2/3 solves that.

While looking around, I noticed we were always calling the destructor from TCP
in v4 and I changed that in patch 3/3. I don't think there is a memory leaks in
usual cases.

Paolo did a pre-review (thanks again for that!) and suggested the patch 1/3.


Matthieu Baerts (3):
  mptcp: remove MPTCP 'ifdef' in TCP SYN cookies
  mptcp: dedicated request sock for subflow in v6
  mptcp: use proper req destructor for IPv6

 include/net/mptcp.h   | 12 +++++++--
 net/ipv4/syncookies.c |  7 +++--
 net/mptcp/subflow.c   | 61 ++++++++++++++++++++++++++++++++++++-------
 3 files changed, 64 insertions(+), 16 deletions(-)


base-commit: 8de87563b5eb14ed009c26cae1e6afbff35c93e0
-- 
2.37.2

