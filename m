Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A17423AA
	for <mptcp@lists.linux.dev>; Mon,  5 Sep 2022 05:48:24 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso2712212pjd.4
        for <mptcp@lists.linux.dev>; Sun, 04 Sep 2022 22:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=EbZKXSgCh5RsltYOgdhkPypXdSGU157pT1dRtq0WdRI=;
        b=UsPjOOXldbgsB6IaVMQYhtf9z5fPwViSG0iNRZhpdw/PyGXHvDD+43pRGpwt0mI0F8
         aGpnYKPbUquSaxs7jmpG+gSggGOdJEbnC/8CqbjQxDy8QauJQlpooPVUYOd1UE0t1110
         QVvk1qGux4WVpWcRKWrLKuolFQfMJUOJv8T+DHT2y/CSRQwPR4FpIL8nVMblepLcYWmo
         8i3Xdd4EkwYZKkDKgt9GWGWgO8xvhxDFv7Y0wSl39AIeyMlUIjkbJZoriuCV9OKEM2dw
         68SD45CgbLKOodOXpYb56rfoxJjMCGkPkQGLuemnPEWQ/qj87MSO2XtR1RIi1n+SWNFG
         XtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=EbZKXSgCh5RsltYOgdhkPypXdSGU157pT1dRtq0WdRI=;
        b=IT6Qr6Hv00x28ILagKWzzDsK+JhqAfqS3WSstanAv0AFg8a5Y+pJIBZcjl+UenPj+A
         ofJzpezqaSVzEbN4xK8GdgCpICoSMawU1Y+Gstg+sH8VQqllETPLArIch5kz+/rjPGyt
         /iG2v5vMXFGcNo8cPmngfT3rueh33KtZO1GEPq3oGl2YoSzqrmSK6OFJ/1n+d8859ONy
         k8JZqWusE/vkjdgzg1LrMmSkQQgc03ru3/gpDNbHfavQlseZku9TJTM0nvR+7Apm3AJi
         tRC0Zr1czi18o79SYTKb81Akkctyo/tU+Rv917QL2jls57WUpiY/cZNXTmQkJYupYRY0
         wiRw==
X-Gm-Message-State: ACgBeo3vn4BIqmFr3Cc/95+uTlrCwQq7lQNPDdBjBhrHRxSKKr/gY/O1
	QFmVAt87ytQWnW08l1gj+g==
X-Google-Smtp-Source: AA6agR7AXlLRuauWnECmioYQVBPqOHbns56J0PVbi+60cAIhlhczGEtgq7QplEoHFtBONb0rWjIlCw==
X-Received: by 2002:a17:90a:e7d0:b0:1f6:a38b:e0be with SMTP id kb16-20020a17090ae7d000b001f6a38be0bemr17553543pjb.100.1662356903692;
        Sun, 04 Sep 2022 22:48:23 -0700 (PDT)
Received: from [127.0.0.1] ([20.228.116.109])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902784600b00172bf229dfdsm6424784pln.97.2022.09.04.22.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 22:48:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Menglong Dong <imagedong@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220905050400.1136241-1-imagedong@tencent.com>
References: <20220905050400.1136241-1-imagedong@tencent.com>
Subject: Re: net: mptcp: fix unreleased socket in accept queue: Tests
 Results
Message-ID: <b6d1b20e-ffae-d0a3-5caa-a57c679a55ae@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Sep 2022 05:48:22 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Menglong,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/4644571920465920
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4644571920465920/summary/summary.txt

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/5770471827308544
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5770471827308544/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/447ae1cfe0f8


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
