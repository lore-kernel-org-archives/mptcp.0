Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2AD33CE
	for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 19:37:08 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id c11so4422459qtn.11
        for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 11:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCxZCNVmOJEoRR8ixJ+0uoCsEhoGjE342Kq/gWb7rH4=;
        b=Gz5y8Z3R7+K9OZ8mK7I4G3itVVL6LDzUGQ0nCtlrR7ulBtN/gJFQaJOeFuij6/4lKz
         Ds8osGmx6WVB9mmj6O5SYOqEMDuXgLHF84XRcsO0GQppXOjO2W5N5LFvBbSvpukNaTb1
         Uy1MMKTSAUX2AsZhwkvX3zdc1QB+fEkd1qtwH7JwfOWoEIcnVl2pJ3l+m/ya9UaW8qL2
         q/6G+Av9MQ4S+1EKX9Zvy/LAFD602+Ndr4nWGjQVNYpnTwmrCNhDVch/73iZ/qz3Cs/b
         +p+zVgvgdRpSOQnYMSaBZLQAXF7MXoT/lk/svWVH5c/FH23+Ezik1yf+X58ACn06RVUm
         MMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QCxZCNVmOJEoRR8ixJ+0uoCsEhoGjE342Kq/gWb7rH4=;
        b=XkxfI/OHAhyQj5qa2/2TIRuKhvv+LubHdv9vjiLmS4oaJUuuI+z6H61ksjZoj65XbK
         lbv/Xap/4sc2wBH/n8iCOnagdB0AqZ/90zYDDk+MJ82L+CY5CLwRjEq21FDzB6iR6M5Z
         ikIFjeItE7ps4W/6U8DuSARGaku3Gs6j30+wMFuuHODsVs6VaItJVzobFcGZnoD8G64A
         /Aogey9ji5JjCl9Hx7RQdE7HZ8PgiN/X6fnsmCGkDE/F/AZqiKLnZl8/MkO7kzygIABw
         tGQ56dGEWaSS95cQTVKLgCEKEASDx5SxhbmrO+WXJEAhkSnAzAuyWCkearTS+wwW03x4
         RFnA==
X-Gm-Message-State: AFqh2koo3zfTG5tBpe0D7aU8Ts4IhuhtizFgOO9RfqWqf43/+AepO7Lz
	3Uc5SZYeztjLEMFq4Hr5hQ==
X-Google-Smtp-Source: AMrXdXtzUWzow9+e5IqTOWCWpT6F+YCtZYEbhqzabkV8JF6gM8JOiKrhmZvbhN82WBi3zg/jVyW9TA==
X-Received: by 2002:ac8:5443:0:b0:3a8:16a7:6968 with SMTP id d3-20020ac85443000000b003a816a76968mr12110366qtq.46.1671824227918;
        Fri, 23 Dec 2022 11:37:07 -0800 (PST)
Received: from [127.0.0.1] ([172.177.36.112])
        by smtp.gmail.com with ESMTPSA id fu22-20020a05622a5d9600b003a611cb2a95sm2420851qtb.9.2022.12.23.11.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 11:37:07 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ea9b21f5551490cc9fa9d0098b4943b91febb971.1671821017.git.pabeni@redhat.com>
References:
 <ea9b21f5551490cc9fa9d0098b4943b91febb971.1671821017.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: add test-cases for mixed v4/v6 subflows:
 Tests Results
Message-ID: <8c215de9-cb36-1e8b-4e70-2a94fbb38b33@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Dec 2022 19:37:06 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6349295318728704
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6349295318728704/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4941920435175424
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4941920435175424/su=
mmary/summary.txt

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: https://cirrus-ci.com/task/5504870388596736
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5504870388596736/su=
mmary/summary.txt

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: https://cirrus-ci.com/task/6067820342018048
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6067820342018048/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5e77a2410a04


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
