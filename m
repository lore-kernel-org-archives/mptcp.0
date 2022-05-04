Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355217F
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 13:22:08 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id c11so1376381plg.13
        for <mptcp@lists.linux.dev>; Wed, 04 May 2022 06:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E66TeSamETutEvlCnByHzYJ0jzXWbnUGqXTPJzlJBew=;
        b=Ud0V+rTE7e0bm+Z1DPj9O1itFxiuPeoWrRWAV0rNH6d7vhw8tozIZlpE0riIZR1ZmC
         rb2o5hmjE1m2cLhEoqpTtZ+zTsrnwlvBbDDbpNnBqMrBhygdDJX5y4pxhyF6RI7tLNcw
         ev6efriEvgM0NcaaBZuU8HJVlVwuZGbPybNo/NJmHIUbx0c2IZiuS8GXBYbgflMWs2qf
         8H5Q4qa4oQyrwzKGSkNv5rkZySqCmhcLSW2DeU44ObC1RxB6S2CKgroFpXDSoBJzZ3U2
         My+MIdl8bmWr8FONuTBhUOjNjaZDSdq9Zdm1MRBc3HvvLzM8ZyFnA86CAqY9NYcolz3O
         j7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E66TeSamETutEvlCnByHzYJ0jzXWbnUGqXTPJzlJBew=;
        b=2+Vy05iqD5Y0RFH2nGp257Z8EreQWit5bkrA6Mj9AV5nsHV6HZN0mn6s0fq9feXHnL
         jRxrHsviPNsgIC6vIvIb1ak88KicwF60pU1W0uGLl2IiBtnMWPlllwbNW7og/T8uBs7/
         +xdSVh+hnEUKRJsi+30x/oAAAihv6f4cDvP76gvaEJQQDpg+XrWN/7nHkDX2Oj+L9ELP
         RYhr6KCfDf2FU1skL8KyYV+RJYDLsM3FSTH+IdzLS/g9mFOSKynMR31SV+0GgjMveez/
         0P7gK+pW89F+TiE6be8/fjxEXl21PVhcGljcWbJ6Rj0lE7YjiNe5OCEEWMLzJt5k0K0w
         e3Ow==
X-Gm-Message-State: AOAM530BMY3xLYdkhCWY+RVRH4kE6QFMkQ1aHvmvG6DPQ5Npcv4NH5/Q
	HeaNiVRmpiHThk1qQNMjIFpx6ZKxW3XM+w7mQVk=
X-Google-Smtp-Source: ABdhPJxznQZ5Y7rA0EpPbvttSYRiTURlliS3flT3kEgQ63o57SC7r+LPinYJHAIHT0qq4iAe0xg0SpTrWxc1ZKxxYsg=
X-Received: by 2002:a17:902:6acc:b0:149:8f60:a526 with SMTP id
 i12-20020a1709026acc00b001498f60a526mr21778812plt.25.1651670527652; Wed, 04
 May 2022 06:22:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cdcd6b9963a1c15b20ffcf71e06b6de70f67ec4a.1651664645.git.geliang.tang@suse.com>
 <20220504121429.GA18870@bogon.HOST> <d4546526351251a86d13673baa3f88de5655fb13.camel@redhat.com>
In-Reply-To: <d4546526351251a86d13673baa3f88de5655fb13.camel@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 4 May 2022 21:21:58 +0800
Message-ID: <CA+WQbwscUM8LJx=sye_QpNr-GAzgTdDE+NqXAHnvLOHGsvE31g@mail.gmail.com>
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add MP_FAIL reset
 testcase" - cleanups
To: Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <geliang.tang@suse.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=884=E6=97=A5=
=E5=91=A8=E4=B8=89 21:04=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Geliang,
>
> On Wed, 2022-05-04 at 20:14 +0800, Geliang Tang wrote:
> > On Wed, May 04, 2022 at 07:44:24PM +0800, Geliang Tang wrote:
> > > Two small cleanups for MP_FAIL reset test case:
> > >
> > > Reduce the test files size from 1024 to 128, to make the test faster.
> >
> > The original commit log needs to update too:
> >
> >  1024KB -> 128KB
> >
> > '''
> > Add the multiple subflows test case for MP_FAIL, to test the MP_FAIL
> > reset case. Use the test_linkfail value to make 128KB test files.
> >
> > ...
> > ...
> > '''
> >
> > > With Paolo's fix [2] for MP_FAIL test-case, the test becomes very slo=
w.
> > >
> > > Drop '+'s passed to chk_csum_nr, with Paolo's fix [1] for act_pedit, =
no
> > > extra checksum failures now, no need to add '+'s anymore.
> > >
> > > Depends on Paolo's commits:
> > > [1] net/sched: act_pedit: really ensure the skb is writable
> > > [2] selftests: mptcp: fix MP_FAIL test-case
> > >
> > > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>
> I noticed the the time increase. Unfortunatelly, it may be necessary to
> be reliable in all environment, comprising the slowers one.
>
> Mat (M.) was able to reproduce some failure with b/w =3D=3D 10Mbps and si=
ze
> =3D=3D 1M. I think/guess he could hit the same failure even with 1Mbps an=
d
> size =3D=3D 128K.
>
> We need at least some additional testing for this one.

If so, let's continue to use 1024k test file sizes.

>
> Thanks!
>
> Paolo
>
>
