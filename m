Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8867D3C26
	for <mptcp@lists.linux.dev>; Thu, 22 Sep 2022 13:56:35 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id g3so15626676wrq.13
        for <mptcp@lists.linux.dev>; Thu, 22 Sep 2022 06:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=Mu7rpVDNVI46/y2iC1g0GEVy6jg4pS6mQOmK0U2qzVE=;
        b=JDXSXeMuOhvCWtXl03AYqdyVuXus1ET5NmcwmnL0acJ6YZJn8r0MwXwWTHCcbcEoEg
         rQc79ky5vMun7/PZ/oHjDdq9c5XaWEy6j6ItB+ZJiWtj2f5jYRtoAZ317SRFg8ncdpEk
         fMFZ7T0jCSux/U/wPZQYSJDJOYccRw9WNZJDFz3B9QpW7tdC9jfd90x+yqwajoaj5LNE
         Mobg4vPFmg13OZIPrs6sB/x4Wk1K+P8FjGeVAZJByC/XckIXGSjZwaGdEZlFa1NurKLH
         HAC6jhpLXbZ7xfzWA2hOE+jdvxFPnsP5pOGmWYwkUPQUitHyC45gXqc7RbZupzWdPk/x
         dZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Mu7rpVDNVI46/y2iC1g0GEVy6jg4pS6mQOmK0U2qzVE=;
        b=iTK6JlMODnOmBoCiggO/JS74BvNI5U+AbDgUm7sqEX/+7Y46xdmfTcvoz6L4lYcEJi
         MVWUY6mC7Sq0QeyREjrtiwY6cj+gOR0h6igVHCJAcidIqZoz6ullb43dhlGGHzXIUUqk
         Gyrww2notHiZroO90lFsW8MbDOwaJ9WGHobB7GjYGQ6Ia3dmE6yftx6cYy+cQC5vdoUN
         FIncRbctH0mFdgq+Y34lPypUCL92AmztMIEefpnHysYSlEQdI9f47GrsisEi9r7lG6cn
         u2Vts9xFQmS+6zhM+SWFKQ2NiBN1riazWWWKbdLPw2GQBpkbN9odY0fSGlRQXwidAa+0
         4kaw==
X-Gm-Message-State: ACrzQf1sn6EXbdX6ppc7rOisyYr3tQxyIzJNzmS19IVh1s/lTky2IsfE
	fxbcGf/8+hYm+4l0DTgYy0m2aEv0m2/Lfya0KhmH/2oUmJJ7E9N8/s+fL3Y1W/q8Fal/aFkCeZI
	XywJetYoT0k2u/VQv8/C5Jg==
X-Google-Smtp-Source: AMsMyM5Uo8JLtPGTOn5OtGr160bhbtl5enIchAPNRc/UvcKO5yZz6ArxTT29EiJapjpPvlBpVdZ14A==
X-Received: by 2002:a05:6000:78e:b0:22a:7e99:da93 with SMTP id bu14-20020a056000078e00b0022a7e99da93mr2141945wrb.20.1663854993284;
        Thu, 22 Sep 2022 06:56:33 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id d9-20020a05600c34c900b003a844885f88sm6577053wmq.22.2022.09.22.06.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 06:56:32 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Subject: [PATCH mptcp-next v2 0/4] mptcp: add support for TFO, sender side only
Date: Thu, 22 Sep 2022 15:56:23 +0200
Message-Id: <20220922135627.2019807-1-benjamin.hesmans@tessares.net>
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
re-used and TCP_FASTOPEN_CONNECT is supported.

MSG_FASTOPEN will be handled by Dmytro's patches.

Individual changelogs have been added per patch.

v2:
- Drop support for MSG_FASTOPEN because we were not sure that it was the
  correct way to do it.
- latest patch of the series: apply comment from Paolo concerning
  mptcp_poll()

Benjamin Hesmans (4):
  mptcp: add TCP_FASTOPEN_CONNECT socket option
  tcp: export tcp_sendmsg_fastopen
  mptcp: handle defer connect in mptcp_sendmsg
  mptcp: poll allow write call before actual connect

 include/net/tcp.h    |  2 ++
 net/ipv4/tcp.c       |  5 ++---
 net/mptcp/protocol.c | 26 ++++++++++++++++++++++++++
 net/mptcp/sockopt.c  | 19 ++++++++++++++++++-
 4 files changed, 48 insertions(+), 4 deletions(-)

-- 
2.25.1


-- 


Disclaimer: https://www.tessares.net/mail-disclaimer/ 
<https://www.tessares.net/mail-disclaimer/>


