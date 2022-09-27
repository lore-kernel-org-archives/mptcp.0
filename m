Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1FB7E
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 04:01:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664251286; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=JjViwzfKodku02GSJQ4OSaFooZYi0dmoYDj43IFfNgRX8UFjrq6nxUH11/PVZ079O1DRNePgYmyExgCqbi7hHbV87ZR9C79J6x/+ckWX+L/swWI9NXH+AOSe679HG3fQz/k05n4PLDGiI9hYofWN++5HJ3x0Pp3T3sMWfyND6Wc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664251286; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=UsE2p9IOib5i2XmaVXFVwGFd55WCHIyllqn1JJAP6TI=; 
	b=AwMd2KkaMe5UX32BMj2qeip6jrnlSG9BvK3Q2yQxYzoq0dvcOaFNyQ3dnKgYY4ZQkeG0DWL1a3GUXooK5n6+64uhZ/drron6KU5qeEqTgHedlKc7//Qc8DClmOxuPCfrIK6/jdBId/xcDbbV07MUBL60Gtc+JpB64UXTIsA2MqQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664251286;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:Message-ID:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=UsE2p9IOib5i2XmaVXFVwGFd55WCHIyllqn1JJAP6TI=;
	b=eCta3s/A+14s4EYFG8/sCBRe9pA7/9gT/YSVTshNswwwEDzq/Yw3FM0w8zobMuf5
	MsPNKeCKdHyZwF3QJWXUrQRrwijxhOtT2HOMcCS6CSbOnAHD3eMZIZKzdzkkVrOgJsM
	/ufiBKN+aDQDKvE5ilfChhMmG51KQLCaFaC2jvOA=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1664251284293686.2839595693476; Tue, 27 Sep 2022 06:01:24 +0200 (CEST)
Date: Tue, 27 Sep 2022 06:01:23 +0200
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
From: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <17582987-b035-a1b7-195f-289e3d9e7edd@shytyi.net>
In-Reply-To: <7b093482-2c18-7657-92be-e2784001eeff@tessares.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

Hello Paolo, Matthieu,


On 9/26/2022 5:01 PM, Matthieu Baerts wrote:
> Hi Dmytro, Paolo,
>
> On 26/09/2022 16:50, Paolo Abeni wrote:
>> On Mon, 2022-09-26 at 01:25 +0200, Dmytro Shytyi wrote:
>>> Add set MPTFO socket option for MPTCP. This option is needed for
>>> the listen socket to accept MPTFO.
>>>
>>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
>>> ---
>>>   net/mptcp/Makefile   |  2 +-
>>>   net/mptcp/fastopen.c | 37 +++++++++++++++++++++++++++++++++++++
>>>   net/mptcp/protocol.h |  5 +++++
>>>   net/mptcp/sockopt.c  |  3 +++
>>>   4 files changed, 46 insertions(+), 1 deletion(-)
>>>   create mode 100644 net/mptcp/fastopen.c
>>>
>>> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
>>> index 8a7f68efa35f..c42ad8609876 100644
>>> --- a/net/mptcp/Makefile
>>> +++ b/net/mptcp/Makefile
>>> @@ -2,7 +2,7 @@
>>>   obj-$(CONFIG_MPTCP) +=3D mptcp.o
>>>  =20
>>>   mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o ctrl.o p=
m.o diag.o \
>>> -=09   mib.o pm_netlink.o sockopt.o pm_userspace.o sched.o
>>> +=09   mib.o pm_netlink.o sockopt.o pm_userspace.o sched.o fastopen.o
>>>  =20
>>>   obj-$(CONFIG_SYN_COOKIES) +=3D syncookies.o
>>>   obj-$(CONFIG_INET_MPTCP_DIAG) +=3D mptcp_diag.o
>>> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
>>> new file mode 100644
>>> index 000000000000..086cbad49979
>>> --- /dev/null
>>> +++ b/net/mptcp/fastopen.c
>>> @@ -0,0 +1,37 @@
>>> +/* SPDX-License-Identifier: GPL-2.0
>>> + * MPTCP Fast Open Mechanism. Copyright (c) 2021-2022, Dmytro SHYTYI
>>> + */
>>> +
>>> +#include "protocol.h"
>>> +
>>> +int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockptr_=
t optval,
>>> +=09=09=09=09      unsigned int optlen)
> I think we should keep everything related to the sockoptions in
> net/mptcp/sockopt.c, no?

I have multiple functions that are related to fastopen in fastopen.c.=20
Probably it is not a bad idea to to keep all fastopen details in one file?

>>> +{
>>> +=09struct sock *sk =3D (struct sock *)msk;
>>> +=09struct net *net =3D sock_net(sk);
>>> +=09struct socket *ssock;
>>> +=09struct sock *ssk;
>>> +=09int val;
>>> +=09int ret;
>>> +
>>> +=09ret =3D 0;
>>> +
>>> +=09if (copy_from_sockptr(&val, optval, sizeof(val)))
>>> +=09=09return -EFAULT;
>>> +
>>> +=09ssock =3D __mptcp_nmpc_socket(msk);
> 'ssock' could be NULL if the setsockopt() is called once the connection
> has been established.


Thanks, in this case need to return error.

>>> +=09ssk =3D ssock->sk;
>>> +=09net =3D sock_net(ssk);
>>> +=09lock_sock(ssk);
>>> +
>>> +=09if (val >=3D 0 && ((1 << ssk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN=
))) {
>>> +=09=09tcp_fastopen_init_key_once(net);
>>> +=09=09fastopen_queue_tune(ssk, val);
>> Instead you could directly call:
>>
>> =09return tcp_setsockopt(ssock->sk, SOL_TCP, TCP_FASTOPEN, optval, optle=
n);
>
> I agree, similar to TCP_FASTOPEN_CONNECT


Indeed this is done here, when pass TCP_FASTOPEN (tcp.c - net/ipv4/tcp.c=20
- Linux source code (v5.19.11) - Bootlin=20
<https://elixir.bootlin.com/linux/latest/source/net/ipv4/tcp.c#L3636>)

So we could use directly=C2=A0 as you both suggested.

>> Side note, we could add a generic helper to invoke tcp_setsockopt() on
>> the mpc subflow, on the give tcp socket option, and reuse such helper
> Indeed. I was already looking at doing that when implementing
> TCP_FASTOPEN_NO_COOKIE. I can share a patch for this other sockopt and
> then you can re-use the new helper for this TCP_FASTOPEN.
>
>> for: TCP_FASTOPEN, TCP_FASTOPEN_CONNECT, TCP_DEFER_ACCEPT... but that
>> can/should be done later.
> Note that for TCP_DEFER_ACCEPT, this is a special case because
> apparently, the setsockopt doesn't fail even if a connection has already
> been accepted.
>
> @Dmytro: Two last things about the patch:
> - you also need to support the 'read' side (getsockopt())
> - if I'm not mistaken, this TCP_FASTOPEN option is only needed for the
> listener side, not for the sender, no?
>
> Cheers,
> Matt

