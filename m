Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DF8BA28
	for <mptcp@lists.linux.dev>; Tue, 29 Nov 2022 21:08:33 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id d20so10732639edn.0
        for <mptcp@lists.linux.dev>; Tue, 29 Nov 2022 13:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=89GXJKIMgi2m/CbFCE5gveAnUdurt/NONIDiWMfvTJI=;
        b=2IrB2NwRScVUc5aUNsG8AVdd/+l2F7Bx+tLhT2gkEj+/RABlbcAwgcuyTvaBC9zA70
         bhYqS636JA61CVLw3/HfJVvs6apyGkYLlQrAuuT7K79zBCiR8GizpcRYjVzEEws/LsqG
         o2nlhX5QUFDXt9WzaSd7lqiXylCWSCjKM/ngWMHZwNrthd7vliqqahkwos5eE7u0NaDY
         qVnubDxoreCwZpILGBhWFcY6S5J1A6VDQuLWWYVZgUIY1RuZ3m3Xw/DSnXR0ep4LHLIw
         RBOMv/dKyoliHb1F3x32buOE93jM3q4IUylQlDP6XPT6bPrW8e+8wdz8RJ8aCVKKcOGi
         Mi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89GXJKIMgi2m/CbFCE5gveAnUdurt/NONIDiWMfvTJI=;
        b=wiPqJXOjAwQwt+NATi7MYjID835tjlJ5XSdYe83zHZjrFuSGYoX6iro/oCoXlokh7G
         LJQ3NFroocu9HWC849EykQp2aOIfY7pc4k5dwknj3trG+c0Nu1dZFg7coGeU9+R2/EPh
         d8JZXPBYreqMjBXoPsRB5OdNPuzGWgHUhMfSL4uxrsu6CMBxzMq4y3b3L9/qJLy34beM
         Jr68+toqamDpNlA2Fa7oRl5DC/+zpCzg/95m6FP9VxRv4oY9OP11k3n+OVggzlnCR74B
         Aq6PhUspkdoTgKjxcyy/CgqRPvJpH4SP/hC12oQGyMw8IIdaTrDVLIfHtu5NM0BwHfgd
         ed9Q==
X-Gm-Message-State: ANoB5pkcggg2QFAgWY9H89cMSee3Fwwy3KwfLYZXuBAT+5CgDJzPUKa0
	Gn56P+SH2GSFUiZ1EplA5VqAn6mhFXfYfynHmpA=
X-Google-Smtp-Source: AA0mqf6FSlX1sAwdGzdsYVHMJ24g4CvakkAvUpo/P/BOowNF9cqVh/aHnzFW/OdIDiBShYsL2i58EQ==
X-Received: by 2002:a05:6402:5:b0:459:cdb:92ad with SMTP id d5-20020a056402000500b004590cdb92admr36741870edu.77.1669756111077;
        Tue, 29 Nov 2022 13:08:31 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090694ce00b007aed2057eacsm6516487ejy.221.2022.11.29.13.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 13:08:30 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net 0/3] mptcp: fix request sock for subflow in v6
Date: Tue, 29 Nov 2022 22:08:01 +0100
Message-Id: <20221129210804.3769157-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=957; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=8hVqgsPwfi8Qb0p6nTrlyrfuCYOqjc6olFThCq+MFOM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjhnSzq6fj/0GcL6dqGvVVKUBkrD5q82gyk00CunGM
 5EMjIliJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY4Z0swAKCRD2t4JPQmmgczvFEA
 DwocBnUdbNyIJCKtfTNYRTrfGqmPSSHSn7xi41IL+olEod2iS8oE2eb3lZVtP9mecKOzUNvy6OoyX3
 y+nxz3snEowxI05nHTFk8QVFFC2szhiQfC6+jz23eo1I7Xhca3Bf9rJPbH/SvHhnXoYyGD4obyQP/e
 ksme0l4SZsvHoiSJjGTFddmivGXbZrlKtDqGlHlazkXC66LQ7Seqy9vTfe0hT1X4G1QNKECLtj6GFP
 LPxZB7r5UxoDW84gG8pxVeay9BxKaNZp4VHd3RkxZQr2G2use3BmU7ZmLaTYpmiPVxwTZZVuCCCRef
 z7kFj9YyLj7z2eIuLukNwaa7ixDKXq4MTU1xHTVLiZNjPgTqY0TD4rw8C2FG5RP0wwsujxQmGE3Fez
 zPJ17+5CU3uttQ5qi0cm9jzvG/Dinm6wyrN+jMM2CY+qxPRtFFOMk7rf1t9PV0/9GbzXrnrwFmcZwh
 aItFjpp7JaBHDbwySo/S8r/PTFcPSVBcVCOBqTmMeigJByYgXxa7C7tjHzFYoTDofsDoQfsLJS/N6R
 E1rs8E3dUhCefyev0rzjeq8WZtrLV3csJqnZGCD4axhYRpavmNfnXaNDR525ozXMaPiqfWvasLQciY
 z6YJCfUCCJaQUjzMp8JEiXZCRJOEFKYFX0GHb8DuhE2kLkRtBa1Q4vmUejMw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

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


base-commit: 8b052cb09c12ccbcf7086bd7f35146941dd337a3
-- 
2.37.2

