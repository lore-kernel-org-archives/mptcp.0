Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E837417723
	for <mptcp@lists.linux.dev>; Tue, 11 Jul 2023 09:20:25 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-401e23045beso44692451cf.0
        for <mptcp@lists.linux.dev>; Tue, 11 Jul 2023 02:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689067224; x=1691659224;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lPoVgbhMWm7XhIP8dNkyITuLUE781+pj1tbamqaLYo=;
        b=NXsLBJiur6l4HBJo3r/bUXudjy9B+og2dVo5XWLkuBD5S6CutjZopcvty6Gk5UoXWo
         aDZpTTiSNSticyZ5wawb+9msXT79GGlYRQ8v2hWSmZcUVHGDYcSQAZQNfuE2gxUcXIpZ
         rUmol5x7hej4zFwyZS69BSUPb1xnTF2dreOb+gJSak08AeXaxW9PIcutpY+owebcv07C
         9hIxTmplJVJRELue7YFDKLJ9UcbQgTwibhItNqrvoS0gBezFR36HWeS0S+l/N+5F5HRn
         nj4A3Mz+AUWy9UZSoGdTRX/QoWC63gR4i4Eq4sZrcquSh+xTZOJrrNs/2PmJtv5ZDunI
         8y+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689067224; x=1691659224;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3lPoVgbhMWm7XhIP8dNkyITuLUE781+pj1tbamqaLYo=;
        b=LMgfrwQCSC+8scWXdM5JTRJzcW9pcmsIGqa0PSVI9Gx1Z9OiouBVl6KuCa11GBUI4Y
         7pEd3q+n7su5OdZ0/zb/VUaRU+6dH1cQvVnVnyAmSLFapSaDf219tFClgcqZ56vz1cY3
         JM/EXDZ4s+o6uPISFGPIAkQahggqc1JmGU0JMuMaq1USzMjrdVv2Qph8O+6td2NpAMPz
         uNKTyUJU97DwAoX8WiKsNIO/CCaTrAgSQYiNgOQrylfa/6O0IFQ3YmmjAkWBAFSisdPr
         x5Kl8NiDoqN3mI0/rS8ODE3OfDBahUSUQDg2/qKiaNmfNmbsglffBI68ALhCXm/VN0HR
         Zonw==
X-Gm-Message-State: ABy/qLaWNVlLEG1xvTl/ZdABl2dcnydV33Or2iLWf5TwcBSrd9v4WDE4
	THl2ssVHzTko1XTdzOxiyV2XV08H3vXg
X-Google-Smtp-Source: APBJJlEF1eL2+HGE1RadTIDm2qqYs9wo9Bhs3PNLGs7N4vhzs+nEWXgTkH5BtFG9rI0dClmMIJDdzQ==
X-Received: by 2002:ac8:5c07:0:b0:403:3048:b98 with SMTP id i7-20020ac85c07000000b0040330480b98mr19297196qti.34.1689067224539;
        Tue, 11 Jul 2023 02:20:24 -0700 (PDT)
Received: from [127.0.0.1] ([104.45.202.167])
        by smtp.gmail.com with ESMTPSA id a8-20020ac84348000000b003e69c51cf53sm895577qtn.72.2023.07.11.02.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 02:20:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230707-mptcp-unify-sockopt-issue-353-v1-6-693e15c06646@tessares.net>
References:
 <20230707-mptcp-unify-sockopt-issue-353-v1-6-693e15c06646@tessares.net>
Subject: Re: mptcp: sockopt: support IP_TTL & IPV6_UNICAST_HOPS: Tests
 Results
Message-ID: <8bd39410-e8af-1781-9f60-af4ead228153@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Jul 2023 09:20:23 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6207458729787392
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6207458729787392/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5363033799655424
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5363033799655424/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5364691875135488
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5364691875135488/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4800083846234112
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4800083846234112/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/25067ce9c170


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
