Content-Type: multipart/mixed; boundary="===============8690420697473448940=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/3] mptcp: parse and emit MP_CAPABLE option
 according to v1 spec.
Date: Tue, 03 Dec 2019 16:50:56 +0100
Message-ID: <9d3849fd-4604-0bba-eb95-6a2605078803@tessares.net>
In-Reply-To: e5970ab9eb7d27408787242b2a3d4199a6d8a0e6.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2770

--===============8690420697473448940==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 03/12/2019 12:05, Paolo Abeni wrote:
> On Tue, 2019-12-03 at 11:39 +0100, Matthieu Baerts wrote:

[...]

>>> @@ -29,12 +29,24 @@ void mptcp_parse_option(const unsigned char *ptr, i=
nt opsize,
>>>    	 * 10-17: Receiver key (optional)
>>>    	 */
>>>    	case MPTCPOPT_MP_CAPABLE:
>>> -		if (opsize !=3D TCPOLEN_MPTCP_MPC_SYN &&
>>> -		    opsize !=3D TCPOLEN_MPTCP_MPC_SYNACK)
>>> +		/* strict size checking */
>>
>> Good idea, even for a v0 (but no need to change the patches v0 of course)
>>
>>> +		if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)) {
>>> +			if (skb->len > tcp_hdr(skb)->doff << 2)
>>> +				expected_opsize =3D TCPOLEN_MPTCP_MPC_ACK_DATA;
>>> +			else
>>> +				expected_opsize =3D TCPOLEN_MPTCP_MPC_ACK;
>>> +		} else {
>>> +			if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK)
>>> +				expected_opsize =3D TCPOLEN_MPTCP_MPC_SYNACK;
>>> +			else
>>> +				expected_opsize =3D TCPOLEN_MPTCP_MPC_SYN;
>>> +		}
>>> +		if (opsize !=3D expected_opsize)
>>>    			break;
>>>    =

>>> +		/* only support V1 of the protocol */
>>>    		mp_opt->version =3D *ptr++ & MPTCP_VERSION_MASK;
>>> -		if (mp_opt->version !=3D 0)
>>> +		if (mp_opt->version !=3D 1)
>>
>> I don't know if you saw my previous comment but if we are parsing a SYN
>> here, should we not accept all versions > 0 and reply that the highest
>> version we support is v1?
> =

> Yep, sorry for the missing answer, so far. I think we can add easily
> that later, if/when newer/experimental version will surface. This code
> preserve the behaviour we already have with v0, I think we can keep as-
> is.

The problem with this code is that if someone develops a version higher =

than 1, it will not be compatible with our MPTCP upstream one, not =

because he/she didn't implement a fallback to an older version or the =

new version isn't backward compatible but because the Linux upstream =

version doesn't allow that:

    C                              S (MPTCP upstream)
    |---- SYN(MP_CAPABLE v2) ----> |
    |                              |
    | <--- SYN (without MPTCP) --- |

I am sure we can fix that later but better to do that as soon as possible :)
(I can propose a patch after it is applied if it is OK for you)

>>> @@ -433,22 +511,36 @@> =

> Paolo
>  void mptcp_write_options(__be32 *ptr, struct mptcp_out_options *opts)
>>>    			len =3D TCPOLEN_MPTCP_MPC_SYN;
>>>    		else if (OPTION_MPTCP_MPC_SYNACK & opts->suboptions)
>>>    			len =3D TCPOLEN_MPTCP_MPC_SYNACK;
>>> +		else if (opts->ext_copy.data_len)
>>> +			len =3D TCPOLEN_MPTCP_MPC_ACK_DATA;
>>>    		else
>>>    			len =3D TCPOLEN_MPTCP_MPC_ACK;
>>>    =

>>>    		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) | (len << 16) |
>>>    			       (MPTCPOPT_MP_CAPABLE << 12) |
>>> -			       ((MPTCP_VERSION_MASK & 0) << 8) |
>>> +			       ((MPTCP_VERSION_MASK & 1) << 8) |
>>
>> Why do you have to change the bit we need from the mask here?
> =

> I guess the above is clearer after rebasing patch "mptcp: Add ADD_ADDR
> handling", which introduces the mptcp_option() helper.
> =

> The above statement set the version number inside the MP_CAPABLE option
> to 1 (the mask is unchanged, the code changes the version value to 1)

Oh yes, sorry, I was expecting to find "subflow->request_version" where =

we set the version 1.

Maybe clearer with a "#define MPTCP_VERSION 0x1" but a detail :)

>>
>>>    			       MPTCP_CAP_HMAC_SHA256);
>>> +
>>> +		if (!((OP> =

> Paolo
> TION_MPTCP_MPC_SYNACK | OPTION_MPTCP_MPC_ACK) &
>>> +		    opts->suboptions))
>>
>> (a detail but why not checking only for SYN?)
> =

> Yep, that would be equivalent. I guess the logic above is checking for
> whatever options need to process more data.
> =

>>> +			goto mp_capable_done;
>>> +
>>>    		put_unaligned_be64(opts->sndr_key, ptr);
>>>    		ptr +=3D 2;
>>> -		if ((OPTION_MPTCP_MPC_SYNACK |
>>> -		     OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
>>> -			put_unaligned_be64(opts->rcvr_key, ptr);
>>> -			ptr +=3D 2;
>>> -		}
>>> +		if (!((OPTION_MPTCP_MPC_ACK) & opts->suboptions))
>>
>> (a detail but here as well, can we not check only for SYNACK?)
> =

> I'm sorry I did not get it. Could you please re-phrase?

sorry, it is just that here, we are looking if we don't have a SYN_ACK =

if I am not mistaken. So instead of:

   if (!((OPTION_MPTCP_MPC_ACK) & opts->suboptions))

we could have:

   if (OPTION_MPTCP_MPC_SYNACK & opts->suboptions)

no? The result is the same, maybe just clearer.

> =

>>> @@ -183,11 +182,22 @@ static struct sock *subflow_syn_recv_sock(const s=
truct sock *sk,
>>>    					  bool *own_req)
>>>    {
>>>    	struct mptcp_subflow_context *listener =3D mptcp_subflow_ctx(sk);
>>> +	struct mptcp_subflow_request_sock *subflow_req;
>>> +	struct tcp_options_received opt_rx;
>>>    	struct sock *child;
>>>    =

>>>    	pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, liste=
ner->conn);
>>>    =

>>> -	/* if the sk is MP_CAPABLE, we already received the client key */
>>> +	/* if the sk is MP_CAPABLE, we need to fetch the client key */
>>> +	subflow_req =3D mptcp_subflow_rsk(req);
>>> +	if (subflow_req->mp_capable) {
>>> +		opt_rx.mptcp.mp_capable =3D 0;
>>> +		mptcp_get_options(skb, &opt_rx);
>>> +		if (!opt_rx.mptcp.mp_capable)
>>> +			subflow_req->mp_capable =3D 0;
>>
>> Does that mean that syn_recv_sock() will do a fallback to TCP?
> =

> AFAICS, yes. I guess pktdrill will help testing this code ;)

Could be good to test because it is not clear what will happen :-)

> Thank you for the in-depth review!

You are welcome.

Do you know if anybody else would like to review it? I will wait a bit =

before applying it :)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8690420697473448940==--
