Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B227C
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 10:43:19 +0000 (UTC)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-75d342af2ceso27094939f.1
        for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 03:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681468999; x=1684060999;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sB2HqZdFNiwamrBSAFwrulfoGG96eMcbexrML9YIey4=;
        b=M5o3wj4AT/fKCT4fLB4d8CkS1OaQicdPUfu8RO6KYHRBRSsAW5pC6Ehh/6VaPHMUn7
         7yA399jQ8ZexgVYPXhoN0XbbbIUfEwFv9RziPOvnri6IecH9zr0fQCfqlG98VpbuYFY1
         QjlERrzQWLob6TgOYQlA/gvL7g8Fi70YJGZCZ6kauVQCF/ekRDFaav7YwvaW3OYqBMM4
         0hHLwKj/YsI92oYdEjB+NwJpZ2TmAGwi1TJhWF3myzIWGC4R1VjiDGgSB0YF7a0+cdR6
         ej7sxq6QoAYMyh9XWDAgI4IiqS84x0ugcgyNilTz4qnwTtxRtKZkZoC8/3YigDJFERn/
         aWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681468999; x=1684060999;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sB2HqZdFNiwamrBSAFwrulfoGG96eMcbexrML9YIey4=;
        b=ESkCoKQ3mYdF3/o3bagkiylreKrGuRZT3MhXOD2VolE+AxboKozK7Yxl2S37j24yO+
         OPLz8tqDHSCPFKauJ6d6cE0I635wl1YznZ01GZ2wV0/5Y7NROqHtxb4A/KoJh6cI11xH
         3AiUUNJi/UvCSyCQsYxJH75sojk13Csa1SW9DBy/J29wTMT9IEKwexrbVojZ0GR11xu4
         l1Y+RcImzwYrTZfqaiT5pfehHlEiPtSwb2ZXOpSDRQgN5pM+3wr3Ozc3VjJ4BbXmDzQH
         +hLeBBJjwuIg6dkEPUQopynxS2KZ76VwbI/6/pcpFUmKR5KmbjIiWxVylY6H+YJtRILD
         sQQQ==
X-Gm-Message-State: AAQBX9cdwmGhJKxE/GOL+CSZRvEhtyOYGwWq57okaSfsTLF7NOXrRjbw
	hj+wcEJ7YseQWwvmPCcAOMhYhxtN2V8J
X-Google-Smtp-Source: AKy350awfx8706jsKFfwo1eHXPNCuEannEOCbdPXswXKTpvkz3GljqhEPuSlkhzpHSWUnbxohS0IEQ==
X-Received: by 2002:a92:d802:0:b0:325:da54:ae8b with SMTP id y2-20020a92d802000000b00325da54ae8bmr3062493ilm.9.1681468998932;
        Fri, 14 Apr 2023 03:43:18 -0700 (PDT)
Received: from [127.0.0.1] ([40.77.92.113])
        by smtp.gmail.com with ESMTPSA id ay32-20020a056638412000b0040071bcb216sm1141896jab.102.2023.04.14.03.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 03:43:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230414092934.4065227-3-matthieu.baerts@tessares.net>
References: <20230414092934.4065227-3-matthieu.baerts@tessares.net>
Subject: Re: mptcp: bpf: Remove unused arguments from btf_struct_access():
 Tests Results
Message-ID: <840d6c33-db92-ca00-46f9-5f62b1f473c4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Apr 2023 10:43:17 +0000
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
com/task/5059865924599808
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5059865924599808/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5622815878021120
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5622815878021120/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6185765831442432
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6185765831442432/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6748715784863744
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6748715784863744/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6d8ceeecf1d4


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
