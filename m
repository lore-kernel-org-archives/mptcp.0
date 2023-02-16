Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE6B3C3B
	for <mptcp@lists.linux.dev>; Thu, 16 Feb 2023 11:34:11 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id d8so1701704plr.10
        for <mptcp@lists.linux.dev>; Thu, 16 Feb 2023 03:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xH90FZ3UJHTf6CtWmYiExGsYpo4Y7okxdMoEVUTYdw=;
        b=WPW2VXdFTdPB1dO0OQKarQOwszk1ObV+Mto8P0XSsD9w4zFKr47XOoxd9y1qgJShb9
         CeIHU3nz2+ioatFoM5hnN9p40M7xHsycILYF07uleyZA3O7JcSeymLg9CDDKnxyaEOJ0
         pYtTyxCIm8W6br/4PmwXSYMapsN5RXe5RHCS3L957I44/mGGraMn3uQnT+Bw0DkDOZZx
         2bz33QYIbrYTbXgfcQneUsgNj46yV5g3wUL9ohA2TWtYexbmIEbfSwdr9QFu1u2/wdB7
         068zWdKX+ky2LixTXsivLezOehENr4Awad79xkLrdZjbChjbJ+BlnrQPhGh3Ce5Gltay
         VdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7xH90FZ3UJHTf6CtWmYiExGsYpo4Y7okxdMoEVUTYdw=;
        b=yYsVeV1omRCZmXWZSvqF6A8YHE/+sIIm8OlyWtU5CjrvzsuLs7eswL5uldBVjaqkSn
         ivws/bL13/FYy0owZ8Seelx6EiOsz0m73MeZmYJOD8ijwnC4tQW5ns7kKI/OtOE50Rwi
         yjHBufWVhY7V1abPIYOIyqppdWjtkvIE5M0K7HS4F6i8cfo9aXtLjAkVbCqkRo+L2oqk
         kMYRK0FPtknGFynjWcPFGwUuXI6Sb9gWIHf6lh+CRpO484Ga0LC+idMDKtdA2EjO2YTO
         qvDW/RS9dl4JjjB/NW0EB5sLXdSv7aziMvGROG5VNZOfs6HNjEgYmdufgH59l0AoTCOb
         dMTA==
X-Gm-Message-State: AO0yUKWq/cbxvIHwV4i77UZKPb9RA7BolrGJGpmELA45Bpg5OLDgOrUX
	YrfYGNenJ0wm4AJ0n+1mJPbEAg3qVA==
X-Google-Smtp-Source: AK7set8pdC9+aORFKrnop3Z8InoCdQ/jbXXy+vjo1qwq7savX63qiW5ba1ZL8qmtMAwfqchBdRmSFA==
X-Received: by 2002:a17:903:2883:b0:194:a6e0:3ba with SMTP id ku3-20020a170903288300b00194a6e003bamr4491321plb.54.1676547251372;
        Thu, 16 Feb 2023 03:34:11 -0800 (PST)
Received: from [127.0.0.1] ([138.91.71.19])
        by smtp.gmail.com with ESMTPSA id bd6-20020a170902830600b0019a723a831dsm1095706plb.158.2023.02.16.03.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 03:34:10 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230216-mptcp-selftests-userspace-pm-typo-expected-v1-1-e004734154d6@tessares.net>
References:
 <20230216-mptcp-selftests-userspace-pm-typo-expected-v1-1-e004734154d6@tessares.net>
Subject: Re: selftests: mptcp: userspace pm: fix printed values: Tests
 Results
Message-ID: <e864503c-a46d-50e9-e6bf-f23ca2f69b4e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Feb 2023 11:34:09 +0000
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
com/task/5020180745551872
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5020180745551872/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5583130698973184
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5583130698973184/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6146080652394496
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6146080652394496/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6709030605815808
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6709030605815808/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c82316fdee1e


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
