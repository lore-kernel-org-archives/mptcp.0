Content-Type: multipart/mixed; boundary="===============6360719965462060737=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/1] proposed export branch rebase
Date: Wed, 11 Dec 2019 20:00:53 +0100
Message-ID: <afc3068e9c228b78ab384be40da1152ba5bfc6a0.camel@redhat.com>
In-Reply-To: b4d68d34218e40cefaf811a81514ef7afae17b84.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2873

--===============6360719965462060737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-12-11 at 17:32 +0100, Paolo Abeni wrote:
> On Tue, 2019-12-10 at 22:27 +0100, Matthieu Baerts wrote:
> > Hi,
> > =

> > On 10/12/2019 19:24, Matthieu Baerts wrote:
> > > Hi Florian, Paolo,
> > > =

> > > On 09/12/2019 13:33, Paolo Abeni wrote:
> > > > Hi,
> > > > =

> > > > On Sun, 2019-12-08 at 19:24 +0100, Florian Westphal wrote:
> > > > > It includes 48 patches (down from 66), I will refrain from patch-=
bombing
> > > > > the list with it.  There is one patch as followup here because its
> > > > > "almost new" in the sense that its an amalgamation of different p=
atches
> > > > > that I placed in that commit because the others seemed quite larg=
e =

> > > > > already.
> > > > > =

> > > > > The __tcp_poll patch is gone.  Later patches, in particular the =

> > > > > changes to
> > > > > only store 'tcp_sock' rather than 'struct socket' on the conn_lis=
t, have
> > > > > been brought forward and squashed into the relevant commits, woul=
d thus
> > > > > be implicitly part of basic mptcp submission.  I've amemded commit
> > > > > messages where appropriate.
> > > > =

> > > > Thank you Florian for the great work!
> > > > =

> > > > I went through the patches up to v1 support, and LGTM.
> > > =

> > > It is also good to me! Thank you very much for the very big work! The =

> > > kind of work where even you you have to sit down to do it! ...  O:-D
> > > =

> > > I just re-created the tree using your branch. I am also checking now =

> > > that all commits are OK, with and without MPTCP. Also the usual =

> > > compilation tests with i386 and without IPv6.
> > =

> > FYI, all tests are green!
> > I didn't re-enable the automatic sync with net-next. I will do that =

> > after having applied recent Paolo's changes.
> =

> The rebased and amost squashed thing is available here:
> =

> https://github.com/pabeni/mptcp/tree/fwestpha-mptcp_export_rebase_19_fall=
back_cleanup_2
> =

> It build on each commit. Not tested yet, sent-out early for review's
> sake.
> =

> Note that some patches after MP_JOIN required some relevant rework,
> see:
> =

> https://github.com/pabeni/mptcp/commit/0a84b5b3547cba0bea6186402d0eed4981=
b6174a

This one had a couple of gross mistake, just cooked a less bugged
version. The new tree is here:

https://github.com/pabeni/mptcp/commits/fwestpha-mptcp_export_rebase_19_fal=
lback_cleanup_3

The only updated patch is the last one:

https://github.com/pabeni/mptcp/commit/831e5c21e2751c2598b3e25516544d59d65c=
72d3

@Florian: I tested the whole tree vs self-tests - so MP_JOIN is not
really tested. Are you ok to merge as-is and then look after eventual
bug introduced by me here?

Thanks,

Paolo

--===============6360719965462060737==--
