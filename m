Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889471FA8
	for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 02:17:09 +0000 (UTC)
Received: by mail-io1-f49.google.com with SMTP id p16so13358477iod.6
        for <mptcp@lists.linux.dev>; Tue, 18 Oct 2022 19:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kY8vvwnrAGub1jLlkIhKuohu/niVUVi4t7jnRvH2ctE=;
        b=S4uRoo11gHvTp2a2KeOa346Yv5fdlGvUTlQKT1I0y1TEl9n09yKbRNNSvfr+P3OJQj
         K1XPKaJfjT1jR1v1UFXIry/HQskQOI9LA9k/+VlnTaxMl6jQjDV45wbNrK3ysIKri/MM
         AdKNjeunSEEjvJOQvFPCT4AI760rGXBP5Tr3MEh8LR8171Pkdvj8YhDf+1d2tdeksy2y
         RL37JVELjJ/h+Ow1xBhy+BwQlSArW0VfurUPGHXziPKfyeG+nubNqhzQi8evMisDCXG+
         tbeptMm2F6EaaLFVft7anMeo0CbFMd+rqufZwTyTaALgeMR4GZcwrlxAgpyJEGFdDGBW
         b2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kY8vvwnrAGub1jLlkIhKuohu/niVUVi4t7jnRvH2ctE=;
        b=qJo976IbEeT9Edx4flrmaNak3u6ryXMalRScd4P1iE/WL6K5gav/mqUQQ3vGK6ssJP
         BuS07i0kJCWf3Sd125JzHhyCLxI3D8ngxK8Hlt6dQRhDibulga6H6rLPmCLsqSWM4x7m
         NPoewMy3Fy1Yq/uhNekLw3DgVKRBAVEN36I1alLa2e8kuZU6yrab0OxzdB5BjsF0IZmc
         D2ltUE4oJrelb33Gn9wNr0R5+DYyVondqY/I+SQd9VEYbgCrEbnvOBGkVYTMKmLy/ndt
         UDc48XvTCNjklxk0R1C8G1knnwKwLTOy3fU9kpPa7/H28jEOc/6pnetEjhx0bit0nYau
         /JKw==
X-Gm-Message-State: ACrzQf26927Qrr5H/61Mva80CsCJ8NNWhg/SCWD9Z+aHnd76ciYuulXJ
	nyhDen0d/4N2bjWG9Vkdlw==
X-Google-Smtp-Source: AMsMyM5Bz+drsYRz65owSwK6cohB312wYUmKD3zumnd0OIguxb81yhmUKOdXHD0irE/ufoT/sqUQrQ==
X-Received: by 2002:a05:6638:12c5:b0:364:1291:3645 with SMTP id v5-20020a05663812c500b0036412913645mr3785189jas.316.1666145828542;
        Tue, 18 Oct 2022 19:17:08 -0700 (PDT)
Received: from [127.0.0.1] ([40.83.44.90])
        by smtp.gmail.com with ESMTPSA id a10-20020a056e0208aa00b002fd0403c75bsm1559762ilt.9.2022.10.18.19.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 19:17:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221018110312.22510-5-geliang.tang@suse.com>
References: <20221018110312.22510-5-geliang.tang@suse.com>
Subject: Re: mptcp: refactor push_pending logic: Tests Results
Message-ID: <86491d98-d746-af82-72e9-e58d812f6729@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Oct 2022 02:17:06 +0000
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
com/task/4741266072666112
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4741266072666112/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5867165979508736
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5867165979508736/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/12a4c489939c


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
