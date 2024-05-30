Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1734817F50C
	for <mptcp@lists.linux.dev>; Thu, 30 May 2024 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717074802; cv=none; b=KHtfoMVpN6iB3/oPIKA2PD3jpIR4wnfz6b8V28jk+f9Rgq+LtZMTH5PQYPvOCD4MdJAXUGX/Aj6wm2BhR7yFXcYkKLDKz2SnaFLEJAD24Hw9tZbqivz64dijxAoPByEJj3eYDpXm1R9mfCHVvGvvUEQKE54enMTOC4QYDbJXmsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717074802; c=relaxed/simple;
	bh=eOKx/4aIiAljifHHB8rj3d8FTVHdq9xwCwuX+rhfkV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TyR/d9dvmr2amc21B1Ix4UTXTVJOSg9SvlUpGch3sdWs5iBeU/PUC+iepAHm5Y05/rggmf1rCkVbPtG3ZAXBoYZ/L5kqHcGMQHvSXA6Fbi+1hwAFYplWdw9zAe0Ed4hFcXluKdiy/xaxXCFznpcoqc3Txa1NJio4dbni+nuNtW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPD9CRaP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPD9CRaP"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f44b594deeso6270355ad.2
        for <mptcp@lists.linux.dev>; Thu, 30 May 2024 06:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717074800; x=1717679600; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rn6/3adWE70qZaluvT2NQrezYGVsLoxoeSVhjQrx1ik=;
        b=SPD9CRaP4znYbzBvUVCFCkc3yx2P8SYZuJ/IQYrICunS+sKDuoi/GeXyJ3IwH2ed3Z
         AVBmYIpTViGHVc+p+tDHCcI07Kj/xd9jEyQAIr/3sTj0yVaoeGIT6/YuMpiLtVEIt1bP
         9OKkwLKHM+bJ1OfNCn/KdoApy5pk8i1vOlqVv+eQYcXeVBc7cT1VbjVZeprB3OhbXqf8
         H92j6LE60Ibb/yOZM4+GImBvzU7MX+qbHU4JdNA2Gq8NcmDnoeJJ4YMxoW4+oxZ33dPV
         SMzCeXlgO40nz8w5cTNxypYFtRhqWdpPJSJ6T+FK/ucjec5+wfKbutlj2hkg+4dt9BUI
         NSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717074800; x=1717679600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rn6/3adWE70qZaluvT2NQrezYGVsLoxoeSVhjQrx1ik=;
        b=uj792X3P14GtxiH5jJW/Ul3ZXyE4nMhM4jW+OASGDJ04CNC/eBAf5hVTL8V+e86E6n
         MBgjJHErK6269XXKCwq0V4Or6DPQ0oL+OWCqbA6IGRk/0AC8dSpnNfFPfmKkTO26y9HP
         hg/M4AxNJQIgMhJGbEO6yVhBB/XgcHnDdLvgvWiyNGvhPC8W99du02HI0Cxt4OISQQDK
         8+rPJZQpHfnD8nTkZenbFxOLdr52o48oFLuWx/IMmgxtEYsrIY8IckvGnKp6tg60uoRH
         100PpDqn5xl5X2AhtwvvfRGPE5yjz9eUelLOKm9ErvScE3j4QCI0WT2mK5zXhDIP6g8r
         YUpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW17EmLNN2XkJWZIn01J3dhvM7FHdRzkYVTHk6uZoU+WWunVJkutZyuwIuck2EzFEnOk7aRu4GSyjKDC3QJ+64KDe3Xoz8=
X-Gm-Message-State: AOJu0YwPjiYJpJsWUVsdQc34y1ZvPaCKgBvOPDBSMSugR4/jYiJAk3JT
	aHgFY1ah0Wnq2dJ8r/1x5lgKdPf/zLbg0GU+1LXHr/PjFLNdMLlN
X-Google-Smtp-Source: AGHT+IF1HjS6GCWnZWXM1RVikObrMN2t9GvykuhPwBY7+yxa+8GpHVBMiLfFToSs+apcXCJrjw9BAQ==
X-Received: by 2002:a17:902:c951:b0:1f4:5477:4be6 with SMTP id d9443c01a7336-1f619733939mr24856605ad.41.1717074800247;
        Thu, 30 May 2024 06:13:20 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c75de6dsm117814885ad.6.2024.05.30.06.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 06:13:19 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v3 0/2] tcp/mptcp: count CLOSE-WAIT for CurrEstab
Date: Thu, 30 May 2024 21:13:06 +0800
Message-Id: <20240530131308.59737-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Taking CLOSE-WAIT sockets into CurrEstab counters is in accordance with RFC
1213, as suggested by Eric and Neal.

Previous discussion
Link: https://lore.kernel.org/all/20240529033104.33882-1-kerneljasonxing@gmail.com/

Jason Xing (2):
  tcp: count CLOSE-WAIT sockets for TCP_MIB_CURRESTAB
  mptcp: count CLOSE-WAIT sockets for MPTCP_MIB_CURRESTAB

 net/ipv4/tcp.c       | 6 +++++-
 net/mptcp/protocol.c | 5 +++--
 2 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.37.3

