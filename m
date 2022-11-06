Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25CE2FB6
	for <mptcp@lists.linux.dev>; Sun,  6 Nov 2022 17:10:43 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id 46-20020a9d0631000000b00666823da25fso5371880otn.0
        for <mptcp@lists.linux.dev>; Sun, 06 Nov 2022 09:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fhc6kNUFszhm2ZGzFy4z1x7u/NsVcVfNjEps6rFtqCk=;
        b=bG7aFdkuUVp7qVUstFELxpwNPuWB5VmHGgZ9X+Vg+a/nTI8ke68SoG1K8Y4THDz9N7
         AZFaJgA+slI/OEo//m/UIyIcGOYJM/BeCxUcssbP5pKfxcQThhpis1oUVt0JbQxb+QKF
         YqN7GvNveswlgBn9dfS7F6/R8scYkPAlt560uiYJQB5dUnmq3lPI39OEYXnsG6eVBd1s
         STeHo0utGPP4g3yr/CHutOxDprygEjrwdMCdHOzQqLxtK7c3LdkT7JBB2X8gK8gE7z91
         VgAxq9ndU5Z325L+wlq0dlv22gJZ6Y1OuymPbghBFO1iLTxNFy2y8Bth5ZhszyZ3cr5Y
         wITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fhc6kNUFszhm2ZGzFy4z1x7u/NsVcVfNjEps6rFtqCk=;
        b=ktxn/Jm/5gjORo9vxNot17+6jsCcSUium+x7RjBmMvqtdMzuMj1oMqFPoZhq3AXRta
         8KK6/IbXQGN3sLIRAJvjvK6l5RBWU2F+30Ps+JKK6ue1406OMzkFkrYmexo2rsixPj/Q
         SJmicgt4QnjIktfe74H6MCA98qi2KJwOL8IxJFIdSuyX90uoX8qA4oBNnxYy9OpHix7Q
         lf0p31aIzKLdHTIhuBWcFv7AMA+bBubPTOaGnLNdTe2UmOQxZ/rMgid1d0kXfBy3/O5H
         nNh4fHHzAxRls8V4vNPSwU8iVNo/W8kAg96JucHMeJsWuOScKVg8dAH1Dc6TB/uyldAi
         H+Yg==
X-Gm-Message-State: ANoB5pls1PJrktHSKZoRwLu6d7slSjPwQ5yks9mQj1qSRTQWsd1KOt5M
	unCBwZ+U0yrNCc1HF61GCg==
X-Google-Smtp-Source: AA0mqf5dbbQibUhwwbQ/JRyhfdNWaOA2uYPHxyYlAccz/MM9NNPvL4yEKgKBy6RW6I1A7PhDXmQT9g==
X-Received: by 2002:a9d:602:0:b0:66c:e9fc:e024 with SMTP id 2-20020a9d0602000000b0066ce9fce024mr426188otn.7.1667754642888;
        Sun, 06 Nov 2022 09:10:42 -0800 (PST)
Received: from [127.0.0.1] ([70.37.90.179])
        by smtp.gmail.com with ESMTPSA id x66-20020a9d20c8000000b00661a05691fasm2000073ota.79.2022.11.06.09.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 09:10:42 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Dmytro Shytyi <dmytro@shytyi.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221106152411.655-6-dmytro@shytyi.net>
References: <20221106152411.655-6-dmytro@shytyi.net>
Subject: Re: selftests: mptcp: mptfo Initiator/Listener: Tests Results
Message-ID: <4323b0ec-515f-b95e-d945-2d977cd36dd0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Nov 2022 17:10:41 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Dmytro,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
mptcp_connect_mmap selftest_mptcp_connect =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5790712473059328
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5790712473059328/su=
mmary/summary.txt

- KVM Validation: debug:
  - Unstable: 3 failed test(s):=
 mptcp_connect_mmap packetdrill_sockopts selftest_mptcp_connect =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5227762519638016
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5227762519638016/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4bc59678c676


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
