Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D434681
	for <mptcp@lists.linux.dev>; Tue, 12 Jul 2022 17:44:15 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id b25so6344021qkl.1
        for <mptcp@lists.linux.dev>; Tue, 12 Jul 2022 10:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=Ssqml+DoH6nXkko27H7lrE3ggGsKgwDwXVNRtOL3AzQ=;
        b=hCTDprqvFvwZvu3NlndSH0zkgKbnYRvKMlRvMfDE3Ve4D3TYVt57RkY+9p/JEAmMdi
         DuyeDWajCsxPkS+h5jm5HpHyQJdl7f7Fj+sisag8Z37Gx78rBNbwunIfcGfoASVOR86t
         +8F/VQryASxlobcGLheNw6BHhPkhtN17/Y5kRpULnZmRFJXA8SSFcvynQlxKqBqDRjNK
         lgVrYtBoLCNIOoryJeL5h4msRdk/haQgFG4+eW5qzHrPEr8CqZXdHxJgXjk2he42ii+D
         TnvgvKXO7yvxGM4QqI0GUe2U+KQaGZcrHPs8X/p3UIlV6NxoBh3dIaZso18DO/zWrWhB
         TWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=Ssqml+DoH6nXkko27H7lrE3ggGsKgwDwXVNRtOL3AzQ=;
        b=6f0RoUl8z1G0P41vF4LMZNdlz/66rXIGBeCnFKd7dB/AxjEiaJB7kWV4xHJ/IDJzT8
         S067zMgwaegM8Unku1Pc6cMZNqoEHTuyL63MfvufsUoP4ni43MB+0/NmVMpFXuxqpWq8
         +SDmHSyczH6T22SwYDjSz5IobcfXrpKzFu448BtsrT7nKJs2KBG4qvikEISZHjjAx741
         +wRmRW/4S4Ir1AGHId7WHYk45wTdismRiz6aN71lAXBm4ltc792UuLk986h115FgIvC8
         8f5Um0LUBQ/mxflui3qtezw6LD9InwmUpBPKUp2cHz9ZI2e/ba4k+t8xBoe1Z4GyQvH8
         TGYw==
X-Gm-Message-State: AJIora+mgfhkM6FX7V4B66l5PxXWNBXDdz+ogYIHlCefebt/N6Sg84x6
	se0s8xxCZR9b/PbAPBw7G+qUkqJc2YMXZuo=
X-Google-Smtp-Source: AGRyM1uKzrj51dGijIGXYK426K/hMyInbQ8NKXJumuvImKZs5qG/aq0PRDjscbyMfyUgO/Q8Ifi8GQ==
X-Received: by 2002:a37:aacf:0:b0:6b5:6f5b:eb9e with SMTP id t198-20020a37aacf000000b006b56f5beb9emr12603696qke.444.1657647854180;
        Tue, 12 Jul 2022 10:44:14 -0700 (PDT)
Received: from [127.0.0.1] ([20.122.192.21])
        by smtp.gmail.com with ESMTPSA id i14-20020a05620a248e00b006b555509398sm10019713qkn.136.2022.07.12.10.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 10:44:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220712160236.3668376-1-matthieu.baerts@tessares.net>
References: <20220712160236.3668376-1-matthieu.baerts@tessares.net>
Subject: Re: mptcp: add mptcp_for_each_subflow_safe helper: Tests Results
Message-ID: <fbc59882-d350-0395-3ad8-976fa757743a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Jul 2022 17:44:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
selftest_mptcp_join selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4969640886534144
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4969640886534144/su=
mmary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6095540793376768
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6095540793376768/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a95c064741f6


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
