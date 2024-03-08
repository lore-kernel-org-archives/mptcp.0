Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7CE5576D
	for <mptcp@lists.linux.dev>; Fri,  8 Mar 2024 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709897113; cv=none; b=res9HqAmoy7Io+6HJcTX+EmeGC45j1+Ov4o4Atdu+7MC2X5PH4r+y7Tas5KV/+96UjGJVHo8apCBZdf/QyxjQDqWfHzHSaOFnfmCvKFGFAFug+HEgc5c+oK9J3Bdh7eRUB6bwiIjXEhADtM24o3BQ+v6O8ehftHZasUIXRU8gXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709897113; c=relaxed/simple;
	bh=GchYU3sRLCHl43EyLRrMwa916/Hymv0L6LEevBMhOfE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nED82FFXTyDmHRzJeNyWjsG8Z6BpoCvZJXsoN9BZxGin3mz/66MDSArqirJyLzqkP5yOeLxncLLzi00lWyJRzIA7qnehjXENcE4g63mRAMJoidPcDB4vGreWtB7NePq3wNqYZQvqLjbdvrWuprJfpZfWsEXoW1tfDK0b8BlnCjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaCmS1TC; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaCmS1TC"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e6277f72d8so1514202b3a.1
        for <mptcp@lists.linux.dev>; Fri, 08 Mar 2024 03:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709897111; x=1710501911; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/5JAH19+ljGA+cfTwCom50gS25UogX7DRM80TIVzLZI=;
        b=WaCmS1TCQ364QAhKx+43Yd1vaJiiXRkQa0/UhfyvCHUppIl0U9GiA++6c25cBsnlGD
         OgosnWCn7YhSqtPxbncmSGAmEjRMJumFS/L8lYY4M3SjG9a4F3CvCnB6RUAJWu/wfUjW
         xEUCUxMUGix45y0rTxEcmx0WI2g3uGoMD5rA2vKur96vId8wD5/BHr2K6Lcns1WyiSpH
         49j0RvMA30m3p+e7k2UjTUYPUid0mWmjU9WruAMrVzq5EjH7ZKAT10eSMlcOYFUWaGjK
         51eZ+w3+41YH3ACf9nD1wjLmuto/3RhidNZlJ11W8xns67zUfFfLMGqvNfbj8ThwWGIF
         95Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709897111; x=1710501911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/5JAH19+ljGA+cfTwCom50gS25UogX7DRM80TIVzLZI=;
        b=xKzznBi6S7F6LwPQEB3J/T5SLB4YZQjiILMfOtUwtN19R54GlPZoZ4SIHKYHMw364N
         nM+odSa8d7Ti1mP9go8T/Af6DV8F04dIlMuLsfQntS8O9eb0W9BnjlEEYNf8DKP+S2dE
         d7MTt1sNopquTHP2+ddxq9S+puTthUcj5uRIC9S3MJPm3iyYnuJ58Dg1zvxqEStw7ow4
         /tvqWZgFfYv7/brXe+rboF8+pFeKoD3frBKW65QCyFj6HiN7gACnaFb5xmunLJPAiAjs
         CKUhEgCRffnEfjS25YTsBQwhZQl0Wh5IaMoOG17u98UYflbiNAootv5BE/aCZsQ/dlIv
         EMxw==
X-Gm-Message-State: AOJu0YytbKybbrc485V1KqthPgGGcK2oj06VDYDLGVzudEzs7qQAZtGO
	ueI0n6b2swHa0ZTquoLmJYwkIXoywpoxHFX6FguOp2WSu3svpBlZ
X-Google-Smtp-Source: AGHT+IHyZKgizh2iozs39rZZNpRM0lghUJVjbwikv1GZSkD0PwOuY/LYlvZhhnIDbP20QhcVqyvRfQ==
X-Received: by 2002:a05:6a21:3a83:b0:1a1:8014:930 with SMTP id zv3-20020a056a213a8300b001a180140930mr2430861pzb.57.1709897110943;
        Fri, 08 Mar 2024 03:25:10 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090311c700b001db608b54a9sm16049806plh.23.2024.03.08.03.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:25:10 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/2] annotate data-races around sysctl_tcp_wmem[0]
Date: Fri,  8 Mar 2024 19:25:02 +0800
Message-Id: <20240308112504.29099-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Adding simple READ_ONCE() can avoid reading the sysctl knob meanwhile
someone is trying to change it.

Jason Xing (2):
  mptcp: annotate a data-race around sysctl_tcp_wmem[0]
  tcp: annotate a data-race around sysctl_tcp_wmem[0]

 net/ipv4/tcp.c       | 2 +-
 net/mptcp/protocol.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.37.3

