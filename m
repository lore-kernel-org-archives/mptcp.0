Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EA71537A9
	for <mptcp@lists.linux.dev>; Fri,  2 Aug 2024 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722621158; cv=none; b=kJEMCJVvo7MZxd6xM3nsaQcJGIoK4tVq7xSNPSenuwzlAR/iCyXRTg+mk2R26D6xSEgzVlC7hXjZp15QvReHUHn42LR/RTGGHiMov0w4HmCnwc5ow/lJBYEbX3SwosC4WwmOaA6VbeEOfojNxu4JIiZRYklcL+VYePFu63aY0Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722621158; c=relaxed/simple;
	bh=pbg6mBhx/Yd1jZSe8IeKUJt/mWyDRtQD2aYkzQTDmiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uW5q2Rt3pWxPUSBUInKHq9Lzc3cRih7LtCa3k7Y1YwZEFxnD7+kd9SF4xwE7Xt388opQZGveI2t2nu/Fxgnbovpxpe691JeN+O15WV+/41QZnGq4B7bw63JgwMsCpmwOiWl1SZuLtLor4O/H+VE5wM5huH1H/Irx1opHwmMpZps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpqB0NBt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpqB0NBt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7F0C32782
	for <mptcp@lists.linux.dev>; Fri,  2 Aug 2024 17:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722621157;
	bh=pbg6mBhx/Yd1jZSe8IeKUJt/mWyDRtQD2aYkzQTDmiI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZpqB0NBtT/s9onTHPFluCX+CW5k9s2wIG/9KKyFiiUVvYreaeSNCqKg3UOcBIQsE9
	 9zKyi1Nl4S40gvRBB9o8g+XR/rbomDRnp6fSid3ZJqHPX/SGc7kJ5WCn1Snrlb22Ul
	 o1vuA/BI/pNFW3arIiAjxmX8qEG4kWj6O7j9OMsT4a5r4ma9CCzlnnFF0u88rNOwb8
	 +dfih0Mfd2t4L40bZUSqX9mj98uOfRVsfqaAjU0OdJszhR4JV6F6vc7RrPjSE0r+yR
	 oOLYMX7xcDYisKepOMSjMcHZVM4ZYw4DyVTpu2FHQPW7xxj5WA/CBzQj9T5a8fSC51
	 J0CfV/cvEHpmw==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6659e81bc68so76920397b3.0
        for <mptcp@lists.linux.dev>; Fri, 02 Aug 2024 10:52:37 -0700 (PDT)
X-Gm-Message-State: AOJu0YybEjhbzo1ZFH9B9x5T0kwdDsg3SMjFAo3JgK7QZC7pUo1+pODx
	o1xgOEdmPvNndzvz2SRhm7CGSOGFp2TRYbMMy4DSgnnG681GdaDoifItJ5QxZ5vzFQdQ/Oyv+at
	kB960MzD6eRtDrE3bX1D3rI+fEA97svkN6r5Z
X-Google-Smtp-Source: AGHT+IGixkNPPtSEF1h224smgOxI+0T0It06aerZoOJT8x3F07ApyzYy8kw8XsQU8uKu3nWlv8G5x7/CFn8cE5wdBSY=
X-Received: by 2002:a0d:f504:0:b0:65f:8afe:9ba6 with SMTP id
 00721157ae682-689601aa855mr46182097b3.14.1722621156949; Fri, 02 Aug 2024
 10:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240802-selftests-net-lib-cleanup-kill-v1-1-66220a8b6911@kernel.org>
 <6806450e-7c7b-8072-0af9-23bac214ec0b@kernel.org>
In-Reply-To: <6806450e-7c7b-8072-0af9-23bac214ec0b@kernel.org>
From: Mat Martineau <martineau@kernel.org>
Date: Fri, 2 Aug 2024 10:52:26 -0700
X-Gmail-Original-Message-ID: <CABbSpciZfzrTdgQAp9fpKN5EPn7QdRXMCgBoipDQ6EF_u3eWzg@mail.gmail.com>
Message-ID: <CABbSpciZfzrTdgQAp9fpKN5EPn7QdRXMCgBoipDQ6EF_u3eWzg@mail.gmail.com>
Subject: Re: [PATCH mptcp-net] selftests: net: lib: kill PIDs before del netns
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 10:43=E2=80=AFAM Mat Martineau <martineau@kernel.org=
> wrote:
>
> On Fri, 2 Aug 2024, Matthieu Baerts (NGI0) wrote:
>
> > When deleting netns, it is possible to still have some tasks running,
> > e.g. background tasks like tcpdump running in the background, not
> > stopped because the test has been interrupted.
> >
> > Before deleting the netns, it is then safer to kill all attached PIDs,
> > if any. That should reduce some noises after the end of some tests, and
> > help with the debugging of some issues. That's why this modification is
> > seen as a "fix".
> >
> > Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
> > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > ---
> > tools/testing/selftests/net/lib.sh | 1 +
> > 1 file changed, 1 insertion(+)
> >
>
> Sounds like a good idea to me:
>
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Oops, it's in the net/ lib, not net/mptcp! I should have said:

Acked-by: Mat Martineau <martineau@kernel.org>

>
>
> > diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftes=
ts/net/lib.sh
> > index d0219032f773..8ee4489238ca 100644
> > --- a/tools/testing/selftests/net/lib.sh
> > +++ b/tools/testing/selftests/net/lib.sh
> > @@ -146,6 +146,7 @@ cleanup_ns()
> >
> >       for ns in "$@"; do
> >               [ -z "${ns}" ] && continue
> > +             ip netns pids "${ns}" 2> /dev/null | xargs -r kill || tru=
e
> >               ip netns delete "${ns}" &> /dev/null || true
> >               if ! busywait $BUSYWAIT_TIMEOUT ip netns list \| grep -vq=
 "^$ns$" &> /dev/null; then
> >                       echo "Warn: Failed to remove namespace $ns"
> >
> > ---
> > base-commit: 3b0e1975962a388844508be0b3e61e759837fa3e
> > change-id: 20240802-selftests-net-lib-cleanup-kill-f546a233572e
> >
> > Best regards,
> > --
> > Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >
> >
> >
