Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA01199FD0
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947218; cv=none; b=EkFq4Tqp0nf6WWb8pg2jqmiHip9e1KYNEanf9uEInZi7STI24E4gcFBpFrsRHgl1Sa29YWCwhd/6oc7Qt+xeH5xE6Lim81u70f5TFjI9JJmeA/0rZ9IsdLuOKBvn+6VHbM5dyttJWYjiELJcI6V718OQ1KsJfZn2taqAgdcwPLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947218; c=relaxed/simple;
	bh=mu4qagGJN6FxX6LV8CsL3UN+YeIhrQ3BOxn2WE6b2Ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxDKH06apJ2oOY5gnEliCEepYenznuXMjARWYCDcEnKY+Eg9qlPkXnUnF8cHhx8pP4nP4cmSVXImWCG8QJtW0p6HKBVuxFP5/XzvRrFoiRz5VkxZFffT/PUKfzzaC+THk9OQkCkj67kbbsOD3NuQj6OwS4HqsgCTKlM3hDxz8cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aTepjp3r; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aTepjp3r"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3e6f6cf69so6327265a12.1
        for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 01:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734947214; x=1735552014; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mu4qagGJN6FxX6LV8CsL3UN+YeIhrQ3BOxn2WE6b2Ps=;
        b=aTepjp3r2mjrl5yYzng6iTIrnrlTHd3JwdQQobDtWTSom3urCjzURUqUjpn9zqtvyw
         qoYQEpoz8darVDbBW6eRHzPrmCbhVNash+q3uKs1WI7TYmNbKUDSc4qNydIub+3Bfk/m
         ab3kF7etuScb99j4Kf2l0b/HY/rAyD6Von0abgkFfecvPpprbpxnVQsDPj4AedBCKHnr
         Ew1xk7xFBCj86sLD2AHYR0iD91LHAIReRFIbshJzs42Kz9JGlQRgUmbJonD8vKJTI/9r
         Le7+bcC0sQJYCUHQWNpiXC+0UKf1nWecZfDGqyiHjBqTJhmR69/QyEPT9rUce1u6ee7F
         Qr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947214; x=1735552014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mu4qagGJN6FxX6LV8CsL3UN+YeIhrQ3BOxn2WE6b2Ps=;
        b=tJw26u7GASpBJ4lYBZBU9Yh+UCgzPl6JWvioVrw/vcvnIRho6tLl2D9xzGbmQKhrmH
         PYyMk3so0FMnB+NYYaxrp5vqwf0lwiodaRLFB8iXhNdr58yeZSxmiXO+qLIw+sUnkZ2Y
         IOADk+L5uQQ8/wPVeQKqKvYxkA7yKKkefJNhdUmcaM+5E1+Zanxcq5JUpHjvY9B1r3Z/
         ZJpR96TQXZlpx7O2yMbMvnT48Y2Gh6UItMUgl8unIyP9z3k+x+FdruQmySKg6tCnQT+J
         6td7bNDcdMscI+qhingcD8FTh2aysx3w5d4lyl/Ot2xg5f1TUMr1uyftQjdDI4ytd7PD
         0Y9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnr1j7n2gaOD7XNQHGGityuiZSLSepeQiQMA1t/p++jMBplj06rHqEo8APF9GQ1R3ULGNDEg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxi8vXFQNAfBodK2THcbEI7YxCPJWkvygn4LUtAsq0VLQ6qUYZF
	N2ISjnMXq+hpVlW+MtdzvgOHTjjuW/wzpI4w4IDBsOToVpgFCDAcqFSAFLppgsmRzpxw7exUa2U
	oJZWqlQDkZ/GePbI5sImSy9Zh3/HI7zhe4RSH
X-Gm-Gg: ASbGncskR0oGMyYD9kkOgJDaxeXogNB+/8S3jqopzIyUXiwJpcDx9y5HV+zFDMgNIi4
	ZDp0n+u0OJneece0tvkReLggzCqTC4mXwDr+6FKI=
X-Google-Smtp-Source: AGHT+IH3+egfWLTE78YKlmwPqtWef5YTuB2kERtTaCX1dCwBHcNtCa+1pJDYxvd4T1CwOvzn7Bqjqihb96SfUcymHm0=
X-Received: by 2002:a05:6402:270d:b0:5d0:bcdd:ffa8 with SMTP id
 4fb4d7f45d1cf-5d81dd83b92mr9613064a12.1.1734947214306; Mon, 23 Dec 2024
 01:46:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <025d9df8cde3c9a557befc47e9bc08fbbe3476e5.1734771049.git.pabeni@redhat.com>
 <047cb3ef-f0c0-43e4-82e9-dc0073c8b953@kernel.org>
In-Reply-To: <047cb3ef-f0c0-43e4-82e9-dc0073c8b953@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Dec 2024 10:46:43 +0100
Message-ID: <CANn89iKU8TwoiZHPwdEAy2w=RhmbDci3n6Wux=oM1YzrkfdzpQ@mail.gmail.com>
Subject: Re: [PATCH net] mptcp: fix TCP options overflow.
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	mptcp@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 21, 2024 at 11:28=E2=80=AFAM Matthieu Baerts <matttbe@kernel.or=
g> wrote:
>
> Hi Paolo,
>
> On 21/12/2024 09:51, Paolo Abeni wrote:
> > Syzbot reported the following splat:
>
> (...)
>
> > Eric noted a probable shinfo->nr_frags corruption, which indeed
> > occurs.
> >
> > The root cause is a buggy MPTCP option len computation in some
> > circumstances: the ADD_ADDR option should be mutually exclusive
> > with DSS since the blamed commit.
> >
> > Still, mptcp_established_options_add_addr() tries to set the
> > relevant info in mptcp_out_options, if the remaining space is
> > large enough even when DSS is present.
> >
> > Since the ADD_ADDR infos and the DSS share the same union
> > fields, adding first corrupts the latter. In the worst-case
> > scenario, such corruption increases the DSS binary layout,
> > exceeding the computed length and possibly overwriting the
> > skb shared info.
> >
> > Address the issue by enforcing mutual exclusion in
> > mptcp_established_options_add_addr(), too.
>
> Thank you for the investigation and the fix, it looks good to me:
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
> > Reported-by: syzbot+38a095a81f30d82884c1@syzkaller.appspotmail.com
>
> If you don't mind, can you please add these two tags when applying the
> patches to help to track the backports?
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/538
> Cc: stable@vger.kernel.org
>

Thanks for the fix !

Reviewed-by: Eric Dumazet <edumazet@google.com>
