Content-Type: multipart/mixed; boundary="===============3674367137665611886=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 23rd of January 2020
Date: Fri, 24 Jan 2020 17:38:56 +0100
Message-ID: <9c637883-ad74-d916-1bbf-8256ac86c4ac@tessares.net>
In-Reply-To: fea5f312eded56950abc076914c464a1a5f264c7.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3498

--===============3674367137665611886==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 24/01/2020 11:14, Paolo Abeni wrote:
> On Thu, 2020-01-23 at 22:42 +0100, Matthieu Baerts wrote:
>>           - We propose to send a new version on Monday if we don't have
>> any feedback (not to spam netdev even more)
> =

> I think it's a good plan.

Plans have changed, it's applied!!! :-D

>>           - Patches are still marked as "Needs Review / ACK"
>>             https://patchwork.ozlabs.org/patch/1226939/
>>
>>           - if we re-send, we should include the checkpatch fixes
>>
>>       - checkpatch: 3 issues:
>>           - one space/tabs mix (1 tabs + 9 spaces instead of 2 tabs + 1
>> space)
>>           - one extra space after '*' when declaring a function
>>           - one comparison to "NULL": var =3D=3D NULL instead of !var
>>           =E2=86=92 we can wait for when we will need to send a new vers=
ion
>>           =E2=86=92 *Matth* can send patches and apply them later
> =

> Would be good including the above, but I personally have hard time to
> do anything before next Mon.

Where can we apply these very small fixes now that the series is =

applied? I can send the patches but do we want to ignore them or apply =

them if we modify the code around?

>> Part 3 remaining stuff:
>>       - Review commit messages:
>>           - needed for the next merge window: not urgent
>>
>>       - reduce locks in mptcp_stream_accept() (currently 3 locks) but we
>> might need to add an helper in inet API:
>>           - Paolo started to look at that
>>           - we suppose he is still on it, to be discussed next week
> =

> Still on my TODO list, but not as high priority as the PM stuff
> below... (no work done so far)
> =

>>       - memleak if a request comes after a socket is closed:
>>           - Florian plans to look at that
>>           - we suppose he is still on it, to be discussed next week
>>
>>       - PM:
>>           - the one we have:
>>               - was/is an interim PM
>>               - maybe need more work: locking ??? (at least check which
>> are the missing pieces, possibly some basic locking schema is missing)
> =

> I think the locking should/could be fixed a not too intrusive way, as
> most PM action already happens in workqueue context and we can acquire
> the msk socket lock there.

Thank you for sharing this!

>>           - do we want to ship it?
>>
>>           - the idea would be to have:
>>               - a "basic" path manager that can create subflows
>>               - a server-side dedicated PM that sends ADD_ADDR, maybe
>> more but not too much (max nb of subflows if it is not possible to block
>> via another way?)
>>               - a netlink PM (see mptcp.org) to be able to customise it
>> from the userspace
>>               - a flexible BPF oriented PM (easy to implement =E2=86=92 =
easy to
>> hook, easy to call bpf functions to change behaviours)
> =

> We discussed off-line this topic. We think that a netlink-based,
> simple and allowing future features could be created with a reasonable
> effort. The idea would be to initially support only a few commands:
> =

> 	- announce the provided address[es]
> 		* argument is an address [list]
> =

> 	- add new subflows using the provided address[es]
> 		* argument is an address [list]
> 		=

> 	- add subflows for each announced address
> 		* argument is a single number: the maximum number
> 		  of allowed subflows created for the addresses
> 		  announced by the peers. 0 =3D=3D no subflows creation
> 		  for the announced received.
> =

> each command will affect all the MPTCP sockets created in the current
> netns after that the netlink command is issued.

If I understand well, you want something different than the netlink =

path-manager we have on MPTCP out-of-tree, right?

This PM acts per MPTCP connection while here, you want to act on all =

existing and future connections, right?

For the two first items, is it not something we can already achieve with =

the "basic" PM via sysctl per NS but only valid for one address to =

announce/create a subflow?

> The idea is that we should be able to easily plug both self-tests and
> almost reasonable "production" behaviours with the above.

To replace the basic PM them or already support the "server PM" we were =

mentioning in the notes?

Cheers,
Matt

PS: thank you for your talk in Brno, I am sure it helped to have part 2 =

accepted :-D
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3674367137665611886==--
