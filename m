Content-Type: multipart/mixed; boundary="===============3224982186667283585=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Optimize DSS fields in
 mptcp_options_received
Date: Mon, 20 Jan 2020 23:34:37 +0100
Message-ID: <931bb51b-d7bf-ab84-5aca-6f17e4edbc77@tessares.net>
In-Reply-To: fe8c38b56768df950cb143970ce5b36e072af20f.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3438

--===============3224982186667283585==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Peter, Mat,

On 19/01/2020 15:27, Paolo Abeni wrote:
> On Fri, 2020-01-17 at 14:00 -0800, Peter Krystad wrote:
>> On Fri, 2020-01-17 at 19:40 +0100, Paolo Abeni wrote:
>>> On Fri, 2020-01-17 at 10:08 -0800, Mat Martineau wrote:
>>>> On Thu, 16 Jan 2020, Peter Krystad wrote:
>>>>
>>>>> Use union to minimize space used in structure.
>>>>> Allow 32-bit DSS to be received at the same time as MP_CAPABLE.
>>>>>
>>>>> squashto: Implement MPTCP receive path
>>>>>
>>>>> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
>>>>> ---
>>>>> include/linux/tcp.h | 18 ++++++++++++------
>>>>> 1 file changed, 12 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
>>>>> index 6abf8d9f1a42..a9200a86a6d2 100644
>>>>> --- a/include/linux/tcp.h
>>>>> +++ b/include/linux/tcp.h
>>>>> @@ -80,12 +80,18 @@ struct tcp_sack_block {
>>>>>
>>>>> #if IS_ENABLED(CONFIG_MPTCP)
>>>>> struct mptcp_options_received {
>>>>> -	u64	sndr_key;
>>>>> -	u64	rcvr_key;
>>>>> -	u32	data_ack32;
>>>>> -	u32	data_seq32;
>>>>> -	u64	data_ack;
>>>>> -	u64	data_seq;
>>>>> +	union {
>>>>> +		struct {
>>>>> +			u64	sndr_key;
>>>>> +			u64	rcvr_key;
>>>>> +			u32	data_ack32;
>>>>> +			u32	data_seq32;
>>>>> +		};
>>>>> +		struct {
>>>>> +			u64	data_ack;
>>>>> +			u64	data_seq;
>>>>> +		};
>>>>> +	};
>>>>
>>>> If one of the goals is to ensure that mixed 32/64 ack/seq is working (=
as
>>>> mentioned in next commit message), I think it would be better to expre=
ss
>>>> that as a union with the data_ack/data_seq and sndr_key/rcvr_key values
>>>> rather than depend on struct alignment:
>>>>
>>>>   	struct {
>>>>   		union {
>>>>   			struct {
>>>>   				u64	sndr_key;
>>>>   				u64	rcvr_key;
>>>>   			};
>>>>   			struct {
>>>>   				u64	data_ack;
>>>>   				u64	data_seq;
>>>>   			};
>>>>   		};
>>>>   		u32	data_ack32;
>>>>   		u32	data_seq32;
>>>>   	};
>>>
>>> I'm really low on coffee here, so please perdom me for the likely dumb
>>> comment, but...
>>>
>>> why do we need data_*32 and  *_key simult? I think we don't allow MPC
>>> and DSS in the same packet ?!?
>>
>> The mutipath-tcp.org implementation would do this so (and also data_*32 =
+ IPv4
>> add_addr). If we know we won't ever do these combinations, and we only w=
ant to
>> work with ourselves, then it is not necessary.
> =

> =

> Uhmm.. I *think* with MPTCP v1 MPC+DSS is no longer required (nor
> should be sent)? we have MPC+data instead...
> =

> (sorry I have the vague the feeling we already have discussed this in
> the past, but for sure I completely forgot the conclusion...)

Sorry to ask this question but do we want this change for part 2?

I understand the benefits and we should optimize mptcp_options_received =

structure at some points but from what I see, there are still some =

discussions about the content of the structure and having this union =

forces us to make sure we don't mix the usage of the members when =

parsing TCP options and when reading what has been parsed. Maybe it's a =

risk we don't want to take now for part 2.

We could postpone these optimizations for later before adding MP_JOIN =

and ADD_ADDR.

This patch and the "parent" one ("mptcp: Store 32 and 64-bit ACKs =

separately") are the two blocking ones to finalize part 2.

What do you think?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3224982186667283585==--
