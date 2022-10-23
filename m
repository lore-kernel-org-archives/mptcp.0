Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F7F362
	for <mptcp@lists.linux.dev>; Sun, 23 Oct 2022 10:42:06 +0000 (UTC)
Received: by mail-il1-f178.google.com with SMTP id l6so3900523ilq.3
        for <mptcp@lists.linux.dev>; Sun, 23 Oct 2022 03:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+DTmwN8eea6SDL+nhEQ7lMMMvvlGR8RIJk4bSVIQ80=;
        b=Cl1iH9+HfY3Ytm+377coJONDii3Sc9s8LAS9Hy/enmIsxW9hQAqEccal4y0DQew2vT
         9vsXK8uMjZdb9tG4KEmZ56a7Z5ECxH1LfVGIZCbDGr6XC6fbnFfFShSW11ruVqU+N+pj
         eq4pR7FaiCknIpzk6qlgdzvxqnLFaGpL03gA9jdCgEn9SVXkzN19/Q9RnHVg8pmjNNmm
         D1piD/om3IrwRqFx0OfPFMAW7E8lrSC6hED4Y1j4+bFyDbqZ8QIR1FQ43OAtahvQ68Hn
         uRi+9hmvvamQa8zNynW8wp9VON/MZzN28fcYdWPcpYqUCcAXCKuXC1Y7ba3pIN9o+4+U
         GT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z+DTmwN8eea6SDL+nhEQ7lMMMvvlGR8RIJk4bSVIQ80=;
        b=Q/0Fx72oSpXYfUd3IVu4pGdFyUiRWXsNyrQl937gZEVOLiR/1s+XMS2Ppcbi/KGpkl
         L6SLPWaDw4guiKXksgFtdVgjaNPrDLi1I9D80Y57QPDFJHdulbp8QNwuYGx1eim+L5Vb
         HiV2S565GFBn5xHnJCkAikkaDAFMxjGlMUoUtx4t08ISLpBXEgVWx+gvoIfOJfSHN0KI
         JSG9O7wGuO7CcRkWdIVJrSgEW0n49TqPb1iwJsY/rRFQEQxyg/cwpOFu9reelaWQppTR
         MubhiAdjg23pzRaMaesyFM78FGqUZHK4WTjxM9zOtiY8YOowwYDrnyQzhgIkryxP+Egz
         V81w==
X-Gm-Message-State: ACrzQf3Pie0JvdzDIVo5F2xzGhjsYNMZhgnnF7h1Wkfg9lb04KLAQRLW
	ZhQaL7lRqmSw+b/XTSyrKA==
X-Google-Smtp-Source: AMsMyM6zPf3iuTmLBJK2lIaWtNxkI/G7SOTkNn08NDVMucxHznL5FqyQlahp+SYDcroBbmFqYktL5g==
X-Received: by 2002:a92:d4d1:0:b0:2fa:f0f:944 with SMTP id o17-20020a92d4d1000000b002fa0f0f0944mr18209724ilm.125.1666521725860;
        Sun, 23 Oct 2022 03:42:05 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.20.1])
        by smtp.gmail.com with ESMTPSA id ay33-20020a5d9da1000000b0067ba7abc4cesm6364076iob.50.2022.10.23.03.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 03:42:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221023083246.4042-1-geliang.tang@suse.com>
References: <20221023083246.4042-1-geliang.tang@suse.com>
Subject: Re: mptcp: get sk from msk directly: Tests Results
Message-ID: <1f4f0614-b4e5-fc3c-674a-101c41236666@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Oct 2022 10:42:04 +0000
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
  - Unstable: 1 failed test(s): =
packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6264849012359168
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6264849012359168/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/4857474128805888
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4857474128805888/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/991c29437e92


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
