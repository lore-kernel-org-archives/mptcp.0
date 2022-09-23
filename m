Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626DA3C05
	for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 12:19:39 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id y5so20226510wrh.3
        for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 05:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=4U+3VrSx+47aPNQGNNKFzqYwtR747hfG7jscGlBgVgM=;
        b=LqDOH6l2216dvTjKrwCpzIeHR8iZMGvCq9YUwORV7wN2KIN6z13Bk3Rmlh3Hy8caUs
         1CW1pfh0LPAR1bxDjaTmvp8iMAulD01CaYsYEZY4S9sJ3XOkbD3p7yl+gLDGW6NfXsfq
         PfMpB++XgqaUFW0XZHztaSeVv2PHtvBGWrGb4CEQ8O1Nwx1Yg0+7ERLobzgLi4tmOpm2
         QfQpMUOfXcwcS3GCPtFGjizu9oKbTU/Z1lFbGle0FRbuTmQzfpPUDdtGGTbuxuRdicKs
         4c5YrFrSN59TywmYQXg8qFPYcVOsxM3JLpNVee04mNqpdUuRrWOxgtMGzy3PREzFomTj
         xzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=4U+3VrSx+47aPNQGNNKFzqYwtR747hfG7jscGlBgVgM=;
        b=MCVSx3LmyIehMsr0Xvl0nLzn1O5J3hjx5lNCAiE3aEDILnB8HZaWlOw5RKzu6e9P0N
         zfEF2cdyRsoabf526NVW18e3+RzXD5lyxz6bfhaY+aM0vjSkJ31fAcKEXG+kS5Hw52Iy
         5A28IoellH2uCp0cYV2r04LFCHM7CdIx6cSV8IgGWnEO5MPofR6wg+h/gnIw+OeVDuLh
         xh6NIjh+cyTb/GR/yG0BSSufnl+s16f0x4hwbrF4ZcTYw/4ylft1YsfR8Kq13iT7uwjV
         +XrPSlkTDwuvIigvu+WQt5InXn+VsuVdmMzWm89DVslCgcVYiGkRI8DJUGbbIIcO5fei
         MUJA==
X-Gm-Message-State: ACrzQf1vpfeQxo0wvHB21wArcM2NHVXrl/gmJKw9HYoRNUFZtRdY9hzO
	B+hlP/Jl3aFPFH8X9xmYSNgQC3OklNHORGPe7IweIVjbQFMZwqAgk3WRH6KP+pEtWaflE/hvUuY
	VvlCyHmXLpL1rC6XVNVg=
X-Google-Smtp-Source: AMsMyM7CQZ6O6GE2k29OC5VDRZIVqmgyykBubNbDePxQgJFMApUzuFmyndF0NJiYRcTRzwDE2O3nJA==
X-Received: by 2002:adf:dfcd:0:b0:228:d923:873a with SMTP id q13-20020adfdfcd000000b00228d923873amr5206633wrn.256.1663935578107;
        Fri, 23 Sep 2022 05:19:38 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bj1-20020a0560001e0100b0022b0214cfa6sm8939309wrb.45.2022.09.23.05.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 05:19:37 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Subject: [PATCH mptcp-next v3 0/4] mptcp: add support for TCP_FASTOPEN_CONNECT, sender side only
Date: Fri, 23 Sep 2022 14:19:09 +0200
Message-Id: <20220923121913.2135229-1-benjamin.hesmans@tessares.net>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The series only considers the sender side.

Compared to the previous RFC patches, these ones focus on
the sender side only. It corresponds to the 4 first patches from the RFC
series.

The sending part is less complex and even if it looks like we are
converging for the receive part, there are still discussions on-going
there.

Again, thank you Dmytro for the previous work done. As already discussed
on the ML and meeting, this approach was slightly different from what
Dmytro originally proposed. Here tcp_sendmsg_fastopen() is exported and
re-used and TCP_FASTOPEN_CONNECT is supported.

MSG_FASTOPEN will be handled by Dmytro's patches.

Individual changelogs have been added per patch.

We would like to credit S=C3=A9bastien Barr=C3=A9, Gregory Detal, Olivier
Bonaventure and Christoph Paasch for the original idea of supporting TFO
in MPTCP, see https://datatracker.ietf.org/doc/draft-barre-mptcp-tfo/

It would be very nice to have these patches accepted in the future
kernel 6.1 which will be the next LTS picked by many vendors: the
modifications are quite small, well isolated and re-using what is done
in TCP for years.

v3:
- Add Dmytro SoB as kindly asked at the last meeting, the code is still
  the same.

v2:
- Drop support for MSG_FASTOPEN because we were not sure that it was the
  correct way to do it.
- latest patch of the series: apply comment from Paolo concerning
  mptcp_poll()

Benjamin Hesmans (3):
  mptcp: add TCP_FASTOPEN_CONNECT socket option
  tcp: export tcp_sendmsg_fastopen
  mptcp: poll allow write call before actual connect

Dmytro Shytyi (1):
  mptcp: handle defer connect in mptcp_sendmsg

 include/net/tcp.h    |  2 ++
 net/ipv4/tcp.c       |  5 ++---
 net/mptcp/protocol.c | 26 ++++++++++++++++++++++++++
 net/mptcp/sockopt.c  | 19 ++++++++++++++++++-
 4 files changed, 48 insertions(+), 4 deletions(-)

--=20
2.25.1


--=20


Disclaimer: https://www.tessares.net/mail-disclaimer/=20
<https://www.tessares.net/mail-disclaimer/>


