Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588392F81
	for <mptcp@lists.linux.dev>; Mon, 19 Apr 2021 20:34:27 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id s15so42355100edd.4
        for <mptcp@lists.linux.dev>; Mon, 19 Apr 2021 13:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gUrlpYch5WHsiNdiHpxwuQ2O3TRH16myabwA1uOCOYQ=;
        b=cXwGpadiCEQSyElKWYyZ4FDiixeNTAp8Co4oNIeRhE0+MY0/RVkA/r7Ag9cEGJkxL1
         KrQPR4PYQ9/qKkAdRpjWS0s/xIOOrnO1fsZsToM1cx5ITm6+BjRGtUQL43lZCuwlaLUf
         Vw540oqzZPS7eck7HS2irl6kJqrvz7a33U/qDL2VrtmiGw/MTUhLXn6Tfq1VJR754hat
         G9LHdCu+6OVRtVQUx6VGvEKGkCV0pRl/jKuH/qje6HPF5qB2wwvZ6L+GhvGAqp++9fqT
         fg59rBVObbdAXQULCTw9P68IAfKjywb0TicVy6QktszYLigxEmgXC9iIS3ah8eQnQxnB
         RwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gUrlpYch5WHsiNdiHpxwuQ2O3TRH16myabwA1uOCOYQ=;
        b=Z1QIzW7qUYXevmPkW+JcITkU70J7+aL43VlOliANuenaBJQzOh1HkFlr2iINjHBrlV
         Qgv9xZd4rlHmrKymc/o1fd4tDbyxMq6SpGNMJ76d1SzKl4wpNS8uo66xwSaqz5mAcxUa
         mPpafkGgHRO4vTdmMfhBVjVSbPqiGmlc1ZMe7aGtyczwGcYFpjSkxKqYdGichcIUQs3x
         z8zXwMdQN/xt025HWJjg6VvisnCnOyCfwfEOi780XX7nBxqWHxdsBZbyVccDmhjAk3bz
         uq501Y0YsnSH2ITei1cSnappJOuI+Lo8BZBHij5+VX329vS2EHleUZv+nOxJtUB22PDM
         3zQQ==
X-Gm-Message-State: AOAM531TcHE+9f6+tfsZvcQ49zcZJEgT5jr7Xyi9dMWzODKwW5w+zAxA
	LLHn5YJ+mcNCjLrwtLOZVciijb0N1ydDvQDm
X-Google-Smtp-Source: ABdhPJzN9LfTB0XzZKc9a0Vc4XpNzwN2pQPvpqF92VnHLTTf6a32kQDB3vNK3k7rBuVZ5iZfqkX0kQ==
X-Received: by 2002:a50:f28e:: with SMTP id f14mr4077700edm.371.1618864465357;
        Mon, 19 Apr 2021 13:34:25 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id e16sm13941867edu.94.2021.04.19.13.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 13:34:24 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Yonglong Li <liyonglong@chinatelecom.cn>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 0/3] Squash to "selftests: mptcp: add a test case for MSG_PEEK"
Date: Mon, 19 Apr 2021 22:33:52 +0200
Message-Id: <20210419203355.3937162-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.30.2
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I started this because I prefer avoiding setting a global variable before
calling a function and reset it later in order to take a specific path in the
called function. While at it, I also reduced duplicated code.

But good thing, I also fixed two unwanted behaviours, see patches 1/3 and 2/3.

Matthieu Baerts (3):
  selftests: mptcp: use 2 different 'peek' modes
  selftests: mptcp: same NS for Peek tests in IPv6
  selftests: mptcp: avoid non-const global variables

 .../selftests/net/mptcp/mptcp_connect.sh      | 44 +++++++++----------
 1 file changed, 22 insertions(+), 22 deletions(-)

-- 
2.30.2

