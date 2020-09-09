Content-Type: multipart/mixed; boundary="===============7802969727036701342=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC mptcp-next 2/3] mptcp: rework poll+nospace handling
Date: Tue, 08 Sep 2020 17:48:18 -0700
Message-ID: <alpine.OSX.2.23.453.2009081644260.19380@fengzha2-mobl.amr.corp.intel.com>
In-Reply-To: 20200906174649.GM7319@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 5763

--===============7802969727036701342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, 6 Sep 2020, Florian Westphal wrote:

> Paolo Abeni <pabeni(a)redhat.com> wrote:
>> On Sun, 2020-09-06 at 17:58 +0200, Paolo Abeni wrote:
>>> On Sat, 2020-09-05 at 12:33 +0200, Florian Westphal wrote:
>>>> +static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
>>>> +{
>>>> +	struct sock *sk =3D (struct sock *)msk;
>>>> +	__poll_t ret =3D 0;
>>>> +	bool slow;
>>>> +
>>>> +	if (sk->sk_shutdown & SEND_SHUTDOWN)
>>>> +		return 0;
>>>> +
>>>> +	slow =3D lock_sock_fast(sk);
>>>> +	if (__mptcp_check_writeable(msk))
>>>> +		ret =3D EPOLLOUT | EPOLLWRNORM;
>>>> +
>>>> +	unlock_sock_fast(sk, slow);
>>>
>>> It's a pity we need to acquire the lock in mptcp_poll()... perhaps we
>>> could try to acquire it only if sk_stream_is_writeable(msk)?
>>
>> I'm also wondering if checking sk_stream_is_writeable(msk) could be
>> enough??? perhaps with a different sndbuf auto-tuning strategy.
>
> Not right now.  But perhaps this is worth exploring -- we would need
> to change mptcp_sendmsg to append data to the rtx queue in case no ssk
> can be found.
>
> I'd give this a try unless you or anyone else has objections.

No objection here, I think it would be good to explore - might fit the =

"easier to follow" criteria you mention in the cover letter. Having =

mptcp_poll() not only locking, but also doing the __mptcp_clean_una() =

work, seems kind of heavyweight for a poll operation.


>
>> e.g. if msk sndbuf <=3D max (ssk sndbuf), I *think*
>> that sk_stream_is_writeable(msk) implies at least a ssk is writeable,
>> too
>
> You mean mptcp_is_writeable()?
> [ Question above still stands though ]

--
Mat Martineau
Intel
--===============7802969727036701342==--
