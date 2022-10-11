Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FD66102
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 00:01:15 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso179124pjq.1
        for <mptcp@lists.linux.dev>; Mon, 10 Oct 2022 17:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tokejhtz4L76jxMn80XrYwbviBn+2EW4fqNYWtIm7yQ=;
        b=qY5Jcudkrh+uhyJw52OdOGD3QRcOahQeJqZ6YecnA8ZurFkY8ClDtnyEj9jY7OpWyy
         eV1at9f9KFY78f999PUnukWw9XIWpUEZFM1QXthZvk7foLqV+yQBjvaJ8dRA3Twfwmyh
         WXaKr2hz0+5MyJu0po9h883+pEW6ShLNaqR8buA6p0pDZjNwM9jupsDTaCYfNT7c0lW/
         RXlaU0tDosLOqW56qGxOpbx0KCXiK68VQG58l+8l0rqxJd2pr1uzHzdK939USIpXFCre
         9NVmnVF92HWcd14/UvhbXbTF9APL02Saa0E0xCDtTHVYzewIoHwRANocYZa7cBFcwIGj
         +1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tokejhtz4L76jxMn80XrYwbviBn+2EW4fqNYWtIm7yQ=;
        b=ytMT4t8gcmmX+00uL2mZ5R5oKaaZzgTci4mvJfISjs0iN+ICRF8DmaKVMmsrBxhIui
         NXzyTbRPGEp8eJp1dwVpFW+LTlshtbTfm7HPaE1w6KD/lISftQJ38pH10Jzwkqd3p2Mp
         9B732PCRGfuw5PdI4kpnlUmYMcm9fjok6CFOH5AZEkhZ/dUxdmTfolaNth/NyAEWZXsj
         vN6bNRWY5oaw4dPdws4eewHTn1csQ55JZP5ISPFQoaGzS7trR/lVQeNqQBqbXQnAXzPo
         +rXnW6itQlobwoAoNRQNSmDNQP1MdsO+1ndq539Fz9JqchGkuoEfFxAmiu+p1p5Gq6QW
         SK2w==
X-Gm-Message-State: ACrzQf3iQx11ymp+zpedlDit3j+n+uOn3GQYHg79Y2zv6CkGCkiFrjPc
	95dQHNKm5LXDgAqIVidubg==
X-Google-Smtp-Source: AMsMyM5Bp9hNO/KlD++k2WA23HHGRgJMcBpUb5yDOrl3ruw2/YoC56X9Q0R7IuY/4p2XSAQygjwfMw==
X-Received: by 2002:a17:90a:641:b0:202:8568:4180 with SMTP id q1-20020a17090a064100b0020285684180mr24239561pje.227.1665446474682;
        Mon, 10 Oct 2022 17:01:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.64.115.56])
        by smtp.gmail.com with ESMTPSA id d17-20020a621d11000000b00561879b0f3asm7437333pfd.203.2022.10.10.17.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 17:01:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Dmytro Shytyi <dmytro@shytyi.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221010221809.1792-6-dmytro@shytyi.net>
References: <20221010221809.1792-6-dmytro@shytyi.net>
Subject: Re: selftests: mptcp: mptfo Initiator/Listener: Tests Results
Message-ID: <f4471619-ea67-7259-fa57-fd6b739d0476@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Oct 2022 00:01:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Dmytro,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
packetdrill_add_addr selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4881336631558144
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4881336631558144/su=
mmary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s):=
 selftest_mptcp_join - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/6007236538400768
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6007236538400768/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/444fcb2258d7


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
