Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8586BBA38
	for <mptcp@lists.linux.dev>; Tue, 20 Jun 2023 11:32:51 +0000 (UTC)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2b479d53d48so29234301fa.1
        for <mptcp@lists.linux.dev>; Tue, 20 Jun 2023 04:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687260769; x=1689852769;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BGdJVpxkR/FbNs+2giqmc5RmHUlxj0hoRAcWJ+N7YYE=;
        b=T4c7qpQdHzwpNuM6yjwXgIg7rQu/gJsskiGT/mdCKZBJdcaeSUW7T6Ita6SOuN9SPW
         NQQd4VMzFefRZG8HC72iMquYO71d//W4o11eSW+Vzecr1LWVDy6lMEGv7TUaoPGzLh+5
         2NkGBd5e6iGYUMrj3ssUmx4YqP9ZGCghiuNhUBN0cfVuopE/YjQAEgEVAwkfXOrmRE7G
         bbaUPGNi0GlCJj0gwv2xxTMI2okJKHcN0v3op162qlNy4iARfeN6H+1VAEkSv41Xkgs9
         MzHLfbevlOmjV7vvvRz1y9xJhsgCSh7bkk+C3TZ7Pt+zG3mOFs6Nd1TW9asPbGShedTM
         tvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687260769; x=1689852769;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BGdJVpxkR/FbNs+2giqmc5RmHUlxj0hoRAcWJ+N7YYE=;
        b=ACwuqpbbu7hUFmKfdR0FpKCZDjonobdw9Es8RVRy184rl45Naj0wz9HVraWlEngAqA
         szGZSqMzPNwNiEdkEiUj+3zhqpj5BjcuzpxJChVE2arVn7RyA01Xt0bu9vrMRJSPOLNr
         /6aoa1KLh1/auIWn4jA3zCbBkqgEZ5ZaIe/XjguOfK+aoLQr+w4fRR8BG/JF1PDZbsxo
         Kp/3yUE8DF+jX6Hpjnl4MTwVBE5CImO55pctD97kYgWKGeTwgKhmcNqA2GvW2Cp+FR+K
         ihLR18wq4fZaxm9n3svfrrCS5wLiR1uBrzzE8hQBP6Sr7lg1lACrmCE07d1PfPusAG+K
         2oBg==
X-Gm-Message-State: AC+VfDxnTtRi1rgnfC3pzK1XnSN3EhXSazDW+8ru8XGm4slaiUAoZLAB
	+IY7ZitmB0fFs5a9Xd1IkFxy/v4joMJOsEY0NJlmglSqDmXq9A==
X-Google-Smtp-Source: ACHHUZ65Y4W6XOnLngSMPut9u+8kyZrsxbdahEXq28ETww35uKCKqAWHbOTrI+iA8mgtav5uQGMje7aRoWCnMrkVoVA=
X-Received: by 2002:a2e:3513:0:b0:2b4:83c3:d285 with SMTP id
 z19-20020a2e3513000000b002b483c3d285mr2233555ljz.38.1687260768882; Tue, 20
 Jun 2023 04:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: parthaz lokesh <parthazlokesh@gmail.com>
Date: Tue, 20 Jun 2023 17:02:37 +0530
Message-ID: <CAJck1w2+nhbiEsa8+oYvbicruru2nsVbHNMWut1HqGrhZ5nhtw@mail.gmail.com>
Subject: mptcpize with shadow socks in android
To: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

I set up a server for MPTCPV1 using (
https://www.tessares.net/mptcp-proxy-setup-at-home-easier-now/ ).
However, for clients I'm trying to use an android smartphone with
kernel 5.15v.
Is there a way I can force tcp sockets to use mptcp sockets in android
smartphones?

I compiled shadowsocks for android, but is there a similar mptcpize
command as below that i can execute in android version?

sudo mptcpize enable shadowsocks-libev.service

Any other alternative would also be fine. Can mptcpd daemon make work
for android also?



Thanks,
Parthaz.
