Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8561829CEF
	for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 23:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713482859; cv=none; b=IyT7qcS3Dsnm2nsEaxFoRl4DnkC8Wru171/odSR9uVOCKrH9gD6gczIYKFDUs1KwQzXXCzywphKgiHlwmaRF+LABEBcXhWlen989OdzhfKdjdL1VCEPhombqaTjeys8CDD3nXolQNkv8oCySHYsZRD8P0eSiFLDunTUhr4sWZRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713482859; c=relaxed/simple;
	bh=xizDYZulULm1cor7kU1CBg+oGHqLt4pe1urWfkCgvDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hq2z5GvNfmXDBKMYGhn1pfAdi/Cfeq5E7pPqaeJC/h8W6xFS+PVk1lzvd92hNqK35eUTwL05pWcYXrPHdL+WAmYC9c9XTjXDe4qBZw4SF9kuPRm2DW8zUU8OL2sWSp0Dhayz8EG8GbXlLUDeSVYhg98s4N/1WwSTEerbD0Z4Fyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hvu+0XiC; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hvu+0XiC"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34782453ffdso1374544f8f.1
        for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 16:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713482856; x=1714087656; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xizDYZulULm1cor7kU1CBg+oGHqLt4pe1urWfkCgvDo=;
        b=Hvu+0XiCsG8C9ZMnAZiUTnMLyWipqlqKp/eUY/YE1DUbDM42KWwRCKpfTNiUpszUxA
         aOuUZKeu310J85+Iih88WzStF6crO3/r9/DsRMWvdtTg6y7K3we4OLgoMGR+trItfB4G
         XiuSyKdcmOcFZyhKfS9wzm0WomeD8U231P3s/rU7yBO2M3i1Ikd+no5ZBnmF+nIDU1w1
         s4pzrXZ0t/3SQSyUaFQEXY/O3xBBkWmQBlsYLSXwJAeakPvPoXff7k4lsnp5qxYYmvsN
         immFodaVsnQ5IIAF76YF1BHi+a4lNIMA9D8yP9PO+aUQ/YGotsY68mbzWccA9F3Bll9c
         nRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713482856; x=1714087656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xizDYZulULm1cor7kU1CBg+oGHqLt4pe1urWfkCgvDo=;
        b=q8cODGr95ZKxFG47EUjYEJ2Knwvm2A4PoDzCVb2AGvK4gkEqGWYeMarMrW/0QvTgK5
         ZuxRQzSrAxr01LDS1XHP8n6zcG8t2ANhx+SV+yCpMbqrsdmEWXGtGU2bliKXXiHoxxWk
         4jJnu8lGPWspVjaYezPykI4I91TtSDBkOMS76VOmqoe0uRn6/KD2QsN6Q7Ms0u9PcHaQ
         poSvzwba1CUmoTtvX8c4/CsN8GnVX6MY/LU7h6xYOk1iGdlK7/4OSY6k+FEi7RsNSZCO
         JnHW9uE25P8JmDFgUygThTmwCIPOdjC1yILP3OsVHxSUerlpbYvGnRIKsbCOcC78lgI6
         IDUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7QCGVwAJQLyK1+soLHUhsvRmmHNKV0DDz0W7sV/2ChmUUzWn3s0Izt8YnFhkln2Q0/MMOg0DCodVHLVij+F+VaoOLYeQ=
X-Gm-Message-State: AOJu0YxmQUIBSNNfucPaLeLe2c/6Kvders7nhgzZgGzx0O3l4U+Y2uUU
	DEO7PrfZc99gSKhFZAsxUC/BLrOtdY9GULRL8g0SsMy7jPLu2sO4OqRy2ZUIblmfGNR0ACHg1RW
	05L9QIuGK1CoN3lXYHxI9y7BZJH8=
X-Google-Smtp-Source: AGHT+IGx1cA9bIs5ny5tYrBbOqozFvluuDaWI9b5II0BFVbz7OLtPuXGmvlvVRvsL1YUhwViEmwaAfmQH3671sqJBLo=
X-Received: by 2002:a5d:522d:0:b0:34a:d2a:5905 with SMTP id
 i13-20020a5d522d000000b0034a0d2a5905mr261746wra.31.1713482855640; Thu, 18 Apr
 2024 16:27:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
 <CAL+tcoDJZe9pxjmVfgnq8z_sp6Zqe-jhWqoRnyuNwKXuPLGzVQ@mail.gmail.com>
 <20240418084646.68713c42@kernel.org> <CAL+tcoD4hyfBz4LrOOh6q6OO=6G7zpdXBQgR2k4rH3FwXsY3XA@mail.gmail.com>
 <CANn89iJ4pW7OFQ59RRHMimdYdN9PZ=D+vEq0je877s0ijH=xeg@mail.gmail.com>
In-Reply-To: <CANn89iJ4pW7OFQ59RRHMimdYdN9PZ=D+vEq0je877s0ijH=xeg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 19 Apr 2024 07:26:58 +0800
Message-ID: <CAL+tcoBV77KmL8_d1PTk8muA6Gg3hPYb99BpAXD9W1RcFsg7Bw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/7] Implement reset reason mechanism to detect
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, dsahern@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, atenart@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"

> When I said "If you feel the need to put them in a special group, this
> is fine by me.",
> this was really about partitioning the existing enum into groups, if
> you prefer having a group of 'RES reasons'

Are you suggesting copying what we need from enum skb_drop_reason{} to
enum sk_rst_reason{}? Why not reusing them directly. I have no idea
what the side effect of cast conversion itself is?

If __not__ doing so (copying reasons one by one), for passive rests,
we can totally rely on the drop reason, which means if we implement
more reasons for skb drop happening in reset cases, we don't need to
handle reset cases over and over again (like adding rst reasons just
after newly added drop reasons if without cast conversions). It's
easier to maintain the reset reason part if we can apply the current
patch series.

Thank you.
