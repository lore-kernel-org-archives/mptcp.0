Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4CE8F51
	for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 15:43:31 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id m19so14740700edj.8
        for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 07:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WTPlnqI4X1EQdZ427Qdxpqetj4xUaQDyeIVc2yaysg4=;
        b=RhTkZA17FTqr2QzKPiZHWXGJczsNB/1GP8mICWLllgQsNhtmLwdjlrYxvYT03rqtEF
         yuWQZvdiS6kwbBW6aiVKLb9W9vABka+YXKeubtqM6W8fCMwj6D0jFeo+/9t74TBZKstw
         rZ+JRnkd4TOtF5N+kQdRikkVckYDqJerXD2duF6bA3WuQqw0mHnl1i54hm0kUYJCk2t1
         pR4LJezSZ3SiDoMH/KytmQPzTFum88wHKeYr+oFo5aodP/V8PaoSMuGl0PkZGpP8all6
         qoWjXmLoSByn/V/C2brHn7XK78debbp8MBkv7hXc3clqvQJrcujZBDNWw2k+wDa7qmEI
         1ygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTPlnqI4X1EQdZ427Qdxpqetj4xUaQDyeIVc2yaysg4=;
        b=JT1hLVcwi07dZpcuOPPWnhJonn8ZFbv1tIQ0LvQ/43+NgRr5mkHe6K6+Fvj0cIZnbG
         v3J2DUlQGlYnQWDmAlD4KMpJRwxa0tBHp6wKgQTDDixDSm+/3BqGwu3a2jUKNYtZBRvA
         pVthUqj/dCbg4ycN92p1AZF1SyOgSlMiUS3iEvEqHIpFJ3IOO5sQDSxeb+nYsD+TDQ7D
         7rwyf+XIhlD0tOszr8Qv8cQtoQV0IglsvpvxAkiyaRHYlTm0UbYGfu8+1AUmYqcKNg0P
         lToyAPm+7PyduyEskbPnYSrOWBFQuD3YNTDQcUuOfkMabehY+RYfiq3erYKe+/TmGB9A
         bnxw==
X-Gm-Message-State: ANoB5pkrgLDGH9HefJQ6TMpoCL0QR+NgLWkkX/oiWtSOgrk0k5r1i4Al
	k2JgLVcEkAbgYZ6xA2yUvcvqHw==
X-Google-Smtp-Source: AA0mqf45iY6v5EnIgMFTeG3IxSMd6Qb9QNRFIz+rygd/FfAWFDxn0Z0xnwe1ifgK7VTI/+PiJ1NLvA==
X-Received: by 2002:aa7:da4d:0:b0:46b:4156:bf29 with SMTP id w13-20020aa7da4d000000b0046b4156bf29mr3948998eds.246.1669650209963;
        Mon, 28 Nov 2022 07:43:29 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id n6-20020aa7db46000000b0046aa2a36954sm4854179edt.97.2022.11.28.07.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 07:43:29 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Davide Caratti <dcaratti@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mengen Sun <mengensun@tencent.com>,
	Menglong Dong <imagedong@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiang Biao <benbjiang@tencent.com>,
	linux-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH net 0/2] mptcp: More fixes for 6.1
Date: Mon, 28 Nov 2022 16:42:36 +0100
Message-Id: <20221128154239.1999234-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=724; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=TuOle9aMVAdwejSJaELmoVnupS13kiLmy7nhhiprnbc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjhNbo5o3pdZU+fR+Elezm+jlhfnafeu6/PtaMwcmQ
 JZyu/rSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY4TW6AAKCRD2t4JPQmmgcwrKEA
 CToHobqfqMJpJioemGJHF3KJQoJAFomQ3ObzW8b/37e6bh6sRywV/mktnVpQHxOc36B9BH7hr8NJgv
 +o3HM5J8YA1XZQPBi4t+e0AKA4D2SGc4o+CZ47Otty1PnzROsHFsNn/RewP2kn/NnzAkc3zhD6Q4Cz
 5ynOcdZjs9McQ9R88dXjXEh32RPtSBy8HB73yNeEnMsUEB/xQZvasOOla+0PbbQ605DUCu0FEsSZ6I
 taMajUT4r4YwiVWiMFV64NyRNWoD7iMOOeHux8QETAE6Z+F+nEpYYK6KPjJXkC4CytmRoz0pg7VAMM
 gUlXUdvBRnCGckT/6EANsAcKdx5Z+GNMlH3uGij3H1o6fqp0pqlfzcwFXvuPLQ5Yk2s38OE6/VKQEt
 Fd1jZBuEsTayL3Ah0K9RHtSM7G/+bKVedohjhslbAiJW8YR93ppsl7VM733pVI31eOysHuWZEhONwp
 Ub4Gff1FpSPd7Y4uhwf/xYWAllPA4Acv67ai6rHOQZvryAeJAQCyfha5XtkTx7Pj0fWZRu8Ix/nVj0
 TVhAAOVEohrcCAh0eKmy+Ei+wwHd5LctrhNbZI14QiR126O2NCDOicx34+TVVRSMPOhxcZFYPgufiU
 om9cUcxQ1qhqiC/f+iqgx6BhgKyN0wdIT7gwEZZuSKCgYMM1exSaRW9WtvUg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Patch 1 makes sure data received after a close will still be processed and acked
as exepected. This is a regression for a commit introduced in v5.11.

Patch 2 fixes a kernel deadlock found when working on validating TFO with a
listener MPTCP socket. This is not directly linked to TFO but it is easier to
reproduce the issue with it. This fixes a bug introduced by a commit from v6.0.

Menglong Dong (1):
  mptcp: don't orphan ssk in mptcp_close()

Paolo Abeni (1):
  mptcp: fix sleep in atomic at close time

 net/mptcp/protocol.c | 13 ++++++-------
 net/mptcp/subflow.c  |  6 +++---
 2 files changed, 9 insertions(+), 10 deletions(-)


base-commit: f2fc2280faabafc8df83ee007699d21f7a6301fe
-- 
2.37.2

