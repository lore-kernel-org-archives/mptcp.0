Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C41C1A612
	for <mptcp@lists.linux.dev>; Thu, 10 Nov 2022 17:59:30 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id a67so4221008edf.12
        for <mptcp@lists.linux.dev>; Thu, 10 Nov 2022 09:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hj1gbAITBgxlVWJnhsnXNkGPe25BlguF8co2LICqpb8=;
        b=ut0aeu2vH61NQngqYtR+WuGAs9mrK0dE2DFx5O1M/zhxsOvDjyCS/H+N3VTgVDh9jI
         d3n/+rW+PYtn6kvWDkcLkmUYOeObwAfp8vNut5DS7LIblvRPOjU4qYCZaT8+56o50DaR
         o5LWBuJjn3vkAL2cpH6bHoIIc8m3Q0EiPa7ZD3aTExYsLHTaJSVWxtGLTHW8yqQxzd2n
         tYWcg4Z28Ugsxl0HI/ieaJQ+XjMk0Ym4ofH6Rt/RTIWne0X1Ghn0mMIdI1RZaA803NhH
         9dKrulIB6jlopqlB+DyUvEBLaPXNJPeASn/27an/kWM+vDV96FvWL6YRA4kmB4sqzqp9
         Pa1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hj1gbAITBgxlVWJnhsnXNkGPe25BlguF8co2LICqpb8=;
        b=QiuOKTlO+XnSm3z5msmD4EwJyeUEAHykRl5lBCAZIzn1EzWYXQE41HF2tsr5+Rmd8m
         WYiz6DKtYv4pmiAcCNtdIdq+vnDC2JGhI/hTgHRgoqfRv23g6KrrAf8mHTlP7/bFqExz
         86ej8VlGiIdjmFL3msDJjL+VGmzxX1hnM7KwIXEFoVnNAgXKlYkPc9x002f1Vn8d51Ua
         XSNDHLtZxETiQmPs9JXrnJQVwQa+qM+ImJCd68KkPs1iFhyP461zOgmY7T8it4r3tPo4
         DV5g85EcSCSI7p852Mpi2kLhnHMIhtFek7UbM1fftm/+RH1j3PKJAAClMsY2Pe8bhscS
         jZuw==
X-Gm-Message-State: ACrzQf2g1IGFiF+IAdIcsz8B6eAh+HVkI1LeJmadmHyCqh3YCEdfWEYF
	xbnWj1zZU5OvOxIqKJ43vZY0mZzfCb8LUmc45pc=
X-Google-Smtp-Source: AMsMyM54l1LIBTW+ElDZKODh14jnFFxLDfWp6n7JYZAJAMwyfEW4TAFwqch2cGVqnN9j4MSdXfbjRw==
X-Received: by 2002:a05:6402:4020:b0:44e:baab:54e7 with SMTP id d32-20020a056402402000b0044ebaab54e7mr2938742eda.265.1668103168099;
        Thu, 10 Nov 2022 09:59:28 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id c8-20020a056402120800b0045726e8a22bsm100765edw.46.2022.11.10.09.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:59:27 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 0/2] mptcp: more cleanup in mptcp_sockopt.sh
Date: Thu, 10 Nov 2022 18:58:55 +0100
Message-Id: <20221110175857.3953994-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=580; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=jK81eJaRqG23+JC1Ey+RTOrlGC/j/2X15fQG+tRcxEQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjbTut6jKAhAKQZuL1CkMmof4LoIk6fk3+LZSy9Zqf
 jwMD4TOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY207rQAKCRD2t4JPQmmgc3bsD/
 9/TjGiKHQbyDI3CdgeQk3NgOEIvm0ea81SsPFuRjpUBpOiDd0VDj+acqIhXDYjd7pwfF48jt81Igup
 IR1/4hgaCfoBJCnt2NY34iK1QVURdrsbr4trOIPAQc6A3JLrPZM6c4q1jQDmoTmPW6uq0zEeUe2smD
 Teqpw00oWRgjZiJAC9lcs6xMg18H7Y+Q+EYe1KWP2Hn0r1fTv1+j0hJtZ4iDDy08O+0mzsVkD/E2NJ
 oeomYhc5j+wwfP2g9nvnnIX/c3daski/nNW/GUUUBdgwCfpHB80utHA4c68iqevOt+dNnl5tSEdI4n
 kldBkdBdk3ccfzMtP3AL14s4TYHutIDGmUa/o5zTm3+LrxmQHnTQjJw+AyJuQzBAEijt/+UydwscUE
 skDA8Cz1frW4HPsR9Fwse3W0GrBXD/GRZ3+vivkzt2dcXFZCkeNWXUpswNFCepNZCYp+fjAZIr4GPy
 43NXJSbQdDkY/gQ0CbkQgAcPr9AGDTlil9hCJn9ITUAMLzwMvg8lcN4Vrr36XEb435F6t2/+LH74yS
 DYp9UVST+LLh5wUbJ9oBDPrXKtYFcIgm8w9KykR9kby4iQ0iC116eL60A69GS+3a3dh/vP7Z7w4oWv
 gFE+HR9+Zyi35MntWYg5kIJf8Aq+/Igz9HargYwzJL6/mp0a/cqpLr/EQo6w==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

The first patch was suggested by Geliang in [1].

While at it, I also added more 'local' keywords as we do in other selftests.
Nothing complex or fancy ;-)

[1] https://lore.kernel.org/all/CA+WQbwuyOdNfg-g=QC-KF9dMyxdXp1vaEPoWn2LzpE+kM_w1yw@mail.gmail.com/

Matthieu Baerts (2):
  selftests: mptcp: clearly declare global ns vars
  selftests: mptcp: declare var as local

 .../selftests/net/mptcp/mptcp_sockopt.sh      | 65 ++++++++++---------
 1 file changed, 35 insertions(+), 30 deletions(-)


base-commit: 5f9e0bf4aacf217cf06e89defe06867e2b4c6e7d
-- 
2.37.2

