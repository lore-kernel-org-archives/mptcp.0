Content-Type: multipart/mixed; boundary="===============4665553403856661588=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Patch does not apply
Date: Thu, 29 Mar 2018 20:12:13 +0200
Message-ID: <20180329181213.GC71178@MacBook-Pro-6.lan>
In-Reply-To: c8071f6c-b69a-0721-be22-c79bc77ae4df@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 469

--===============4665553403856661588==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 29/03/18 - 10:41:08, Rao Shoaib wrote:
> On 03/29/2018 08:40 AM, Mat Martineau wrote:
> > On Wed, 28 Mar 2018, Rao Shoaib wrote:
> > > I am unable to apply the 6th patch.
> > > =

> > > rshoaib(a)caduceus5:/home/mptcp/sock_mptcp/linux.old(master)$git am
> > > "/tmp/mails/[MPTCP] [RFC PATCH 03_16] mptcp: Add MPTCP socket stubs
> > > - Mat Martineau <mathew.j.martineau(a)linux.intel.com> - 2018-03-28
> > > 1618.eml"
> > > Applying: mptcp: Add MPTCP socket stubs
> > > .git/rebase-apply/patch:87: new blank line at EOF.
> > > +
> > > warning: 1 line adds whitespace errors.
> > > =

> > > rshoaib(a)caduceus5:/home/mptcp/sock_mptcp/linux(master)$git am
> > > "/tmp/mails/[MPTCP] [RFC PATCH 06_16] tcp: expose tcp routines and
> > > structs for MPTCP - Mat Martineau
> > > <mathew.j.martineau(a)linux.intel.com> - 2018-03-28 1618.eml"
> > > Applying: tcp: expose tcp routines and structs for MPTCP
> > > error: patch failed: include/net/inet_common.h:35
> > > error: include/net/inet_common.h: patch does not apply
> > > Patch failed at 0001 tcp: expose tcp routines and structs for MPTCP
> > > The copy of the patch that failed is found in: .git/rebase-apply/patch
> > > When you have resolved this problem, run "git am --continue".
> > > If you prefer to skip this patch, run "git am --skip" instead.
> > > To restore the original branch and stop patching, run "git am --abort=
".
> > > =

> > > rshoaib(a)caduceus5:/home/mptcp/sock_mptcp/linux(master|AM 1/1)$git
> > > remote -v
> > > origin
> > > https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git
> > > (fetch)
> > > origin
> > > https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git
> > > (push)
> > =

> > If you cloned my git.kernel.org repo (which appears to be the case from
> > your 'git remote -v' output), you shouldn't need to apply the patches
> > from email. Instead:
> > =

> > $ git checkout -t origin/mptcp-proposal
> > =

> > will get you the commits directly from the git server.
> > =

> > =

> > Just to be specific, to apply the patches from email instead of directly
> > checking out, you would clone
> > https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git and
> > apply the patches to that repository. In addition, I'm not 100% sure
> > 'git am' understands .eml files - the man page for the latest git
> > release mentions maildir, mbox, mboxrd, stgit, stgit-series and hg as
> > supported email formats.
> > =

> > Hope this helps!
> > =

> > -- =

> > Mat Martineau
> > Intel OTC
> Hi Mat,
> =

> For some reason that was not clear to me, anyways I just looked at the
> patches and I am sorry to say I do not see any thing special about the
> patch.
> =

> For example the patch uses
> =

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .conn_request=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D subflow_conn_request,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .syn_recv_sock=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D subflow_syn_recv_sock,
> =

> The original implementation used
> =

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .conn_request=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D mptcp_conn_request,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .syn_recv_sock=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D tcp_v4_syn_recv_sock,
> =

> subflow_syn_recv_sock() calls tcp_v4_syn_recv_sock()
> =

> The patch handles options exactly the same way as they have always been
> handled. Old implementation had struct mptcp_request_sock the patch has
> struct subflow_request_sock.
> =

> The patch is incomplete as it can not exchange any data using MPTCP. I see
> no reason to use this approach, we have a working implementation and that
> should be used and improved upon.

I think the intention with this patchset was to show how the struct prot
and exposing MPTCP fully at the socket layer allows to simplify things.

Creation of a real struct socket for subflows is also going to help a lot,
as that's the path forward to enable proper lock-separation. We can't take =
the
meta-socket lock in the TCP-stack as I mentioned in my review to your
patchset.


So, in that sense for the above two points, the patchset is very useful as
it shows how MPTCP fits in such a model.


Christoph


--===============4665553403856661588==--
