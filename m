Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E1B46B4
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 17:24:11 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-131886d366cso2511999fac.10
        for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 10:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=Mdx/Fqj1U4yaUf6gzDooNPuMTL6tAbJ1ka5uCaj7Occ=;
        b=XX4KLxHmg9/PwMlF++qg2QPHIRsMG1fUFt1IqgJ0hBjics3zNsxh5LuXyOHRe5oSdV
         8siZywt99X/nWh4egdhYk8o57STnECRe5Aiz1UwQFwbLAGrz8wGRdah1G7CIXHO0nO7A
         udGdYjuYSopflV/aXpKaCh+Kq3ZwZKQkeYSY9YVK2pa+/3maUD2jSZqJR2sxKqCYpN71
         Ltsyoq7I4BytgG0kyXf/4vWuxzgwjSRGCr0lbhoXfT5EGGz3Bzg7JboR0znbTJ+U/yg3
         kyDp1plQT7bEsKSg3VQc3I34Yfi6cIMc+EPAzo3UOxePCP2mELXoxrxpY3pQGBCBPiDc
         r0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=Mdx/Fqj1U4yaUf6gzDooNPuMTL6tAbJ1ka5uCaj7Occ=;
        b=rturOgadR3IVCRkHxNtJD+bJWDfd46NYdbuPEOBtVTpim1Qpx80xhISLIU1EapS51G
         5BflkQBoY9144gKUGUyk5aDJaNG8w/Yjq5fx2q5gaKqi263v3GDEUi0hIgARg3lH+hWi
         B3tvi8lkpRXKRooONnd/hYFwQu7EeOZcsT2dxTohgAJkaKUrKYCQDUYr2Cu0ZaB7qhKl
         B/kxEUFtSeZUJ4HgnlplAzfqVmYwhIwk1YniHColdmghNkvjFXSdBXK1vRbLZ/+qffzB
         FnPwUYeW5GCfJIWxXxCtaRyazeeG4u2RK5cQljgXJihElesb6v/tMiVpGIMZtBm3LUxi
         kNbg==
X-Gm-Message-State: ACrzQf0iAosFjaqXQafqX3oUWdBSMOzw5i9eLlLQ85ffgCBKjQmRgKLP
	/JBzUXcXowti5IpZL/uG4A==
X-Google-Smtp-Source: AMsMyM7nDYcXcbiUMEdLzsbC/KLaTqB5Z2xcQPhY6kDhRhddtXjO126Evv6rClnQoSt2RWZxE/orDQ==
X-Received: by 2002:a05:6870:471f:b0:131:907f:2739 with SMTP id b31-20020a056870471f00b00131907f2739mr1422369oaq.18.1664299450369;
        Tue, 27 Sep 2022 10:24:10 -0700 (PDT)
Received: from [127.0.0.1] ([20.225.217.228])
        by smtp.gmail.com with ESMTPSA id f4-20020a056870898400b00130d060ce80sm1107167oaq.31.2022.09.27.10.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 10:24:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9c104d9eebb5c7f2f6b5e0e0079cd0efb90c788c.1664291273.git.geliang.tang@suse.com>
References:
 <9c104d9eebb5c7f2f6b5e0e0079cd0efb90c788c.1664291273.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_red test: Tests Results
Message-ID: <77a958e3-3e8d-7e1a-f577-257b72c1b173@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Sep 2022 17:24:08 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Critical: Global Timeout =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5154530944876544
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5154530944876544/su=
mmary/summary.txt

- KVM Validation: debug:
  - Critical: 104 Call Trace(s)=
 - Critical: Global Timeout =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/6280430851719168
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6280430851719168/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/04ba877e852b


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (Tessares)
