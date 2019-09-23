Content-Type: multipart/mixed; boundary="===============0559277886512290835=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: sendmsg: fix stream corrution
Date: Mon, 23 Sep 2019 10:17:48 +0200
Message-ID: <c0fac11b-3b23-9905-66ca-c5ca9d455a5f@tessares.net>
In-Reply-To: 8d138cb8c6bc48942ec2238f145a10227e7850e2.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1903

--===============0559277886512290835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 23/09/2019 09:46, Paolo Abeni wrote:
> On Fri, 2019-09-20 at 15:45 -0700, Mat Martineau wrote:
>> On Fri, 20 Sep 2019, Paolo Abeni wrote:
>>
>>> Currently we can hit a stream's corruption with the following sequence:
>>> - sendmsg_frag is invoked while the write_queue tail skb's len is equal=
 to
>>>  the current size_goal.
>>>  sendmsg_frag sets can_collapse to false, even if mptcp data are in seq=
uence.
>>>  Anyway it does not set eor in the write_queue skb.
>>> - sendmsg_frag invokes do_tcp_sendmsg(), which tries to allocate a new =
skb -
>>>  as the 'size_goal - skb->len <=3D 0' condition is true.
>>>  But it hits memory limit and/or such allocation fails, so do_tcp_sendm=
sg()
>>>  jumps to the 'wait_for_memory:' label and invokes tcp_push()
>>> - tcp_push() tries to transmit the write queue tail skb, but due to win=
dow size
>>>  limit, split it, send the first half and leave in the write queue a sm=
aller
>>>  skb - without any ext attached
>>> - do_tcp_sendmsg() invokes sk_stream_wait_memory and than checks again =
for skb
>>>  allocation, this time skb->len is less than size_goal and do_tcp_sendm=
sg()
>>>  collapse the data on the existing skb
>>> - sendmsg_frag adds a new ext to the tail skb in write queue, but due t=
o the above
>>>  it is associated with a wrong/unexpected subflow sequence number: it m=
aps
>>>  a future ssn -> stream corruption
>>>
>>> This change addresses the above issue explicitly setting the 'eor' when=
 hitting
>>> the initial condition so that tcp will not collapse the data after tcp_=
push().
>>
>> Thanks for the detailed description. Code looks good to me and tested fi=
ne =

>> (although failures remain, but I don't think this was intended to fix =

>> everything).
> =

> I haven't seen any failure on top of this patch (plus recvmsg
> refactor), could you share debug enabled dmsg and/or pcap trace for
> failure you see?

I also saw failed tests but everything was fixed once "recvmsg refactor"
was applied too!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============0559277886512290835==--
