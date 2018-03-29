Content-Type: multipart/mixed; boundary="===============2551804250177271566=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Using struct socket for subflows
Date: Thu, 29 Mar 2018 13:01:10 -0700
Message-ID: <c8b8a471-0f08-68e5-12c9-3d57ea6e35a8@oracle.com>
In-Reply-To: 7aca469a-a2ed-b795-cd9f-9eca5f2fe0a0@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 474

--===============2551804250177271566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 03/29/2018 12:19 PM, Rao Shoaib wrote:
> Hi Steve,
>
> Sorry I did not respond to your email, too many issues to worry about :-)
>
>
> On 03/28/2018 02:33 PM, Stephen Brennan wrote:
>> Hi Rao et al.,
>>
>> On Tue, Mar 27, 2018 at 06:53:46PM -0700, Rao Shoaib wrote:
>>>
>>> On 03/27/2018 05:04 AM, Lorenzo Colitti wrote:
>>>> On Tue, Mar 27, 2018 at 11:18 AM, Christoph Paasch <cpaasch(a)apple.com
>>>> <mailto:cpaasch(a)apple.com>> wrote:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 It also would allow us to expose subflows as =
file-descriptors =

>>>> to the
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 user-space. That way the user-space can do se=
tsockopt,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 getsockopt,... on the
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 subflows. An idea that came up in the past wh=
en we were thinking
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 on how to
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 expose an MPTCP API that allows apps to contr=
ol certain things =

>>>> on the
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 subflows.
>>>>
>>>>
>>>> +1 to this since it will allow client platforms to use setsockopt to,
>>>> for example, bind subflows to interfaces (e.g., with =

>>>> SO_BINDTODEVICE, or
>>>> with SO_MARK as used by Android).
>>> May I ask why it can not be done=C2=A0 -- Only flow id should be needed.
>> It sounds like you're referring to the proposed MPTCP_SUB_GETSOCKOPT and
>> MPTCP_SUB_SETSOCKOPT operations in this IETF draft [1], correct?
>>
>> [1]: https://tools.ietf.org/html/draft-hesmans-mptcp-socket-00
> Actually I have not read the draft, my comment was based on general =

> understanding of the kernel. I am coming of Solaris and we know how to =

> create custom socket, special setopt/getopt , special fd's to expose =

> something etc etc. It is not rocket science. If someone has already =

> thought of it then we have less work to do.
>
> Any change of this kind has to be discussed in a standards body so =

> vendors and users can comment.
>>
>>> Plus for
>>> policy enforcement the meta socket would have to be consulted. I am =

>>> new to
>>> Linux but based on what I have read SO_BINDTODEVICE does not =

>>> guarantee much
>>> for Tx if the routing says otherwise, quick check of ip_queue_xmit() =

>>> shows
>>> it first consults the routing table. I understand policy routing can =

>>> be used
>>> to steer the packets. Perhaps my understanding is incorrect.
>>>
>>> IMHO this whole idea of exposing individual flows to the application =

>>> seems
>>> to go against the basic design of MPTCP. I am not sure what the use =

>>> case is
>>> as TCP is streams based and MPTCP will spread out data on multiple =

>>> flows. I
>>> am not a involved in the cellular space so I don' know, feel free to
>>> enlighten me.
>> I'm also a bit confused at this. I've read the Socket API drafts from =

>> IETF,
>> which seem to be motivated by the idea that mobile apps will want to
>> directly control which subflows and paths are created (similar to the =

>> iOS
>> APIs released recently). It sounds like we have two approaches: (1) =

>> MPTCP
>> as a drop-in replacement for TCP, so unmodified applications may use it,
>> and (2) MPTCP as an explicitly requested protocol which user-space
>> applications request, and then manipulate via socket options. Given the
>> amount of drafts and other work put in so far, it seems that use case =

>> (2)
>> has enough demand that it ought to be supported.
> Can you point me to the drafts or requests. As I said with the current =

> design everything is possible. No change is needed.
>
> Shoaib

Steve take a look at the following -- The possibilities are endless.

https://arxiv.org/pdf/1707.03585.pdf

The best approach I think is to enhance netlink. I have a=C2=A0 pie in the =

sky idea, we can have meta/master socket register with netlink, =

identified by src and destination addresses for direct communication.

Shoaib

--===============2551804250177271566==--
