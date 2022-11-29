Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78782F36
	for <mptcp@lists.linux.dev>; Tue, 29 Nov 2022 16:37:52 +0000 (UTC)
Received: by mail-qv1-f53.google.com with SMTP id i12so10090192qvs.2
        for <mptcp@lists.linux.dev>; Tue, 29 Nov 2022 08:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7rLNn6yGdJAsMIYdriVsA9W6DEhuobYhPUq6oZw7Zs=;
        b=HwaNdRRT0rsqqklu5NPBl2mTSUbdN2u8iA4CHlgmyn5NXKw4Mr1ggJFvAlkh4rsVcp
         HVWLaxV+KXNoE3G77uuqe8Vfq79/r0CtWTutNy0X7v1bv3sZkrsQBs1Xgo58uW0jaEsk
         3yWALaIPXFISpjYGItA1gn+F0kK13tkIp8y2+3XSHujlZ/pfZ6FrhEYV1SExfTt4RX6Z
         qJ7qih9Yeq6PMlLqEkTesqMC0JcqN3W5RTZC4ZaqSABxINsZKcNWZwZGpwzulwgh0hjA
         JUbW1ThKGo2t3RVC1fh4b5p95d4Mx05io2nJmfyN332VA1qyrcoWbk6/768PAYqVhK1x
         yWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l7rLNn6yGdJAsMIYdriVsA9W6DEhuobYhPUq6oZw7Zs=;
        b=0ep9h9KzZrZv/imxI9kTTSNoI2GhETJAKhFxAUFgwamIL0xGn+EOYXqxCRAKnGDPbS
         1IHeZWuMG6TjHVZQ/D9Gc0iCtkFKJTdqVJi6xrpfDUyMzw5jvusX8BYilRNviHFWQ7zk
         Oq/p+7nRxluO8iTPkNRD3xGP3J4I5uYTihuGPENELE9KCCr/WELaKrBQrtWhJcUaHZVQ
         6exjGn57ABD0V397gs/D9IcqNOThk7pixVwQq4CHSPaARoYt7vxmdSa+1i20moBKXpmj
         apPytwP3JouWh7qUDtQiihS0oes5Rj4xhL8DLHX76zaJLLkdNIeMLTKg30UP5nwRzsyc
         dZSA==
X-Gm-Message-State: ANoB5pnJAIlApDnlkFQROpHGQVgpX7EZdJPxsgeY9JsRVi88xdHEDp7S
	Gsn+0/nhf+APCGYbVvLurcKYEHD8vucGuFM=
X-Google-Smtp-Source: AA0mqf6lUv4n4NzkIIvupdvbyS7DKrT+rr2wC+xJSgCn/mfYbsPAEfPnDGEK+5tOLbC9B6E/rf1JmQ==
X-Received: by 2002:a0c:d7c1:0:b0:4c7:305:178d with SMTP id g1-20020a0cd7c1000000b004c70305178dmr9170991qvj.50.1669739871650;
        Tue, 29 Nov 2022 08:37:51 -0800 (PST)
Received: from [127.0.0.1] ([172.177.75.132])
        by smtp.gmail.com with ESMTPSA id v12-20020a05620a440c00b006fc2b672950sm11030464qkp.37.2022.11.29.08.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 08:37:51 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221129142010.2886747-1-matthieu.baerts@tessares.net>
References: <20221129142010.2886747-1-matthieu.baerts@tessares.net>
Subject: =?UTF-8?Q?Re=3A_Squash-to_=22bpf=3A_Add_bpf=5Fmptc?=
 =?UTF-8?Q?p=5Fsched=5Fops=22=3A_Tests_Results?=
Message-ID: <55325af3-45d3-f080-5006-e88b92fa8e79@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Nov 2022 16:37:50 +0000
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
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5929540917133312
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5929540917133312/summary/summary.txt

- KVM Validation: debug:
  - Critical: Global Timeout =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5366590963712000
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5366590963712000/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6ddc47454ee3


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
