Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6461D813
	for <mptcp@lists.linux.dev>; Mon, 21 Nov 2022 05:35:48 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id g5so988887pjp.4
        for <mptcp@lists.linux.dev>; Sun, 20 Nov 2022 21:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5C4YhaQroGori7aUEiQ/rSiTxWGeDGhGSaLGJ02BRE=;
        b=WFlh+hRe9egV0UHgtsVuzVAJ+YzNCE0BQXkCWeNBYSiG6roO68nESTYZfqJfkOL/sU
         +d31Oa7TD48Hvxc9YXaeoTlGxf+Lbiq2K3tudY0UFKViJ6AgCuO9ukzdxySDuLC4JUhW
         oDBo3qJXInFuP5fLQeUFpK9b9og7JXd/uBlzZkJD1Wh+eoOaK3yydr7ZOB4/1CxrVD5D
         hZhrAigTtkBHr22RTvILpl4lAE6Nr1JzpzlwXQEHRQWpZD0Uf6Anl1+0XbE51CmfKhK5
         CiWp2TIeS/Lmo0CevWAwChsXetGIpVnCEivlpQ+t91RUIG/sTmAXdd18YQuq/lXE3K/5
         nYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P5C4YhaQroGori7aUEiQ/rSiTxWGeDGhGSaLGJ02BRE=;
        b=VGxkW9appXdJ0GHDYD9gUJyEw3KrRO1ErDQp15l7V+Bo+smcn7XeC4866KKIyRcMMR
         Xqu6hH501KxgXndp9SuTRwdAsIAJEU+jppvcJovjsYA3db5WR/sZ8Yi2ODXM99mUVziL
         oVxiNJUcK4aFi6GOblV/zLa5OrT7mZEdPMb7qSrkDe/IPawIEK85PCzsa2xd6vENj4oH
         RLxyugD9GGgrD3F1il5R1JPxyW5c4Otfq9ocexA3Pc1hzpdhaPWeL3RmxGR4yTFo+OWE
         bROZfYvfxWiuR6WqpNvQKmCPaK/5XRo2jGD+XSU9+FPnfS2yw4v+nvvM7OGjbRg+h91x
         xiNg==
X-Gm-Message-State: ANoB5pmVT1sq+ZuIFMWhCC85xHm+MP0eucYABOZ7BCCNurMnWlLkI3im
	DvfK90/vsq4H+sLHWKWXzA==
X-Google-Smtp-Source: AA0mqf5NFSFSmFbwvGVssryKbWVuq2Jn4J4U3JLm+F0CBqNsvdZyETas/LiqNUlkHrosCOnW1gI6Lw==
X-Received: by 2002:a17:90a:d304:b0:218:8d0e:9f03 with SMTP id p4-20020a17090ad30400b002188d0e9f03mr12882782pju.114.1669008947733;
        Sun, 20 Nov 2022 21:35:47 -0800 (PST)
Received: from [127.0.0.1] ([20.66.61.4])
        by smtp.gmail.com with ESMTPSA id ie4-20020a17090b400400b0020af2bab83fsm6914145pjb.23.2022.11.20.21.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 21:35:47 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Menglong Dong <imagedong@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221121034140.548112-1-imagedong@tencent.com>
References: <20221121034140.548112-1-imagedong@tencent.com>
Subject: Re: mptcp: don't orphan ssk in mptcp_close(): Tests Results
Message-ID: <f50f78ff-0c18-6260-66c1-bb58a7ad04bc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Nov 2022 05:35:46 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Menglong,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6300542272536576
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6300542272536576/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/4893167388983296
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4893167388983296/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/c60397ab65aa


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
