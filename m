Content-Type: multipart/mixed; boundary="===============7573503199834813840=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 23rd of January 2020
Date: Fri, 24 Jan 2020 11:14:22 +0100
Message-ID: <fea5f312eded56950abc076914c464a1a5f264c7.camel@redhat.com>
In-Reply-To: 5c91c39c-c774-0be9-f8d1-84c319862306@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3494

--===============7573503199834813840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-01-23 at 22:42 +0100, Matthieu Baerts wrote:
>          - We propose to send a new version on Monday if we don't have =

> any feedback (not to spam netdev even more)

I think it's a good plan.

>          - Patches are still marked as "Needs Review / ACK"
>            https://patchwork.ozlabs.org/patch/1226939/
> =

>          - if we re-send, we should include the checkpatch fixes
> =

>      - checkpatch: 3 issues:
>          - one space/tabs mix (1 tabs + 9 spaces instead of 2 tabs + 1 =

> space)
>          - one extra space after '*' when declaring a function
>          - one comparison to "NULL": var =3D=3D NULL instead of !var
>          =E2=86=92 we can wait for when we will need to send a new version
>          =E2=86=92 *Matth* can send patches and apply them later

Would be good including the above, but I personally have hard time to
do anything before next Mon.

> Part 3 remaining stuff:
>      - Review commit messages:
>          - needed for the next merge window: not urgent
> =

>      - reduce locks in mptcp_stream_accept() (currently 3 locks) but we =

> might need to add an helper in inet API:
>          - Paolo started to look at that
>          - we suppose he is still on it, to be discussed next week

Still on my TODO list, but not as high priority as the PM stuff
below... (no work done so far)

>      - memleak if a request comes after a socket is closed:
>          - Florian plans to look at that
>          - we suppose he is still on it, to be discussed next week
> =

>      - PM:
>          - the one we have:
>              - was/is an interim PM
>              - maybe need more work: locking ??? (at least check which =

> are the missing pieces, possibly some basic locking schema is missing)

I think the locking should/could be fixed a not too intrusive way, as
most PM action already happens in workqueue context and we can acquire
the msk socket lock there.

>          - do we want to ship it?
> =

>          - the idea would be to have:
>              - a "basic" path manager that can create subflows
>              - a server-side dedicated PM that sends ADD_ADDR, maybe =

> more but not too much (max nb of subflows if it is not possible to block =

> via another way?)
>              - a netlink PM (see mptcp.org) to be able to customise it =

> from the userspace
>              - a flexible BPF oriented PM (easy to implement =E2=86=92 ea=
sy to =

> hook, easy to call bpf functions to change behaviours)

We discussed off-line this topic. We think that a netlink-based, =

simple and allowing future features could be created with a reasonable
effort. The idea would be to initially support only a few commands:

	- announce the provided address[es] =

		* argument is an address [list]

	- add new subflows using the provided address[es] =

		* argument is an address [list] =

		=

	- add subflows for each announced address =

		* argument is a single number: the maximum number =

		  of allowed subflows created for the addresses =

		  announced by the peers. 0 =3D=3D no subflows creation
		  for the announced received.

each command will affect all the MPTCP sockets created in the current
netns after that the netlink command is issued.

The idea is that we should be able to easily plug both self-tests and
almost reasonable "production" behaviours with the above.

Cheers,

Paolo

--===============7573503199834813840==--
