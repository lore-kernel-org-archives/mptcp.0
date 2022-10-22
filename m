Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ECE29AD
	for <mptcp@lists.linux.dev>; Sat, 22 Oct 2022 09:58:58 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id r18so4618373pgr.12
        for <mptcp@lists.linux.dev>; Sat, 22 Oct 2022 02:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tAUhV0HZn8vo73unj0E9dfLHuwofpkRyR3KkAY0cs4=;
        b=iHs+K24xJ++TBcV2i8rb9iI9wbRpnXrkCN654LYeYJbbO65Ncrmdyeh6LM/M7pNvRm
         Lii5OFGgtgIft9jY5qBFBksi0MV+TrdmeqTC306k0v3qHJ3kQjgtQ5zI8yGrM71tdyFF
         5f/8ufYhy2uwMdu7W/WKx/mzjCcUTgMy6rFWfoPwKvsdYj/Av2g/an2xjYBIIGVtPD6/
         wshmKEV55UyblJeA/oXnNemyKUiqYsVSBhLra8MIBb1iQt0KkSwGxUVl4YHw64hOmVwV
         snR8PrU1iOoL9RmZmGMOdI34brjfk96z6XTEKiP9J2gAeKzBUDUnA3uBvXSvE4HddEep
         knEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5tAUhV0HZn8vo73unj0E9dfLHuwofpkRyR3KkAY0cs4=;
        b=Vr/vX7GOMac8TlhkuvXE0H1yw8j+H5VhQHN99hikzq/YZnVAkEG/spv5JPiLz3A78l
         dcmHAnKuhiT3NswaMxHQPAR3blVjl5tDfdyL62crK2wl488ddVrAK0CBOpko0QiSF6Wf
         PeKS6xCXfkaAxhLi1D049ZJAM1etKDgVTAlegECXDwDfmOqGR6PG48tg1mY0zZ/QShJc
         qPvwDEsUxvSStcEjiuIl4mZkH1BORVu5ZXnqNk06oRZsxPCIFdOyVBmxxqZHx82SoB6+
         Uh91E9f/Xox3vYZvJ98afL7evHjICfnzXOC0pKpgXhFknQzem9XqFv37Nt1pSBCg/Zd4
         V5TA==
X-Gm-Message-State: ACrzQf1VMvR6q2KLjbf0WTEBE/9DoPCP/RJy2DkzEW4a9mV6G6Ukm/MR
	pL31EiAnwPeS5e03IWQ0NDTRg2Yc3Q==
X-Google-Smtp-Source: AMsMyM5XnpAHWsIYuFPG4RBB1sZyd8EjdXDl3SR9eD4VNUhf7Dl6Xg9TpsgE12oCq1iwdxUUn89sbA==
X-Received: by 2002:a05:6a00:1707:b0:562:e790:dfc3 with SMTP id h7-20020a056a00170700b00562e790dfc3mr23747314pfc.59.1666432738079;
        Sat, 22 Oct 2022 02:58:58 -0700 (PDT)
Received: from [127.0.0.1] ([104.42.194.179])
        by smtp.gmail.com with ESMTPSA id z16-20020a170902ccd000b00186727e5f5csm3464163ple.248.2022.10.22.02.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 02:58:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221022075412.471-1-geliang.tang@suse.com>
References: <20221022075412.471-1-geliang.tang@suse.com>
Subject: Re: mptcp: fix divide error in mptcp_subflow_get_send: Tests
 Results
Message-ID: <c7e49e02-442e-aa92-6fd0-9b41e3afcf28@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Oct 2022 09:58:56 +0000
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
packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5728997552685056
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5728997552685056/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5166047599263744
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5166047599263744/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c5b3f2e01f96


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
