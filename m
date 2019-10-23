Content-Type: multipart/mixed; boundary="===============8699499449553676282=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 2/4] subflow: wake parent mptcp socket on
 subflow state change
Date: Wed, 23 Oct 2019 12:02:19 -0700
Message-ID: <alpine.OSX.2.21.1910231125360.37761@rjszuste-mobl.amr.corp.intel.com>
In-Reply-To: 20191023182228.GO25052@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2294

--===============8699499449553676282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Oct 2019, Florian Westphal wrote:

> Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
>> On Wed, 23 Oct 2019, Florian Westphal wrote:
>>
>>> We need to wakeup readers blocking for POLLIN, as no
>>> more data will arrive they will never be awoken otherwise.
>>>
>>> This is needed at least until proper MPTCP-Level fin/reset
>>> signalling gets added.
>>>
>>> Signed-off-by: Florian Westphal <fw(a)strlen.de>
>>> ---
>>> net/mptcp/subflow.c | 23 +++++++++++++++++++++++
>>> 1 file changed, 23 insertions(+)
>>>
>>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>>> index 1f27a96d0439..7bae7c35ea6b 100644
>>> --- a/net/mptcp/subflow.c
>>> +++ b/net/mptcp/subflow.c
>>> @@ -722,6 +722,28 @@ static struct mptcp_subflow_context *subflow_creat=
e_ctx(struct sock *sk,
>>> 	return ctx;
>>> }
>>>
>>> +static void __subflow_state_change(struct sock *sk)
>>> +{
>>> +	struct socket_wq *wq;
>>> +
>>> +	rcu_read_lock();
>>> +	wq =3D rcu_dereference(sk->sk_wq);
>>> +	if (skwq_has_sleeper(wq))
>>> +		wake_up_interruptible_all(&wq->wait);
>>> +	rcu_read_unlock();
>>> +}
>>> +
>>> +static void subflow_state_change(struct sock *sk)
>>> +{
>>> +	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
>>> +	struct sock *parent =3D subflow->conn;
>>> +
>>> +	__subflow_state_change(sk);
>>> +
>>> +	if (parent)
>>> +		__subflow_state_change(parent);
>>
>> In the v1 patch I asked about the missing sk_wake_async() for the parent
>> socket - you proposed calling parent->sk_data_ready(parent) here. Can you
>> confirm which is intended?
>>
>> https://lists.01.org/hyperkitty/list/mptcp(a)lists.01.org/message/EMGGJL=
4WII7NYOVGY7VM7DAVYDGXSVJO/
>
> That comment refers to subflow_data_ready().  The patch here was not
> part of v1.  An alternative would be to make sock_def_wakeup()
> non-static and use it but since the function is very small I don't think
> thats needed. We will also likely want to do something different once
> MPTCP is able to process mptcp-level reset/fin.
>
> The proposed change of
>
> if (mptcp_should_wake_parent(subflow))
> 	parent->sk_data_ready(parent);
>
> inside subflow_data_ready isn't needed anymore because after Paolos
> refactoring the existing parent->sk_data_ready(parent);
>
> is already conditional on 'we have in-sequence data', so I dropped
> that part from the last patch.
>

Yeah, I misread the new patch. Thanks for explaining. I do agree that it =

makes more sense to create __subflow_state_change() than it does to export =

sock_def_wakeup().

--
Mat Martineau
Intel
--===============8699499449553676282==--
