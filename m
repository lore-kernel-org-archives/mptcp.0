Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5854C63
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 15:26:20 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id y5so10513015wrh.3
        for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 08:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=jitbND+vZlc3NO7ennGPGlXaYIW8/hxbAME0Pc82OeA=;
        b=W+wJ6h+lDSJJYiFOCTcd4OLuC08fUbtjUmsK48MeW8cKOM0TU1AjnlZrJiI9XqTmhn
         0NxQXWZCk4cX8yrzzs4SmWArWcW0iQEb64U32wub/+NS+iNaFUyCK5rDe9/KTMQ01tcS
         NA2QA2CwcEP133HQyuWzL3k592TeJS6WgQ/3+yIQFvurri81OZl7i6xEaNNd9I2B36l/
         V8BvSLhs9yHEoRJPRh91ZIorEL/aOKA6IDA+sLBLe8KUDdom3d6BfHHy3BLyFoZZ3TiP
         QgebKsUezvO9sniKvCpGrDWdYbln3goJWiu68I8G/TA7srHju0zwCXEwqEoUOFYysMOR
         F79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=jitbND+vZlc3NO7ennGPGlXaYIW8/hxbAME0Pc82OeA=;
        b=5DPwzNDPIflPXnBz+kxka+AqRtA6ue0eSw+UcOMqqMTAyVMZPs6gqT2HKoq7Ly2PIV
         e8C2JQW4lKyeo4VnMAYuwLJzl43qsVPreasfUFkWzlRJsM4x25n11tDUkfurgQ3jqDTo
         9z4LwTkr3NrpBvaE1vPqVXs+HCVBZuhggVnuvQpRZZDbDUJZm40+Ekn0F771IvFY7i+m
         SVVTTwCn5MsaZ7yfnEsHExShLLtkWcG+9Osz67TEZwgwiTPRI+3lVMnjk6485JjiyZJ9
         +yMB10P52CH4V2VZenwshQ76K4Tyt+COrCfHvsSspmmq1woYQtN6vpc7baaTaqaskN+k
         +eyQ==
X-Gm-Message-State: ACrzQf0tDYNNK42TxPgEyj9JdCcK6J3i8io5FMoCynX78IiJCy46RUUP
	0+PonG7gJldDANMNLjsDmHNE8piSXkvJWu9JN8icmd8e/Ph4k8Kce9oGkCu6TGDWw4w9SuTjuV3
	NbI3f14HcfpLo2d+owT8=
X-Google-Smtp-Source: AMsMyM5Vl3iPmXCfmCdVZq9oiKrTHnxQiPlPx9MHCnBKRtA+ATZuau/EDtLoU11Paxj/4pZzpDc0kw==
X-Received: by 2002:adf:df82:0:b0:228:e2cf:d20f with SMTP id z2-20020adfdf82000000b00228e2cfd20fmr18942517wrl.356.1663773978081;
        Wed, 21 Sep 2022 08:26:18 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c358400b003b4935f04a4sm3994435wmq.5.2022.09.21.08.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:26:17 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Subject: [PATCH mptcp-next v1 0/5] mptcp: add support for TFO, sender side only
Date: Wed, 21 Sep 2022 17:25:34 +0200
Message-Id: <20220921152539.1851441-1-benjamin.hesmans@tessares.net>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

The series only consider the sender side.

Compared to the previous RFC patches, these ones focus on
the sender side only. It corresponds to the 4 first patches from the RFC
series.

The sending part is less complex and even if it looks like we are
converging for the receive part, there are still discussions on-going
there.

Again, thank you Dmytro for the previous work done. As already discussed
on the ML and meeting, this approach was slightly different from what
Dmytro originally proposed. Here tcp_sendmsg_fastopen() is exported and
re-used and TCP_FASTOPEN_CONNECT is supported. MSG_FASTOPEN was already
handled by Dmytro's patches and it has been added to the series re-using
Dmytro's SoB, hopefully that's still OK for him.

Individual changelogs have been added per patch.


Benjamin Hesmans (4):
  mptcp: add TCP_FASTOPEN_CONNECT socket option
  tcp: export tcp_sendmsg_fastopen
  mptcp: handle defer connect in mptcp_sendmsg
  mptcp: poll allow write call before actual connect

Dmytro Shytyi (1):
  mptcp: add MSG_FASTOPEN support

 include/net/tcp.h    |  2 ++
 net/ipv4/tcp.c       |  5 ++---
 net/mptcp/protocol.c | 32 ++++++++++++++++++++++++++++----
 net/mptcp/sockopt.c  | 19 ++++++++++++++++++-
 4 files changed, 50 insertions(+), 8 deletions(-)

-- 
2.25.1


-- 


Disclaimer: https://www.tessares.net/mail-disclaimer/ 
<https://www.tessares.net/mail-disclaimer/>


