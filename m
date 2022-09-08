Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611233222
	for <mptcp@lists.linux.dev>; Thu,  8 Sep 2022 13:38:47 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id k17so10862388wmr.2
        for <mptcp@lists.linux.dev>; Thu, 08 Sep 2022 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=RAvzXdOurNPCwitNPy342JeVz+SYxlH+OA+WAoTv03c=;
        b=7NY2haqFCqjQoyLTzvvxdiTwvdK2sYyblPYd5AYlMsMJgpqBJAPvFRtwaqVPmZh6Rq
         +vv0enSjI7WNxB4n8pZDvWL223yaE38Z4dhTqEwOpsrnc27AoRYAvXo8UxnRzuYjarjZ
         WKvvpjrrSpIvo48hUXYX4hrhID6Pef04cS6k74bslBFEgT0bhBVXT+pAztNa06EWT0BV
         CgDFRjEkFruz6nuNYVcAXZKycbaxZuOGRhRtXt+8v9/0P3gCedP2wzeaVmDbF2Ql/HHZ
         R4ypkE/DdP0WOd8BMKq/T746/4wobmVyLwORLgeFRu4NEDSvKkDUGz8IF3NXswj/nHV4
         IB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=RAvzXdOurNPCwitNPy342JeVz+SYxlH+OA+WAoTv03c=;
        b=tFVXsnM2hIhoAmsrS0AVQP3PtILsmPHhRoAKEwSa+qOynWSy8QV3gysf/jtCNgDsQ6
         pfRWtUWe8yprJGn3PRJJy9j4ohPzTvAvLg0bUKAK0hc2pC5xPUFqlgNJTxqeRQYtuVPc
         6BLEzBHiPM7C9ttzh1swe2fSsBFuU7Q7eKOmxBCmu20haRs8MnKXnP90IIwhkHLI+2G7
         iavkdwRj2R5JBaMeT6VmOSKLbPWLe09eV0h3xGN+j7naVGXZnwN+PfbZX471oPsAGeFa
         XgOoZfMaxujlr5Gv3hQrpdsmlpSfAgzLL8zXXHNvai+hCMGXtTDHPNVYsQpJNUg9r7SX
         DYkQ==
X-Gm-Message-State: ACgBeo0YhY4hVHDfA9QkfAmB8A4tjpCg+7csBZ9k6A/Q02LQV2HXihmZ
	wfhE5dzZbgERnMMS8pGEObE/oVUaJj4wIEWPiNJixVR67lNJLZ/tpAr9K5x7uYl8/4BpUDvlOQx
	RY0SBS7wQknD/FrVzP5vcTA==
X-Google-Smtp-Source: AA6agR6q4pHyPjN2MbE0rfDj9b9e913s+VQOHy+vQDgbos1Z7luNq9VgpfsR/DlE+yN+8yOnpOf4Lw==
X-Received: by 2002:a05:600c:3217:b0:3a6:8235:4f6f with SMTP id r23-20020a05600c321700b003a682354f6fmr2277424wmp.96.1662644325315;
        Thu, 08 Sep 2022 06:38:45 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id fc15-20020a05600c524f00b003a5260b8392sm3100822wmb.23.2022.09.08.06.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 06:38:45 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Subject: [PATCH RFC mptcp-next 00/10] Implement TCP_FASTOPEN_CONNECT for mptcp
Date: Thu,  8 Sep 2022 15:38:19 +0200
Message-Id: <20220908133829.3410092-1-benjamin.hesmans@tessares.net>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

Add support for TCP_FASTOPEN_CONNECT for MPTCP

This series only consider data in the SYN and not the TFO cookies.
Dmytro SHYTYI has pending patch for the TFO cookies and the TCP_FASTOPEN
socket option.

Benjamin Hesmans (10):
  mptcp: add TCP_FASTOPEN_CONNECT socket option
  tcp: export tcp_sendmsg_fastopen
  mptcp: handle defer connect in mptcp_sendmsg
  mptcp: poll allow write call before actual connect
  mptcp: delay mptcp data_ack calculation
  mptcp: allow delayed data_ack calculation
  mptcp: TFO receive: bypass mapping check
  mptcp: allow data that can not be DATA_ACKed
  mptcp: force data_ready
  mptcp: test TFO

 include/net/tcp.h                        |  5 ++-
 net/ipv4/tcp.c                           |  5 +--
 net/ipv4/tcp_fastopen.c                  |  4 ++
 net/ipv4/tcp_minisocks.c                 | 29 ++++++++++++-
 net/mptcp/options.c                      |  1 +
 net/mptcp/protocol.c                     | 32 +++++++++++++-
 net/mptcp/protocol.h                     |  3 +-
 net/mptcp/sockopt.c                      | 18 +++++++-
 net/mptcp/subflow.c                      | 15 ++++++-
 tools/testing/selftests/net/mptcp/tfo.sh | 55 ++++++++++++++++++++++++
 10 files changed, 158 insertions(+), 9 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/tfo.sh

--
2.25.1


-- 


Disclaimer: https://www.tessares.net/mail-disclaimer/ 
<https://www.tessares.net/mail-disclaimer/>


