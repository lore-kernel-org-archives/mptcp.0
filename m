Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A823C07
	for <mptcp@lists.linux.dev>; Tue,  4 Apr 2023 16:21:46 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id l37so19373959wms.2
        for <mptcp@lists.linux.dev>; Tue, 04 Apr 2023 09:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680625304;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KnTnFgm1PnlGFc9eoqC92Qc9rt1oMZcnKjAI1iU5+Z0=;
        b=p1pJODYQKBd+QPJJzw4rjWd4QtAgmzJdMcEOnxAkEdiiwIVTzs12FO4rJyr98q/xkp
         rXyu/uz6VawevP2gvSPQf6p8ETOJ2JyZ8JcaAC6LwUNx4SDlKf4lpu+3c2y2BtD0q+PE
         dfkVxBYU0AflMzZRjTcndS/etT9UMKtBS/MuseKBhhuXaURVAhuZjpZtM2MDGRcFFSwP
         h/AD2Y1x0HttPEiuTEAa1/tHYgW8WhfnCPKQvaNoirHQRILKpflQ61UYSOk1VJtY3L5g
         NRpIJdZQg5s10PRYN8W9gm+zbxxqEVfEM5qAhgLjyL8CQ+wgU2f8CriqufGLWp3AFLn3
         QPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680625304;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KnTnFgm1PnlGFc9eoqC92Qc9rt1oMZcnKjAI1iU5+Z0=;
        b=eoGUfu3tbzJo06c9Id/kcIKw1g/0tF+Qa9nfHW9p5/N0aJ5XutSPkNJgU/1sDSpUrk
         GwnOz7RTIUlEPoKWBKiIWrGJ4UA/3izs2mYscAjWlddRBpHvt+4hhUBOXOi9B6oAVaOd
         HUMbqmosEpWIffeCcQpH0QGyJo++cPiKRGWilheMqs36ISHvmrUmClnqRrtjcMiV3U1e
         o18fd64rQBrZevylLuef8oMozdllC+LkOEKrBvqZAYgzClnOgC0vuTnLGffIfIvg6176
         SBJhUvsR9UzM7T5CI7uOwIS4RgPj4GcTpdfWRca371yJIxtIycng3H0I7nusX5YPSR53
         vn7A==
X-Gm-Message-State: AAQBX9dq+L6DoYvI80hsy8RUjUzVxeUkcJlu+b6jcwtyrvbFr+pqY2A+
	s6+MV8TJlTfZ+GVWI7P9TbCPePgi/tSJkLGQVBXk4PmK
X-Google-Smtp-Source: AKy350Zdy4mwUTj+8qzupvtqv86Pwp/cuUMj1IjSZvoVdKkxW1CPe4GQI707ECgax6uGOQwqg0+/tA==
X-Received: by 2002:a05:600c:2312:b0:3ef:6396:d9c8 with SMTP id 18-20020a05600c231200b003ef6396d9c8mr2435840wmo.5.1680625304489;
        Tue, 04 Apr 2023 09:21:44 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id u14-20020a05600c210e00b003f04785699asm12379689wml.43.2023.04.04.09.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 09:21:44 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2 0/2] mptcp: selftests: join: support BusyBox
 and ShellCheck
Date: Tue, 04 Apr 2023 18:21:27 +0200
Message-Id: <20230404-mptcp-selftests-join-busybox-shellcheck-v2-0-9113fa4d2ce2@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIdOLGQC/5WOQQ6CMBREr0K69isUMMWV9zAuSvm1VSikvxAI4
 e4WPIHLyUzevJUReovEbsnKPE6WbO9i4KeEKSPdC8E2MTOe8jwt0gK6IagBCFsdkALBu7cO6pG
 Wup+BDLatMqg+gIrnlRZNgUKzSKslIdReOmV2XriMAwWPstvLwaO286HxYL8Hh3Ngz9gZS6H3y
 2E4Zcfib5kpgxSupah4wYWsyuwe9yQ90tlhvNm27QsgbiW7CgEAAA==
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1397;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=nEJD5TtSJDe7A9s9B9/vEAHaJlHun8zhNFg3hksKs9A=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkLE6X7afz5Vy9WT23+e7cF9iWAJdjvQhIxmUGz
 aCJ+/2TokWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZCxOlwAKCRD2t4JPQmmg
 czxrEADK+mgA8EjdDt1E+WG6WXhLUJ3dC2MlDmtd9XhANNGUjNEv+khuYfLqN45SNxU6S7Ym1OC
 UaDfPrAn79kkX7KNN0CjOPXOUiXgC6hVkiMHuc+h5oQ7n3cUj/4SoOflUqxacWFy6FQU7i3GstU
 3IY2sXKlnuANxjlKuqeXY25LQDVzI5mbKXZLXpi4zGNfZZceW659CuZ0R2y3kXoYUXamYGZocWU
 P46Jny2CL1rUgNWLWGglkQKLPdcINJFxmAXpV8QTtLD1Xlyg07OKrqlNdJkIQsEziSIEeWtZOIX
 N5W9ix28wMzyrUhHieiVz8oKlNZi+Pw/MP1Jq7EzdFwwiZ6FsKjL7gRss3Cr+CrmYwtWl8k4iiu
 G5IRYUsusyzMO412MCKFEQ3jq2tVw7SOmPXX3v88V+WWlXf/Zft+FJgJ1iAvUv1GkLmHpQ2JCCI
 ME0ANwdGH2tXpJovZUpXIQch47b0ppWkQTd70326SUjZ+xi6A4ZAtSO0kQIlzaEDxG8wVHGeAEM
 wzoRGBH/eiVinlNk6zBR1tQ9T9pAL0AoKj0+5MXvf8P2d/OF2AqQ2IGHDNKff1QGgxBtaR/vcWd
 JIRRO8OjrMiiFxer+4rM06EsMgNg7RcEETqXWaxdyRUi1kpb/PUXydfjBBACSQgTic0Xh+gRBMH
 9PjmV5BQQjNJ/Lw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are two simple modifications, not really fixing anything for us but
fixing issues for those using BusyBox like LKFT.

At least the first patch fixes a bug they have. They might switch to a
different version of cmp at some points but it doesn't seem easy. So
probably best to have this patch flagged as a fix to have it backported
in order to detect when other mptcp_join.sh subtests are failing.

The second patch fixes ShellCheck warnings: it was reporting issues for
most lines of the script. Best to fix these warnings to easily spot new
warnings that could be linked to real issues. But no need to backport
this one I suppose.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Changes in v2:
- Patch 1/2 now shrink files instead of doing something useless
- Link to v1: https://lore.kernel.org/r/20230404-mptcp-selftests-join-busybox-shellcheck-v1-0-65892428a951@tessares.net

---
Matthieu Baerts (2):
      selftests: mptcp: join: avoid using 'cmp --bytes'
      selftests: mptcp: join: fix ShellCheck warnings

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)
---
base-commit: 73fd52db48d9eff550fef735066f742acc2bf0e6
change-id: 20230404-mptcp-selftests-join-busybox-shellcheck-ec239f8d4e8f

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

