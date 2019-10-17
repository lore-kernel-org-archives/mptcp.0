Content-Type: multipart/mixed; boundary="===============3142087200594612620=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 5/6] mptcp: add and use
 mptcp_subflow_get_retrans
Date: Wed, 16 Oct 2019 17:26:50 -0700
Message-ID: <alpine.OSX.2.21.1910161621460.4400@jodiswax-mobl1.amr.corp.intel.com>
In-Reply-To: 4719dfb073174d7c381f9e9efc01626ff4fef7b2.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2198

--===============3142087200594612620==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 15 Oct 2019, Paolo Abeni wrote:

> On Tue, 2019-10-15 at 14:13 +0200, Florian Westphal wrote:
>> Paolo Abeni <pabeni(a)redhat.com> wrote:
>>> On Tue, 2019-10-15 at 01:19 +0200, Florian Westphal wrote:
>>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>>> index 259a2743db91..e003608af237 100644
>>>> --- a/net/mptcp/protocol.c
>>>> +++ b/net/mptcp/protocol.c
>>>> @@ -781,6 +781,35 @@ static void mptcp_retransmit_timer(struct timer_l=
ist *t)
>>>>  	sock_put(sk);
>>>>  }
>>>>
>>>> +/* return first subflow that has no data outstanding at tcp level.
>>>> + *
>>>> + * Never return a backup subflow unless thats the only kind left.
>>>> + */
>>>> +static struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock=
 *msk)
>>>> +{
>>>> +	struct mptcp_subflow_context *subflow;
>>>> +	struct sock *backup =3D NULL;
>>>> +	bool use_backup =3D true;
>>>> +
>>>> +	sock_owned_by_me((const struct sock *)msk);
>>>> +
>>>> +	mptcp_for_each_subflow(msk, subflow) {
>>>> +		struct sock *ssk =3D mptcp_subflow_tcp_socket(subflow)->sk;
>>>> +
>>>> +		if (!subflow->backup)
>>>> +			use_backup =3D false;
>>>> +
>>>> +		if (tcp_write_queue_empty(ssk)) {
>>>> +			if (!subflow->backup)
>>>> +				return ssk;
>>>
>>> I think that to be as accurate as possible we could try to check only
>>> vs the write queue of the subflow used to send the current dfrag -
>>> otherwise we could end-up with spurious/unneded retransmissions on some
>>> corner cases.
>>
>> I'm not following, sorry.
>>
>> So I think that what you'd like is something like this:
>>
>>> Additionally we may want to explicitly exclude/penalize such subflow
>>> from the selection here.
>>
>> static struct sock *
>> mptcp_subflow_get_retrans(const struct mptcp_sock *msk, struct sock *dfr=
ag_origsk)
>> {
>> 	[..]
>>
>> 	if (ssk =3D=3D dfrag_origsk)
>> 		continue; /* never retrans on same subflow */
>>
>> 	if (!subflow->backup)
>> 		use_backup =3D false;
>>
>> 	if (!best || compare_sk(ssk, best))
>> 		best =3D ssk;
>> ...
>>
>> Is that right?
>
> Yes, exactly!
>
>> Rationale for the approach done in patch 5 was that MPTCP-Level retransm=
its
>> are useless in virtually all cases.
>>
>> The retransmit would only be needed in case we sent data on ssk x
>> but peer went dead after xmit started.
>
> uhmm... I think that it will suffice if peer goes dead after we
> create/enqueue the skb (mptcp_sendmsg() completes). Could/should happen
> quite consistently e.g. when the client switches from wifi to 4G, and
> the flow is almost unidirectional from the server.
>
>> I wanted to make sure we only retransmit on ssks that have no
>> inflight packets, under the assumption that the dfrag has been acked
>> by the next time the retransmit timer kicks in.

That might make it a good idea to not push more new data in to the ssks =

once MPTCP-level retransmission kicks in? We don't want the subflow =

buffers filled up with new data when the MPTCP socket is trying to =

retransmit.

>>
>> What we could do is re-use mptcp_subflow_get_send() from patch 6,
>> adding a 'struct sock *ignore' argument, which would be NULL for normal
>> case and dfrag->orig_sk for retransmit case.
>
> I was in the act of suggesting the above on patch 6 :) I think it would
> simplify the code having a single algorithm to pick-up the next
> subflow.

Simplifying sounds good to me! However, I'm not sure it's good to =

completely ignore the dfrag->orig_sk socket, it could be the only subflow =

(or only non-backup) available. Our MPTCP-level reassembly code doesn't =

currently have an out-of-order queue, so it can flush incoming data =

received on a working subflow when the actual network loss was on a =

different subflow.

>
> Apropos: another thing I would eventually consider for patch 6 is [try =

> to] reuse the subflow we used last, if it has a non empty window. If we =

> can't, we do the full lookup. That should allow the peer to reconstruct =

> more easily the MPTCP level data sequence, with possibly less switches =

> from one subflow to another.
>

In the LPC presentation and paper we proposed keeping the scheduler =

extremely simple, with the focus being on the server use case with a =

limited number of subflows (maybe even just two, allowing for a primary =

and backup). The idea for the first patch set was to focus on MPTCP for =

failover rather than aggregating multiple subflows to maximize throughput.

That could mean simply transmitting on the first available non-backup =

subflow, leaving others on the list idle.

>> That would make retransmits more aggressive for active/active
>> scenarios when one subflow is 'stuck' and the other has pending
>> packets (but the subflow can accept more data).
>
> I think we can mitigate/optimize out the unneeded retransmissions some
> way. e.g. no need to retransmit if the relevant ssn increased since
> last check/enqueue time.
>
> In some scenarios retransmitting the data on a different subflow could
> possibly inprove the tput/latency even if the first transmission has
> not been lost - e.g. if the subflow we used first is experiencing
> congestion.
>
>>> Storing the subflow ptr into a new/additional dfrag field at
>>> transmission time should allow the above.
>>
>> Yes, we can store the ssk that was used for orig transmission,
>> question I have is why :-)
>
> I think having relevant subflow handy will help with the above
> heuristics.
>
> I can agree we can do this kind of tuning/optimization/heuristic[/over-
> design???] later, I'm wondering if we should consider some room for
> them now?
>

As this email thread shows, there are a lot of potential inputs for making =

a scheduling decision and there isn't a one-size-fits all scheduling =

algorithm. The multipath-tcp.org kernel handles this with different =

scheduler modules, and we do have configurable schedulers later in the =

roadmap.

My suggestion is to keep it very, very simple for now!

--
Mat Martineau
Intel
--===============3142087200594612620==--
