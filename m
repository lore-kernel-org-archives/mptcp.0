Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F411C2562E
	for <mptcp@lists.linux.dev>; Mon,  3 Jun 2024 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434153; cv=none; b=d3IUIkPwh6X4uvAvPGPixQmTps9m3hf563VhePVz7AKaGTVa+jhlw6VulmWCJhPrNucP7k2FvKZ96ntsbKz4R2IFnWrqmNvoPsnNfmRVdHJXGKn1Mmzme18+WAtjyWGJB4N657QiJWb9fy9g9vQGfJBOqS1rLh/N/whQojhgvuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434153; c=relaxed/simple;
	bh=VjMt0glpQePD8evdEjP05HrOAXJ7FMPoS+Bm3n4Nkhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N3zPw1vOz5klS2pub1fOtIB/ZPXbZgZ2LJ/54DK4ROOHGQn9MIPhhzV32+4K8OaHvOZILg9NagQxNSyvg4628QYilcVfp+QbixsAMY4EFxw1Yvr9zjvpo+Fpf95Qr6SdWZZ8Nz12JuRe/qam1MP+iMEFNEZYffdAbdCueh50zag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3YYkoiO; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3YYkoiO"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2bfff08fc29so178007a91.1
        for <mptcp@lists.linux.dev>; Mon, 03 Jun 2024 10:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717434151; x=1718038951; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hM97C1DwkDE3R6cN0KJoKmJQI59XMjBaknQKnZz5NeE=;
        b=P3YYkoiOSEgMMfRlQ0v82FGXj3diDhy/Xf3Cvl6P1u1HewcphRkwt/Ev5epBa5hPbN
         rRSSzDdRTJspOyvA34ousxsflY+yPpexmkJq/xYXo59iShJGWB4iFovoR6EMzRichq+e
         9CkTOcv2lKyymMRGdX6609WFJ4unimfB6WSmhkmRW9zPfVA+EVcM/cKrKEQ0yCnmb9AU
         1Rr80NmjENmk2apmwmdi9x89POY2JFtY9qYNDBxhsUB37sa2EIGgdj1Lqz+ToEruYdKl
         LdGpvLj7yJw1Z5AEIDoGBDFZDZXFwBmP549Exq7SckLJd2U+wDRuWcYbRUkthGzV6zoP
         aKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717434151; x=1718038951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hM97C1DwkDE3R6cN0KJoKmJQI59XMjBaknQKnZz5NeE=;
        b=sZLYQNOLIXn7ZjOsNorYZmmYRwL4R+usvK369rFEBFnvPdgEaEZk3D1f7JnEfGrmQM
         uDTBNDUAeAVqQcCWojW2gaiuk9HTf+3FF/fYDIEfEaOr0pKvYJDehnwN7OdxrURH5DY9
         6XAP4no+n5y3NoEj3zrxucv7bs0oLXnXeLUucXOKinRiqNnCDr3MrZ0naqXt06gdUYJV
         4oQ05uOUkgaz//SpcWbjIGz+47xhfjFJ/wPN9LynVTrfAUi2WIqJB34SW4xkD5KNApM1
         tvJCOYSPm/bp9Ytr8u6NSa9RC8rxgym9jMe4202ZkCIacAgmav2nc91tHU3NrAz+FUTw
         T6jA==
X-Forwarded-Encrypted: i=1; AJvYcCXTqsIvDk7d7rAQBC/ytVKWw6wXCTYuIhPGpf/caUoVggBa9CrOeDxetmN++hOYLmEKZCNBdMr2K1VgTAxg2S4Bg2STYFk=
X-Gm-Message-State: AOJu0YzTQlho/fNaL+9qKFCv+dEBSDoTtEFfenYNwblZkA6JHDcgIVNQ
	uGn4kLr6eSOYj1uTU0Oxv9HwyrSXIGH0cA7Qvqbl++L4Xv+5WAYa
X-Google-Smtp-Source: AGHT+IGuDw2evC4F6PvTbIamoMcNVw149vK0hJNtZu5/sqgt0ZQEGrCWXYyJox9BE24L7f9VJsNREA==
X-Received: by 2002:a17:90b:1241:b0:2c2:1d86:f785 with SMTP id 98e67ed59e1d1-2c21d86f8e4mr3703907a91.47.1717434151173;
        Mon, 03 Jun 2024 10:02:31 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c27e577fsm6460431a91.32.2024.06.03.10.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 10:02:30 -0700 (PDT)
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
Subject: [PATCH net v5 0/2] tcp/mptcp: count CLOSE-WAIT for CurrEstab
Date: Tue,  4 Jun 2024 01:02:15 +0800
Message-Id: <20240603170217.6243-1-kerneljasonxing@gmail.com>
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

v5
Link: https://lore.kernel.org/all/20240531091753.75930-1-kerneljasonxing@gmail.com/
1. add more detailed comment (Matthieu)

v4
Link: https://lore.kernel.org/all/20240530131308.59737-1-kerneljasonxing@gmail.com/
1. correct the Fixes: tag in patch [2/2]. (Eric)

Previous discussion
Link: https://lore.kernel.org/all/20240529033104.33882-1-kerneljasonxing@gmail.com/

Jason Xing (2):
  tcp: count CLOSE-WAIT sockets for TCP_MIB_CURRESTAB
  mptcp: count CLOSE-WAIT sockets for MPTCP_MIB_CURRESTAB

 net/ipv4/tcp.c       | 6 +++++-
 net/mptcp/protocol.c | 9 +++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.37.3

