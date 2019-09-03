Content-Type: multipart/mixed; boundary="===============7736721132184597612=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 2/7] mptcp: update per unacked sequence on pkt
 reception
Date: Tue, 03 Sep 2019 16:54:59 -0700
Message-ID: <alpine.OSX.2.21.1909031524540.92944@hzhan13-mobl.ccr.corp.intel.com>
In-Reply-To: 8ac2d23a69f85523b23f7a27dfd9394928ad2c09.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1786

--===============7736721132184597612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 31 Aug 2019, Paolo Abeni wrote:

> On Fri, 2019-08-30 at 17:46 -0700, Mat Martineau wrote:
>>> +void update_una(struct mptcp_sock *msk, u64 old_una, u64 new_una)
>>> +{
>>> +	atomic64_cmpxchg(&msk->snd_una, old_una, new_una);
>>
>> Do we want to silently skip the update if the old_una does not match?
>>
>> Skipping the update is certainly the right thing if msk->snd_una was
>> changed to be a value after new_una. If msk->snd_una is still behind
>> new_una, then we're ignoring a valid ack.
>>
>> Back when I was (mistakenly) using cmpxchg with msk->ack_seq, I had this
>> chunk of code:
>>
>> +       do {
>> +               if (!before64(old_ack, ack_seq)) {
>> +                       pr_debug("skipping ack update");
>> +                       break;
>> +               }
>> +               pr_debug("old_ack=3D%llu new_ack=3D%llu", old_ack, ack_s=
eq);
>> +       } while (!atomic64_try_cmpxchg(&arg->msk->ack_seq, &old_ack,
>> ack_seq));
>>
>> Seems like it would be good to use something similar here, maybe limiting
>> the retries.
>
> Yep, I thought a  bit about introdicing something similar, but for this
> submission I preferred keep the code as simple as possible. At worse we
> will need a retransmission or reinjection (but the occurence looks
> quite unlikely). I can add the loop in the next iteration. I don't
> think bounding it is required, even a malicius peer can push packets
> b2b close enough to let us spinning here.
>

Ok, I'm fine with adding the loop in the next iteration.


>>> +}
>>> +
>>> void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb,
>>> 			    struct tcp_options_received *opt_rx)
>>> {
>>> @@ -547,6 +567,19 @@ void mptcp_incoming_options(struct sock *sk, struc=
t sk_buff *skb,
>>> 	if (!mp_opt->dss)
>>> 		return;
>>>
>>> +	/* we can't wait for recvmsg() to update the ack_seq, otherwise
>>> +	 * monodirectional flows will stuck
>>> +	 */
>>> +	if (msk && mp_opt->use_ack) {
>>> +		u64 snd_una =3D atomic64_read(&msk->snd_una);
>>
>> After our discussion of memory barriers in the "Make MPTCP socket
>> block/wakeup ignore sk_receive_queue" patch, I wanted to double-check th=
is
>> use. Documentation/atomic_t.txt says that "non-RMW" operations like this
>> read are unordered, and need smp_mb__before_atomic() or
>> smp_mb__after_atomic(). It seems like we need to worry about ordering
>> because we have a locked subflow here and an msk lock is not held by this
>> thread, and there may be other subflows trying to update snd_una on other
>> CPUs.
>
> I *think* atomic64_read() is enough here, mainly because I don't see
> other read operations we need to enforce an order? What I'm missing???
>

I don't think you're missing anything, the misunderstanding was on my =

part.

>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 15bd54f43d4b..52e39fbb217d 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -696,6 +696,7 @@ static struct sock *mptcp_accept(struct sock *sk, i=
nt flags, int *err,
>>>
>>> 		crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
>>> 		msk->write_seq =3D subflow->idsn + 1;
>>> +		atomic64_set(&msk->snd_una, msk->write_seq);
>>
>> Does the msk lock give us the ordering we need here?
>
> Same here, in respect to which other write operations we want to sync
> here?

I was looking at any of the changes to msk->snd_una that happen without =

the msk lock held. Looking at it again, I'm pretty sure this is fine - all =

of these values need to be set before any data is sent or received, and =

both the subflow and mptcp sockets are locked. Sorry for the confusion.

--
Mat Martineau
Intel

--===============7736721132184597612==--
