Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208FD29A9
	for <mptcp@lists.linux.dev>; Thu,  5 May 2022 18:38:15 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so8776745pju.2
        for <mptcp@lists.linux.dev>; Thu, 05 May 2022 11:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=qmf85bBrLnZofsHPy/Ei9Sz5htK+HgxrbGeSUPPQywM=;
        b=qAconjCT9bYXRo781Z2TZ2dEfXbNFOFnWnaLPLW6MIw/u3onnOUfvsztS17qn4Wmdd
         9EsyqVQtwAFofd1bbWJBpPizeBaUhNdEYYHZGjSfsDFu1+nlv8zN7/Rnx5Wb4xBiNQHa
         VS12/i4+fXRuMSlc142PZa1iatut6c6K7C6DppRyjfHGmMOMlmRiJeehAwZi77XNiHKm
         pv5gbazDQ3YpJ2bomLiQ4IXu7fgH229zGnCpgo2PEsbQp9nbdodT3UBOtaj4Wc/97t5y
         5BQnFxC0Hacvnf0Yzc6zAkULa/hbkbSwP9ppwsTALaSWJAVSEygbS6ImI22O5FP84RpG
         5bnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=qmf85bBrLnZofsHPy/Ei9Sz5htK+HgxrbGeSUPPQywM=;
        b=KzJA9wfTGewDgKM75t6WBt1vnTG55IXYe7s9paVKDx54cYqOKWdi/UKgNg7BzQdOUX
         4E8AteeM5KSww86Yx+WrzUBBPAtygeaq0rUUeQQInOlsIhg6Asa8Hs6VWiT3J7qfn9ol
         x9aLAkiBDTdRLFhSBxaWd5iLMgg+aFTylO7i/ipiHQ0nb2M72DbUgHbLtLurC5H8k0vO
         hDhb2daJLmptmCIMKVf0Aq+mK25Ly9m5aDv2kIPwcO/XpUTJZjl6stOc+BI/xd2DYn6E
         FfjZU12nhRZNt24jFRvOso6OaUTRVaEBQwFLAlSEchktO24i0wPEPPtEx1FpvDQEEFLj
         ErWg==
X-Gm-Message-State: AOAM533uH8Oy7URs+AJsLa4mn+o90k1x59vDUCZa5l/vQaWbvNfoSxzL
	cmTpDJmriahq8WebJ7abvg==
X-Google-Smtp-Source: ABdhPJyBfUkWl5OZwNCJRsH6jlLtum3wH4kEA760KoldZjSRiMKvtS/JJCIr3aS4ibK0r9DY04DVwA==
X-Received: by 2002:a17:90a:4a8a:b0:1d5:a3df:ab5 with SMTP id f10-20020a17090a4a8a00b001d5a3df0ab5mr7787519pjh.64.1651775895508;
        Thu, 05 May 2022 11:38:15 -0700 (PDT)
Received: from [127.0.0.1] ([20.66.123.192])
        by smtp.gmail.com with ESMTPSA id z7-20020a170903018700b0015e8d4eb2e9sm1837614plg.307.2022.05.05.11.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 11:38:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0343ae0f3f81535f20d387147ce6b8e4158cc1fc.1651770128.git.pabeni@redhat.com>
References:
 <0343ae0f3f81535f20d387147ce6b8e4158cc1fc.1651770128.git.pabeni@redhat.com>
Subject: =?UTF-8?Q?Re=3A_Revert_=22mptcp=3A_add_data_lock_f?=
 =?UTF-8?Q?or_sk_timers=22=3A_Tests_Results?=
Message-ID: <c0da703b-624f-9d24-c043-46da54965954@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 May 2022 18:38:14 +0000
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
com/task/5032872854683648
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5032872854683648/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6158772761526272
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6158772761526272/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/641d7584c1de


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
