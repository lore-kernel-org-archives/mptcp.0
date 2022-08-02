Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D1B7F
	for <mptcp@lists.linux.dev>; Tue,  2 Aug 2022 19:16:42 +0000 (UTC)
Received: by mail-io1-f45.google.com with SMTP id q14so11404369iod.3
        for <mptcp@lists.linux.dev>; Tue, 02 Aug 2022 12:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=Csa3X9m8hHqpRp/o+QHDoyNrFX3P4BEx6E8i38CkDok=;
        b=j97/lWFGfRwZEox1LRjpdNG7S/TER4Hk8u4/18fevs1nIEieya+JD7W8spfz4XY3fd
         XdESMuEF84Tx2o/MDUQlFPluH6wsmLzU9lZCl9UQze4Fl/mjTVLR9pYVGeG97BlFRkBu
         d3yv+Ziku8P/UQ91MKhTg2tlDtG0uP1tdnY57S+QZUwCfitvbMGHLfb1ZWmFqQDHfR1L
         1HhEvcMTQ3cbA0vJs+rXWcv0XlznOf5Aw0XOFuOppMH+B33hK4ShRntPDcKaSy1Ji9cU
         Od2jo8m7Il3tMUuXaZw4uQf0V6KmsJ3Cvwid2BZC4ViNqeh33XZLkwSGP/AXwHP4zNbK
         XYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=Csa3X9m8hHqpRp/o+QHDoyNrFX3P4BEx6E8i38CkDok=;
        b=MEvopT6/m7F8j9Q4XnZr5+712V+UWv6pLw2f1tbCY/ZVWd+HfOxOFWEirRZ+Xl+Gpb
         RYstzptY9D6zoNpWdBV+nQ+dCTA/sD/ku5WN7x483jbnS7/x220GO4sv7b/snvMEMzV3
         /OC3ml2wMBffITsqkiIGgDjNbHGYEv5hf+TXLB63ur7pV2uA0JmMNcFc5k3LaZtqCB+a
         2UDpxcBAUsElrSDV/f1yJVuQxRA4BJO/GFlgdx2psTgG/GAAgkHZtYXpCyeI0MXUu823
         3pYlTESfc28v3C0msdLi4RkDDXya3eOQHTMFTiUJFdtiS2LCSCzcDxtwenXqI360EHLh
         Lrhw==
X-Gm-Message-State: AJIora+A8Lof+3dvoP6oxk0FDzpm0+PZiYMIhQ0D0VqpSXs1aSFEkSxl
	du9FUlemutTad2s4jsoHSQzHic172FJh
X-Google-Smtp-Source: AGRyM1sbXoV0e1IJxO14P9REo3NQHZgIMdkmmfeMw7p9DZI9n15mU1xczSo+HKC+7DAX9hHdICf/mw==
X-Received: by 2002:a05:6638:3181:b0:32a:eb54:1152 with SMTP id z1-20020a056638318100b0032aeb541152mr9198560jak.120.1659467799068;
        Tue, 02 Aug 2022 12:16:39 -0700 (PDT)
Received: from [127.0.0.1] ([20.29.85.116])
        by smtp.gmail.com with ESMTPSA id d2-20020a023f02000000b00342768b3d51sm2743264jaa.17.2022.08.02.12.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 12:16:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220802163324.1873044-1-jolsa@kernel.org>
References: <20220802163324.1873044-1-jolsa@kernel.org>
Subject: Re: mptcp: Add struct mptcp_sock definition when CONFIG_MPTCP is
 disabled: Tests Results
Message-ID: <b96134f5-f9b8-127a-8806-e6e33201e73f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Aug 2022 19:16:38 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jiri,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/4921402208813056
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4921402208813056/summary/summary.txt

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/6047302115655680
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6047302115655680/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/71103ca3923b


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
