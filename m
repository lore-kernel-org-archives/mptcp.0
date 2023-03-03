Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ED51FB3
	for <mptcp@lists.linux.dev>; Fri,  3 Mar 2023 09:00:24 +0000 (UTC)
Received: by mail-vs1-f50.google.com with SMTP id f23so1714822vsa.13
        for <mptcp@lists.linux.dev>; Fri, 03 Mar 2023 01:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JLsdOAyBgyezK1lgQkAs7g3tPEWRNLmT3YtzhsnA9Eo=;
        b=Mpff6y11+tajpm4ENnXldBTwnQin3kMRQ35Jp+KKyWKE3NfomdkPgesXEPbzxVmb3u
         DpgXevAA34AlBXahtjo6WUCEuc0td6jcwDxeUCPhUbCCFtpR+PkvzW0icD4vf7/AWRey
         9AIPc/rC/r6s0rAz1FaWCORh33o7WCuFkL4KmhR7JwACpAHGeXhYVSo87DvTp0zFEuYh
         f2nKjCneFaMk7SzKRGtTEC/P9aZfqdyF9d57k+kfQuoZtWMglWWouqW+wOgWUy5pqNiX
         eRug/NxMn5OrbEQMJr5CL3aj5Dj3vZztlpRmdKpao6yd3yce8PdIq/K9LkCg/Im4QNxH
         Z8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JLsdOAyBgyezK1lgQkAs7g3tPEWRNLmT3YtzhsnA9Eo=;
        b=hZ66/UFtH5x20K5OX48IM3DtjWbraFtAyQkeGFQG085A4ngIQw24fdG2uuqTElmt46
         +OpZZhC5SAHR6EfUpgxLRCFR2tgNSd3G8EEp6IjmCxJmkv0DMjaOpd+brGeiTvEEH1F2
         bNrUcs/tnCGSCON73otJr01n3r2xrmCVpsBupZTKMqzHn3FH7zbN1tTO9XVOhr/lzLkl
         srA8JPh82DXgKyT8TN9dhrsevWJwJAfTKJ1AvX/hSfPAwVhXcrv+//K9yWlobBQYB3ve
         oBkTUWuDUC4U0HqdYVHTOKbJWH7XFL+4sTuCEr1x59v0fm/kjpuWgKr+RqbVg75PfwQ/
         FHyg==
X-Gm-Message-State: AO0yUKXYKDDnbgCjH8Y2iYzMery0LENOz9c+4GNgP64ZYbG0BVI4sci0
	fUWfZ8P4xLAPymC2remQ5WtTc6ojiEuNZKxcDdi56g==
X-Google-Smtp-Source: AK7set/9X7i92FLRbTs4K8F7WILTtmVS53pxFldUzuXDJlvs6xFldr/xpFZjsZya7JsDSXEoQg7weJ37y8z0INCPtdU=
X-Received: by 2002:a67:f58b:0:b0:411:c62b:6bf0 with SMTP id
 i11-20020a67f58b000000b00411c62b6bf0mr683428vso.3.1677834023770; Fri, 03 Mar
 2023 01:00:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230301180657.003689969@linuxfoundation.org> <CA+G9fYtDGpgT4dckXD-y-N92nqUxuvue_7AtDdBcHrbOMsDZLg@mail.gmail.com>
 <ZAB6pP3MNy152f+7@kroah.com> <CA+G9fYsHbQyQFp+vMnmFKDSQxrmj-VKsexWq-aayxgrY+0O7KQ@mail.gmail.com>
 <CA+G9fYsn+AhWTFA+ZJmfFsM71WGLPOFemZp_vhFMMLUcgcAXKg@mail.gmail.com> <ZAGbUsae7DHoI5k4@kroah.com>
In-Reply-To: <ZAGbUsae7DHoI5k4@kroah.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 3 Mar 2023 14:30:12 +0530
Message-ID: <CA+G9fYsoEdhf09n-8eFzYPnsvDH=YryJ9rdsphZx8XQ3N3BbMw@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/42] 6.1.15-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, mptcp@lists.linux.dev, 
	Florian Westphal <fw@strlen.de>, Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	Matthieu Baerts <matthieu.baerts@tessares.net>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Mar 2023 at 12:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Mar 03, 2023 at 01:32:47AM +0530, Naresh Kamboju wrote:
