Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B867579F9
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 14:43:55 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id r11so39749170wrr.12
        for <mptcp@lists.linux.dev>; Thu, 06 Apr 2023 07:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680792234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpeYeTlPCSjCzesZ5RiOpkKQaOiJYEXrA3BRe7RFWW0=;
        b=bM09rBI63y96NWs4xWjFWyjBGPXO4LMcEPAgz/movq9l+4XZaHbmnRVaJ3kujBP+YH
         fTHDibzsiML5uuIiZDQspJDGPl4ehTHab7vAyRc2cVLRMu/Z99hJcZSWjn58Ge4LSOE1
         g/1ePdZgICw2QCiQBtGgzB6qPo5QMVG1LQuec4yMIvAD56tbOBoFNct0gm21IRbpd0Fb
         mbxP9/M81nds/rw4XdgKpyj+hpMtQF9vFiuVV2D8Whs/wXQA1xv5OFVRCealjM5IOykl
         whOQG5crmk6tEUAseuqv7YArtvKlM2cIVvFZX0DrkcN4Hu7f9TYYueLOZFFJ4/O6jzGL
         EQNA==
X-Gm-Message-State: AAQBX9f1d/lgmTGaBzTvnJlqdeBgV1OBHpGIZGDo3weyWPwAV76+yAOj
	1gXgTRoHqQ/lN6dh35iloQc=
X-Google-Smtp-Source: AKy350aD2Lho4oSNIg7agw45Of4VLNEFw3wGkTM1LkIkjxdhofXWpEzZoYmSuEopYsZQnRAATnKa/w==
X-Received: by 2002:a5d:4d50:0:b0:2ef:930a:cb27 with SMTP id a16-20020a5d4d50000000b002ef930acb27mr165033wru.2.1680792233938;
        Thu, 06 Apr 2023 07:43:53 -0700 (PDT)
Received: from localhost (fwdproxy-cln-028.fbsv.net. [2a03:2880:31ff:1c::face:b00c])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d5308000000b002ce9f0e4a8fsm1945760wrv.84.2023.04.06.07.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:43:53 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	asml.silence@gmail.com,
	axboe@kernel.dk
Cc: leit@fb.com,
	edumazet@google.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	dccp@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	matthieu.baerts@tessares.net,
	marcelo.leitner@gmail.com
Subject: [PATCH 0/5] add initial io_uring_cmd support for sockets
Date: Thu,  6 Apr 2023 07:43:26 -0700
Message-Id: <20230406144330.1932798-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leit@fb.com>

This patchset creates the initial plumbing for a io_uring command for
sockets.

For now, create two uring commands for sockets, SOCKET_URING_OP_SIOCOUTQ
and SOCKET_URING_OP_SIOCINQ. They are similar to ioctl operations
SIOCOUTQ and SIOCINQ. In fact, the code on the protocol side itself is
heavily based on the ioctl operations.

In order to test this code, I created a liburing test, which is
currently located at [1], and I will create a pull request once we are
good with this patch.

I've also run test/io_uring_passthrough to make sure the first patch
didn't regressed the NVME passthrough path.

This patchset is a RFC for two different reasons:
  * It changes slighlty on how IO uring command operates. I.e, we are
    now passing the whole SQE to the io_uring_cmd callback (instead of
    an opaque buffer). This seems to be more palatable instead of
    creating some custom structure just to fit small parameters, as in
    SOCKET_URING_OP_SIOC{IN,OUT}Q. Is this OK?

  * Pavel has some ideas about the SQE->cmd_op field, so, we can start
    discussing it here.

This work is heavily inspired by Jens Axboe's initial implementation.

[1] https://github.com/leitao/liburing/blob/master/test/socket-io-cmd.c

Breno Leitao (4):
  net: wire up support for file_operations->uring_cmd()
  net: add uring_cmd callback to UDP
  net: add uring_cmd callback to TCP
  net: add uring_cmd callback to raw "protocol"

 include/linux/net.h      |  2 ++
 include/net/raw.h        |  3 +++
 include/net/sock.h       |  6 ++++++
 include/net/tcp.h        |  2 ++
 include/net/udp.h        |  2 ++
 include/uapi/linux/net.h |  5 +++++
 net/core/sock.c          | 17 +++++++++++++++--
 net/dccp/ipv4.c          |  1 +
 net/ipv4/af_inet.c       |  3 +++
 net/ipv4/raw.c           | 26 ++++++++++++++++++++++++++
 net/ipv4/tcp.c           | 34 ++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_ipv4.c      |  1 +
 net/ipv4/udp.c           | 18 ++++++++++++++++++
 net/l2tp/l2tp_ip.c       |  1 +
 net/mptcp/protocol.c     |  1 +
 net/sctp/protocol.c      |  1 +
 net/socket.c             | 13 +++++++++++++
 17 files changed, 134 insertions(+), 2 deletions(-)

-- 
2.34.1



