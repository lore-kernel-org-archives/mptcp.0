Content-Type: multipart/mixed; boundary="===============6082782778138529217=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 1/2] mptcp: reduce number of pr_debug() calls.
Date: Tue, 11 Jun 2019 22:14:37 +0200
Message-ID: <e1cbe6ee-b059-11ce-2871-819bc5534c51@tessares.net>
In-Reply-To: 3033cd593b2421cc7c82c0024a6baa0711360212.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1338

--===============6082782778138529217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 11/06/2019 19:17, Peter Krystad wrote:
> =

> See my responses inline:
> =

> On Tue, 2019-06-11 at 13:48 +0200, Matthieu Baerts wrote:
>> Hi Peter,
>>
>> On 08/06/2019 02:40, Peter Krystad wrote:
>>> squashto: Handle MPTCP TCP options
>>
>> Thank you for the new patch!
>>
>> I have two questions, please see below.
>>
>>> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
>>> ---
>>>  net/mptcp/options.c | 33 +++++++++++++++++----------------
>>>  1 file changed, 17 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>> index 1bee4a267fd8..cad1702323a3 100644
>>> --- a/net/mptcp/options.c
>>> +++ b/net/mptcp/options.c
>>> @@ -13,7 +13,7 @@
>>>  void mptcp_parse_option(const unsigned char *ptr, int opsize,
>>>  			struct tcp_options_received *opt_rx)
>>>  {
>>> -	struct mptcp_options_received *mp_opt;
>>> +	struct mptcp_options_received *mp_opt =3D &opt_rx->mptcp;
>>>  	u8 subtype =3D *ptr >> 4;
>>>  	int expected_opsize;
>>>  =

>>> @@ -29,25 +29,29 @@ void mptcp_parse_option(const unsigned char *ptr, i=
nt opsize,
>>>  		    opsize !=3D TCPOLEN_MPTCP_MPC_SYNACK)
>>>  			break;
>>>  =

>>> -		pr_debug("MP_CAPABLE");
>>> -		opt_rx->mptcp.version =3D *ptr++ & MPTCPOPT_VERSION_MASK;
>>> -		if (opt_rx->mptcp.version !=3D 0)
>>> +		mp_opt->version =3D *ptr++ & MPTCPOPT_VERSION_MASK;
>>> +		if (mp_opt->version !=3D 0)
>>>  			break;
>>>  =

>>> -		pr_debug("flags=3D%02x", *ptr);
>>> -		opt_rx->mptcp.flags =3D *ptr++;
>>> -		if (!((opt_rx->mptcp.flags & MPTCP_CAP_FLAG_MASK) =3D=3D MPTCP_CAP_H=
MAC_SHA1) ||
>>> +		mp_opt->flags =3D *ptr++;
>>> +		if (!((opt_rx->mptcp.flags & MPTCP_CAP_FLAG_MASK) =3D=3D
>>> +		    MPTCP_CAP_HMAC_SHA1) ||
>>>  		    (opt_rx->mptcp.flags & MPTCP_CAP_EXTENSIBILITY))
>>>  			break;
>>
>> detail: could we use "mp_opt->flags" here instead of
>> "opt_rx->mptcp.flags" used twice here above.
> =

> Sure.
> =

>>>  =

>>> -		opt_rx->mptcp.mp_capable =3D 1;
>>> -		opt_rx->mptcp.sndr_key =3D get_unaligned_be64(ptr);
>>> -		pr_debug("sndr_key=3D%llu", opt_rx->mptcp.sndr_key);
>>> +		mp_opt->mp_capable =3D 1;
>>> +		mp_opt->sndr_key =3D get_unaligned_be64(ptr);
>>>  		ptr +=3D 8;
>>> +
>>>  		if (opsize =3D=3D TCPOLEN_MPTCP_MPC_SYNACK) {
>>> -			opt_rx->mptcp.rcvr_key =3D get_unaligned_be64(ptr);
>>> -			pr_debug("rcvr_key=3D%llu", opt_rx->mptcp.rcvr_key);
>>> +			mp_opt->rcvr_key =3D get_unaligned_be64(ptr);
>>>  			ptr +=3D 8;
>>> +			pr_debug("MP_CAPABLE flags=3D%x, sndr=3D%llu, rcvr=3D%llu",
>>> +				 mp_opt->flags, mp_opt->sndr_key,
>>> +				 mp_opt->rcvr_key);
>>> +		} else {
>>> +			pr_debug("MP_CAPABLE flags=3D%x, sndr=3D%llu",
>>> +				 mp_opt->flags, mp_opt->sndr_key);
>>>  		}
>>>  		break;
>>>  =

>>> @@ -83,7 +87,6 @@ void mptcp_parse_option(const unsigned char *ptr, int=
 opsize,
>>>  	 */
>>>  	case MPTCPOPT_DSS:
>>>  		pr_debug("DSS");
>>> -		mp_opt =3D &opt_rx->mptcp;
>>>  		mp_opt->dss =3D 1;
>>>  		ptr++;
>>>  =

>>> @@ -399,10 +402,8 @@ void mptcp_write_options(__be32 *ptr, struct mptcp=
_out_options *opts)
>>>  =

>>>  		if (OPTION_MPTCP_MPC_SYN & opts->suboptions)
>>>  			len =3D TCPOLEN_MPTCP_MPC_SYN;
>>> -		else if (OPTION_MPTCP_MPC_SYNACK & opts->suboptions)
>>> -			len =3D TCPOLEN_MPTCP_MPC_SYNACK;
>>>  		else
>>> -			len =3D TCPOLEN_MPTCP_MPC_ACK;
>>> +			len =3D TCPOLEN_MPTCP_MPC_SYNACK;
>>
>> I am not sure to follow why you did this change. It doesn't seem to be
>> related to the pr_debug() calls. Are you doing that because
>> TCPOLEN_MPTCP_MPC_ACK =3D=3D TCPOLEN_MPTCP_MPC_SYNACK =3D=3D 20?
> =

> I'll pull this out of the patch, not sure why I did this here either, it =
was =

> fine as is.

Thank you for this new patch!

>> 3 commits are modifying this first block in mptcp_write_options():
>> - 47168d901887 (mptcp: Handle MPTCP TCP options)
>> - 5e4c2881c7c9 (mptcp: Handle MP_CAPABLE options for outgoing connection=
s)
>> - 447773e0cd92 (mptcp: Create SUBFLOW socket for incoming connections)
>>
>> The first one introduces this block (with "OPTION_MPTCP_MPC_SYNACK").
>> The second one removes "OPTION_MPTCP_MPC_SYNACK" condition.
>> The third one re-adds "OPTION_MPTCP_MPC_SYNACK".
>>
>> Should we not introduce "OPTION_MPTCP_MPC_SYNACK" condition only at the
>> 3rd patch and keep:
>>
>>     else if (OPTION_MPTCP_MPC_SYNACK & opts->suboptions)
>>
>> for clarity purposes?
> =

> Yes, use of the OPTION_MPTCP_MPC_SYNACK condition should be added by the
> "incoming connections" commit. A long time ago I split a single commit in=
to
> the current "incoming" and "outgoing" commits, and did not get this part =
quite
> clean enough.

Thank you for this explanation!
I just cleaned that!

- f1eea07b5639: clean "mptcp: Handle MPTCP TCP options"
- no signed-off modified for this
- 3a58fe749160..6614ebdd54b7: result: the code is still the same as before

Cheers,
Matt

> Peter.
> =

> =

>>
>> It's a detail but it is blocking me to know how to apply this patch
>> correctly and avoid this add/remove/re-add :)
>>
>> Cheers,
>> Matt
>>
>>>  		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) | (len << 16) |
>>>  			       (MPTCPOPT_MP_CAPABLE << 12) |
>>>
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============6082782778138529217==--
