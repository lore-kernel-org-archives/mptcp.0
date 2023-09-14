Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE67FBE7
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 18:24:53 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-450f46861edso618850137.1
        for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 11:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694715893; x=1695320693; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGhXvSh3AZRdBH3kjsk+7X2VCKWgs6x5S+P3vjYt5G8=;
        b=oSKNxRCyQn6eof+UIsyPya5I6DlukuDPq9vjPErWrKXpdzL/t7+7AXZXpZbE/gNDQO
         em5ndcpmPtkjkUct8HEsbxeqYXSGpQJkCFxwQuCmvx+mga/Xs2yGLlejvJO3Mi34fzK9
         ElMVoNzzL8phE+KIzQUegWm7XQmT4kcNhHRnByuR0ydHgEV00XXROJAf8q/3ym2gV8xC
         r6tjgXgbksqR3DZBiLGq0TdFiezmpfqRF3YDeStupp59w8utAOWR47Ls3FDLYm7zAZRs
         jxxiwK50vYgvfZurwpHezmurdjFKEpMZzvV9qixfVoIyEOBc3MNXMLCY/AMzhdcyXzsw
         1F0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694715893; x=1695320693;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mGhXvSh3AZRdBH3kjsk+7X2VCKWgs6x5S+P3vjYt5G8=;
        b=A88hQzLXPqfkau1ln5jWLBtb4TVTa3rWCYB0umfQSEim7WzvM5A1skr7oZOQWNq5y6
         GU6cTt3EF3/u/ajVTE7sTBAgD6CXEBAimohAmGYbX1WfwJmryGy65R26BFJuDU+oGSyD
         VJmT6vLv9vwThuJqBGZAcdhRfWI6Fo3iCmxz4lonGX7Q3vmPMT82SLXPRoSm/RzP+6po
         HO3T8eWy4QLwedPVWxdVdChNbb1t+NDhq6rRDLshdCu4rdfMLo5ZwgtAM+2hQt+P4M99
         H4SydtCrKifIz78xp/qqBlk1RQdhjzU6GPBakDvxLSKBkfxisbLLC5NENzLn1XqYPQAn
         Vj1Q==
X-Gm-Message-State: AOJu0Yx3Toa6Wd2OsVrMtMZgkDri1wG2MMBr1hmPFkm/zgjwQtO3PaZe
	Y2DgLjgqXMKO3NjIyP8zvw==
X-Google-Smtp-Source: AGHT+IFPA0wX5j7ykxczqvz1z0K3huMknZ/rxa9ENkJpfjaHAjtvuFIavksYlb2BMvlMSfTJ+i8LqQ==
X-Received: by 2002:a05:6102:15aa:b0:450:f9eb:f412 with SMTP id g42-20020a05610215aa00b00450f9ebf412mr4267506vsv.5.1694715892789;
        Thu, 14 Sep 2023 11:24:52 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.44.133])
        by smtp.gmail.com with ESMTPSA id d1-20020a0cf0c1000000b0064733ac9a9dsm643629qvl.122.2023.09.14.11.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 11:24:52 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <91b50314a17d427087f718d4b77aa23dd07fcde4.1694710538.git.pabeni@redhat.com>
References:
 <91b50314a17d427087f718d4b77aa23dd07fcde4.1694710538.git.pabeni@redhat.com>
Subject: Re: mptcp: refactor sndbuf auto-tuning.: Tests Results
Message-ID: <c34064f0-3c5a-9f00-62e7-0b1efc89ba0a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Sep 2023 18:24:51 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6279691204558848
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6279691204558848/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 3 failed test(s): packetdrill_mp_join packetdrill_regressions=
 packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4736620755156992
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4736620755156992/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5435266274426880
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5435266274426880/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5202597829672960
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5202597829672960/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/1bab8fbe6c42


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
