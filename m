Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF4E2D29B5;
	Tue, 10 Jun 2025 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560399; cv=none; b=Ft4KUIV8ShA38Vbcy8Md5PFQNVXQ1/CiQEVrfKsxz31ABz41ujew9266mfaqUKfX6rUwjolRwBlBVSR4xNA01gwWl21A3n6PHeTDVSWosubBydyT5ETC2G4kf7FG4FWwD2C7UPRULe8OKCc9VgS5itKrho7kYngLkQzCjzVi+WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560399; c=relaxed/simple;
	bh=8s9eNAGzDntGvZK7Pc6cMHYrqeVLULwscezMnMgGoE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DGR36VD9cfHK/S2XBKN8jvmP8EuqcP2wYbzOwxgBEEZng87c+rGOVgLZ/KtBtFuob0KeJvi3iYC37c9B1glIke87088nZMDz98MZR3RcihVrM9ll4q2QQ6eAD4umazIepUZH/YOyPhW6EOfCWFNIpEKhLvt+Gyh5e8Cux5p52gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhKNI7CO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhKNI7CO"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so48425205e9.3;
        Tue, 10 Jun 2025 05:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749560396; x=1750165196; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EBizC4HChtDjhvxMjVZXHxWUIj72Hoy73F5AtjgusPA=;
        b=KhKNI7COKBGHWwPW9pTktxRLey5CE6zArTC5CTOOWzX9ivq/XJAeL/iCxIinuNqU+m
         Ep6jSOBdiiDA89HuMlLG/SZnLcwI8/QGU5doPhTNkr9egy2v6Hk5m8b5h00lXIJZHLbC
         ynjWW2w/sbDDcmd5W7z6x24d5v5Se6ubc2xdNJaEXTM1e2MlX+B9j8UuNBFbfI7wVQPD
         vZD6744Gd0X5OshvumBlcruqtp0fxuTuCnvW6KwjzJ43Oz0KjoiKn3aXp9HxhvYghLQs
         YIJjRTUeNY9Gqo+h1CAhv99yR1wsZ7HkvKLqi56e9WkE8Noe7q3IU+Yjh/SEGgnqTNBk
         cQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749560396; x=1750165196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EBizC4HChtDjhvxMjVZXHxWUIj72Hoy73F5AtjgusPA=;
        b=Q/b25Cos3cs9xWgHOzceAv7v2SBsk0RVD7MBbu1q7XEWz95t5migYdkIH/9sKfFYwc
         /z8LC5/X8YyfmIvVVC9e69/ZormzVcQf2ElTZoZ3udL9egEJF0C/iy3I3zJjDI/2r88v
         qr0l72lx+gCEK0qdiFwywe0nm3nzoFrchbSUgE67q04UsImWzDgvn+3DxQOZSqaoIii3
         ifgjZMJi2xUo8cy7a5klcEXkZe82wX95nM/RzFHuy+qEx8eYPGw9uNjLqLrE12f4oawB
         UiN1fD2d18UBACyvLM+xRbGmFKP1q+hp9M3S/f238joIEHv0ZmTZE47zDAm0jC0Olnao
         e47A==
X-Forwarded-Encrypted: i=1; AJvYcCUUg9EMHSryYsI5m8y2zI902Eb/RjyPLTnJapungW7d/FRqC2a73LTm599jgQlFrnqddBT1PmSUuuFrE1C0pPubj8I+DA==@lists.linux.dev, AJvYcCWIFUwuIbu0Q8/uNAjoGeUQ76aq8Ul2ewrkDq6UkRmnqI6fKY4iUoOVn38B//kjd8/xAsfWicI=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3ig/xI1UoDhGPk6v3X+3556WiDLTt4KjDq5EQ02FW2g3mWyh4
	qDFPVykhrI5zRGZ/DKJXgr2ONmZzYIrpjNqU5STZxTcGDTnGc6AJVRKf
