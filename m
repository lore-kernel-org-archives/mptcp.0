Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ED82F2D
	for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 21:20:14 +0000 (UTC)
Received: by mail-qv1-f50.google.com with SMTP id q3so4489357qvp.5
        for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 14:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=GjVGl661jifo4CnaKOpjynHQsaJjNe6og9vu3FUffzw=;
        b=oNlLpITwJkt+9XPApl5xSud6xjTKoMk2qhfhjtXfEldhZRFm28Iyg1lr6vJ5Q1pvW6
         QtStG6m7VOCbCHHJzAihlzz2MWowT6NHpZWnm+80eqODzkJlA7Ebt8oQGkA607YRyaaj
         OyZW46rGzkAUIpHVlRfDLTBQFMbSoSJKyxA7B8VyLVda76wdEb2ADe9xub7il9k2w0Ot
         SOa9HCyPfRRbNIMEHl2MJjbZggcmBeinlxuh19cIZk6oecRKlKDy6AJXlGHSIxAxf9ox
         Q4g5XJEqZ415fvA4sDCFqcTlY+kVxFXesniEawMYDoqaQ/Ti6S7t8LeywHgjAlLxyoIB
         5oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=GjVGl661jifo4CnaKOpjynHQsaJjNe6og9vu3FUffzw=;
        b=d/3Uv3avkLZsmepZkcFIXIr6WpVa3MNPdPXhuM47TUcp8cZBrL72Uj8j9dMf1qhRk+
         iCvshbZv6x9og60HszKQ6nE04nL5bkXeWH+1ewOjh99HZ8GheZBuheRCqpcza8A157hs
         4ZPGVythuNKJOy7y44nDFDXUHmJTBCsOrPNsGAPs/0PagBgm7a+PzZ1i6wXfyEKE4D1l
         0BzIOePEqps88DkvUy41VO2ELKNl/RD3OzSVy1/FEjx4qiuQLdQwAzqNp2q9YTnerlHn
         ea3XGfediv1oRdDg9OuqyagzxCFp3FSwT1Ts0u+8FJ5pylfNuPxESUXhBe9p4P8T0++i
         k/Iw==
X-Gm-Message-State: ACgBeo3B6cwYrbKF3qBNO+BeCmbK+IRemok73jdm8FF2HjNDBlvbPu6D
	3AJlM2TLzYb1xTTZAInUYg==
X-Google-Smtp-Source: AA6agR5SERgWc+uLHUXjgI2dCys8gbyNK62SyoMDvngA2gasfbz7LdOQeTC/jL7uUhelM7dDnPqdzQ==
X-Received: by 2002:a0c:b4d2:0:b0:474:8739:9d08 with SMTP id h18-20020a0cb4d2000000b0047487399d08mr5140114qvf.99.1659129613483;
        Fri, 29 Jul 2022 14:20:13 -0700 (PDT)
Received: from [127.0.0.1] ([52.142.53.173])
        by smtp.gmail.com with ESMTPSA id u8-20020a05622a14c800b0031ecddf2278sm2998941qtx.37.2022.07.29.14.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 14:20:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <a5a451ed4421993380b46e8b546b228a66001212.1659117128.git.pabeni@redhat.com>
References:
 <a5a451ed4421993380b46e8b546b228a66001212.1659117128.git.pabeni@redhat.com>
Subject: Re: mptcp: use common helper for rmem memory accounting: Tests
 Results
Message-ID: <61f9c526-ec4d-e8f6-1de1-a8a25e94cab3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 Jul 2022 21:20:12 +0000
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
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6475967970410496
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6475967970410496/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6082667547459584
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6082667547459584/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/2febaa3d4a51


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
