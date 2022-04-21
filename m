Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B886E1FC0
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 16:08:34 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id b68so3889027qkc.4
        for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 09:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=k2u8mxj8KEXHVPEylxocidSqupiJshnvYmf/BsWr/Ek=;
        b=Cn49LcqmzRGKnHWQZbyj6sy3RYZaXw3FuXKPbI/P8F8Uc7QtnzU6dAdViDpcZZjpUA
         oqENpk01k+l2tkravqDhqE5BBhD9+J6wOziPlqnB7r7Um6dCEVCPY4JoCYE/bg2vJbAl
         9KcfOzEKZqTEK53qlhzOb6bJoVx3CqaQy1zSe5YI75eUcw+xwB03wcWnImQkCcMerzhH
         Ve+tcM18a5pPp4UFd4unGGG/hpfIr+sFBQ344c/mDdWFL1KMhfNhXKB5/bQyKEMTmIcs
         JitL6gvwKZrYCS//fsMMo9QIFeXezGzdYkTeX5gqfihDH0Mr369ygwHBLIouzKl1Zlyl
         i6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=k2u8mxj8KEXHVPEylxocidSqupiJshnvYmf/BsWr/Ek=;
        b=Q5oPXwZ7MEx2tNzSiKO6ckI4IKdnxYvMCV9d93SE4StT2W1QvC/gVTHLee1zsoB0nB
         04dmhNA9ka0BYF2Zjkj2BzYpgzyT7BW43dplhvnQDh/dbyAtsPGbcEqdJVwkj52LK3Ws
         STDgJXKKOLbiqHnjzS7T71dt+hAS5Yyr76FLK/7rOdcLo/lLVeFml4pM3aKV+WpqWz7R
         g2zrTqM9QbSWFphH7c0CQdIB+K2RWSPIv7aDFwi5q+9L7zD6Irkf3FLa2rwvg7BmuiTC
         XMHCWFSpELNxNArEWn4/dG85DMO62zhbrezIRPJyqPa57o8xMFmhnBn7vbhoi8RQxByP
         5Gkg==
X-Gm-Message-State: AOAM533AcGkApRNBz3KNAlF9tVU7vt87Mu0nuTsY/6lJW1Ik+edfIXar
	UY3wbVhTtlpMtsv7ozCblQ==
X-Google-Smtp-Source: ABdhPJzxMPhWKKup8WNejLGomSfg9oOtVVNvAPSSHC9lSy3UmsysmKcnZIWEix3JmirSpygFHkQzIg==
X-Received: by 2002:a05:620a:470b:b0:69e:bd29:16ec with SMTP id bs11-20020a05620a470b00b0069ebd2916ecmr132994qkb.134.1650557313592;
        Thu, 21 Apr 2022 09:08:33 -0700 (PDT)
Received: from [127.0.0.1] ([52.254.76.33])
        by smtp.gmail.com with ESMTPSA id f186-20020a379cc3000000b0069e82c4d8a1sm3045136qke.80.2022.04.21.09.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 09:08:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f998d6afb13f09f018d151647f8618034eaa0caf.1650550242.git.pabeni@redhat.com>
References:
 <f998d6afb13f09f018d151647f8618034eaa0caf.1650550242.git.pabeni@redhat.com>
Subject: Re: mptcp: add more offered MIBs counter.: Tests Results
Message-ID: <9096eac0-815a-3ef4-5611-024111e6c0b4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Apr 2022 16:08:32 +0000
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
https://cirrus-ci.com/task/5291819050205184
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5291819050205184/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_join - Critical: KMemLeak =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/6417718957047808
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6417718957047808/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d2204656a1fb


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
