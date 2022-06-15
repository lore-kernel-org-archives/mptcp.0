Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAEF7A
	for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 11:00:26 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-fe15832ce5so15967957fac.8
        for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 04:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=pLM4R4OY4TjhTXLK6XCknupimzaLj5h8Gbz3mbi6N3A=;
        b=GlUrV4BzdsT1C3jTRL2/QMnofbDhD9ahpiLDnf1/C91SVpJ5Z+jE4CCV5NGtaEJTGE
         vvyfWu3bzUxR+iGg/frxwKLo5b7bel8yoBnwiw29z+yDZLbox7SvXFmVKclfCwYKZe8I
         pmBPVcD80kT/TbnOPg6h2Ieqj66ynZCZ1iMW4Deg18PXC0EtzN4QH6IHr/ckP1j7ySQ3
         lkQtFCRX1pYSCYcaMexgwxsFFGAA5am2cBp6KFO4KPsS/KMSN/AN3KZJI1oMiKo5Asmk
         bbdfeePZNTG1tevjU//dh5vUzPGaqhJ1W6pqPPBmOasxOid/EE2lVhw6FZqePLzDE/pY
         IM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=pLM4R4OY4TjhTXLK6XCknupimzaLj5h8Gbz3mbi6N3A=;
        b=TDm3UZOHF2VR06efIQYiYHb3C5+KOih9C1xq5iu5+wPPlRpn59eYra99vEi4G1t037
         tT8yTl3QV+Vt0EsTKm9ItEgDd7J2Rb4WrG49jCjyo/NwOHoFpADHhvlcGnfIw5uL3IAo
         DuogKNizI471uE/Lc1xxX1N45Cpecpv3K9L7ZQc/OZVe7GRgjsW7yGzQEyWKom4+R6Fw
         2YLFHhbro8gWf4mNVnSKyc9JrF6O1TNKMo5Q/NtIwjt/kFMF+N+B0sZHgxf/+Os0/mvy
         NK2Q8cN8ZwcmNKMo803Jj84ZLj+5MEQqKGx8esu4mzeSuyuYCdDkZ55SLZSsJmYNgEFH
         qLxw==
X-Gm-Message-State: AJIora8AhUHk7A+IF8x59kcR5W/c6Cwo5YInsZNdKALD7nL98EXAJgAT
	WXgJuc1dOxWy2aOXSAP/JQ==
X-Google-Smtp-Source: AGRyM1tHWj759XLYWGQZbOVPCyGxaGhGzD12Fzt6IGVMAuvGqbdQDnHJ4aXcSo7AZKuL7L5VCU0Y8A==
X-Received: by 2002:a05:6870:70a4:b0:f2:c17b:a413 with SMTP id v36-20020a05687070a400b000f2c17ba413mr5195645oae.14.1655290825820;
        Wed, 15 Jun 2022 04:00:25 -0700 (PDT)
Received: from [127.0.0.1] ([20.225.49.36])
        by smtp.gmail.com with ESMTPSA id c10-20020a056830000a00b0060bf670dd35sm6074697otp.49.2022.06.15.04.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 04:00:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <979dc4297888128f0d058ba7631e17415b894666.1655283387.git.pabeni@redhat.com>
References:
 <979dc4297888128f0d058ba7631e17415b894666.1655283387.git.pabeni@redhat.com>
Subject: Re: mptcp: consistent map handling on failure: Tests Results
Message-ID: <8c094a5b-0e21-5add-9128-e402297c7623@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jun 2022 11:00:23 +0000
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
https://cirrus-ci.com/task/5751797246590976
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5751797246590976/summary/summary.txt

- KVM Validation: debug:
  - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5188847293169664
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5188847293169664/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c95b21fa8a7b


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
