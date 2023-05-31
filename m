Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F2F182A7
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 16:28:47 +0000 (UTC)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6260de7cfaeso30684956d6.2
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 09:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685550526; x=1688142526;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqBqWmvAnl8LfiZTvBOaOo86sRuEoRwJoWzSbY6HrLg=;
        b=MhGdXmzeZdvQ2t9XrOiFmHXm6pSdqSSTKHwWW7Z/w2Qcl7nzNTDsb4H0I8MCNM0DLG
         p98B5H28+6Ah2qL0wss9wPQUrOMAoDqb7pRx/7cFvHuZY98gzNvBronyzLaMFI54ALe8
         1tzoVNvCb0odEZkVtF7eu+tzTzgj+qicvuTgiYg+t8AUmNSRwPY1uuoKe5RR674pT/py
         4KFaVKcZbjmBDRp7g5n/1h2qOMpDxzp67la2NxFFuSLN8/suq5xhoJtg2iEuY5JtJS+N
         gGgJudUYm/ch4U/UMJHT1JsheU3hsl1uyBOiLttsgsUFXJMUkvg+HXxbOAHzisjHzBxq
         +lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685550526; x=1688142526;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JqBqWmvAnl8LfiZTvBOaOo86sRuEoRwJoWzSbY6HrLg=;
        b=YecpkScnzEDWgNlI0jX+NzJnZzhF6ou6Pb4BswO2+h30pYFCJPfIdXe4I7FEIZ/0te
         NHPRynV3x43tCIsT1GAI5DKEodfPu8Gf3KgBcfn+0v5+CNcDjANByOqGE/YnzT7jx0qs
         6IKUnCFhZ76zUBAV0Q60bZDq/QOU4NecLDfoIsCEWhDuVnPp0Q0qEy1dIsVlQcYF53sq
         Om7Qaw1tIPnEfadp08OqeSB9OsIGLiDc1IflIRO/eMDjlwhN5oyhtDDsacqmVWcBvmJ3
         DlOxYLUj74wvwnMNArN261R5+ix/N6S6MxzTz4Fw0tlUzxLnaqRVB1UMfGnPDL7HhbEv
         G7Kg==
X-Gm-Message-State: AC+VfDzLnP4UBLMDDkSo9x+0mTS1MVwgRZqQnwLUw98cNwkXHD6kWiZA
	EiJOjmPQ8krJvRkSiiNqGQ==
X-Google-Smtp-Source: ACHHUZ4i4VEIYsuawtjmzJjjLTIBDw6Q8jvVwAf1/SSBv11QS1BGQCVxb2+0gaYuDHq9wBtk3X1Nag==
X-Received: by 2002:a05:6214:1309:b0:628:2d00:5301 with SMTP id pn9-20020a056214130900b006282d005301mr2048134qvb.39.1685550525972;
        Wed, 31 May 2023 09:28:45 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.36.116])
        by smtp.gmail.com with ESMTPSA id s12-20020a05621412cc00b005fe4a301350sm6028893qvv.48.2023.05.31.09.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 09:28:45 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ae994823d6d110c718c395a2756e58c52848a12f.1685067241.git.geliang.tang@suse.com>
References:
 <ae994823d6d110c718c395a2756e58c52848a12f.1685067241.git.geliang.tang@suse.com>
Subject: Re: mptcp: unify pm set_flags interfaces: Tests Results
Message-ID: <8f9270a8-78ae-b081-1ae1-74f07e0fc3ab@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 31 May 2023 16:28:44 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4573693066608640
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4573693066608640/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5550058117005312
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5550058117005312/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4987108163584000
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4987108163584000/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 4 failed test(s): packetdrill_fastopen packetdrill_sockopts =
packetdrill_syscalls selftest_diag =F0=9F=94=B4:
  - Task: =
https://cirrus-ci.com/task/6113008070426624
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6113008070426624/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/bfddc60fdd08


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
