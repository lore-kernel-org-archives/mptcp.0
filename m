Content-Type: multipart/mixed; boundary="===============3129393248372006211=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] tcp: Check for filled TCP option space before SACK
Date: Tue, 14 May 2019 18:11:00 +0200
Message-ID: <3c517247-2b9d-ad3d-4954-f1873004c1f2@tessares.net>
In-Reply-To: alpine.OSX.2.21.1905101643530.59728@julieann-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1170

--===============3129393248372006211==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 11/05/2019 01:59, Mat Martineau wrote:
> =

> On Fri, 10 May 2019, Matthieu Baerts wrote:
> =

>> Hi Mat,
>>
>> Thank you for the patch!
>>
>> On 09/05/2019 19:06, Mat Martineau wrote:
>>> The SACK code would potentially add four bytes to the expected
>>> TCP option size even if all option space was already used.
>>>
>>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>>> ---
>>> =C2=A0net/ipv4/tcp_output.c | 3 +++
>>> =C2=A01 file changed, 3 insertions(+)
>>>
>>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>>> index 12c9e8ebc86d..1cd915890ce5 100644
>>> --- a/net/ipv4/tcp_output.c
>>> +++ b/net/ipv4/tcp_output.c
>>> @@ -814,6 +814,9 @@ static unsigned int
>>> tcp_established_options(struct sock *sk, struct sk_buff *skb
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> +=C2=A0=C2=A0=C2=A0 if (size + TCPOLEN_SACK_BASE_ALIGNED >=3D MAX_TCP_O=
PTION_SPACE)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return size;
>>> +
>>
>> Should we not add this check in the "if" block here below...
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 eff_sacks =3D tp->rx_opt.num_sacks + tp->rx_op=
t.dsack;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(eff_sacks)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const unsigned int rem=
aining =3D MAX_TCP_OPTION_SPACE - size;
>>
>> ... to use this "remaining" variable only if we want to add SACKS:
>>
>> =C2=A0=C2=A0 if (TCPOLEN_SACK_BASE_ALIGNED >=3D remaining)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return size;
> =

> Florian had suggested the above location (#2 in
> https://lists.01.org/pipermail/mptcp/2019-April/001097.html). Seemed
> like adding the check there made sense because there's no need to
> calculate eff_sacks if there's no option space.

I thought Florian' suggestion was only to show the bug. But OK for me to
keep it there if you prefer.

>>
>>
>> Do you want me to squash this fix in Peter's commit (mptcp: Handle
>> MP_CAPABLE options for outgoing connections) or to add it as a new
>> commit just after Peter's one? (It's only to ease the "rebasing" task
>> later by helping doing a maximum now as long as I can help :) )
> =

> I'd prefer to add commits to the end so it's easier for everyone to see
> what's changing over time.

Do you mean for those who doesn't subscribe to this ML? Or for everybody
in general?

If it is for everybody, I guess the best is also to stop the CI scripts
doing the automatic rebases once per day after validations then.

Added at the end as requested.

https://github.com/multipath-tcp/mptcp_net-next/commits/export

Matt

> -- =

> Mat Martineau
> Intel

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============3129393248372006211==--
