Content-Type: multipart/mixed; boundary="===============5567045077357217238=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH RFC net-next 1/2] net: mptcp: improve fallback to
 TCP
Date: Tue, 19 May 2020 11:12:22 -0700
Message-ID: <alpine.OSX.2.22.394.2005191021440.18759@dnlloyd-mobl.amr.corp.intel.com>
In-Reply-To: a1fe73ff004547bc0750a217f1d9b7b7862b702e.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4423

--===============5567045077357217238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 19 May 2020, Davide Caratti wrote:

> hello Mat, thanks for looking at this.
>
> On Mon, 2020-05-18 at 17:14 -0700, Mat Martineau wrote:
>> On Mon, 18 May 2020, Davide Caratti wrote:
>>
>>> current MPTCP resets the connection in case the DSS option is not recei=
ved
>>> after a successful three-way handshake, while RFC8684 =C3=82=C2=A73.7 s=
uggests a
>>> fall-back to regular TCP when only the first subflow has been estabilsh=
ed.
>>> Introduce support for "infinite mapping" to allow continuing without DS=
S in
>>> these cases.
>>
>> If I'm understanding the intent of the changes, the idea in this patch is
>> to keep using the MPTCP segmentation & reassembly after fallback, but to
>> short-circuit most of it by (1) not writing the DSS option to the TCP
>> header on the tx side and (2) generating dummy mappings on the rx side.
>
> on a second thought, it would have been better to split this and the
> support for infinite maps into two separate patches.
>

That would help!

> Initially I cleared "is_mptcp" on reception of an infinite map, but then
> those "goto fallback" were creating so many troubles that the approach was
> flipped to always use msk, also for fallback sockets (unless the ones
> passing through subflow_ulp_fallback()).
>

Not depending on is_mptcp for fallback behavior is good. Subflow sockets =

with is_mptcp =3D=3D false do lead to some confusing situations.

>
>> I'd also like to avoid overloading the term "infinite mapping", which has
>> specific meaning in the RFC: a DSS mapping with the data-level length set
>> to 0 that is sent under specific circumstances. If that specific DSS
>> mapping isn't present on the wire, maybe "dummy mapping" or "fake mappin=
g"
>> is a useful term to use instead.
>
> good point. Looking at the specifications again, not only the kernel must
> be able to process an incoming infinite map; it must also emit an infinite
> map, tentatively, in case it detects a middlebox that filters/corrupts the
> DSS sub-option.
>
> [...]
>>> 	}
>>> @@ -639,8 +645,12 @@ static enum mapping_status get_mapping_status(stru=
ct sock *ssk)
>>>
>>> 	data_len =3D mpext->data_len;
>>> 	if (data_len =3D=3D 0) {
>>> -		pr_err("Infinite mapping not handled");
>>> +		/* XXX TODO this should be allowed only if we didn't
>>> +		 * receive a DACK yet. Paolo suggests to use a dedicated
>>> +		 * flag in msk, but can't we use msk->can_ack? */
>>
>> The RFC has a lot of requirements for allowing an infinite mapping, and I
>> don't think they align perfectly with what msk->can_ack means. A dedicat=
ed
>> "allow_fallback" flag could be set to 'false' when fallback is no longer
>> allowed: a subflow is added, out-of-order MPTCP mappings are encountered,
>> etc.
>
> sure, and also talking with Paolo "can_ack" didn't really fit, as it means
> "can send ack because have both local and remote keys". I was for using
> subflow->conn_finished (and for removing all XXX stuff before posting to a
> ML :) ), but also this is not fitting well.

It has been a challenge to keep track of what each flag means and how they =

all interact. A fallback state machine is a possible way to approach the =

problem, but I'm not sure how well that works with our locking =

arrangement. Hard to narrow down what to recommend here, the tradeoffs are =

complicated!


>
>> The way I read the RFC (and I could be misreading), there are cases where
>> an infinite mapping can be used after DATA_ACK if other conditions are
>> met (like the checksum error section in 3.7).
>
> let's see if I can add a scenario for this (in addition to those at
> https://github.com/dcaratti/packetdrill/tree/fallback-after3whs )

Great, thank you.

>
>>> 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
>>> +		if (!subflow->local_id && !READ_ONCE(msk->pm.subflows))
>>> +			return MAPPING_INFINITE;
>>> 		return MAPPING_INVALID;
>>> 	}

Thanks for sharing the patch!

--
Mat Martineau
Intel

--===============5567045077357217238==--
