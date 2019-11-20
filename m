Content-Type: multipart/mixed; boundary="===============8556726101876625711=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 3/4] mptcp: warn once if exceeding tcp opt
 space for dss/mp_capable
Date: Wed, 20 Nov 2019 18:27:53 +0100
Message-ID: <9bde8b1c-d71b-c826-9e83-0db1602035cd@tessares.net>
In-Reply-To: 7460b4baec916e0cf895c57c10affec362703932.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2623

--===============8556726101876625711==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Peter,

On 16/11/2019 00:41, Peter Krystad wrote:
> On Fri, 2019-11-15 at 13:35 +0100, Paolo Abeni wrote:
>> On Thu, 2019-11-14 at 22:43 -0800, Peter Krystad wrote:
>>>> @@ -279,22 +265,27 @@ bool mptcp_established_options(struct sock *sk, =
struct sk_buff *skb,
>>>>   			       struct mptcp_out_options *opts)
>>>>   {
>>>>   	unsigned int opt_size =3D 0;
>>>> +	bool ret =3D false;
>>>>   =

>>>>   	if (!mptcp_subflow_ctx(sk)->mp_capable)
>>>>   		return false;
>>>>   =

>>>> -	if (mptcp_established_options_mp(sk, &opt_size, remaining, opts)) {
>>>> -		*size +=3D opt_size;
>>>> -		remaining -=3D opt_size;
>>>> -		return true;
>>>> -	} else if (mptcp_established_options_dss(sk, skb, &opt_size, remaini=
ng,
>>>> -						 opts)) {
>>>> -		*size +=3D opt_size;
>>>> -		remaining -=3D opt_size;
>>>> -		return true;
>>>> -	}
>>>> +	if (mptcp_established_options_mp(sk, &opt_size, remaining, opts))
>>>> +		ret =3D true;
>>>> +	else if (mptcp_established_options_dss(sk, skb, &opt_size, remaining,
>>>> +						 opts))
>>>> +		ret =3D true;
>>>>   =

>>>> -	return false;
>>>> +	/* we reserved enough space for the above options, and exceeding the
>>>> +	 * TCP option space would be fatal
>>>> +	 */
>>>> +	if (WARN_ON_ONCE(opt_size > remaining))
>>>> +		return false;
>>>
>>> It seems to me, and maybe I am missing something, but all this change a=
dds to
>>> existing functionality is showing this warning when
>>> mptcp_established_options_mp() fails due to lack of remaining option sp=
ace.
>>> The small change I propose above does the same, yes?
>>
>> This change has a few goals:
>> - consolidating the check vs TCP option space exhaustion: there is a
>> single warn_on(). Currently we have already one, and we need to add
>> another one in mptcp_established_options_mp(), plus v1 support will
>> require adding at least one more.
>> - documenting that we don't actually expect to exhaust TCP option space
>> with MP_CAPABLE/MP_JOIN or DSS (as we don't send DSS and MP_CAPABLE
>> together)
>> - the assumption that DSS will never exhaust TCP option space allow to
>> simplify the code a bit.
>>
>> yes, alternatively we can add more warn_on(). That will uglify a bit
>> the v1 code.
> =

> I guess I'm OK with a single WARN_ON. This patchset LGTM.

Thank you for the patches and the reviews!

@Paolo: I *think* that the first patches of this series were not based =

at the end of the series but at the end of part 2 (kselftest =

introduction). I had to add some extra code and resolve some conflicts =

with what I hope would be what you had in mind :-)
Please see the different conflict resolution and the extra commit here =

below, especially 7d8b4fe573fb which I guess there are better ways to do =

but I hope the code is OK.

- 3ce88efe9902: "squashed" patch 1/4 (or 1/1 :) ) in "mptcp: Create =

SUBFLOW socket for incoming connections"
- 9c58989db059: "squashed" patch 2/4 in "mptcp: Create SUBFLOW socket =

for incoming connections"
- 946c99f17805: "squashed" patch 3/4 in "mptcp: Write MPTCP DSS headers =

to outgoing data packets"
- 27a10380b320: conflict in t/mptcp-Implement-MPTCP-receive-path
- a17134e4116a: conflict in t/mptcp-Add-ADD_ADDR-handling
- 7d8b4fe573fb: extra code: take extra established options into account
- 34c0738e7ed4: conflict in =

t/mptcp-Add-handling-of-incoming-MP_JOIN-requests
- 63e57f2facbc: conflict in =

t/mptcp-Add-handling-of-outgoing-MP_JOIN-requests
- 0f2c93ad449d: "squashed" patch 4/4 in "mptcp: Add handling of outgoing =

MP_JOIN requests"
- 84cd31e06aaa: "Signed-off-by" + "Co-developed-by"
- aad61f16b421: conflict in t/mptcp-increment-MIB-counters-in-a-few-places
- 84af4075aa4f..e73eef882a05: result

Tests are still all passing!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8556726101876625711==--
