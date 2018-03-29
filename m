Content-Type: multipart/mixed; boundary="===============4417635431411790867=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Using struct socket for subflows
Date: Thu, 29 Mar 2018 12:11:57 -0700
Message-ID: <0c0eb52f-b446-eb98-ea6c-053650152c92@oracle.com>
In-Reply-To: 20180329182757.GE71178@MacBook-Pro-6.lan
X-Status: 
X-Keywords:                  
X-UID: 473

--===============4417635431411790867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 03/29/2018 11:27 AM, Christoph Paasch wrote:
> Hello,
>
> On 28/03/18 - 14:33:03, Stephen Brennan wrote:
>> Hi Rao et al.,
>>
>> On Tue, Mar 27, 2018 at 06:53:46PM -0700, Rao Shoaib wrote:
>>>
>>> On 03/27/2018 05:04 AM, Lorenzo Colitti wrote:
>>>> On Tue, Mar 27, 2018 at 11:18 AM, Christoph Paasch <cpaasch(a)apple.com
>>>> <mailto:cpaasch(a)apple.com>> wrote:
>>>>
>>>>      It also would allow us to expose subflows as file-descriptors to =
the
>>>>      user-space. That way the user-space can do setsockopt,
>>>>      getsockopt,... on the
>>>>      subflows. An idea that came up in the past when we were thinking
>>>>      on how to
>>>>      expose an MPTCP API that allows apps to control certain things on=
 the
>>>>      subflows.
>>>>
>>>>
>>>> +1 to this since it will allow client platforms to use setsockopt to,
>>>> for example, bind subflows to interfaces (e.g., with SO_BINDTODEVICE, =
or
>>>> with SO_MARK as used by Android).
>>> May I ask why it can not be done=C2=A0 -- Only flow id should be needed.
>> It sounds like you're referring to the proposed MPTCP_SUB_GETSOCKOPT and
>> MPTCP_SUB_SETSOCKOPT operations in this IETF draft [1], correct?
>>
>> [1]: https://tools.ietf.org/html/draft-hesmans-mptcp-socket-00
>>
>>> Plus for
>>> policy enforcement the meta socket would have to be consulted. I am new=
 to
>>> Linux but based on what I have read SO_BINDTODEVICE does not guarantee =
much
>>> for Tx if the routing says otherwise, quick check of ip_queue_xmit() sh=
ows
>>> it first consults the routing table. I understand policy routing can be=
 used
>>> to steer the packets. Perhaps my understanding is incorrect.
>>>
>>> IMHO this whole idea of exposing individual flows to the application se=
ems
>>> to go against the basic design of MPTCP. I am not sure what the use cas=
e is
>>> as TCP is streams based and MPTCP will spread out data on multiple flow=
s. I
>>> am not a involved in the cellular space so I don' know, feel free to
>>> enlighten me.
>> I'm also a bit confused at this. I've read the Socket API drafts from IE=
TF,
>> which seem to be motivated by the idea that mobile apps will want to
>> directly control which subflows and paths are created (similar to the iOS
>> APIs released recently).
> The iOS APIs only allow an app to communicate its intention (handover,
> interactive, aggregate). At the end of the day, the app is not able to
> trigger the creation of a subflow on cellular.
>
> Just nit-picking ;-)
Creating subflows and managing them=C2=A0 can be done today.
>
>> It sounds like we have two approaches: (1) MPTCP
>> as a drop-in replacement for TCP, so unmodified applications may use it,
>> and (2) MPTCP as an explicitly requested protocol which user-space
>> applications request, and then manipulate via socket options. Given the
>> amount of drafts and other work put in so far, it seems that use case (2)
>> has enough demand that it ought to be supported.
> Yes, the drop-in replacement does not work IMO, because the MPTCP-stack
> needs more context to make decisions.
#1 does not exclude #2. You can have both options, system wide or just =

on demand. The current implementation hands over the full packet to =

MPCTP to do whatever it wants.

Provide an example that can not be handled by the current design that I =

have posted.

>
>> Going slightly off topic from this discussion, it seems that a lot of wh=
at
>> is desired in use case (2) is allowing the application to manage its own
>> paths. We now have a Netlink API for userspace path managers. Have we
>> thought about the possibility of a userspace application creating an MPT=
CP
>> socket, and also a netlink socket, so that it could manage its own paths?
>> Just an off-the-wall idea. If such a thing were possible, it could give =
the
>> userspace app much more control over its own path management, while
>> reducing duplication of functionality in-kernel (e.g. wouldn't have both
>> socket option for opening a subflow, plus a netlink command for opening a
>> subflow).
> Yes, this is definitely a viable solution. The app could use a library th=
at
> is able to speak netlink-API and manage subflows.
>
> Your library? ;-)
Yes that is what I have in mind also but this does not require any =

change in the current design. I have not read the netlink design but I =

thought that it would already have that.
>
>> A userspace library could hide some of this complexity for users
>> of use-case (2), while still allowing use-case (1) to exist through the
>> normal socket API.
> The idea behind exposing subflows as FDs came from the need that apps wou=
ld
> want to control socket-options on a per-subflow basis. E.g., TCP-keepaliv=
e,
> SO_MARK (for Android),...
> The app would want to get stats like TCP_INFO,...
>
> We don't have a good way at the moment to do this. And, using
> file-descriptors seemed like a viable solution.
No it does not. Application needs to handle only one fd. All the above =

can be done but is not in scope for the initial implementation.
>
>
> That doesn't mean that we will do this right away :)
> But - as from my original mail - having fully functional struct socket
> attached to the subflows allows us to move that way in the future.
I do not see any technical argument. In fact I argue that if for example =

fd are needed in the future it would be simple to expose the current =

subflows without requiring any change to MPTCP or TCP. The current =

design does not exclude anything.

Shoaib


--===============4417635431411790867==--
