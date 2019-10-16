Content-Type: multipart/mixed; boundary="===============6475071438457826436=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/3] mptcp: just another recvmsg refactor
Date: Wed, 16 Oct 2019 10:22:22 +0200
Message-ID: <87fd8b8115c48d4b2472bea06df4ccef5830d3de.camel@redhat.com>
In-Reply-To: fbb84d58-9078-773e-ce7e-2b0f9792a10a@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2166

--===============6475071438457826436==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-10-16 at 09:39 +0200, Matthieu Baerts wrote:
> On 15/10/2019 22:39, Paolo Abeni wrote:
> > On Tue, 2019-10-15 at 17:44 +0200, Paolo Abeni wrote:
> > > I think this 3 patches should be squashed into
> > > "mptcp: Implement MPTCP receive path", but the resulting one will be =
likely
> > > too huge; possibly splitting the resulting code in 2 different patche=
s would
> > > be nicer. Additionally "mptcp: Implement MPTCP receive path" has some=
 chunks
> > > that should be likely moved to some other patches (e.g. ULP RCU fixes=
).
> > > =

> > > What if - after the eventuall accept - I publish the resulting code o=
f the
> > > above squashing somewhere?
> > =

> > Since I'm an incurable optimist, I went ahead and pushed the rebase
> > here:
> =

> Thank you for this work!
> =

> > https://github.com/pabeni/mptcp/tree/mptcp-proposal-recvmsg_rebase_7
> > =

> > Squashed:
> > "mptcp: flush duplicate data at data_ready() time"
> > and
> > "mptcp: move some helper into the header file"
> >    into "mptcp: Implement MPTCP receive path"
> >      (and rewrote the commit message)
> > =

> > "mptcp: harmonize locking on all socket operations."
> >    partially in
> >      "mptcp: Associate MPTCP context with TCP socket"
> >    and partially in
> >      "mptcp: Create SUBFLOW socket for incoming connections"
> > =

> > Moved the RCU bits from "mptcp: Implement MPTCP receive path"
> > into:
> >    "mptcp: Associate MPTCP context with TCP socket"
> > =

> > Moved the options/ack_seq bits from "mptcp: Implement MPTCP receive
> > path" into:
> >    "mptcp: Write MPTCP DSS headers to outgoing data packets"
> > =

> > Rebased "mptcp: recvmsg() can drain data from multiple subflows" on top
> > of "mptcp: Implement MPTCP receive path"
> > =

> > Removed a few intentation issue.
> > =

> > I checked for build issue only on the modified patches.
> > =

> > The overall diff from current export branch plus the pending patches is
> > reported below.
> =

> Which ref of the "export" branch did you use? This branch has been =

> overridden 3 times yesterday:
> - around 3.52am: a rebase on latest net-next
> - around 2.42pm: to include "selftests: allow compilation on older system=
s"
> - around 5.23pm: to include "mptcp:pm: some cleanup"

It looks I luckly included all the above.

> Note that a rebase on latest net-next was done this night by the CI but =

> that's easy to re-do.

But not this one.

> Will you include the change proposed by Mat in a new rebase?

Yes, I'm cooking patch && rebase right now. I hopefully will send soon
v2 of the patches with a reference to the rebase branch in the cover
letter. I'll rebase on top of net-next commit:

77ffe33363c0 ("hv_sock: use HV_HYP_PAGE_SIZE for Hyper-V communication")

to be in sync with the current export branch. Would that help?

Thanks!

Paolo

--===============6475071438457826436==--
