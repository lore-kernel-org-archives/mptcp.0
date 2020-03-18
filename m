Content-Type: multipart/mixed; boundary="===============3403240953628709782=="
MIME-Version: 1.0
From: Eric Dumazet <eric.dumazet at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC mptcp-next] tcp: mptcp: use mptcp receive buffer
 space to select rcv window
Date: Wed, 18 Mar 2020 11:14:38 -0700
Message-ID: <95e08be8-9902-f998-6558-e7e574d783b0@gmail.com>
In-Reply-To: 20200318180526.GJ979@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 3985

--===============3403240953628709782==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 3/18/20 11:05 AM, Florian Westphal wrote:
> Eric Dumazet <eric.dumazet(a)gmail.com> wrote:
>>> @@ -2771,6 +2771,11 @@ u32 __tcp_select_window(struct sock *sk)
>>>  	int full_space =3D min_t(int, tp->window_clamp, allowed_space);
>>>  	int window;
>>>  =

>>> +	if (sk_is_mptcp(sk)) {
>>> +		mptcp_space(sk, &free_space, &allowed_space);
>>> +		full_space =3D min_t(int, tp->window_clamp, allowed_space);
>>> +	}
>>
>> You could move the full_space =3D min_t(int, tp->window_clamp, allowed_s=
pace);
>> after this block factorize it.
> =

> Indeed, will do.
> =

>>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>>> index 40ad7995b13b..aefcbb8bb737 100644
>>> --- a/net/mptcp/subflow.c
>>> +++ b/net/mptcp/subflow.c
>>> @@ -745,6 +745,23 @@ bool mptcp_subflow_data_available(struct sock *sk)
>>>  	return subflow->data_avail;
>>>  }
>>>  =

>>> +/* If ssk has an mptcp parent socket, use the mptcp rcvbuf occupancy,
>>> + * not the ssk one.
>>> + *
>>> + * In mptcp, rwin is about the mptcp-level connection data.
>>> + *
>>> + * Data that is still on the ssk rx queue can thus be ignored,
>>> + * as far as mptcp peer is concerened that data is still inflight.
>>> + */
>>> +void mptcp_space(const struct sock *ssk, int *space, int *full_space)
>>> +{
>>> +	const struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk=
);
>>> +	const struct sock *sk =3D READ_ONCE(subflow->conn);
>>
>> What are the rules protecting subflow->conn lifetime ?
>>
>> Why dereferencing sk after this line is safe ?
> =

> Subflow sockets hold a reference on the master/parent mptcp-socket.
> =


Presence of READ_ONCE() tells something might happen on
this pointer after you read it.

Can this pointer be set while this thread is owning the socket lock ?

If not, then you do not need READ_ONCE(), this is confusing.

If yes, then it means that whatever changes the pointer might also release =
the reference
on the old object.

Thanks.
--===============3403240953628709782==--
