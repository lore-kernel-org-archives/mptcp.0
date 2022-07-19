Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AB133F6
	for <mptcp@lists.linux.dev>; Tue, 19 Jul 2022 14:44:46 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id mi10so11233458qvb.1
        for <mptcp@lists.linux.dev>; Tue, 19 Jul 2022 07:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=k1wxkAAWqJhnV/rPQfsJzMF6SBRyTmtG7B5tAyYVfYk=;
        b=BUi0jQSflaUiXOxjHvANcklox+R81SieWSIxr3yzyds9Dc8rhRFZ0rBTg9kA5hkN5r
         joCf/GvtCMO3xkRrwIl6dWMfMJeTCjjUnV6ltN5Mx22HxR7ODf3SNDf/UW3bhiR7Uvvw
         wJG0TpUugRu+N3mDX+12EUJKDdf/V5SW3K/1fKgR2aIfC5TznZ0HCZBGQ2L7KfCXeu22
         JDyb/ZmaWQ8rc8MPCwFaRmR33Nvq4jOBjZ/zuB/Ln8OGDJoEJjSQKK17d9fahk2FxVaL
         J7wcub3IEXKNdT3L3SG7JRWvB6tv9Iso1zKOo3CwTI656JQSQKlLNIc7vzqm06gl9TWX
         UStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=k1wxkAAWqJhnV/rPQfsJzMF6SBRyTmtG7B5tAyYVfYk=;
        b=jKZtCcg0NsZbTkmjvFgb4YGnxYX/EDgTxeMzzLEkM/oWMU0ziNCiK0rkMJhMlA0G/2
         BU4UwLQznIdHufUI/HFao9U5Z4/xH/DUa2ZqmSHprnM1Qb2BX30U8gv4KFfbf1I/OOVm
         kcFV2x9xSK1vLqdldphh042NjdGlwlYW7lt1ao76EaZhKDWiudBEuKypMOy6APT6dYFB
         BS7xNUingrgHZiUYYUA5r6sg8z/uEFjzWWb6VZTyE25VuBsnmBwOPHpbXzwHJM2rGa1l
         PT+43d2UccWyBTfzBzpA9PlqSCikT3+6s3v3fTFiOBfQv1BWhqseeCV+1hStMo4Ufh6r
         /SyQ==
X-Gm-Message-State: AJIora/NoTqy9Xq/84xfIlwAz/+rESFeZjaFGJy9cLLCubTE4DdjyNfh
	9TqAFaJfyLZ7QEFe3u7Sl9QVeiShecPc208=
X-Google-Smtp-Source: AGRyM1urnf0fP4Tme09Y+Wuzn+JczUf50/cqYt0hHTeGpB/lcdw2Lavh7+KYyvIZXI+0+J4GSz4Lzw==
X-Received: by 2002:a05:6214:519d:b0:473:2532:1f5a with SMTP id kl29-20020a056214519d00b0047325321f5amr25366909qvb.59.1658241885298;
        Tue, 19 Jul 2022 07:44:45 -0700 (PDT)
Received: from [127.0.0.1] ([20.7.193.102])
        by smtp.gmail.com with ESMTPSA id bj12-20020a05620a190c00b006b5f68bc106sm3736432qkb.110.2022.07.19.07.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 07:44:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jason Wang <wangborong@cdjrlc.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220716044226.43587-1-wangborong@cdjrlc.com>
References: <20220716044226.43587-1-wangborong@cdjrlc.com>
Subject: Re: mptcp: Fix comment typo: Tests Results
Message-ID: <0fc467cf-d88e-db03-67f5-08e84e057592@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Jul 2022 14:44:44 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jason,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5398489659080704
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5398489659080704/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/6524389565923328
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6524389565923328/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a3d94f3f9ae5


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
