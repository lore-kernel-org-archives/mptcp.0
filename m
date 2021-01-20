Content-Type: multipart/mixed; boundary="===============5117913792496546125=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp 7/7] mptcp: add netlink event support
Date: Wed, 20 Jan 2021 13:55:16 +0100
Message-ID: <daddb23f-9094-03d8-e8c2-1dfcf2ccadae@tessares.net>
In-Reply-To: 20210120122709.GO19605@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 7443

--===============5117913792496546125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

Thank you for your reply and explanations!
Sounds good to me!

On 20/01/2021 13:27, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>>> + * MPTCP_EVENT_SUB_CLOSED: token, family, saddr4 | saddr6, daddr4 | da=
ddr6,
>>> + *                         sport, dport, backup, if_idx
>>> + *    A subflow has been closed.
>>
>> I noticed that the error (copy of sk_err) is not in the arguments.
>> Is it simply because we don't need them in the first version or because
>> there is a technical issue?
> =

> No, i've added it now for v2.  It exports ssk->sk_err in the subflow
> announcements.

Great, thanks!

>>> +	if (nla_put_be16(skb, MPTCP_ATTR_DPORT, info->port))
>>> +		goto nla_put_failure;
>>> +
>>> +	switch (info->family) {
>>> +	case AF_INET:
>>> +		if (nla_put_in_addr(skb, MPTCP_ATTR_DADDR4, info->addr.s_addr))
>>
>> (I should not review that late, I blocked here a few seconds thinking you
>> were using the "source" addr for DADDR :) )
> =

> Right, it would be better to use __be32 instead of struct inaddr but
> that would result in more (useless) code churn so I left that as-is.

All good, this code is good like that :)
(I only blocked yesterday because we hadd "DADDR" followed by s_addr :) )

>>> +	case MPTCP_EVENT_UNSPEC:
>>> +		WARN_ON_ONCE(1);
>>> +		break;
>>
>> Probably useless but should we move this to the end and add "default"?
> =

> gcc emits a warning if you add a new name to an enum and a switch
> statement doesn't handle that.
> =

> This is why there is no default branch but all the other 'should not
> happen' values are listed verbatim with a warn-on.

That's right, I forgot about that!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5117913792496546125==--
