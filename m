Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B467FBA0
	for <mptcp@lists.linux.dev>; Fri, 31 May 2024 06:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717137419; cv=none; b=raFn0LBPaYssfKV88OKV1xwJgprLlcCN91IEvjGflnE3tPSfZnCW2/wwn6pMBhK7Q/bjhi/dpkgR9xDkFQ59vCy81of/tcwtT+pmOFh6JfxdIop+hxM4kUqSnOiaAq4x8k1+0GPoVm2u85c6gcPt+IQ//Tl2SDE+N5WuPVr8e0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717137419; c=relaxed/simple;
	bh=CGpTk4lbXH8qLs2ecxKmg9BxLyqP5LmNkGHvwWalhmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gcnBrXVNRW+gP7LtlsiicrhurGuAUCMdKWVK+MyeffDhuP5ecEVsf8YKNguG3GUO7v3xqFsppiYiIZCUjdCosj6OMbRQeWhLs5dNGBzEja46/STxpeQNT9euikrN6btLqcytG+9MRzTgqBcK8tJs1/Pdw/Ijfqz4Um3JxKpxriA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c73HWLmw; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c73HWLmw"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5785f861868so1987903a12.2
        for <mptcp@lists.linux.dev>; Thu, 30 May 2024 23:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717137416; x=1717742216; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6r2uf5/4nHBYjMlsc8P9luDNgjde4ePUQQK33xJhjw=;
        b=c73HWLmwbZ7U8IDXm02SjVOdqQPWn+poqtOf5rk4b54xZEQs0/dVKqn4yjYsdvT2Tj
         RazS2WBMbyvzKeBsPC+0DshJRALNkCItyS5QAOVLwv44ZGQ3RvK8gCmg9F/rqgf+WuYB
         iy81E1GIJexvQGHjLGoj+PGMF0DjJ7eEl4p7lf+9lVzhd7igWBzEBP+5yaxqK30xJQA3
         EEp9G2xhaaQWosYZO79xIoZ/k27G7MvF30x32xC3wHmlirJ7ynFrgvs6DGelVeQQdlQ4
         l2NQ84HojOWhrhH7y2wOv0Ns+8a2vfKS/UPGyBFHofufhV7kTAAYVhWIsQzEXSY1h0we
         UZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717137416; x=1717742216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6r2uf5/4nHBYjMlsc8P9luDNgjde4ePUQQK33xJhjw=;
        b=Z60INDaQVTP//lyxODoE8kOv/GYLS3HLmFLnLSgtTt/9+YlHHOzG2UIuyBvljZz/j1
         /gQhxpiVqRm1fgTw1mZksFqPVhEfNCJ4/aO08tksVgidKhKOYOArWc45BUoKaGcPAVHS
         7Q0WQJiq0BWQ9jjg6ZIDtsqK+8+uQcmPlTyBiTCS/BNbvONTTaYffMwAIEKRU0oABP98
         XCMWXGzteqPExwsDED8URRGodt+YLg2sOQ0+SlXhJsjonXKGaWtyjLFt502WNq//RoGr
         norxHQ5D0xeG2oTjvBcW5ihECsCQMNgGWcJdVbafwelzeY2jZ/bSw8NaEG6c6ECHduCo
         PWng==
X-Forwarded-Encrypted: i=1; AJvYcCXm76voUoxUXQVoleOj+QChgMK7wA/0srm1ePCdtmdhGn+BiisP6HPJRHLy0ueOUxQO9NkPiGi0fj3DbU0+FHto1ZJlDdQ=
X-Gm-Message-State: AOJu0Yy+NQEntw1Tvwms4fusVT92WAeHw4nLWfQ4wLHXVGoFNYK+7SJf
	i2fy5xgho5Xu1+8FJiAubObOwjzLbVN+HSAOQ4fiU7XkzJzyAjVsB3NuItCy6T5PEIOtPtX2pO0
	wfJUMl3XIWbNKTBq35RT3wCRY0rI=
X-Google-Smtp-Source: AGHT+IF3TqofeKKDWS2kZfv9Xp+UxYFNQUxCNGYM0ylUoRTAMWf1KKuY6tNdQqDvUZbbK+LrIbYs0QeJgYFqWPL+ubo=
X-Received: by 2002:a17:907:c92a:b0:a66:197f:a47 with SMTP id
 a640c23a62f3a-a681c8d9e9amr57031066b.0.1717137415381; Thu, 30 May 2024
 23:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240530131308.59737-1-kerneljasonxing@gmail.com>
 <20240530131308.59737-3-kerneljasonxing@gmail.com> <CANn89iJZo2R3eOVvWpo3-5aoMaaEtzxH90H0iv0FQXPUz7aJyg@mail.gmail.com>
In-Reply-To: <CANn89iJZo2R3eOVvWpo3-5aoMaaEtzxH90H0iv0FQXPUz7aJyg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 31 May 2024 14:36:16 +0800
Message-ID: <CAL+tcoBHT+BegR2jyohdg8ENP4xN5vYF+0YbWUQV_3ioyKT2uQ@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] mptcp: count CLOSE-WAIT sockets for MPTCP_MIB_CURRESTAB
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 2:26=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, May 30, 2024 at 3:13=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Like previous patch does in TCP, we need to adhere to RFC 1213:
> >
> >   "tcpCurrEstab OBJECT-TYPE
> >    ...
> >    The number of TCP connections for which the current state
> >    is either ESTABLISHED or CLOSE- WAIT."
> >
> > So let's consider CLOSE-WAIT sockets.
> >
> > The logic of counting
> > When we increment the counter?
> > a) Only if we change the state to ESTABLISHED.
> >
> > When we decrement the counter?
> > a) if the socket leaves ESTABLISHED and will never go into CLOSE-WAIT,
> > say, on the client side, changing from ESTABLISHED to FIN-WAIT-1.
> > b) if the socket leaves CLOSE-WAIT, say, on the server side, changing
> > from CLOSE-WAIT to LAST-ACK.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>
> MPTCP was not part of linux at that time.

Oh, right, thank you.

It should be:
Fixes: d9cd27b8cd19 ("mptcp: add CurrEstab MIB counter support")

I'll fix it soon.

Thanks,
Jason
