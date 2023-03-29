Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086802578
	for <mptcp@lists.linux.dev>; Wed, 29 Mar 2023 14:34:20 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id ix20so15125559plb.3
        for <mptcp@lists.linux.dev>; Wed, 29 Mar 2023 07:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680100460;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KO/qsPQswwfdiuparzsHn3g0jUcd7us9bgBn4wD0aM=;
        b=oAp0GBdDLDWu01ozV3XgXEcWkWuI5PlDjiHyBmTWSgk+57z+dIc+Pcgurblb7w/dfh
         iYtT9Mk5VKjtj2eLrc/ekgk91UMAQ+wDWLu+uV4yAK4j5qKV63EIXDTfpLnANd5LrgRb
         mAAwD2vjvIwf1JyO0mrvn2vrTqjAYwublDDiDxexf/9IRCHp52nLmAGLsGJ7mOR+fdfi
         om/156JK5JVfDzrdPdM+ZGzsK+rHY8VF5zI7sMNaWgru1A99oleBZhWyC5KVYlSRE3M+
         Ce8dekagWWZzHv28l3TXSawm44VHWftcM2Hnsh2BXuE5UmkPMsdsvcME5z5pYu2a31/l
         f0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680100460;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9KO/qsPQswwfdiuparzsHn3g0jUcd7us9bgBn4wD0aM=;
        b=3XPR2mAIAY8HFi1WV9PcK3U47TwIH2Ev2TTq/LEYll2JzCDqTkoHEXTLW72fZLMybV
         Sdrsz96qZtwPTK+ccEd65x6tM4LpmEjfcNyzXBzMppqVzZpsxDCjqFyYveWDnD+LqZo7
         DrTZ94AnOet+TNQzPd6PhrcEWEzVCrSFag+nog8FadX5pwEnBlJ0mhxd+kmtNIAfN0fM
         HDImzvm0Zy73Hr533cG4r8z+jkM23QzhTWykujSrwv2TixuUyDU5h2iChtwd1xXHoYNi
         jcF6dnUOmvGlnS5d8CCOiqQyjpb5Nt6ArHhIOzvnuSgtG2VDzmYs1JaQojaOQJNqy018
         s6ZA==
X-Gm-Message-State: AAQBX9c5mYAL40n1ewdmcQaGK80kWBNmqjIpe4U8XN32CCjJyGYv1p03
	tlZlz+hAX8c+rmtgZ2NMTouxJfMseOgT
X-Google-Smtp-Source: AKy350bZYuL9nVvP++1GP+tHWKCyhCqphM6fRgglFmsRGwXvQyKFeVEuMVIjPMzX7WHN4hlhB9dE1Q==
X-Received: by 2002:a17:90b:38cd:b0:240:1e0b:a7b7 with SMTP id nn13-20020a17090b38cd00b002401e0ba7b7mr22232372pjb.39.1680100460322;
        Wed, 29 Mar 2023 07:34:20 -0700 (PDT)
Received: from [127.0.0.1] ([4.155.128.241])
        by smtp.gmail.com with ESMTPSA id fv22-20020a17090b0e9600b002372106a5c2sm1495412pjb.37.2023.03.29.07.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 07:34:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230329-mptcp-misc-cleanups-v1-3-a839001f0b05@tessares.net>
References: <20230329-mptcp-misc-cleanups-v1-3-a839001f0b05@tessares.net>
Subject: Re: selftests: mptcp: remove duplicated entries in usage: Tests
 Results
Message-ID: <adfe91e7-cd48-c4eb-ec4d-e13e4dcb9af3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Mar 2023 14:34:19 +0000
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
com/task/4990035158630400
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4990035158630400/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/6115935065473024
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6115935065473024/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5552985112051712
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5552985112051712/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6678885018894336
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6678885018894336/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/df1c60a23322


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
