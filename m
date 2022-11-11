Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD2120E7
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 09:53:11 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-13ae8117023so4899861fac.9
        for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 01:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5kOVsPVh1VWh7NDuJtn0suB4fPouJsBhw228gdrCvg=;
        b=H0EYmgWTEMJDWEGQGHr3IX9FlUMQzRHtLcf2EQxanWzJnu7QDLVo0TRjwtvkg1OgzM
         AtEwVQ0/q0MZAEXUsoYG3np4xcoRh0vU2pY0oIYttIItZBzFvkGMOpzNdPiAPUQQeK63
         w8SebSNOIBUCiYDzPhWzZs3gNMqh78JGG+Cc7tU9Lia9zNzFDkYqRWVd03ZKGrgxVgVR
         tAu2z6rURwEnrTa/XK0Yp5AS8VkKpBWIUwbcHdM2E97pm1zSFq0D3qwdrvoYRH54G6j2
         ESXcA0Zm0kKddp95ygKFYqcI+r4BiUVt/4hLPMnwAHjwZ0arqcwEQT4cj+yTHh4rViCk
         77nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W5kOVsPVh1VWh7NDuJtn0suB4fPouJsBhw228gdrCvg=;
        b=JJe2BYfEInduCkfpZgeSYwk5vCn/OWsTmfc9+TSCt+WF8x7XZxFuBqU6SB4e3mcfkJ
         XOC/ZXPbDGzh24HAUvplgpNGkOd4EZIOIxZ8bv9OgcDxX386/pkHsKgypC8rbgNKHPz+
         Yp5r/jn33aA4uUNOfBHDsXW+SPxepLucNYtDHrYbaCS6lHID2BkX74jUajL6TQD6jsse
         DpjKq0THmBzlxuUz3DKjQ+5ag9yJUs/Hyne0auq3te6hse41U+KfE3KkqOnAHwGxYGxR
         48M3DJZ41PJHiT8K66HuiO/HrBFkPVJoliyHjbve1aD0fUlkmGdnnmPRbFpToaG1ZY4I
         7weQ==
X-Gm-Message-State: ANoB5plqDaCc0aJP0F3ccW9v+ccNXj+K61QjaGSlXlPXl47v/Dvqi/nJ
	QpME+KEMCMcpylkOolSt9Q==
X-Google-Smtp-Source: AA0mqf7iDzOh9hUWkY5EjQdrrA5kg1PoxApmpuYHEUz2h6//V+tYvqysmbXJo5mKd9PsZdQS/r60ow==
X-Received: by 2002:a05:6870:590:b0:136:3535:cf38 with SMTP id m16-20020a056870059000b001363535cf38mr427953oap.73.1668160390289;
        Fri, 11 Nov 2022 01:53:10 -0800 (PST)
Received: from [127.0.0.1] ([13.66.10.160])
        by smtp.gmail.com with ESMTPSA id z41-20020a056870c22900b001324315bb6asm1016968oae.29.2022.11.11.01.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 01:53:09 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d1d8d0acb444c6ac39eb6ae945bf439d633e74b3.1668151131.git.geliang.tang@suse.com>
References:
 <d1d8d0acb444c6ac39eb6ae945bf439d633e74b3.1668151131.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Frr_scheduler=22=3A_Tests_Results?=
Message-ID: <49cb0f16-208e-5231-e1c9-31130d0eaad6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Nov 2022 09:53:09 +0000
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
mptcp_connect_mmap =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5566491222343680
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5566491222343680/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): mptcp_connect_mmap=
 packetdrill_add_addr - Critical: Global Timeout =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/6692391129186304
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6692391129186304/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b52f03a91914


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
