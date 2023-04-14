Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EE32918
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 15:23:27 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id fv6so5893654qtb.9
        for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 08:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681485806; x=1684077806;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIw/wdXCPIKKk+Xkg4DAZo50MoQOWfEoDY5zVD45+/4=;
        b=aVMxBF6Qus1yS1H3UnU5hdtpuK1SgyTxkNu2sNXbc4Ue2AtphkKS3sSx5YnyScvPyC
         XITJENltJeO6JlpIV+18uS2SlWv4f8tmRkKpHhHG9lLBS9TA7QDAgZjHiNgJurdJTKq+
         ruJnH6uhm1DfwtzfHaKwWQIO1eNFwLKgY19hWYMrUL8yf95bJevesM18Jg1fxxlRkO3V
         SKsTp64LZg1hZAEkA70uq007lv/N4EgQH8+xpWsJ3kVrg5s7KhYWMHKF6GoHP7Ao4/K3
         ZdTUOYVyzVvEFrPNGn1b1A/Uk+w0EtDtds5loNJaryCQs72Tpd68ny5G9qq5Gr9pxk1M
         /ylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681485806; x=1684077806;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bIw/wdXCPIKKk+Xkg4DAZo50MoQOWfEoDY5zVD45+/4=;
        b=F0dwHRcXYUwtigzzdAzwmXOaRDRI6fS0kplSIzmHHzRkso1R9/1ypp6UbX44svkPc6
         ILE8S1mhFWP5UvoneiQe623OgdIX6XG4HHw45Pe82w/ZwVI2MhuFB44KHkGvTavYUb5h
         2DwBgvMOgc/K9v5z5wtmd9EYKf+iAr5RrInnifd/RH7kssZnd/sbKXQotvccRbQTGORa
         zOET+cjARafSdyqy19+2j+Gylrk3/RVoQ3OvO3lxQJMTJYukDRgE69arJczVRcvx32lL
         6NrgG7RGfIg5DFWVs6UkoyQni+9RVm1XBsZL1A+Im2hFVn9dwvQYHDj+3JS9m5cpaAb0
         H/OQ==
X-Gm-Message-State: AAQBX9ehgL0Y6oAVuL5oAM6j2CYrSSBkV4YV1Glhddk6do5fCtqGXAh4
	sM4QjKGjF82yVbwXXmO3ZA==
X-Google-Smtp-Source: AKy350ZU1toEt7NoTrYAbNBpGcTa29lBT51H6saoAUlpAet78SLkrfG45NH6RG1FZXTJJ8Zc4zXeuQ==
X-Received: by 2002:a05:622a:190:b0:3e6:4b7b:253 with SMTP id s16-20020a05622a019000b003e64b7b0253mr10683380qtw.7.1681485806784;
        Fri, 14 Apr 2023 08:23:26 -0700 (PDT)
Received: from [127.0.0.1] ([52.190.17.199])
        by smtp.gmail.com with ESMTPSA id c3-20020ac84e03000000b003e635f0fdb4sm1282632qtw.53.2023.04.14.08.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 08:23:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <291b881c99c9fe75898c0f65a0f6a49c5066a1dd.1681481877.git.pabeni@redhat.com>
References:
 <291b881c99c9fe75898c0f65a0f6a49c5066a1dd.1681481877.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: centralize stats dumping: Tests Results
Message-ID: <b1af4079-f62d-de78-07a3-9609181339eb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Apr 2023 15:23:25 +0000
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
com/task/5301653952266240
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5301653952266240/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6427553859108864
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6427553859108864/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5020178975555584
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5020178975555584/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6146078882398208
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6146078882398208/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d17c54b50423


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