> > On Thu, 2 Mar 2023 at 16:30, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > On Thu, 2 Mar 2023 at 16:00, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Thu, Mar 02, 2023 at 03:49:31PM +0530, Naresh Kamboju wrote:
> > > > > On Wed, 1 Mar 2023 at 23:42, Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > This is the start of the stable review cycle for the 6.1.15 release.
> > > > > > There are 42 patches in this series, all will be posted as a response
> > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > let me know.
> > > > > >
> > > > > > Responses should be made by Fri, 03 Mar 2023 18:06:43 +0000.
> > > > > > Anything received after that time might be too late.
> > > > > >
> > > > > > The whole patch series can be found in one patch at:
> > > > > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.15-rc1.gz
> > > > > > or in the git tree and branch at:
> > > > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > > > > > and the diffstat can be found below.
> > > > > >
> > > > > > thanks,
> > > > > >
> > > > > > greg k-h
> > > > >
> > > > > Regression found on Linux version 6.1.15-rc1 on 32-bit arm x15 and i386.
> > > > >
> > > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > > >
> > > > > ## Build
> > > > > * kernel: 6.1.15-rc1
> > > > > * git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
> > > > > * git branch: linux-6.1.y
> > > > > * git commit: b6150251d4ddf8a80510c185d839631e252e6317
> > > > > * git describe: v6.1.14-43-gb6150251d4dd
> > > > > * test details:
> > > > > https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.14-43-gb6150251d4dd
> > > > >
> > > > > Regression test cases,
> > > > > i386:
> > > > > x15:
> > > > >   * kselftest-net-mptcp/net_mptcp_mptcp_sockopt_sh
> > > > >
> > > > > # mptcp_sockopt: mptcp_sockopt.c:353: do_getsockopt_tcp_info:
> > > > > Assertion `ti.d.size_user == sizeof(struct tcp_info)' failed.
> > > > > # mptcp_sockopt: mptcp_sockopt.c:353: do_getsockopt_tcp_info:
> > > > > Assertion `ti.d.size_user == sizeof(struct tcp_info)' failed.
> > > > >
> > > > > test log:
> > > > > ----------
> > > > >
> > > > > # selftests: net/mptcp: mptcp_sockopt.sh
> > >
> > > ....
> > >
> > > > Nit, wrapping a log like this makes it hard to read, don't you think?
> > >
> > > Me either.
> > > That is the reason I have shared "Assertion" above.
> > >
> > > >
> > > > > # mptcp_sockopt: mptcp_sockopt.c:353: do_getsockopt_tcp_info:
> > > > > Assertion `ti.d.size_user == sizeof(struct tcp_info)' failed.
> > > > > # server killed by signal 6
> > > > > #
> > > > > # FAIL: SOL_MPTCP getsockopt
> > > > > # PASS: TCP_INQ cmsg/ioctl -t tcp
> > > > > # PASS: TCP_INQ cmsg/ioctl -6 -t tcp
> > > > > # PASS: TCP_INQ cmsg/ioctl -r tcp
> > > > > # PASS: TCP_INQ cmsg/ioctl -6 -r tcp
> > > > > # PASS: TCP_INQ cmsg/ioctl -r tcp -t tcp
> > > > > not ok 6 selftests: net/mptcp: mptcp_sockopt.sh # exit=1
> > > >
> > > > Any chance you can bisect?
> > >
> > > We are running our bisection scripts.
> >
> > We have tested with 6.1.14 kselftests source again and it passes.
> > Now that we have upgraded to 6.2.1 kselftests source, we find that
> > there is this problem reported. so, not a kernel regression.
>
> Where is this problem reported?

We have been running most recent stable (6.2) selftest sources on
older stable-rc branches ( 6.1 ... 4.14).

> Is this a 6.2 test checking for
> something that is not in 6.1?

mptcp developers might have a better idea,

- Naresh
