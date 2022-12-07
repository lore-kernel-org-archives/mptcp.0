Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6B133E7
	for <mptcp@lists.linux.dev>; Wed,  7 Dec 2022 20:55:03 +0000 (UTC)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-143ffc8c2b2so22791616fac.2
        for <mptcp@lists.linux.dev>; Wed, 07 Dec 2022 12:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBcCU6siPLwlVW+TfOuUOqoRiYLgWI6sNfHOpi/CA1k=;
        b=a9aACU6KgDwv1PqFcF2JX2sny313CxzRDtrLMaHDEtSNv40WVKVx9gVCH5JfS8j+Cw
         Bxs6t1Q2syLLhtpSFSg3Ce+cqzk9ReEEv3rVVAqygoeuC5ux8AWhiL6o3RXhHFqWWe47
         0/94OhLdfhgpVUR0suMtW4oNjJ+ptmku7cQkwbk0QP30DZYC7hrhK7vMmV/5BynEKH4B
         TcgT6IA0ov5V5X4WGRwjr1lCtxHRMW1vrRYcCwjBzNiigiutXdbs6gUrs0LA/9G1D5cq
         9sbEkM6QbW8n8T6F7CFToovD7jcslo3wvN8ol7fd3KBYVByDbnWsegmKNQ+UukdplKoV
         GTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yBcCU6siPLwlVW+TfOuUOqoRiYLgWI6sNfHOpi/CA1k=;
        b=YFs18fuFBrrQnsGSqdqTi1JfP7rut8xXkOeSkcX5UO1Svs7XrLIJWavJH/eJAvvhy2
         YXUj5jdsfnV520/SD8PBkx/D3YIfNov5jz+4NGXD7DMWsWjEDQDral5iUAmZrKsrw6Od
         cPEoh2GTso0uKtoSHVMZ0dIqDAay4hWA+01ACcinMkgw+xbG3nZ4qzAWF+HBjw82AlPW
         l3ppY0Ch90gzoHwYzEbOJjAslNZlCqoSLMm0yv0LKvQJobRKoMPbzjPmOnKFLUoSQLN8
         oY8ic1rxl5VSn2PAu+OBBjlnoPGBsDAjmHQA8V6GdByoGrppov/fYSbA/xsLlDGdwIdu
         MFuA==
X-Gm-Message-State: ANoB5pl97ukcnu1NEsZ/r7lRzXv1J34CYojBT6wJhSj9AzQ+lsoeg+s0
	vyJLZFVQ3oWJIxWbmZ75QQ==
X-Google-Smtp-Source: AA0mqf6ddZ+ioe4uggM3aHT4AVt1pOa2RjCp/tGwa+N8WB6oBGKFvWbHEGZzGZ02/uX8+9MkqVgHAw==
X-Received: by 2002:a05:6870:312:b0:143:58a2:8974 with SMTP id m18-20020a056870031200b0014358a28974mr749787oaf.5.1670446502097;
        Wed, 07 Dec 2022 12:55:02 -0800 (PST)
Received: from [127.0.0.1] ([23.102.190.106])
        by smtp.gmail.com with ESMTPSA id fo12-20020a0568709a0c00b001431bf4e5a0sm12792411oab.38.2022.12.07.12.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:55:01 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0818f7332284bd7781956959fbebb90188e140cb.1670435550.git.pabeni@redhat.com>
References:
 <0818f7332284bd7781956959fbebb90188e140cb.1670435550.git.pabeni@redhat.com>
Subject: Re: mptcp: fix lockdep false positive: Tests Results
Message-ID: <55fedd22-1b19-dafd-375a-2ec6c71069a8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Dec 2022 20:55:01 +0000
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
com/task/6525687946280960
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6525687946280960/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4856789854846976
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4856789854846976/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4696100597661696
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4696100597661696/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5109398255697920
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5109398255697920/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/989a6ecd0b50


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
