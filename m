Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1909123AF
	for <mptcp@lists.linux.dev>; Wed,  1 Mar 2023 18:35:00 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id t22so11534486oiw.12
        for <mptcp@lists.linux.dev>; Wed, 01 Mar 2023 10:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677695700;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fe0no0O8pxeu5NGnHIzlXsnZyihUJEbAmOHypTVOZHI=;
        b=itqZzDcwwI6S9iQc0XY1P63t7zoG1BAqTRP4EAxx3GsagbBO679T3quClkyf7KMZH4
         ewbO3v1Re8aPNwfMEd98S321cM4Eu6G9OFJqF+O36rBKCfcHJS7OhjWoOJC1nlhsqh+K
         ZdsrGqHROLsziZT6nLeX+tyRC1LESShp8PLO/feJ9UAfsuSzMnwWXqkxo4qzyAD0pWe9
         K8DLqk6pRYLCCXEzYe8xVpyaX828E3azKOF0hQmTtjYkEKbA1S0oMotlQYPy6zE0iy15
         nWRBR3desFQUJYcUhLAbBuRWrJUMtR5ogtdbyI2tUmMuneJZT399h7Pv2NuiWLrBI96D
         pnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677695700;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fe0no0O8pxeu5NGnHIzlXsnZyihUJEbAmOHypTVOZHI=;
        b=2ClP9cRxv34ZvbdwolZvp4XO3InRc4Sl52oR9gF+GOrWeqlu/HhR3PhtLHLArLVP7G
         7y7FHoXrl9TI1EbljJLqJ2OjE9l/IGL5PoGXChGn00GHbvMuXXhNNJrcXBhMzvfzX2+a
         wmNREs2744E4JT+XS7Vf8EVi9E7f/wNMaB6oo4gFtC6EyozvQUV28HXYisMB9BpOWkdj
         img8v9VnM+QtxKpChz0QfGfBzYJ4d7l74yn2RqM0Nkrk95X3EE8hi7qzoLZJXs0OXTns
         P2cNWHAumApIp33ezrSY3FjyYmVmTcDhOSUz0TyhAZx09hFsw+dcaoZ5Kkso1xJ5L28k
         XG2g==
X-Gm-Message-State: AO0yUKUMplhCUPOEBMVrIxctgmS8eUxyotr5b7uhyN5VkiD6tJzzSTvy
	6AzBSgKBrR11tvo8bIzEKw==
X-Google-Smtp-Source: AK7set8Ql8JK5PGGQ9iOGB3fYmFoF17R4/OA2wFDMggbp/uO6240PUsY3BrTOYV8sWRHljtrz6Fjlg==
X-Received: by 2002:aca:1a09:0:b0:384:4212:848a with SMTP id a9-20020aca1a09000000b003844212848amr3494931oia.36.1677695700040;
        Wed, 01 Mar 2023 10:35:00 -0800 (PST)
Received: from [127.0.0.1] ([52.248.87.130])
        by smtp.gmail.com with ESMTPSA id r204-20020acadad5000000b003785996ef36sm6036010oig.19.2023.03.01.10.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 10:34:59 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <869ca49933fc7983c50a88f2a8b4a680e5eedc5b.1677693276.git.pabeni@redhat.com>
References:
 <869ca49933fc7983c50a88f2a8b4a680e5eedc5b.1677693276.git.pabeni@redhat.com>
Subject: Re: mptcp: fix possible memory leak on syn_recv race: Tests
 Results
Message-ID: <eb6a053b-5d2c-c45e-d196-195c0dc67a5b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Mar 2023 18:34:58 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/6362501890179072
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6362501890179072/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/6081026913468416
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6081026913468416/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/4955127006625792
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4955127006625792/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/5518076960047104
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5518076960047104/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/6b3b8fa6b068


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
