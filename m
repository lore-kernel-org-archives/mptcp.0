Content-Type: multipart/mixed; boundary="===============1712482126667308956=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Using struct socket for subflows
Date: Thu, 29 Mar 2018 12:19:38 -0700
Message-ID: <7aca469a-a2ed-b795-cd9f-9eca5f2fe0a0@oracle.com>
In-Reply-To: 20180328213303.GB31782@greed.cult
X-Status: 
X-Keywords:                  
X-UID: 472

--===============1712482126667308956==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Steve,

Sorry I did not respond to your email, too many issues to worry about :-)


On 03/28/2018 02:33 PM, Stephen Brennan wrote:
> Hi Rao et al.,
>
> On Tue, Mar 27, 2018 at 06:53:46PM -0700, Rao Shoaib wrote:
>>
>> On 03/27/2018 05:04 AM, Lorenzo Colitti wrote:
>>> On Tue, Mar 27, 2018 at 11:18 AM, Christoph Paasch <cpaasch(a)apple.com
>>> <mailto:cpaasch(a)apple.com>> wrote:
>>>
>>>      It also would allow us to expose subflows as file-descriptors to t=
he
>>>      user-space. That way the user-space can do setsockopt,
>>>      getsockopt,... on the
>>>      subflows. An idea that came up in the past when we were thinking
>>>      on how to
>>>      expose an MPTCP API that allows apps to control certain things on =
the
>>>      subflows.
>>>
>>>
>>> +1 to this since it will allow client platforms to use setsockopt to,
>>> for example, bind subflows to interfaces (e.g., with SO_BINDTODEVICE, or
>>> with SO_MARK as used by Android).
>> May I ask why it can not be done=C2=A0 -- Only flow id should be needed.
> It sounds like you're referring to the proposed MPTCP_SUB_GETSOCKOPT and
> MPTCP_SUB_SETSOCKOPT operations in this IETF draft [1], correct?
>
> [1]: https://tools.ietf.org/html/draft-hesmans-mptcp-socket-00
Actually I have not read the draft, my comment was based on general =

understanding of the kernel. I am coming of Solaris and we know how to =

create custom socket, special setopt/getopt , special fd's to expose =

something etc etc. It is not rocket science. If someone has already =

thought of it then we have less work to do.

Any change of this kind has to be discussed in a standards body so =

vendors and users can comment.
>
>> Plus for
>> policy enforcement the meta socket would have to be consulted. I am new =
to
>> Linux but based on what I have read SO_BINDTODEVICE does not guarantee m=
uch
>> for Tx if the routing says otherwise, quick check of ip_queue_xmit() sho=
ws
>> it first consults the routing table. I understand policy routing can be =
used
>> to steer the packets. Perhaps my understanding is incorrect.
>>
>> IMHO this whole idea of exposing individual flows to the application see=
ms
>> to go against the basic design of MPTCP. I am not sure what the use case=
 is
>> as TCP is streams based and MPTCP will spread out data on multiple flows=
. I
>> am not a involved in the cellular space so I don' know, feel free to
>> enlighten me.
> I'm also a bit confused at this. I've read the Socket API drafts from IET=
F,
> which seem to be motivated by the idea that mobile apps will want to
> directly control which subflows and paths are created (similar to the iOS
> APIs released recently). It sounds like we have two approaches: (1) MPTCP
> as a drop-in replacement for TCP, so unmodified applications may use it,
> and (2) MPTCP as an explicitly requested protocol which user-space
> applications request, and then manipulate via socket options. Given the
> amount of drafts and other work put in so far, it seems that use case (2)
> has enough demand that it ought to be supported.
Can you point me to the drafts or requests. As I said with the current =

design everything is possible. No change is needed.

Shoaib
>
> Going slightly off topic from this discussion, it seems that a lot of what
> is desired in use case (2) is allowing the application to manage its own
> paths. We now have a Netlink API for userspace path managers. Have we
> thought about the possibility of a userspace application creating an MPTCP
> socket, and also a netlink socket, so that it could manage its own paths?
> Just an off-the-wall idea. If such a thing were possible, it could give t=
he
> userspace app much more control over its own path management, while
> reducing duplication of functionality in-kernel (e.g. wouldn't have both
> socket option for opening a subflow, plus a netlink command for opening a
> subflow). A userspace library could hide some of this complexity for users
> of use-case (2), while still allowing use-case (1) to exist through the
> normal socket API.
>
> Stephen
>
>


--===============1712482126667308956==--
