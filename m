Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D977C33DA
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 13:36:04 +0000 (UTC)
Received: by mail-io1-f49.google.com with SMTP id l127so10793940iof.12
        for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 06:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11gF0rfrB86afEhalmO0peAR8m5XOy/k6sHAPj1S/m0=;
        b=RQOHfOAhkJ65UrqPJFdZJ4hxKaBQQdEsi/tRHmp42HS8rlxxViiNHXVBA50fy+b/QC
         BILnSSWzmu2Sox/7GzMN81raf6r0UpNyOsIBJ6B2+w+ycCiMA4QD2xehMb7s1SybJVYY
         /4fACJhmphJ1KWxaeoFoLcTw0GICSo7/ZqAG6n5mAxol5Jq5zpFMwr5hPYjkbdCI6GjN
         CCPn9Vhcn84jjSHknYPCajPL2dWCeohFkW0IrBTDXsls4FV+sTyqBkQG90Z2ZUhTbYrV
         poaL4Dr0tWizm71tca8cg0Jwy7FjnODi7wTXAWBSfJKgwZngbSzvuZd9GHMTUcKyuzds
         A7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=11gF0rfrB86afEhalmO0peAR8m5XOy/k6sHAPj1S/m0=;
        b=dxmuFjrXe39SgAS8vbGEiM9YhVGndiNMU7cUCWn4enCm4vM49BZxypwIZz0CGxd3sp
         5MVYpz4QG4j5HQtkTNuWBXTv7RAjDsUkA0XSnymp4Kwc2vVsFyjnVzeFgqYuSc+kLGDa
         mf4jDfDt8aYSmUa50tjJoVimE0hM1OVeS9zkEYQ/ntNZJpDlvJpK53j8GPA2/pci/YGS
         yIjF/S24jTx+JHuy7XYSpJf4xEmh5tzR0/NeXP2VQ3zznvnUCPov03x4WaNU74J73Zci
         CaJmhBUZYWM09tQchzJhYIE1r3+eZpqlBmCGE6i+pXWNc5gkHgCj9SpK+rdQLygr2Vkh
         7m0g==
X-Gm-Message-State: ACrzQf1BxOSwofgzUNtbbZGA7nm6xesiJXaqtMX4rmghOfL3DJaVyXgD
	FiIu1Ju5EHlwqxY8hajetw==
X-Google-Smtp-Source: AMsMyM7lT5e6XsEvshkTuUiW8MCWYwGJHJS/dTMH7bbqKUkkE0aq9qSpe+guqmslT5XX6zxWFN7ZQQ==
X-Received: by 2002:a05:6638:490e:b0:363:c0fb:a5ea with SMTP id cx14-20020a056638490e00b00363c0fba5eamr4253972jab.285.1665495363880;
        Tue, 11 Oct 2022 06:36:03 -0700 (PDT)
Received: from [127.0.0.1] ([40.83.47.159])
        by smtp.gmail.com with ESMTPSA id m62-20020a6b3f41000000b006bc7de823ccsm616193ioa.53.2022.10.11.06.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 06:36:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221011120137.5475-14-geliang.tang@suse.com>
References: <20221011120137.5475-14-geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Frr_scheduler=22=3A_Tests_Results?=
Message-ID: <7ec03145-dac2-0715-a27a-c7dc8e388be8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Oct 2022 13:36:02 +0000
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
  - Unstable: 2 failed test(s): =
packetdrill_add_addr selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6091106109620224
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6091106109620224/su=
mmary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5528156156198912
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5528156156198912/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/329ea0dac7da


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
