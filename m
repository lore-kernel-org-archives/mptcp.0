Content-Type: multipart/mixed; boundary="===============6087600112299580308=="
MIME-Version: 1.0
From: Krystad, Peter <peter.krystad at intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Patch does not apply
Date: Fri, 30 Mar 2018 18:25:19 +0000
Message-ID: <1522434318.16359.97.camel@intel.com>
In-Reply-To: dff16cb5-970b-b3f1-0189-d8b09ef58857@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 490

--===============6087600112299580308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-03-29 at 12:01 -0700, Rao Shoaib wrote:
> =

> On 03/29/2018 11:12 AM, Christoph Paasch wrote:
> > On 29/03/18 - 10:41:08, Rao Shoaib wrote:
> > > On 03/29/2018 08:40 AM, Mat Martineau wrote:
> > > > On Wed, 28 Mar 2018, Rao Shoaib wrote:
> > > > > I am unable to apply the 6th patch.
> > > > > =

> > > > > rshoaib(a)caduceus5:/home/mptcp/sock_mptcp/linux.old(master)$git =
am
> > > > > "/tmp/mails/[MPTCP] [RFC PATCH 03_16] mptcp: Add MPTCP socket stu=
bs
> > > > > - Mat Martineau <mathew.j.martineau(a)linux.intel.com> - 2018-03-=
28
> > > > > 1618.eml"
> > > > > Applying: mptcp: Add MPTCP socket stubs
> > > > > .git/rebase-apply/patch:87: new blank line at EOF.
> > > > > +
> > > > > warning: 1 line adds whitespace errors.
> > > > > =

> > > > > rshoaib(a)caduceus5:/home/mptcp/sock_mptcp/linux(master)$git am
> > > > > "/tmp/mails/[MPTCP] [RFC PATCH 06_16] tcp: expose tcp routines and
> > > > > structs for MPTCP - Mat Martineau
> > > > > <mathew.j.martineau(a)linux.intel.com> - 2018-03-28 1618.eml"
> > > > > Applying: tcp: expose tcp routines and structs for MPTCP
> > > > > error: patch failed: include/net/inet_common.h:35
> > > > > error: include/net/inet_common.h: patch does not apply
> > > > > Patch failed at 0001 tcp: expose tcp routines and structs for MPT=
CP
> > > > > The copy of the patch that failed is found in: .git/rebase-apply/=
patch
> > > > > When you have resolved this problem, run "git am --continue".
> > > > > If you prefer to skip this patch, run "git am --skip" instead.
> > > > > To restore the original branch and stop patching, run "git am --a=
bort".
> > > > > =

> > > > > rshoaib(a)caduceus5:/home/mptcp/sock_mptcp/linux(master|AM 1/1)$g=
it
> > > > > remote -v
> > > > > origin
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.g=
it
> > > > > (fetch)
> > > > > origin
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.g=
it
> > > > > (push)
> > > > =

> > > > If you cloned my git.kernel.org repo (which appears to be the case =
from
> > > > your 'git remote -v' output), you shouldn't need to apply the patch=
es
> > > > from email. Instead:
> > > > =

> > > > $ git checkout -t origin/mptcp-proposal
> > > > =

> > > > will get you the commits directly from the git server.
> > > > =

> > > > =

> > > > Just to be specific, to apply the patches from email instead of dir=
ectly
> > > > checking out, you would clone
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git =
and
> > > > apply the patches to that repository. In addition, I'm not 100% sure
> > > > 'git am' understands .eml files - the man page for the latest git
> > > > release mentions maildir, mbox, mboxrd, stgit, stgit-series and hg =
as
> > > > supported email formats.
> > > > =

> > > > Hope this helps!
> > > > =

> > > > -- =

> > > > Mat Martineau
> > > > Intel OTC
> > > =

> > > Hi Mat,
> > > =

> > > For some reason that was not clear to me, anyways I just looked at the
> > > patches and I am sorry to say I do not see any thing special about the
> > > patch.
> > > =

> > > For example the patch uses
> > > =

> > > +       .conn_request      =3D subflow_conn_request,
> > > +       .syn_recv_sock     =3D subflow_syn_recv_sock,
> > > =

> > > The original implementation used
> > > =

> > >          .conn_request      =3D mptcp_conn_request,
> > >          .syn_recv_sock     =3D tcp_v4_syn_recv_sock,
> > > =

> > > subflow_syn_recv_sock() calls tcp_v4_syn_recv_sock()
> > > =

> > > The patch handles options exactly the same way as they have always be=
en
> > > handled. Old implementation had struct mptcp_request_sock the patch h=
as
> > > struct subflow_request_sock.
> > > =

> > > The patch is incomplete as it can not exchange any data using MPTCP. =
I see
> > > no reason to use this approach, we have a working implementation and =
that
> > > should be used and improved upon.
> > =

> > I think the intention with this patchset was to show how the struct prot
> > and exposing MPTCP fully at the socket layer allows to simplify things.
> =

> It does  not, Look at my patch, compare and post.

I did look at your patchset. This one has ~200 lines of code change in
net/ipv4/*.c, a very low impact, yours is >1000. While yours has more
functionality this one is simpler, in the sense of having less obvious
impact to TCP code.

> > =

> > Creation of a real struct socket for subflows is also going to help a l=
ot,
> > as that's the path forward to enable proper lock-separation. We can't t=
ake the
> > meta-socket lock in the TCP-stack as I mentioned in my review to your
> > patchset.
> > =

> > =

> > So, in that sense for the above two points, the patchset is very useful=
 as
> > it shows how MPTCP fits in such a model.
> =

> It does not show anything because it does nothing.

I beg to differ. The point of this patchset is to show, not do. We had
direct feedback from the netdev maintainers that "something like KCM"
would be of interest to them, this is an attempt at that.

Regards,

Peter.
 =

> =

> Rao.
> =

> > =

> > =

> > Christoph
> > =

> =

> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
--===============6087600112299580308==--
