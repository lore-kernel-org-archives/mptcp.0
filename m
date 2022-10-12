Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F51915A8
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 02:25:00 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id a24so1896928qto.10
        for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 19:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ix66tASyYZMpXHp7oxOurqxLipwHKFkL2U4ojV2tuWs=;
        b=FkKuA6Fz/CifQ5mrul6xbeQK9oQH98b2Lb2sYgZtUAnRL2oth0Kxa77BkIZzar6wJ9
         UgDqa5KzdkfiTv+MeuLnoMBmaLbsYHlAua4PbxFxQ9lzScnXQX/CKwf0g8qOFd/T9Z/g
         cI2JMnoHqNs94Fc4oFTxQZHEN9iho/ff7rq6LLBCpOg1O2/jJ1TagPCyuB5j1w6H6TD0
         BRmMhSWh2QxK+NAmnF7RoC7/2/gcrlKLwz2DcvgRajGtfGmZGhkVHUazcB2KOFEfP8JP
         2fB8DNnV0NtM4jzUtPCGek1gbFLaSa7hP3qCYhvl6rnXvhltwlqlgtCqoAMcAkvKBkXN
         ZbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ix66tASyYZMpXHp7oxOurqxLipwHKFkL2U4ojV2tuWs=;
        b=W1hIx6CWMgqQ46TeqzuCLxGrKG/1doV6D3Qg6qPC+H6W6bwziDoOa3bqs5D6vnCrs/
         Ci/6SQclZ+XmIEV6WW3qS8aeSSpKwB7KWei8Aw5bxT+8BRrNWS0Py+UdyM/dTXqg2a1L
         0O+UvTMhV/PNj/sUCSdpskjLGRUpmUYuZu7V4uLYx9BbvVqFevYVhwMnbmjDAd5EfuKV
         sgCDxyY0PFteJWbCGIjowEqY+j9yCh0oYIvdnLCbJPguA7I+jROrwaB6EmjB0f2DdmK4
         nhnO8N7dVqd8KuJ19U7G6ooihYPVADDKkQtEFhhX58Zk03U/wHFyBIe/YoONMSv+0Llg
         8SSw==
X-Gm-Message-State: ACrzQf2uvkG0DL8sO7doOQ2/ysyyQfxmC4Eg7hQ25dRwBhNcsO/VBTug
	LCx/4qGFhq1Qs+2f/oHwRg==
X-Google-Smtp-Source: AMsMyM5zYX8Ul2EFQktRBWC002nfaPrBu8F02qoFbeZyjAHlPn3eeVAdCRd0c2gpYHU7/XXcH3gbaA==
X-Received: by 2002:ac8:7d93:0:b0:399:35e1:13de with SMTP id c19-20020ac87d93000000b0039935e113demr12809406qtd.649.1665541499348;
        Tue, 11 Oct 2022 19:24:59 -0700 (PDT)
Received: from [127.0.0.1] ([20.12.12.96])
        by smtp.gmail.com with ESMTPSA id he35-20020a05622a602300b0039a55f78792sm5470167qtb.89.2022.10.11.19.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 19:24:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Menglong Dong <imagedong@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221007092922.13169-4-imagedong@tencent.com>
References: <20221007092922.13169-4-imagedong@tencent.com>
Subject: Re: selftest: mptcp: add test for mptcp socket in use: Tests
 Results
Message-ID: <a2593522-61f0-c017-0d19-2541be76f2de@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Oct 2022 02:24:58 +0000
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
  - Unstable: 1 failed test(s): =
packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5412647641284608
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5412647641284608/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6538547548127232
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6538547548127232/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ebf2e7e28f93


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
