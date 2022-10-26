Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BCD1374
	for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 12:20:14 +0000 (UTC)
Received: by mail-io1-f43.google.com with SMTP id p141so211768iod.6
        for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 05:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ui380/532NiL76otPywVcSoqxIlAN37vHNx8p+3gZzk=;
        b=PQrVX8O2VgIpNh1nskvYZ6O3AJzgxTpfS6vGPG1dS/JvMX4abVbocY/fF4IvjV6IUq
         XVNs4gwtj1gHVfOaB3lloR/z3EZC+pXPEw+PcHcMUpgXNRM+7KjI6gh37p7Yzr3WHaG9
         gCL6NV8VP66Icz3/gAaZCg4W09PNgncO4Y74JXbysD4HfLX+ni2sa9LX7gKEPa/y/MbE
         25e+05mv+881j5dnujp1f/jKh9DNBuDNqN4HsJY+mm+4rYfeMAAwOxbzE0ScZu4nCA98
         o1W0I7VhTtg8gXu/y1YIWgfje4fNcJ9ZHtEznnjWRjv1zJl0eYOaDq/GTwALGgw0Idtg
         nxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ui380/532NiL76otPywVcSoqxIlAN37vHNx8p+3gZzk=;
        b=H4AOaU9pmIvwKEuKscsdl78VogLt+/AtLH4+WM4PKrfln3d2v5by8UhVXGDXAgeasV
         IqzV4Gxl6wIZ1PKAEwA0lXDtncnjgoyQqMUZ0vO6vzaogczWxyZZfyBK/DDQfT4EjS5k
         fgbONwVscxN3EvyZ5VoC6MwwPTya19rByi7L708K6psuo7j62ErYvpNmVVaAeQ6FFoZA
         Bx4ABWavfinnc0ereDJ/7GIIqFVSeKeBBzPtOTZwzaRtgZq6Is+kIqShFRMTneHp0i/6
         wOL0TEGKE5u4S7Ls2TJqRYSevHfjRIfn5WTi4yEhC9SH1x4Jwfz4PS42nDBE1DN//qDP
         GuzQ==
X-Gm-Message-State: ACrzQf3vxexwJiYB53DAeUm9RHY77kh9ARylZimQjw8cR3+Uuj8B7wFe
	U43HjkFVRF/r74UKSrrr5w==
X-Google-Smtp-Source: AMsMyM7aYEARXSYs4DsIXWq2dXRdDrXU/Y3uSOuXD47Wd7TGbYsRf3SHqAwaGoIjhz/l7rt7U1R4JQ==
X-Received: by 2002:a02:a913:0:b0:375:c2a:6578 with SMTP id n19-20020a02a913000000b003750c2a6578mr3486608jam.88.1666786813650;
        Wed, 26 Oct 2022 05:20:13 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.254.112])
        by smtp.gmail.com with ESMTPSA id p13-20020a92d68d000000b003002d1ba94esm1994566iln.42.2022.10.26.05.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 05:20:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <c390b060596c5d0553ad7b388d2dcf76fe034968.1666780919.git.geliang.tang@suse.com>
References:
 <c390b060596c5d0553ad7b388d2dcf76fe034968.1666780919.git.geliang.tang@suse.com>
Subject: Re: mptcp: add pm listener events: Tests Results
Message-ID: <af86c0dc-264a-1be9-e933-4d2b100aae5d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Oct 2022 12:20:12 +0000
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
selftest_mptcp_join selftest_userspace_pm =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5474410546069504
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5474410546069504/su=
mmary/summary.txt

- KVM Validation: debug:
  - Unstable: 3 failed test(s):=
 packetdrill_add_addr selftest_mptcp_join selftest_userspace_pm - Critical:=
 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/6600310452912128
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6600310452912128/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4458805fd0e0


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
