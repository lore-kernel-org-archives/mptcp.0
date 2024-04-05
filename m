Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C42010949
	for <mptcp@lists.linux.dev>; Fri,  5 Apr 2024 02:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712284773; cv=none; b=PUsl5L4ms+a3eqxy5KX53K2vWNWIAfCjmHcRh7CPrwd3NTq7Inl8UL7GEsz3m95m8Y2vuMEoUiTJe2uDwhaPhyOY9OJyq6W0Y8eqHPCxWs3DbqBt04GYTAG5SKJpkSLOO6A+GVxsNvhEh02qWp6/t/y6g+LLkyPNmP0aF+dbTLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712284773; c=relaxed/simple;
	bh=yCrgtIEyJaXtaIIO80fltYjSfsjjoKuT7F4mKQ+FKKc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mzLXZquoqKCeb9IIG7XWAQAxhUeJlzHZ5GaJ7MLyGVajBYMYWTYqaLCBq0VYbqapyjfidXpCZeJGvd0tWGokxUe64XZU4L4nL5Q+MHeUP2lcWTCDiAWtaihJypdbBJhxNdly1PkcjLml45C1kLXLTopPQtrPz2MXnlAi54DS9MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfBGRANG; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfBGRANG"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e67d42422aso1055312a34.0
        for <mptcp@lists.linux.dev>; Thu, 04 Apr 2024 19:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712284770; x=1712889570; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ru6gzWZMnxJpSoX+oWtJXQs1aqt/q+okaky3Vgyasnk=;
        b=JfBGRANGadGmjX9YKbkDkUIg1cq6uAGpOsnlIN6vjFj7qg4XVMn7OvsxI4mw0fywud
         NEI/SEZsLbIVUXg5WsdWCFQLym724O0qkeTAI0Yl/ZDOiZNPBnVM/pk5hpy7SMvrytzf
         2dlRY9ZmZOkFmnjXzFNUFDsFrV5XME6Aahb6td8geWzL8B6yzB3JYeqTEF5MIkvef1vh
         lsHWYV/kKl/4bdjEO8VJOEaZ+qXxAZGqmWcEJHV4AT2gPpHQXgv7cnE7jI4zAG4fjvAd
         7F7COIuiQMcKFBI1d6Ca8NmQIjJrtJVqhv8nKm0J2oc602Byiic13geeDoken070HFrO
         GjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712284770; x=1712889570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ru6gzWZMnxJpSoX+oWtJXQs1aqt/q+okaky3Vgyasnk=;
        b=YNJLLUhMJ6XlhSnDKaFQgdoWURZs8eoaHUwE+hPCEOxRJFqI7NXLuVtzVGttieNGrQ
         aOI8KNBBC1vVMJOt5mp7c073FXhMnbbX5UhDmkKiVh6vTG3LmpQEfBQfGrj94SQAEJLx
         Occ9QZITcpFVlaIx/dPtr3MyctF8TX/APa52PDuEaoWk9rrMqNjCTvmLMoPBDG2uP3/I
         dnqiWoMiVBKXDt0SG4y4Y40wsrUPYcn7CoqRP3mRPUecqGjoxuvt2YI/zIG8trxXZS+v
         Y9+2fNccoM5zd+l9Ep4LuKLdMtY6lB54h5kO/UegmOuFSf0q0ixflHAK0jsD7VMjJoGj
         eUhg==
X-Gm-Message-State: AOJu0YxVDHhN5Vhb5s2Q7EVwNZrz0nc+Los7PvLj8tEcTEv7sT9jFyoK
	EkETMs5J6ticOR96NIarSbKgaVuDkNPb/WdKIYwurngqDxGkT79T
X-Google-Smtp-Source: AGHT+IEi5eNI/vjTMu+2orLSL75cx2jVOhRKt1mlpryze+uU3jxlB9BUvsiYH4ZfXhti36YHx5oiGg==
X-Received: by 2002:a05:6871:80b:b0:22e:15d2:6773 with SMTP id q11-20020a056871080b00b0022e15d26773mr280798oap.32.1712284770467;
        Thu, 04 Apr 2024 19:39:30 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.7])
        by smtp.gmail.com with ESMTPSA id g27-20020a63565b000000b005d8b89bbf20sm366494pgm.63.2024.04.04.19.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 19:39:29 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/2] mptcp: add reset reasons in skb in more cases
Date: Fri,  5 Apr 2024 10:39:12 +0800
Message-Id: <20240405023914.54872-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The first patch only removes the check while the second adds reasons into
some places.

Jason Xing (2):
  mptcp: don't need to check SKB_EXT_MPTCP in mptcp_reset_option()
  mptcp: add reset reason options in some places

 include/net/mptcp.h |  5 +----
 net/mptcp/subflow.c | 21 ++++++++++++++++++---
 2 files changed, 19 insertions(+), 7 deletions(-)

-- 
2.37.3

