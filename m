Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A9741836B
	for <mptcp@lists.linux.dev>; Mon,  7 Sep 2026 07:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788766905; cv=pass; b=FPcyhk4wxA7S13nyPoxu4AcZVFyeutQD4oYHj6O8UJARW9c0WxpZpWpFlcL19frm3jKOC3YkJH4Wy/MkwFfiejOvlcaNV7hkUugQaytH41sUHdmP/HnUF/tffTUr+dbK8tkInsL+Hmt2hZaQ01EsuuGtJmOMTYrZ+u6cOZGrBPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788766905; c=relaxed/simple;
	bh=QKjvgmeZzGEaOpz3gNTV5TQ4+j80gPA1r1+NsciZfkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIAOnX64UW/HhGZ57CZOdfTPcVHMO6yQGTyVWyxMTXiVK1LaSlagL3yO1BScqAxBMh3JKBDngmYignvvUVEhTpyb+I7BnH8gGfBtDPLaBVpSYYQXZD2i/Y84bPwImQzPGdlT0kGNb41FhxgzQ2EYA7E6AbvlsS33VM1uH8yRgQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=hjO/1xpb; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="hjO/1xpb"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3a20c95e412so27210561fa.1
        for <mptcp@lists.linux.dev>; Mon, 07 Sep 2026 00:41:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788766901; cv=none;
        d=google.com; s=arc-20260327;
        b=QpTPtrbj7s3p/H0+vsY76iNUSIxvnZSoURN/j5H1EubtbqXuHZ8ATeTe4P+klG2XA2
         Mti65wOJmUzOIprelu24vAYEHoey4z5aBchRJo3NHBlXm8F5FkGkV08ys16keRYpj5FP
         pfo9mPUl2BA4x2kA+OwnbXRghmTKY3yXXd95U3OacofEMoBSqiJTqFZg9uite8dWuHz7
         qY4rMk9gbguBYJKhooiVZMiifaHasmeExnQTU4auQ4quMp1V+XfrY/DDUDf8mgqkV8qa
         koiYpk5qC6hop1k5t24fGhvdLNnf6I2eg8fZCXWpNoCvs6qGHFKlz1D4ohIxcU8FZBg6
         Hxdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BH9WMir8rF2hqn5Htua6dfyRLLaHMRp/CMdHgEBBKQA=;
        fh=opwYxF3/lMySS1XwZZE1aCbgU8OfuG9b7Mb4HuJVPQA=;
        b=EHyiYEQGPk9aYaUPgzjzNXefGfBPSUAAdOIPEzSQJ/s5NUKBgsf3JSmTZORQkrp+zw
         7VwPY0GXusLM6Z2Ook6VMLuxqT1LTuD53TD0JEskOf3EgwkEJ8D7xNxnHPUlOS7iG7Dd
         k3RrYPgMZednzp+/hrjk9PFurAbY97VOlLBUEEwCuC1JXjqTQgF/CQRuKuksbXYNZ6Zx
         XjJC17j5kqj2pXYc+yI8Y7No1V90FELXFVCRDimPj1JFd2E1tw7h83mg8j49D+heBr/k
         hgO/7amzsdjQwz+ctEC56LKVQSWtrnMuIgUfnzpMGtxMey+dsvh/Cs0D3/+KajLpSL/t
         0s1g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788766901; x=1789371701; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BH9WMir8rF2hqn5Htua6dfyRLLaHMRp/CMdHgEBBKQA=;
        b=hjO/1xpbVJOS2+OyxjXB06kaz0YdNO5/iMR6DZZTU5Gdw086LWqyV20lnCczO2FLxc
         41tt0cswJ9rBvvgHy1wqXlew3Qe8GcyTJVtIPEZx3zayGrR3JOVPT4K+ubOMtwyOkRpY
         QltyWNtQOFcHYhaHh//4wiPDqpHQh7yZ1EwVTF9nRAtvjaW7zinJwMylpnFU32kYDBkf
         AVMnui/77gVRlQGKCw8Zgr2S4DP4Dk2iCTir23qxP8YnRlavKBbUdm65y5PisjrIyBl+
         ys2lnsTcrhiwVoJpio41jva0/MiqC8CIa0E/lw8Ya04/aExDMfcHAMUqZmlzWKfKBw+G
         9EiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788766901; x=1789371701;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BH9WMir8rF2hqn5Htua6dfyRLLaHMRp/CMdHgEBBKQA=;
        b=U+OcvCeZ3CfwpUG5d/L2tIcN7E9cDAW2DnmIzPrZjhnP32CJg0MmGaALcBU+9FdJiS
         DUglTtfYy1s1Pw8FdwO8CpCL3RXtF+qwv5CBu97DuwiVzYuB+AdC4rWuG250Le1BHqK8
         fjbTLq1MY1wy+rOXZ78JCQTPuzJx/8p9gQpY3aBeMPa6Ald2q4kj/kGa0grjDj9RD/i4
         uR60Eq06znRd6Nr93yySUYkHy21PTgbWrGSOX9WVpuBBGf2buKP414ipdNewVLYdVcY8
         9AdynDQY+g7mONi7tof8asxgKuxJy8vbG3Xdsm3rbj4qiN4eVIaTF3MUTknesMUJMWp+
         cGtg==
