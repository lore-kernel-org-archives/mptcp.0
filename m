Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D649B362
	for <mptcp@lists.linux.dev>; Fri, 10 Jun 2022 04:33:44 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-fe4ac3b87fso1932707fac.3
        for <mptcp@lists.linux.dev>; Thu, 09 Jun 2022 21:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=JbVo9aAE2vbmWRc5fkdHVzzmASTc1dyUfmTzCZPLMKA=;
        b=b0KRFJ5nsva52kXs5v+GtPC3vNfH6S4BWX/7jtjwdl1gD3OTG0xtoiuBQ5MuzoOHko
         6ingyc2rcz6fPRUTSb/J8BYfzab2ojELAow1cl27kvHQPDQcTGL48FEKBNU0O/IDO7WL
         GE8kPLmGxA9j3tF5IcX7bT9P6YgjE90HqQBHOdMGjlOs3dLYQGL9JARUntyKJwCZSKo6
         d0gFod5tDKBqJ8Az2nCEg6PUq3QC9JP0eGmT5I267/rHvRjPvXJ53wCRdLpeSDrJ4IkQ
         qEVM00nXnmvnKnhrxH1qCmFNxV1z2XEJWJ7r1RULCsiSBpSUJj6nn0hiwXLUFLASvR33
         69hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=JbVo9aAE2vbmWRc5fkdHVzzmASTc1dyUfmTzCZPLMKA=;
        b=LAsGhu6+ag+CIxXaromg9AAhiKTIAZ5P+xz/R/UgkkxoUzkk3N+AFU4t7fpGMAgMri
         y6uBJaSV9rywVD/tIA5X13bn8Yd2hTjkWx6HIaMErAhMij6YWQvlN33Y4k1uLpxJxWtY
         F7ntZNlzmIEUkW+Ij0xmIxuqL8HVo9P+gcAASqhOo5YEYJzkVgQHc+UgHOdP9JGQA0qB
         Z/y7W3L0ljQ4spvR3hp+BcfemfgIPqNKIvipvPBu1HhKKUsmUZ94iwM1ay8v7OLM1uOe
         dS1YgfGNlRJjIjmznn46kojqVhhNzyHR+L4/B7wGbitl5g+XGJVevNxvBUWn9KkZiXFH
         ADjQ==
X-Gm-Message-State: AOAM530hr2pXdH08E30aHbiI/ITe7ZjRtJsp5Y86YTKplZC2y64xivx4
	ARqmEDgdIkBBvVdksr0iXg==
X-Google-Smtp-Source: ABdhPJxPMNWrmTIzrs7+sZS/WGBbyAr0yF8LQAGyUfx/eQg4fpzMw6ZOoxCeYuahYBTnoNLNcr8Ftg==
X-Received: by 2002:a05:6870:c1c1:b0:e6:84ac:4f86 with SMTP id i1-20020a056870c1c100b000e684ac4f86mr3746486oad.46.1654835623904;
        Thu, 09 Jun 2022 21:33:43 -0700 (PDT)
Received: from [127.0.0.1] ([20.225.140.248])
        by smtp.gmail.com with ESMTPSA id ga9-20020a056870ee0900b000f5ccbb7d75sm11701644oab.1.2022.06.09.21.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 21:33:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <829ce50fa6d830c6c5ed371e7741b6d30792d905.1654829977.git.geliang.tang@suse.com>
References:
 <829ce50fa6d830c6c5ed371e7741b6d30792d905.1654829977.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: avoid Terminated messages in userspace_pm:
 Tests Results
Message-ID: <98f150c1-b411-3d82-85e5-2971e1ced1d8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jun 2022 04:33:42 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6697921566474240
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6697921566474240/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4551674869055488
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4551674869055488/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/195087709400


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
