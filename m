Content-Type: multipart/mixed; boundary="===============7457279576315283028=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH RFC net-next 1/2] net: mptcp: improve fallback to
 TCP
Date: Tue, 19 May 2020 11:28:20 -0700
Message-ID: <alpine.OSX.2.22.394.2005191112430.18759@dnlloyd-mobl.amr.corp.intel.com>
In-Reply-To: ac96ebd7022571490f379ddbd2be2c8b5b1f439c.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4424

--===============7457279576315283028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 19 May 2020, Paolo Abeni wrote:

> On Mon, 2020-05-18 at 17:14 -0700, Mat Martineau wrote:
>> On Mon, 18 May 2020, Davide Caratti wrote:
>>
>>> current MPTCP resets the connection in case the DSS option is not recei=
ved
>>> after a successful three-way handshake, while RFC8684 =C2=A73.7 suggest=
s a
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
> The above has a few goals, which can't be reached with the current
> optimization for sendmsg/recvmsg on fallback:
>
> * support for fallback in scenario we currently can't support. e.g. on
> passive socket we can't fallback due to infinite mapping with the
> current infra, as passive sockets have 'msk->subflow =3D=3D NULL'.
>
> * cleanup the non fallback code, removing most of 'if (<fallback>')' in
> critical path
>
> * better performances for non fallback - e.g. we drop a lock pair in
> poll() and likely we could drop also the remaning one. (this will
> improve also the fallback scenario).
>
> Moreover this allows follow-up patch[es] to address other current
> shortcoming. e.g. setsockopt()/getsockopt() on passive sockets
> currently always return -EOPNOTSUPP as they relay on 'msk->subflow'.
>
> The rationale is I'm pretty sure we should try to remove 'msk->subflow'
> usage completely ;)

Removing msk->subflow sounds good to me!

Thanks for explaining the goals for this approach to fallback.

>
>> That seems like a lot of overhead, but if optimizing sendmsg/recvmsg on
>> fallback is introducing problems then we need to take that in to
>> consideration. It's not clear to me what we gain by using MPTCP
>> segmentation & reassembly after the fallback is complete (other than
>> possibly working around bugs in the existing fallback code). If the tric=
ky
>> part is completing the transmit or receive call where fallback happens
>> *during* the call, maybe the fallback technique used in this patch could
>> help complete an in-progress send/recv, but future calls would use
>> sock_sendmsg/sock_recvmsg?
>
> I would personally favour non fallback scenarios vs fallback ones.
> Keeping the current fallback 'shortcuts' affects badly the non fallback
> one due e.g. poll locking.

I agree, we don't want to add overhead to MPTCP connections in order to =

optimize fallback connections. The impact on polling and other operations =

wasn't clear to me before.

>
>> I'd also like to avoid overloading the term "infinite mapping", which has
>> specific meaning in the RFC: a DSS mapping with the data-level length set
>> to 0 that is sent under specific circumstances. If that specific DSS
>> mapping isn't present on the wire, maybe "dummy mapping" or "fake mappin=
g"
>> is a useful term to use instead.
>
> Agreed! :)
>
>>> @@ -428,8 +432,15 @@ static void mptcp_clean_una(struct sock *sk)
>>> {
>>> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
>>> 	struct mptcp_data_frag *dtmp, *dfrag;
>>> -	u64 snd_una =3D atomic64_read(&msk->snd_una);
>>> 	bool cleaned =3D false;
>>> +	u64 snd_una;
>>> +
>>> +	/* on fallback we just need to ignore snd_una, as this is really
>>> +	 * plain TCP
>>> +	 */
>>> +	if (msk->fallback)
>>> +		atomic64_set(&msk->snd_una, msk->write_seq);
>>> +	snd_una =3D atomic64_read(&msk->snd_una);
>>
>> An alternative to flushing the rtx_queue here would be to not add anythi=
ng
>> to the rtx_queue when in fallback, and to do a one-time flush when going
>> in to fallback.
>
> I *think* we will end-up doing the one-time flushing here, as fallback
> may happen in subflow ctx where the msk socket lock is not held.
>
> Yep, we can inprove memory usage avoiding the enqueue in the fallback
> case.
>

Agreed, thanks!

--
Mat Martineau
Intel

--===============7457279576315283028==--
