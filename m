Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327E53624BC
	for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122237; cv=none; b=tJoDSZISoLgMFdOkqPm+xEjI/UDiVByaKUM1fRBxblZwgPT57njgAE9oUMb+VUqc+mUhkn2RGYzv5IXEKC3zuhcUfnX4nLK0QVIbtmt5WcZ9BlmZ7Bs0OQkG6jNPqWkxjvgAXdjIOZyVyCLRX4H4LUf3e8A0JYfaMclQWsQmggQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122237; c=relaxed/simple;
	bh=0LzovFZdUcj9Hb84y6n3jMqUEC545rL6U9CKlP2XrpM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=E0M+29+uogyTufyvYRJ+9yyBCc8zRmzQZEiqWJnuVlJW3rXrlsflFgHqVvgDXbCBkvWyG3+aq7MxmGL0jsrAE4jyRChZDOk+QXJokRM3he0z4aD9FE0Hsr7BQ2pNbM8+RePcll3NnI/gMi7ctk6mjI+0eUfpfOAutkhG+Caj+Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bej76twK; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bej76twK"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8de2adc59d8so33948796d6.1
        for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 02:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782122235; x=1782727035; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oi35yps+4dje6y6erto9EXLm3QHCnhX/bqtSXjGwPCI=;
        b=Bej76twKM8g+9ZgbiYRPOMWXOcVnEkVXYHOjXJU+vF567jbvzvqXJGpr1wGmvkXaEy
         U78P/hhkosGlCAhDIVnmmyf9H1NVEtKK6aMsQAI6vMSVdS/pBp8oMPREEZ7mCI3Qeppf
         /imabyxikcu+RXIhZOnMH9wgwxcrrRI+i/soDie42Z8RT6UQ9j6zRq9YgIUm2/cYze9+
         QMRyeeE665i8k+3KvhMnoqJSzPs7tuaFqy3771BWdWk/g8VwRvLw7cVRRkw0LGYu/Qf2
         0bNo5OaxDK0ddU4Ah6OdMRlUzMUmhAvswwXDanY2G7Jrd+jdJ77kwa1nUQgA7F+EW3+N
         bFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782122235; x=1782727035;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oi35yps+4dje6y6erto9EXLm3QHCnhX/bqtSXjGwPCI=;
        b=LKL3xeonc5sEro4XvJSQoDc+cyKTg/JVQB7ls2CvrxVul9cOe8B6uw+51tT2t4QNFA
         jOJBFBdcac2W+GxvqSwvyg4WTCdv2MxffixSM//qFotZ/rOGswnx5Wfw5/An/dPGhFYM
         rsl8V07LM54ItjfttMlM9RgULOp0R/0dEIgjZqyqny6FAo5dgMRobOzpTysSyKRv6fnn
         8pWBklKLz+8/blteNelYRLhYQUz2ZiBONOfWP5R1pdYrKst+lXN46vFr8z4rLnZ7N0nq
         6Q/ib5hHxeFmuZHnBOcYuJr4Jyd3b0gJq2jP9uQJPjV2GZyKTrLy7yrIu9JOYIPX4Jlo
         Qm7g==
X-Gm-Message-State: AOJu0YxlK/BooAVCDUEVaruFeGgNX7HhnPs2oqCaybT8n4CHYW4SC648
	yP6u4A6oFJWOe4ET+s4zI7aM1S68vSrRimueOcNXQale/FyTQ8woV4o=
X-Gm-Gg: AfdE7cmAG2UY0341UOrGS1xA79Y+XWiZhcdRQFwSw8qGobq7FVaOVCtXb1CJfAVkv91
	2hgesWmNQCQ4UKgp4AL5Dlq4kYUV+nEVFXBvlNePLM7VH4P1LF+Hs5yCV+ucVOI8rPiOV5SNvW1
	rMlch8WUAbKV5rMxFFN7tWcWhR7+KTeWobFz6MHPj6SXpyFc44Ln37wkfIOY5UrFBaP0ih2UZVC
	kH6pP9h64BW8zQz3YafRYM8CoMgGFBZubZHvp0A7gSwYlVFI3rUhE44nzEIvTx9uIGsQrWhYKFw
	Pby9hTDsrh6pLlAh1pGT5Uj+qoNFWgPGanE3J/pZilv5vYrkpxxE81sqUhTyBSneMmhOhUyBBQA
	mI0nfYATF7cOr1MQbuG1rq1sfa3BJxBGw5F7kXzLhkq2J47O0397PfEUM+XlE+pmCpEKOX5x4vU
	vUyXpb2fla+3pDCIEDyDH2L4xfSg==
X-Received: by 2002:a05:6214:4010:b0:8db:480e:6944 with SMTP id 6a1803df08f44-8de4cd6fb8dmr204271036d6.26.1782122235284;
        Mon, 22 Jun 2026 02:57:15 -0700 (PDT)
Received: from [127.0.0.1] ([20.83.175.153])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df82c6459bsm89801446d6.46.2026.06.22.02.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 02:57:14 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260622092838.1267134-1-kalpan.jani@mpiricsoftware.com>
References: <20260622092838.1267134-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH net v4 0/2] mptcp: pm: fix stale ADD_ADDR entry on id 0
 removal
Message-ID: <40436d10-baeb-b1e2-0d03-3c58b8d89666@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 09:57:14 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/27944189360

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/27=
9ca4d41984
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1114633

Feel free to reply to this email if you cannot access =
logs, if you need
some support to fix the error, if this doesn't seem to be=
 caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
