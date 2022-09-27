Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249674C86
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 21:56:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664315807; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=KvIVrjY6Hstwv/4I30GxPzzHz4U7q/IT0RSyCXmbWVnqjDYQgkjnfm+qtM5fmY2w+8hBGEEbD9jWxfA4Avtu6Qp4o6Qr+u9jZ6ANNvCzonj8fHRb0pUQrfYJbA0wY8kmxmCQd3nziaLpA3Sys3wSwrC5YHzqqVqd6KxtxwKhpI4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664315807; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=IBGG38jjSFXAhipkXnR4vhXXujsq6gt72I7b1adQN7w=; 
	b=WxjlVV0XzD0KQFvuuD4+NkHtIavwuFLlbDKz2JWkgx9UDfvxsyJsIHckHCI/CqUm5GIt+bsrXDJsF2kwBrVnQDHW0HV058ljGVfjzTJRV+d8gxQRRaYnrCes1r0W2j1300jhd6tjiO1XGUx8vJ8EDdxCn6ODZaZv6iMUVxcjj2A=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664315807;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:Message-ID:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=IBGG38jjSFXAhipkXnR4vhXXujsq6gt72I7b1adQN7w=;
	b=fAvnROKqveshbxCxVdsbI8/qnYkkTcIri8FDcQJnIj3Iwtgug3Fz5z2KSfeRFu8f
	pyKRn4FZ4f+C2kQLll1zhM20ND0vea3fz56A292Ke2MYedOKWP0H8zATt8039u2Hnj1
	iTzoYeyvdgf21nmfyI5Ij9TCOl0a49WF35KnLmy8=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1664315805118316.191642215485; Tue, 27 Sep 2022 23:56:45 +0200 (CEST)
Date: Tue, 27 Sep 2022 23:56:44 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH mptcp-next v11 1/4] mptcp: add
 mptcp_setsockopt_fastopen
Content-Language: fr
To: Matthieu Baerts <matthieu.baerts@tessares.net>,
 Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20220925232601.25252-1-dmytro@shytyi.net>
 <20220925232601.25252-2-dmytro@shytyi.net>
 <84be9c0419af677897836e5af900596bc4713767.camel@redhat.com>
 <7b093482-2c18-7657-92be-e2784001eeff@tessares.net>
 <17582987-b035-a1b7-195f-289e3d9e7edd@shytyi.net>
 <15a476f0-c5e4-7999-a23c-73ab0b6c60c5@tessares.net>
From: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <a6ba2a52-bdb6-f636-19a0-5e334f123e6a@shytyi.net>
In-Reply-To: <15a476f0-c5e4-7999-a23c-73ab0b6c60c5@tessares.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

Hello,

On 9/27/2022 5:22 PM, Matthieu Baerts wrote:
> Hi Dmytro,
>
> On 27/09/2022 06:01, Dmytro Shytyi wrote:
>> Hello Paolo, Matthieu,
>>
>>
>> On 9/26/2022 5:01 PM, Matthieu Baerts wrote:
>>> Hi Dmytro, Paolo,
>>>
>>> On 26/09/2022 16:50, Paolo Abeni wrote:
>>>> On Mon, 2022-09-26 at 01:25 +0200, Dmytro Shytyi wrote:
>>>>> Add set MPTFO socket option for MPTCP. This option is needed for
>>>>> the listen socket to accept MPTFO.
>>>>>
>>>>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
>>>>> ---
>>>>>  =C2=A0 net/mptcp/Makefile=C2=A0=C2=A0 |=C2=A0 2 +-
>>>>>  =C2=A0 net/mptcp/fastopen.c | 37 +++++++++++++++++++++++++++++++++++=
++
>>>>>  =C2=A0 net/mptcp/protocol.h |=C2=A0 5 +++++
>>>>>  =C2=A0 net/mptcp/sockopt.c=C2=A0 |=C2=A0 3 +++
>>>>>  =C2=A0 4 files changed, 46 insertions(+), 1 deletion(-)
>>>>>  =C2=A0 create mode 100644 net/mptcp/fastopen.c
>>>>>
>>>>> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
>>>>> index 8a7f68efa35f..c42ad8609876 100644
>>>>> --- a/net/mptcp/Makefile
>>>>> +++ b/net/mptcp/Makefile
>>>>> @@ -2,7 +2,7 @@
>>>>>  =C2=A0 obj-$(CONFIG_MPTCP) +=3D mptcp.o
>>>>>  =C2=A0 =C2=A0 mptcp-y :=3D protocol.o subflow.o options.o token.o cr=
ypto.o
>>>>> ctrl.o pm.o diag.o \
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mib.o pm_netlink.o sockopt.o pm=
_userspace.o sched.o
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mib.o pm_netlink.o sockopt.o pm=
_userspace.o sched.o fastopen.o
>>>>>  =C2=A0 =C2=A0 obj-$(CONFIG_SYN_COOKIES) +=3D syncookies.o
>>>>>  =C2=A0 obj-$(CONFIG_INET_MPTCP_DIAG) +=3D mptcp_diag.o
>>>>> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
>>>>> new file mode 100644
>>>>> index 000000000000..086cbad49979
>>>>> --- /dev/null
>>>>> +++ b/net/mptcp/fastopen.c
>>>>> @@ -0,0 +1,37 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0
>>>>> + * MPTCP Fast Open Mechanism. Copyright (c) 2021-2022, Dmytro SHYTYI
>>>>> + */
>>>>> +
>>>>> +#include "protocol.h"
>>>>> +
>>>>> +int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk,
>>>>> sockptr_t optval,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int o=
ptlen)
>>> I think we should keep everything related to the sockoptions in
>>> net/mptcp/sockopt.c, no?
>> I have multiple functions that are related to fastopen in fastopen.c.
>> Probably it is not a bad idea to to keep all fastopen details in one fil=
e?
> We already have a file dedicated to all socket options. I don't think we
> should have an exception for TFO, especially if there is nothing
> specific to TFO thanks to tcp_setsockopt().
Okay.
> Also, you can use the new mptcp_setsockopt_first_sf_only() helper I sent
> a few minutes ago on the ML. For TCP_FASTOPEN sockopt, you now need a
> commit similar to "mptcp: add TCP_FASTOPEN_NO_COOKIE support" by just
> adding "TCP_FASTOPEN" in three different places in sockopt.c, see:
>
>
> https://lore.kernel.org/mptcp/20220927150306.1552795-1-matthieu.baerts@te=
ssares.net/T/

Thanks!


> Cheers,
> Matt

