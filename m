Content-Type: multipart/mixed; boundary="===============3389999889200756048=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Next steps discussion
Date: Thu, 01 Mar 2018 12:05:30 -0800
Message-ID: <alpine.OSX.2.21.1803011143000.24753@mjmartin-mac01.local>
In-Reply-To: 20180301193847.GV2038@MacBook-Pro-4.local
X-Status: 
X-Keywords:                  
X-UID: 337

--===============3389999889200756048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 1 Mar 2018, Christoph Paasch wrote:

> On 01/03/18 - 18:05:40, Matthieu Baerts wrote:
>> Hi Christoph,
>>
>> On Wed, Feb 28, 2018 at 11:41 PM, Christoph Paasch <cpaasch(a)apple.com>
>> wrote:
>>
>>> Yeah, feedback was disappointingly scarce :/
>>>
>>> It probably was not what he had completely in mind, as he didn't talk a=
bout
>>> a TCP-option framework but simply about moving TCP-MD5 code out of the
>>> TCP-stack. So, with our proposal we went a bit further.
>>>
>>
>> Or maybe simply unlucky with who was available at this time to have a lo=
ok
>> at them :)
>>
>>
>>> TLS is a good example. They actually do have a lookup table where the
>>> driver
>>> is calling back into the TCP-stack to get the TLS-record information.
>>>
>>> We had discussed this with people from Mellanox that proposed the
>>> TLS hardware offloading: https://lists.01.org/
>>> pipermail/mptcp/2017-November/000165.html
>>
>>
>> Thank you for the link!
>>
>> Yes, that would be good! Just a short weekly sync could be useful.
>>>
>>> Do you have a Webex or other means to set this up?
>>>
>>
>> I think I can setup a webex (even if it is less fun to use that on a Lin=
ux
>> desktop :) ). We already used talky.io, more Linux friendly if we need to
>> share screen and others, maybe not needed.
>
> talky.io is fine for me as well.

I haven't used it before, but it looks like a fine option. Thank you for =

setting this up.

>
>> Another issue may be the time. I think you are all in the west coast of =
the
>> US :-)
>> But I am sure I can find time on the evening for a short meeting!
>
> Ideally for me, it would be at 9am (for you 6pm). Otherwise, I can make 8=
am
> as well (5pm for you).
>
> I don't know what the opinion of the others is on the timing.

I'm also in the Pacific time zone, as are my coworkers Peter and Ossama. =

Personally, 9am works better.

>
>>
>>
>>> Looking forward to the netlink PM! :-)
>>>
>>
>> I hope I will have time very soon to clean this.
>> Mat, do you prefer to talk about that directly by commenting the patches=
 on
>> mptcp-dev ML?

That's fine with me. I did read the paper (unfortunately I hadn't come =

across it before!), and it looks like our approaches have a lot in common =

- it will be informative to compare the details.


From earlier in this sub-thread:

>      This is what I'm working on now. For outgoing packets, I have a way
>      to optionally allocate sk_buffs with extra control block space. For
>      incoming packets, my initial experiment is with preventing packet
>      coalesce/collapse so TCP options are still in the skb headroom. I
>      don't consider that a long-term solution, though. Some kind of
>      lookup table will probably be needed.
>
> That looks interesting!
>
> On some systems with hardware acceleration to bypass the main CPU for =

> established connections, I guess they also have to modify the skb to =

> share info between the main CPU and another component. Do you have any =

> ideas how they are doing that? It is maybe not a real problem for them =

> to increase the size of the skb if most of the traffic goes in the "fast =

> path".

Are you referring to userspace stacks (like DPDK), or optimizations like =

GRO? I'm not sure of the specific answer to your question, but from what I =

see the drivers try to allocate enough space in the skbs to accomodate the =

storage needs through the skb's lifetime.

Thanks,

--
Mat Martineau
Intel OTC

--===============3389999889200756048==--