X-Forwarded-Encrypted: i=1; AKwUvBxmLt0ZXjFcsS0J3k1quHl4J7HoabG4HKM9bIod5fctHXMLuTiXodZhHpOISdWDrOI/q6I/lw==@lists.linux.dev
X-Gm-Message-State: AFuF++lZ1cix3rbXdrfWcIlBmIDbyh/pwuaGp+8vT9WFc1h8uChMVghG
	pC6Xdxn3VI40GsK7kb/TfIlaEPHSTbvKsfsZlaBJ7BNdLvwJjYq9eopcKgvGvxKiT9Ld4ohY4RO
	4Rd6+u/Yu70RpsmIuMTDI1Zw2LS9wg+04MDdj9yfwP6M=
X-Gm-Gg: AYBFou2GhXvbRkM9slvYJaMIghxJ8B1L6Uq/ZkXRZAfAKfH783UTIloY3mI2HNlKPDw
	LppPwFuymMqR57wMomOoIfnOoBf/jrEcMFTEtMA+VUGNUB4Saf7hUpOXWMyQOj4oNO+BmV7Hqof
	ZimCovPNIMcyEQZqYqB5XmAcD9nznosveSAj4HFI7t6MBhz/kqZwxsjIGeedMR+KAHmga/nEjVR
	8wnFg7wKxhtoBO9ik5CdEZCbGOun9UhI3PGozudJAafW4MiogSpsWYq6bfWPiTXRt5cKW8LkeSB
	OTjroQzbnBfHtUoedUiR/e9bUIzaJBX0DtoH683AJqeHhI+5pHb/s9VciSEvMDfeRPnlRHZvUYs
	=
X-Received: by 2002:a05:651c:15c1:20b0:3a2:fda9:34fd with SMTP id
 38308e7fff4ca-3a371bb4496mr14915881fa.9.1788766901322; Mon, 07 Sep 2026
 00:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cdc628415cf10721480a51ce14837f846ec778c2.1788248601.git.zihanx@nebusec.ai>
 <178875495405.219967.5594821749566554418@kernel.org> <CAANe3eRBOQud=bMgLnPbD_yUYUkJtT=GBqtY+GR0ZtU0_kbzhg@mail.gmail.com>
 <CANn89iLn+Xi9cEphy3nR4bGnFCownrWa9rTZ=AnijArDFo2O7Q@mail.gmail.com> <CAANe3eR=sQeTRNuewiqo0ZFwS6fk=HtxvT6TMGhq8F5Pqdxovg@mail.gmail.com>
In-Reply-To: <CAANe3eR=sQeTRNuewiqo0ZFwS6fk=HtxvT6TMGhq8F5Pqdxovg@mail.gmail.com>
From: zihan xi <zihanx@nebusec.ai>
Date: Mon, 7 Sep 2026 15:41:27 +0800
X-Gm-Features: AcwNN1VzGJxnqabKgTDT5QXQvwkk_pkpIGT7iWj3PbbALy5PgIuN8fmhJFOeJSY
Message-ID: <CAANe3eSbySUA=RreUvFxBaE4xFp5Ob1uapgFn86UYO4J8WuXzA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: diag: bound bucket lock hold in tcp_diag_dump()
To: Eric Dumazet <edumazet@google.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mptcp@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, 
	kuniyu@google.com, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, gnault@redhat.com, fw@strlen.de, stable@vger.kernel.org, 
	vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 3:15=E2=80=AFPM zihan xi <zihanx@nebusec.ai> wrote:
>
> On Mon, Sep 7, 2026 at 3:06=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > > - bind cursor UAF / dangling tb2: valid
> > > - unconditional sock_hold() on unpublished TIME_WAIT: valid
> > > - clearing s_num on cursor mismatch: valid
> > > - lockless cursor-membership checks: valid as a concern
> > > - commit message overstating bind/ehash fill-under-lock: valid
> > > - missing note that MPTCP needs the follow-up patch: valid as a
> > >   backport note
> > > - endless re-scan of the same bucket head: not valid as a
> > >   guaranteed livelock; duplicate output after a rejected cursor
> > >   is valid
> >
> > I just saw your patch today. This is absolutely insane.
> >
> > Please limit the complexity of a filter to something reasonable.
> > Absolutely no sane user is using a very complex filter.
> >
> > Same for UDP.
>
> Thanks for the feedback.
>
> We will drop the dump-cursor rewrite.
>
> A follow-up can cap inet_diag bytecode complexity in
> inet_diag_bc_audit() so TCP, UDP and MPTCP dumps share the same limit.
>
> Please let me know if that is the direction you want.

To be clear, this series is dropped. I will send the bytecode cap
as a new series.
