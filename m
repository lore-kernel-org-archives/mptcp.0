Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169D82F3A
	for <mptcp@lists.linux.dev>; Mon,  5 Dec 2022 22:52:18 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id 62so11767148pgb.13
        for <mptcp@lists.linux.dev>; Mon, 05 Dec 2022 14:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHtFHmF8i4JZD2O4bz5pOC47GVc/LO/ZE1LBI7JBFFw=;
        b=Q/BiSK4KygODCbgn2M6vQp0ZCOb/BKYH+DbI0jjMGEPW5NBOVB3pcCnrSo63lkkeuG
         E2k1yYbSuLy3ax6rW8pJTCc+h1GVXpn0GdzTKDFXyn+SoYE4Ot7bEfwrW+BIIDlLFfjJ
         W8wj/0FJ64dhhvPyChRIA8phCEYBQYB/oV9YV9x+DWGcwAyoMmq3qMaGcunGRwHE0yZr
         sn4UjfwxScqWfhQ5CqqslUBsvQJKxLWSpy2KrZH9qd0uDMBz+/UQ+Ka6jAshf+JAk7GI
         eplxefiyFWx3lQ4nW0lPEivuQz4Kry4It1S8lPWAbmBACVpFleinV7V2gQFk5TRMyMLu
         6AaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hHtFHmF8i4JZD2O4bz5pOC47GVc/LO/ZE1LBI7JBFFw=;
        b=gOjHQiGPtbI79o417HpE9osnwxlrjUU+439z5fd2gmzAaFL6Z8XgpGV7fDnuoWHY3/
         W3sITwO3eRBN9ax091Qz1uJnEbTpnwb3lpVeqr3Au9/ea2EPO14p7JlqKvxKtSWu6/ra
         sNJfHO6/hmsGj8DhqwGCB4Dq8oSh3PYk9tWzElAZcvm+XlPe0xgzyZiLuEN3bi1+5Gdm
         UYwY2+CGUvdn58WE+85/eSxhnL7p3I0KMM/fGc+GyaD3MTNBZBQx51XIbgkawbAx5WhS
         k4Wjebo9tqWfhiYCxoc9bRZNofQvpN8iNVnn+G14lolZiCqfXEChM1UUFl7cjzQFrFRW
         u9mA==
X-Gm-Message-State: ANoB5pnHaPQrWC87HzGBNgTcrJ/D5N9w9wMUVuVifvSI2QPUaE+oBKQq
	PoVq+7oYqW4kzG0LikVdAMrbL29iRJy4
X-Google-Smtp-Source: AA0mqf4wm7BhJlQTzMakkdvmiS+UYLeweAQp78zo/QyfvfV10FbidMRZsnZXP28nzQkO0jdvNH5fgA==
X-Received: by 2002:a65:4b8e:0:b0:478:d3a8:6ba3 with SMTP id t14-20020a654b8e000000b00478d3a86ba3mr2539129pgq.615.1670280738476;
        Mon, 05 Dec 2022 14:52:18 -0800 (PST)
Received: from [127.0.0.1] ([104.40.35.141])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b00186727e5f5csm11087366plh.248.2022.12.05.14.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 14:52:17 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221205101002.2620762-1-matthieu.baerts@tessares.net>
References: <20221205101002.2620762-1-matthieu.baerts@tessares.net>
Subject: Re: mptcp: return 0 instead of 'err' var: Tests Results
Message-ID: <80447522-7ddd-14d1-6c17-c6fed1ab665d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Dec 2022 22:52:17 +0000
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
com/task/6314116181131264
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6314116181131264/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5469691250999296
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5469691250999296/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6032641204420608
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6032641204420608/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4906741297577984
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4906741297577984/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/03d981012d68


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
