Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3B9624
	for <mptcp@lists.linux.dev>; Sun, 19 Feb 2023 08:38:14 +0000 (UTC)
Received: by mail-il1-f171.google.com with SMTP id v8so52716iln.6
        for <mptcp@lists.linux.dev>; Sun, 19 Feb 2023 00:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diqnONTFCRevvqsJFVzSVYmKM5TLPw5CWvWxQwDdDsQ=;
        b=NsqmjmKpDUiUjjbEDY/EL1877PlwKvhQcwhnjxZxLk3+zYqQ10sWJP1iWycQbz7z/3
         5uLzjM5z2g6fQLTActkLKRv5m14+L9FkJVTi6qu+KgLgcRGU2nX2m+IHPon8nfcpLG4p
         ZHyxg+KjAsa5SANAIHRHTULLkujq8uofzkq2PAU8HlqGZdLtmZZRSh9OWRy731bYfdym
         b4Yi7tLN1L8/obAKkjNW4aWmV45IOHyG6TsP104ywtLJw21LGgz/PZiTuLZRphZSUhSR
         7D8nBp/+XyK/K3u2UO8lP0xo+H72hSUdCzKlzV6CjMNZAJhcEyS3Tt3C2UISGQ2evpUe
         aK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=diqnONTFCRevvqsJFVzSVYmKM5TLPw5CWvWxQwDdDsQ=;
        b=HoWz4O5y/dhEPmwWdz1PzKRxuJDIkVtbm/jzQiNARHNC7y6nq4mT/DjB2jSnBBQHHZ
         0hbzNLCUxIvifY0nGbmMYbR7xqEBcauBhHW6yH6f9xHOzfKGtfFJMUT2OuGH1zdI3oJO
         toDF4CkXgLiLm17NLLTM4oVbFwjQ8Grwg/If+90sOREicUwK8783zsqmh/crsQknURiz
         K5gwaL16geDSNra/qen9I1XaBGRkhsYPBFMAaoA6cQQNxvwIH+h37z11Jf59+Nz7FmUy
         bULXHEURhven+MA9kFVHc0tboak3/HyTeX71vAYADy2cC8jcf1dL8xgGEKvn2V2U2M6S
         e/Gw==
X-Gm-Message-State: AO0yUKXnuEqAxIceR8x7j52oACLrgjYX5k3AreanQNg5vlsvFsEnPjcm
	DjxRubE5StYI/gI7NU0k5A==
X-Google-Smtp-Source: AK7set9XmvW1u/6UcF5k0IP+YGcb+8zyuaEd5PZONZsK1Au6KgPPR5BTejP259edczGJRJ3aRCDmcQ==
X-Received: by 2002:a05:6e02:20ca:b0:310:dbcd:942c with SMTP id 10-20020a056e0220ca00b00310dbcd942cmr1997682ilq.21.1676795893094;
        Sun, 19 Feb 2023 00:38:13 -0800 (PST)
Received: from [127.0.0.1] ([40.77.92.209])
        by smtp.gmail.com with ESMTPSA id f1-20020a056638118100b003bada974a13sm2791851jas.165.2023.02.19.00.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 00:38:12 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230219070124.3900561-1-liuhangbin@gmail.com>
References: <20230219070124.3900561-1-liuhangbin@gmail.com>
Subject: Re: selftests/bpf: run mptcp in a dedicated netns: Tests Results
Message-ID: <08b1b758-3eae-f2fd-5db6-f329a4902178@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Feb 2023 08:38:11 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Hangbin,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6016037968150528
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6016037968150528/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6578987921571840
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6578987921571840/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4749400572952576
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4749400572952576/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5453088014729216
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5453088014729216/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/897f90e8a312


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
