Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06607A
	for <mptcp@lists.linux.dev>; Fri, 10 Jun 2022 07:11:55 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso1444042pjl.3
        for <mptcp@lists.linux.dev>; Fri, 10 Jun 2022 00:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=QWPE3CvL5FOJty1nkqaZovNouMmw16v0ReZsOAs7CAk=;
        b=mKrPV/NPCx1Ldm3tLdSjf9Llf2SbEeQ2Y1ANeh0JgjA1jcAX+UvlaSOdrx3b1HAf54
         KoYyraEd6QaqsMC7ejB90Suv3ApqBUxgwLzjnkv9lhDvcqGXywedgtfb9LVlBlhfK1Jq
         7c9LEtoMtE+4AyiUCvzgu2UkPF0Gm9ImmFZ3O4yqJ6cyPsPrvGCsB1zMO0zzWdcCLeqm
         1yPb3npQb0g+sTxUdHsC2GgBZxtq/5kqyT41enLg8y06tqZ1+hlvLKDmR7T4POJDYNQQ
         O9X+HunVLhzheB1mp891fMGzEwm/LDc+h8A0okIE4RJ5fKulQqdSR/JV2pbQ3lA9nmZi
         SZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=QWPE3CvL5FOJty1nkqaZovNouMmw16v0ReZsOAs7CAk=;
        b=bvqwU6Hvr7gjSFsD5aLz+NU29rSJ4rM0FiL9i0DlGsAINFBVlm5fCL2pmFZazLyPuS
         dNkPRBnVDGqavD8k5tRbWz/EJnXm9I8enP+gvbLN/B6jX5tblIDYOf+diOH/QJfH7V+b
         9rS/2WEujpRwAINiyY+WoxhO3B5APJNhQN+uYJl7mc6DET2tNkBqb35uejuJzrb7HzsD
         5S1EITLx+HdlXOsOrTrIFDD+cpaDPAVhXuioKmARdgRBUIgY+H2cstImul3tSEMv9Nw6
         nE69iManrQd81CQwZ2uUvDP2NXwKeamlPEGbfalTYDwFYAMcVOPa83Iro25f7V6wuOMK
         3pLw==
X-Gm-Message-State: AOAM532knZ0VJzU9VQWHicRBgtapvgnzRHwpIUYN9VLOW7ECsVGHopyK
	tAvgiqbDTYZ1aJ6sTW4YPY4Iu6Kup//r
X-Google-Smtp-Source: ABdhPJzVOfWffEUzVV7RbddfYTVynbXCRd0pPVITVgd2HChS5ondBsQdicelX/sK0VM7U+BQDMaOZA==
X-Received: by 2002:a17:90a:9914:b0:1ea:7bc5:8218 with SMTP id b20-20020a17090a991400b001ea7bc58218mr2143968pjp.50.1654845115012;
        Fri, 10 Jun 2022 00:11:55 -0700 (PDT)
Received: from [127.0.0.1] ([20.237.183.244])
        by smtp.gmail.com with ESMTPSA id u8-20020a17090abb0800b001df239bab14sm897978pjr.46.2022.06.10.00.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 00:11:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <4894e178ac9a9ee233246a73e5c968858b7a3a87.1654839889.git.geliang.tang@suse.com>
References:
 <4894e178ac9a9ee233246a73e5c968858b7a3a87.1654839889.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: update pm_nl_ctl usage header: Tests Results
Message-ID: <50fc4b48-540a-038e-eded-ac3b605a8e2f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jun 2022 07:11:53 +0000
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
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6017698135015424
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6017698135015424/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6246459333935104
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6246459333935104/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/c86f7081c919


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
