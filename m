Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CA6168BC
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0qgLVq38"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so16113a12.0
        for <mptcp@lists.linux.dev>; Tue, 07 Nov 2023 09:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699376726; x=1699981526; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4px/2qMu4/WgMphU9I1ccL+GGJJvzbMFepSi2aInZM=;
        b=0qgLVq38lZIUE9Kg/sIv6ARTKWlJpf9UPDZhBOeYdjR+u6II040B1rcyz47REM8yuE
         BDVgaUzvaWCISa4j4iDiPaYC8YNEAc75Y26HXeaSmIJIlmlcXyKx6HvaMpTbU+J2xAaq
         9eUZJLeK0uIZmbgwD/ka+PHnyRAW39ietDkmfM0Dr0OkcXTzDR1xQCBJJZfWs/Hp/vWc
         D/Sjxgjm/jQkS6b0kzz3KigDFYxw7Isd9ml7UuTXpHPEFUM3aOshiZKhxr0ZyIbJpQ86
         eXeBmUi3KYbaj9wuEBETPuGSlhCH80y7DMS09KOm4RMbW6J0wSAFYqc4kc7C7qJsC/u1
         0z1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699376726; x=1699981526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4px/2qMu4/WgMphU9I1ccL+GGJJvzbMFepSi2aInZM=;
        b=R6ipb1BJho/0j7gEu3+6t88eyzFC2jQ8Bp0h49LYWu5xnMLwlIWex0w9CGGZQI5Gqt
         qWyra4IrGrUc17bTFwHA+xq8pk5ssQJhqfPK7OaOMhM5d8vowIF3IUMg+qS8zM+tMQDi
         NVpjBzDB+HvU3rVmOtb5NazfCPSk8LTsIELgwctzXmTZiV5O8rMVOkOAESjUq3ATUJl6
         bqHXeOfHxotlnnHvbBzWr549UAgxvfUzRC9iCATOmu3j+zW+90gmd3abnq+YeDtXjXKg
         Mi2EGsnkuc+UPMDNguL1wMTGa2kpHoCR4E2ZqVicNSr3umBlR/XVihrR7QnJyQDor3HD
         zSbA==
X-Gm-Message-State: AOJu0YzuKYjK9RcIH75aKXdeZOjagSz2fTvbwinIucA1Gh2igzj+eYYL
	EhOouGsCOUA4N17Ullm8DEB7qHmYAIYEJe0MvP946A==
X-Google-Smtp-Source: AGHT+IEofWxPwmMO+w5EoyfkmAyb2kjUXiLysK+HhcHsXQl1GBcQpUqFNmDJc2BSNqOmw+ybceyUrt0FGejEafQOW/s=
X-Received: by 2002:a05:6402:5002:b0:545:94c:862e with SMTP id
 p2-20020a056402500200b00545094c862emr20468eda.2.1699376725461; Tue, 07 Nov
 2023 09:05:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <c872b639f2c3c9b6b20ec46d3a109bde6ab7b5f5.1699376301.git.pabeni@redhat.com>
In-Reply-To: <c872b639f2c3c9b6b20ec46d3a109bde6ab7b5f5.1699376301.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 Nov 2023 18:05:10 +0100
Message-ID: <CANn89i+kGzeN=q2mrL7u6qnmJiMAsPYCq8TwHGvhmhA1EB1zmA@mail.gmail.com>
Subject: Re: [PATCH mptcp-net v2] mptcp: fix possible NULL pointer dereference
 on close
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 5:58=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> After the blamed commit below, the MPTCP release callback can
> dereference the first subflow pointer via __mptcp_set_connected()
> and send buffer auto-tuning. Such pointer is always expected to be
> valid, except at socket destruction time, when the first subflow is
> deleted and the pointer zeroed.
>
> If the connect event is handled by the release callback while the
> msk socket is finally released, MPTCP hits the following splat:
>
>
> To avoid sparkling unneeded conditionals, address the issue explicitly
> checking msk->first only in the critical place.
>
> Fixes: 8005184fd1ca ("mptcp: refactor sndbuf auto-tuning")
> Reported-by: syzbot+9dfbaedb6e6baca57a32@syzkaller.appspotmail.com
> Reported-by: Eric Dumazet <edumazet@google.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/454
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2: reword the changelog, to be hopefully more descriptive (Mat)

SGTM, thanks.

Reviewed-by: Eric Dumazet <edumazet@google.com>
