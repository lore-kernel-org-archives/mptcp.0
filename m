Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9437B
	for <mptcp@lists.linux.dev>; Wed,  8 Jun 2022 14:36:50 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-fe15832ce5so1725586fac.8
        for <mptcp@lists.linux.dev>; Wed, 08 Jun 2022 07:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=uswx9lUaPDAPOTOQc9xW3nJVoMXE5rQAh8V+eIjpBB8=;
        b=jSgQER9JbXKj3hAt/kt2yRekQUll46yM2rjIlKMBffMgOi67Nxu7xdIkJm18d0S+Z5
         obBYr5hTvC0o1pF8Za0YiRKdqW7XBDM0e4OyV8Np4wmepI0XHE4T6/76OOmuwBb8fwhw
         aTCTprB0uNwkMyH8f2gDerXO05u+7faE73A6KCPgRpqSQLyXArL6Gt6Z3Hn/ydtBFrmb
         Osssgnp7ZQ4x/TsQITPN/G/BJkgMdE7OXLWs95pKL2eNEQrvMD/OImy7U+sAtzarccmH
         khh2oypiTDBQlCAjiUMukBs/9oQ9jIV4ze4jRTXyUklxOANzeN+DcYhmNngAi/oRa1SG
         UA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=uswx9lUaPDAPOTOQc9xW3nJVoMXE5rQAh8V+eIjpBB8=;
        b=RLv3e9R+m8U+fKdeICVpLN95rPyMl7kOFKjQsZBMW4XgBqQw+wAnXQ/GK6Z4UDQig5
         ngL2aYJknfGdP3E2nmmRNzNq2UKnN2vS3SAwCjHm99aRqMksC/xOptNqoY47Sj7cgqYX
         QtK0ehRknDpOb6jxlURQzp6BHa2DKJjKJGT34AhCB5HOpA3XvEpU8US1S/aH5CGrWRaK
         OD3uuvRnZUevnTMoscv/apJm6UOGxPkq/lYyjNODIK3GIxKJYeSos+I/qzUIgBJHwbGr
         Kvm0yb+mUX4fddb4uXEriuPkS/W8LuT4oWFulg7IMgqtL0BV31StGsecfzUZptI0tr3S
         MasA==
X-Gm-Message-State: AOAM533yjBT7MkmIfvP/w+05PHx5LWTfpF2NTyV4Rw/nscx5k2mFpwHe
	yOZl2lu1gxfeZ74Z7D4B1g==
X-Google-Smtp-Source: ABdhPJwP5dCddR28L6YPRireHEaXgBnxNcCWKDHAhDG4F2pH/ptEmvhH2jdaW38nJ/3NIM2IF2yKDg==
X-Received: by 2002:a05:6870:c8a5:b0:f1:65c3:b1e9 with SMTP id er37-20020a056870c8a500b000f165c3b1e9mr2659771oab.36.1654699009652;
        Wed, 08 Jun 2022 07:36:49 -0700 (PDT)
Received: from [127.0.0.1] ([40.84.186.93])
        by smtp.gmail.com with ESMTPSA id g3-20020a056870ea0300b000f33ced2c50sm9439040oap.56.2022.06.08.07.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 07:36:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <527414fccf0c041908900aadb2f043134a0ec09c.1654694739.git.geliang.tang@suse.com>
References:
 <527414fccf0c041908900aadb2f043134a0ec09c.1654694739.git.geliang.tang@suse.com>
Subject: Re: mptcp: refactor MP_FAIL response: Tests Results
Message-ID: <8569d7c4-6ec4-254e-6a28-5bc2ea7be136@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jun 2022 14:36:48 +0000
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
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5446757227167744
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5446757227167744/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6572657134010368
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6572657134010368/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/a555dd44b7a8


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
