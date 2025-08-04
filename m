Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E74B19F11E
	for <mptcp@lists.linux.dev>; Mon,  4 Aug 2025 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754327399; cv=none; b=aIv8YZ7p6PNVLJWMMyTcAkRm+g2cGY8y5rVtYdGBC6e5nK0heZMkoIfy13kyCQZMvlcrl5vfWr6KAer+bzpelzsmthqyjpCCYDXKLhsXdxG5tb39I8gyuaQG9CIxw1oOfyq87vy2mFWbMauxuFA6MWfRScq24YKsI1LT5U7H7v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754327399; c=relaxed/simple;
	bh=lZaA4QHi0SNAzNMzHsrY3Z+EKPO0JgGPvF8UfaBP9o0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBmbqPX8ZGrckMEeK1IIx7EkuVPt2Qr3Ewyu9DFQm3ow7J8fmlJr/8vyLZTwo3MXB30OvaHBkNGckXWpGI3mAn1aftZKyH/xVLrZ86g0Rg3P77qZR5/ZlRyX9jpzeFP7mnAyYXQi76hNzB6VMLUgi9Qx5HPGqkwpvZKf4tYJc1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=FQjXc5JD; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="FQjXc5JD"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3323afe4804so30318891fa.0
        for <mptcp@lists.linux.dev>; Mon, 04 Aug 2025 10:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1754327394; x=1754932194; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ji+cx4N/5dIEraDJG6hTXM37c0HUiWz8JcxOq79jMkA=;
        b=FQjXc5JDUQJAieJHt1m2ibnZD8opkMbM8Ruy3r85ctOwvxjLluHWWuqFupI/+XXAkV
         W91aZ7fFoeTMYH/PT5vvCVQXJWAJLc70iE7iTC5UkqC78m97PNOc4HqDp1mVTUzjvNGM
         FxxUM30npa7RVTC8UkyfM+FTEdvG89I13M6Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754327394; x=1754932194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ji+cx4N/5dIEraDJG6hTXM37c0HUiWz8JcxOq79jMkA=;
        b=XuXZK9v553qVzhsn0Mm249DcUd79XRVy7iHnfU+VXrwx2DFI+CislAhkPJ/5Fwlcow
         l7D7jcjjuw6qDYUlzEVnagrS0X4V37FFxbUjX4gzs/qmDiwTF76EM9+6NltsXyFzo/fy
         iMqikLF9vUHCv2zaukk9BYEdbIPlY0y7n+8KLwa1kteB3+FKHl6BjEuMmO1Wq+FLtilQ
         hIczmwXokPM6gf3JnaPBmdYFnri9SOoQw+NHFpeOsSYCwoxgmNm6dznf0Y3WTitxssUf
         u86QgxchTH9QSHpFkA0sbB3lUQ5kEez/oliUrG6y+YwsXjudSS9QUpWRcz0pOud0gAas
         nRow==
X-Gm-Message-State: AOJu0Ywqeu1ptjjhHPkjYw1i1yrg2gnz0j13MFGc55pUbC7/m9AOsaxc
	Uk+atSmkMp5zfTFAvHMlanRS4PK84PnlNjPzjV51wOwHOA00woBABnurR+BkAYrb1+7miCnGACc
	mhIlbIh+2wYNV2Qz3KQq+9rgsFBdY61DvVgV0wqIpzA==
X-Gm-Gg: ASbGncvXaOqK61PtMUl+Wo/juXbxfyUcHjjZNeHTvR75IUHXTnPcdA2VVPAKDl8n5DX
	mOKjMjTQyw1r3Da/WQViOkl65flPrebxebUYVNSQHARUfKF6t+NqjMVgUzRp0ZHB+GHKT0gPj0L
	dVt5xCZhv+U4j9HERkyoziaTL6+O+ajMsvaQHTf65zP3VRfYQqXyWHv8UXQkdL4LEwsA3YaUGVp
	GoFr9cJ
X-Google-Smtp-Source: AGHT+IGREXf+Ap9+X5AaCTSg5Jcg11pOdFbCsjWoBL/V65UoVr98yM1jC8XRj6/j8oBVjNBphBnTesnLGEpj6plUYFU=
X-Received: by 2002:a05:651c:2220:b0:32a:778d:be86 with SMTP id
 38308e7fff4ca-33256810cf8mr24656411fa.31.1754327394167; Mon, 04 Aug 2025
 10:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250802-b4-mptcp_setsockopt-v1-0-50d4905a4c2b@openai.com>
 <20250802-b4-mptcp_setsockopt-v1-2-50d4905a4c2b@openai.com>
 <fec77e23-020c-4bdb-b937-df11685dd6ca@kernel.org> <690613e8-e926-4ed9-b8d4-9f214bc0997c@kernel.org>
In-Reply-To: <690613e8-e926-4ed9-b8d4-9f214bc0997c@kernel.org>
From: Christoph Paasch <cpaasch@openai.com>
Date: Mon, 4 Aug 2025 10:09:43 -0700
X-Gm-Features: Ac12FXyDHycxWwH_6M3l0l3_HExQld-hBqxkToCVWyxsyecK_38JPht9t4EB_Sk
Message-ID: <CADg4-L9_eBkZZv2mpNzTbjyqEgEE=7AWsoNqvZfK0ZMo9t3vtA@mail.gmail.com>
Subject: Re: [PATCH mptcp-next 2/2] selftests: Add tests for SO_MAX_PACING_RATE
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 5:11=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> On 03/08/2025 14:04, Matthieu Baerts wrote:
> > Hi Christoph,
> >
> > On 03/08/2025 01:52, Christoph Paasch via B4 Relay wrote:
> >> From: Christoph Paasch <cpaasch@openai.com>
> >>
> >> Add a test to check the API for SO_MAX_PACING_RATE in MPTCP.
> >
> > This test only checks if some values can be set or not, but most of tha=
t
> > is checked by the code in net/core/sock.c, not really related to MPTCP.
> > Do you think it is worth it?
> >
> > Could we eventually have a test checking the expected rate when using
> > multiple subflows? Or would it be too complex? I guess not something
> > easy to do with Packetdrill, right?
>
> Also, when I do a "make" in the selftests, I get this, not sure why:
>
> > # make
> >   CC       mptcp_sockopt
> > mptcp_sockopt.c: In function 'test_so_max_pacing_rate':
> > mptcp_sockopt.c:791:32: warning: ignoring return value of 'asprintf' de=
clared with attribute 'warn_unused_result' [-Wunused-result]
> >   791 |                         (void) asprintf(&msg, "setsockopt SO_MA=
X_PACING_RATE to %lu", in);
> >       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~
> > mptcp_sockopt.c:800:31: warning: ignoring return value of 'asprintf' de=
clared with attribute 'warn_unused_result' [-Wunused-result]
> >   800 |                         (void)asprintf(&msg, "getsockopt SO_MAX=
_PACING_RATE expected %lu", in);
> >       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Argh - sorry about that.

Christoph
