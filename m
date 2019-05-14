Content-Type: multipart/mixed; boundary="===============2056544118572218162=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] tcp: Check for filled TCP option space before SACK
Date: Tue, 14 May 2019 09:59:01 -0700
Message-ID: <alpine.OSX.2.21.1905140944270.17351@jdicke-mobl1.amr.corp.intel.com>
In-Reply-To: 3c517247-2b9d-ad3d-4954-f1873004c1f2@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1171

--===============2056544118572218162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 14 May 2019, Matthieu Baerts wrote:

> Hi Mat,
>
> On 11/05/2019 01:59, Mat Martineau wrote:
>>
>> On Fri, 10 May 2019, Matthieu Baerts wrote:
>>
>>> Hi Mat,
>>>
>>> Thank you for the patch!
>>>
>>> On 09/05/2019 19:06, Mat Martineau wrote:
>>>> The SACK code would potentially add four bytes to the expected
>>>> TCP option size even if all option space was already used.
>>>>
>>>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>>>> ---
>>>> =C2=A0net/ipv4/tcp_output.c | 3 +++
>>>> =C2=A01 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>>>> index 12c9e8ebc86d..1cd915890ce5 100644
>>>> --- a/net/ipv4/tcp_output.c
>>>> +++ b/net/ipv4/tcp_output.c
>>>> @@ -814,6 +814,9 @@ static unsigned int
>>>> tcp_established_options(struct sock *sk, struct sk_buff *skb
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>>> +=C2=A0=C2=A0=C2=A0 if (size + TCPOLEN_SACK_BASE_ALIGNED >=3D MAX_TCP_=
OPTION_SPACE)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return size;
>>>> +
>>>
>>> Should we not add this check in the "if" block here below...
>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 eff_sacks =3D tp->rx_opt.num_sacks + tp->rx_o=
pt.dsack;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(eff_sacks)) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const unsigned int re=
maining =3D MAX_TCP_OPTION_SPACE - size;
>>>
>>> ... to use this "remaining" variable only if we want to add SACKS:
>>>
>>> =C2=A0=C2=A0 if (TCPOLEN_SACK_BASE_ALIGNED >=3D remaining)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return size;
>>
>> Florian had suggested the above location (#2 in
>> https://lists.01.org/pipermail/mptcp/2019-April/001097.html). Seemed
>> like adding the check there made sense because there's no need to
>> calculate eff_sacks if there's no option space.
>
> I thought Florian' suggestion was only to show the bug. But OK for me to
> keep it there if you prefer.
>
>>>
>>>
>>> Do you want me to squash this fix in Peter's commit (mptcp: Handle
>>> MP_CAPABLE options for outgoing connections) or to add it as a new
>>> commit just after Peter's one? (It's only to ease the "rebasing" task
>>> later by helping doing a maximum now as long as I can help :) )
>>
>> I'd prefer to add commits to the end so it's easier for everyone to see
>> what's changing over time.
>
> Do you mean for those who doesn't subscribe to this ML? Or for everybody
> in general?
>

I was thinking in general - with various patch sets (and versions of those =

patch sets) in stages of review and getting merged, it helps if it's easy =

to see what's been merged and when.

The new pattern seems to be to squash small fixes and append more =

significant ones - that seems to be working for the group and not causing =

problems.

> If it is for everybody, I guess the best is also to stop the CI scripts
> doing the automatic rebases once per day after validations then.

The automatic rebase does make it harder to refer to existing commits by =

id (for "fixes" information, squashing, etc) because the commit ids are =

constantly changing, but we also don't want to fall too far behind =

net-next. Seems to be going ok so far, we could talk about rebase =

frequency at the meeting this week. I added it to the agenda.


--
Mat Martineau
Intel

--===============2056544118572218162==--