X-Gm-Gg: ASbGncuCfn7w1C1empqJGfikKJyDfbd4nybH7To5TtJus1rsQRsCAe6DlijNPlajtMC
	EkDXImFiZ5PIoXwEO9I2wYbyVxc9pnUfTQIiHaAyaHw33eQAGrIrL4qAYWR3Z/bmtu3bYHZd7UR
	n4nErCmFIPm16r0kmyhhgo84ltQJbVkbLkZsRp+0K6sJ5etGlGlrNZUgY8hGv+i4wCuja5+JE++
	pY61ygO93K0EnhNbfS8pS8H04APwn4TxFH4JbVtHQbYwV296jaQ9zmLX1gJ+Sw3iAA6AUC3YBUM
	vkejS26aEWCqY5UEaZ93O7wyMX0d5m6xU0zNL+0zAYtDipjU59MooN9FbTQC9MBEHvRjkbfe7LU
	cnqfh
X-Google-Smtp-Source: AGHT+IGpxd1xxIqDK6SYHgkxWT+7F5cwAd7IVV1tuOTh0FRSNPqlNQxFdPzeQh9zjHggZ7MrXo7Uxw==
X-Received: by 2002:a05:600c:3b95:b0:442:faa3:fadb with SMTP id 5b1f17b1804b1-4520134081dmr172208475e9.2.1749560395787;
        Tue, 10 Jun 2025 05:59:55 -0700 (PDT)
Received: from imac.lan ([2a02:8010:60a0:0:6117:17d9:610b:9e0a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452fb381abfsm130563485e9.17.2025.06.10.05.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 05:59:55 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	mptcp@lists.linux.dev,
	kernel-tls-handshake@lists.linux.dev,
	bpf@vger.kernel.org
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 0/7] netlink: specs: fix all the yamllint errors
Date: Tue, 10 Jun 2025 13:59:37 +0100
Message-ID: <20250610125944.85265-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

yamllint reported ~500 errors and warnings in the netlink specs. Fix all
the reported issues.

Link: https://lore.kernel.org/netdev/m2tt4tt3wv.fsf@gmail.com/

Donald Hunter (7):
  netlink: specs: add doc start markers to yaml
  netlink: specs: clean up spaces in brackets
  netlink: specs: fix up spaces before comments
  netlink: specs: fix up truthy values
  netlink: specs: fix up indentation errors
  netlink: specs: wrap long doc lines (>80 chars)
  netlink: specs: fix a couple of yamllint warnings

 Documentation/netlink/specs/conntrack.yaml    |  38 ++--
 Documentation/netlink/specs/devlink.yaml      | 208 +++++++++---------
 Documentation/netlink/specs/dpll.yaml         |  14 +-
 Documentation/netlink/specs/ethtool.yaml      |  70 +++---
 Documentation/netlink/specs/fou.yaml          |  14 +-
 Documentation/netlink/specs/handshake.yaml    |  10 +-
 Documentation/netlink/specs/lockd.yaml        |   4 +-
 Documentation/netlink/specs/mptcp_pm.yaml     | 192 ++++++++--------
 Documentation/netlink/specs/net_shaper.yaml   |   7 +-
 Documentation/netlink/specs/netdev.yaml       |  43 ++--
 Documentation/netlink/specs/nfsd.yaml         |  10 +-
 Documentation/netlink/specs/nftables.yaml     |  16 +-
 Documentation/netlink/specs/nl80211.yaml      | 109 ++++-----
 Documentation/netlink/specs/nlctrl.yaml       |   6 +-
 Documentation/netlink/specs/ovpn.yaml         |  26 +--
 Documentation/netlink/specs/ovs_datapath.yaml |   2 +-
 Documentation/netlink/specs/ovs_flow.yaml     |  16 +-
 Documentation/netlink/specs/ovs_vport.yaml    |   4 +-
 Documentation/netlink/specs/rt-addr.yaml      |   2 +-
 Documentation/netlink/specs/rt-link.yaml      |   2 +-
 Documentation/netlink/specs/rt-neigh.yaml     |   2 +-
 Documentation/netlink/specs/rt-route.yaml     |  10 +-
 Documentation/netlink/specs/rt-rule.yaml      |   2 +-
 Documentation/netlink/specs/tc.yaml           |  27 ++-
 Documentation/netlink/specs/tcp_metrics.yaml  |   8 +-
 Documentation/netlink/specs/team.yaml         |  16 +-
 26 files changed, 440 insertions(+), 418 deletions(-)

-- 
2.49.0

