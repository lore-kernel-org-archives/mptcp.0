Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F7B1851
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 17:47:39 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id o11so6282548qtp.13
        for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 10:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=zDW37WIaGrh2cMC9NBgU/YVCIKddemZZvLFYS9XsuFQ=;
        b=cn4uETHcqptRBBhKw360FwfxLApwdoV9vnb0T6z6ihX8JWToZSsuwwhiIDG4W2idXw
         06pesJqLT+wWGmVLo7AX5nfa+tn6o0OY70lUAX128xkn02368+X8QRZVuTfMsrrhFUfr
         ixHJaI9AmzNhWYtTUEJ6vVAuuKrzlcYSm10EOC9n2yFXL8tL5GP6WrHwA1SATEuWYWxx
         hgQOV4hVAJTZyunbOLqrvihEKP5CzkWWKIvxVNWkM1BakV45O6nONKoHFT6DoK2+qgD/
         cOJQcGv+kWniBFs4tCfbQSJOGWIoCjESU01FgA+FAcCVhA2QFwUB8hhcpT27jaJQNK+u
         XIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=zDW37WIaGrh2cMC9NBgU/YVCIKddemZZvLFYS9XsuFQ=;
        b=cGbm6SadTkBNbI3gSxG+8Ut5+0vCsQNfnmoLEbk0rsDR0ck2Z2P9Xq2R8ynrzoU2OG
         0rnGN1MpdpaJKg2wa9J4CZYRR1vjsiAmSd5DAbdv3MHYXt8oDG3rxwd8ZHrLi2EmilNf
         fi9aVXQpdCBDkWWhUaPfMXobVisNQnpKp53CdRo0pedNlmXtK84JB52CeSLD9/N4rWGP
         imsbSdLRYy281YJpFZN7S9+Egrr5gMt8/olExGMLYPg5NJGmTVcHK8c+Bot1uVg/NXq7
         mGgCBGuuCfzKfG9xLdtls94wSAKFrxdMLnP8QZrNwzNfU7X/Y2fwwKSAatH1SzvvEmUD
         Mb1A==
X-Gm-Message-State: AOAM532FaKJOX6lTEBf2+SWAMqrGCvrcVif2aBarqrQhuHwkD0wN583g
	uCMlG0Emk/2nJJmfamvsFg==
X-Google-Smtp-Source: ABdhPJwkAUTkBwbz9etwvPlbELalZ8+FXnSWLh+FLwHP+Lqs0wKb+3kHjfsBqJEuihMmkjvWL7MqtQ==
X-Received: by 2002:a05:622a:342:b0:2f3:5c21:1bed with SMTP id r2-20020a05622a034200b002f35c211bedmr491826qtw.123.1651254458854;
        Fri, 29 Apr 2022 10:47:38 -0700 (PDT)
Received: from [127.0.0.1] ([20.122.125.201])
        by smtp.gmail.com with ESMTPSA id u11-20020a05622a14cb00b002e1fd9dce3dsm2075129qtx.60.2022.04.29.10.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 10:47:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <a4e7a052279a027da6721d59dbd293b0bb7e08cf.1651248223.git.pabeni@redhat.com>
References:
 <a4e7a052279a027da6721d59dbd293b0bb7e08cf.1651248223.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: fix MP_FAIL test-case: Tests Results
Message-ID: <e31ab535-c260-fa26-d6e5-d3219c1259c0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 Apr 2022 17:47:38 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5704510495522816
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5704510495522816/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_diag - =
Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/5141560542101504
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5141560542101504/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/d97a7b7382ca


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
