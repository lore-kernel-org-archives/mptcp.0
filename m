Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE96C70
	for <mptcp@lists.linux.dev>; Fri, 23 Jul 2021 04:01:13 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id n10so1801489plf.4
        for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 21:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NS2auRiIapspTcJ6e3JzSQYhwEUT0aUsNcHCl7GBZYM=;
        b=uqq+p3V3tsChKFCYMnwUE3HvjKDVvla/jdWjhJFtFcM90eYJ0ydLiqYo3x85UAMDR+
         haM65WPAl3CIjadWBzASO2qfZ/y6tl10YQCdCOLL4WAfZ0f5mF1rwocPdMzWFgLRZ6Wk
         SIp7aBiCKsXcG2QHa3I/hckcT4QoWPGewwRaQ2hoz7YRIwfjUtMy9ojl5c7+k+2ZtwBZ
         zz6VMWMcaVQB/DhcnPsrQBAJkl9cMwFKPhNI8EXkU9uQdSuasyUXI0JYWaltIz3BwmGg
         j/dFxD7yun/IC5gPC4cT5GgDH3f3N0H9Wz5X4gCFQn3mjrTMSyWYPvZuk32KGV2tSQRb
         r5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NS2auRiIapspTcJ6e3JzSQYhwEUT0aUsNcHCl7GBZYM=;
        b=OUDHr+udfsAV1O7rb4/GqbPI4fVbHdfZ5MECt5cPy9RlKkUppBNVP6U9iz0XSwai69
         Ht13wpMjlTo50RqjD7mgJzHJ7mPl+wXqzxnx0qn9CMnoMqCF2mtAw8AHLie9Gb43X/8L
         m3Jfqju7IqQNAAta44x0zl2aQL6IGkok10nEzkkQoCeGaxDv/7KwxIDVD+T0sKPs8NVJ
         VBgQDkqlxgfLS365jx73xRrjTuxtPY/EfKKnMsl5aix11kCjZk6QXZkcsPkw5dvXAylX
         6Jlqlsg2ZA2qqD8p+m8+XR+YC/iVOOuiK8Cb992cMO6WMtPPP+q8JAn3g5Qo4zm1Ts8p
         KVsA==
X-Gm-Message-State: AOAM532WcAuZ2ZC9uz1dtUi/Z91uEIQ2lQJ6mmIKykQNYqh6jkTn8H9w
	JchW6wWpqNiqM2pB9sMqyjPBeIExiaKsK6mTywM=
X-Google-Smtp-Source: ABdhPJytnG9RdPHjKYq64MG7yAWFzKrnlKNgK6Q5xHGVqn5clBCVGogYCP7/YPSOHN5ZANi8bTtEUl7k22nODAW8E38=
X-Received: by 2002:a17:902:ab91:b029:12b:8dae:b1ff with SMTP id
 f17-20020a170902ab91b029012b8daeb1ffmr2351362plr.52.1627012873476; Thu, 22
 Jul 2021 21:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <d05f15b3381a4827e4c55826ca5597d9242d222f.camel@redhat.com>
In-Reply-To: <d05f15b3381a4827e4c55826ca5597d9242d222f.camel@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 23 Jul 2021 12:01:02 +0800
Message-ID: <CA+WQbwvrXso4SSLDfYBja58WsqVAfjNifFZcwAryVR8uoY1WYw@mail.gmail.com>
Subject: Re: IRC snippet
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thanks for your information, it's very helpful. And I have two more
questions below.

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8822=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=887:23=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello,
>
> moving here from IRC, to avoid disconnection issues...
> < geliang >   Yes, Netd has the similar thing
>   < geliang >   It can get the IP up/down event too
>   < geliang >   https://android.googlesource.com/platform/system/netd/
>   < geliang >   So I need to add a new flag full-mesh to netlink
>   < geliang >   and drop the notifiers
>   < geliang >   and add the addresses array in
> mptcp_pm_create_subflow_or_signal_addr
> < geliang >   I'll do these things, thanks Paolo
>
> Note that the array size should be limited by the
> current add_addr_signal_max (and thus should be max 8).
>
> Each array entry should be mptcp_addr_info, that is 24 bytes.
>
> 24*8 =3D 192
>
> The above *could* be a little too much for a stack-based local
> variable, anyhow the kernel should tell, if so, you will get a warning
> at run time alike 'x function is using y bytes of stack'.
>
> In case of such warn you could:
> - dynamically allocate such array (and fail if allocation fail)
> [or]
> - add such stiorage inside mptcp_pm_data
> [or]
> - something in between e.g. use a local variable to a very limited
> amount of addresses and then dynamically allocate a variable.

If the endpoint's flag is subflow,fullmesh, we need to get all the remote
addresses. So we need to record all the received ADD_ADDRs. Should these
two old patches work?

mptcp: rename mptcp_pm_add_entry to mptcp_pm_anno_entry
mptcp: add add_list in mptcp_pm_data
https://patchwork.kernel.org/project/mptcp/patch/ae0d32922128771f09b230e571=
8774472a088207.1621002341.git.geliangtang@gmail.com/
https://patchwork.kernel.org/project/mptcp/patch/850406b0f49fa0a76b4825b36c=
55426a0d033d52.1621002341.git.geliangtang@gmail.com/

If we use these two patches, then we can connect all the remote addresses
like this in mptcp_pm_create_subflow_or_signal_addr:

if (local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
        struct mptcp_pm_add_entry *entry;

        list_for_each_entry(entry, &msk->pm.add_list. list)
                __mptcp_subflow_connect(sk, &local->addr,
&entry->addr, local->flags, local->ifindex);
}

What do you think about this approach?

>
> I *think* the latter could be an interesting option.
>
> Finally note that similar changes will be required
> in mptcp_pm_nl_add_addr_received(), with the main difference
> that mptcp_pm_nl_add_addr_received will fill the array with all the
> known local addresses, while mptcp_pm_create_subflow_or_signal_addr()
> will fill it with remote addresses.

If the endpoint's flag is signal,fullmesh, we announce this address, send
this address with ADD_ADDR to the peer. The peer received the ADD_ADDR in
mptcp_pm_nl_add_addr_received. It's easy to get all the local addresses,
it's on the local_addr_list.

But how can we know whether the received address is a fullmesh one or not
in mptcp_pm_nl_add_addr_received? The endpoint's flag is set on the other
side. In mptcp_pm_nl_add_addr_received, we can't get this flag.

Do you have a good way to do this?

Thanks,
-Geliang

>
> Cheers,
>
> Paolo
>
