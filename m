Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E432E1805C
	for <mptcp@lists.linux.dev>; Thu, 27 Jul 2023 19:33:54 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3a43cbb432aso1106294b6e.3
        for <mptcp@lists.linux.dev>; Thu, 27 Jul 2023 12:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690486434; x=1691091234;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYfVpnroXeEk9NeuczI6auuFF5Ghza4UdnLoyeuVyI8=;
        b=ew/6SlHVYVrpgdrGQD1m6VU7ESuMjUCw9qvP7Ai2dimR2LVR4c7iB/SFSYq7UlaKSd
         YlJZq68Y7/6oStvd4nAamojE7bV1Fxg07/rjZFkx/BWont6UBOsjsrOrlICW4ikHfbuf
         BhgySs1jbZDAKwG4WaA4rxXIBqZH+Wbw12UorqpCDMMe/Ua/mRVCUky0Dpk8KT9vhVsE
         sPOApSKonqNXGvL3akr68DZ7eoD52yO4nOIMOkSkHXZhBc0gQLEONBF62FTYXhKYpBy+
         1772bCmowaMpWF2c04/ecAF46ZDb+SMqpxPVy9OyGmSmM9sl9gpm0DgWULRDwuaXqhel
         Hk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690486434; x=1691091234;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hYfVpnroXeEk9NeuczI6auuFF5Ghza4UdnLoyeuVyI8=;
        b=bdT8RwqiH26Wec9JyrGnl55silwl84XBfboQr4fzhH7ohZ068o5JYBbY1dfbNMANp2
         /bp/KoVxwv9qS9dxXwV67Wwth9toZH5mXY23JY/McXnaYaNkaG6siC6zBQsoUSS6RtN3
         U0pgg2B1dgOzDyjtIKykyNTd2CA/INT0mfKO74SmGCqa9Bztfz+Vc7Kzofn9e1j6y6dA
         L1+K3//NyfFu+0z0O2kRQVQgBrE++WRJD7yaGdK07uG2MLoOCLu4GL54TvBChw38myPk
         J2Pil0FnMM+tWtuoSdjZaeIjaYyzCsaocVHWYhkCjY+bKzJ6f97bD7sGluNK1sBoNyJi
         Ypfg==
X-Gm-Message-State: ABy/qLbO7JRN/DcoppkSl8aWVdHnhUZ8OVaqbaBFcvVP5WxXo1KNErWh
	gMCHhkKQ2o0Qi3eWEHgVmg==
X-Google-Smtp-Source: APBJJlGiBFYiZPe00jxh2FzELw/+7cziggaknHdpKCGB9jyNoyVntSg9yWnwuP03aviy6f2A+tiP8Q==
X-Received: by 2002:a05:6808:1708:b0:3a4:31da:34c5 with SMTP id bc8-20020a056808170800b003a431da34c5mr174579oib.39.1690486433789;
        Thu, 27 Jul 2023 12:33:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.66.10.118])
        by smtp.gmail.com with ESMTPSA id w14-20020a056808090e00b003a390ca26aasm973333oih.5.2023.07.27.12.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 12:33:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ee258a29aba5deeede5aa200f53a1d7e9284817a.1690478147.git.pabeni@redhat.com>
References:
 <ee258a29aba5deeede5aa200f53a1d7e9284817a.1690478147.git.pabeni@redhat.com>
Subject: Re: mptcp: avoid bogus reset on fallback close: Tests Results
Message-ID: <396f9b77-1241-4a4b-f19f-3046f769e15c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Jul 2023 19:33:52 +0000
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
com/task/5479657076686848
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5479657076686848/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5901869541752832
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5901869541752832/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/4775969634910208
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4775969634910208/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6605556983529472
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6605556983529472/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/48e86d20b7fc


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
