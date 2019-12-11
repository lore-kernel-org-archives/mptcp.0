Content-Type: multipart/mixed; boundary="===============8872327604383671324=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/1] proposed export branch rebase
Date: Wed, 11 Dec 2019 17:32:59 +0100
Message-ID: <b4d68d34218e40cefaf811a81514ef7afae17b84.camel@redhat.com>
In-Reply-To: 6c28e243-afe5-ba23-5788-67a409f9706e@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2871

--===============8872327604383671324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-12-10 at 22:27 +0100, Matthieu Baerts wrote:
> Hi,
> =

> On 10/12/2019 19:24, Matthieu Baerts wrote:
> > Hi Florian, Paolo,
> > =

> > On 09/12/2019 13:33, Paolo Abeni wrote:
> > > Hi,
> > > =

> > > On Sun, 2019-12-08 at 19:24 +0100, Florian Westphal wrote:
> > > > It includes 48 patches (down from 66), I will refrain from patch-bo=
mbing
> > > > the list with it.  There is one patch as followup here because its
> > > > "almost new" in the sense that its an amalgamation of different pat=
ches
> > > > that I placed in that commit because the others seemed quite large =

> > > > already.
> > > > =

> > > > The __tcp_poll patch is gone.  Later patches, in particular the =

> > > > changes to
> > > > only store 'tcp_sock' rather than 'struct socket' on the conn_list,=
 have
> > > > been brought forward and squashed into the relevant commits, would =
thus
> > > > be implicitly part of basic mptcp submission.  I've amemded commit
> > > > messages where appropriate.
> > > =

> > > Thank you Florian for the great work!
> > > =

> > > I went through the patches up to v1 support, and LGTM.
> > =

> > It is also good to me! Thank you very much for the very big work! The =

> > kind of work where even you you have to sit down to do it! ...  O:-D
> > =

> > I just re-created the tree using your branch. I am also checking now =

> > that all commits are OK, with and without MPTCP. Also the usual =

> > compilation tests with i386 and without IPv6.
> =

> FYI, all tests are green!
> I didn't re-enable the automatic sync with net-next. I will do that =

> after having applied recent Paolo's changes.

The rebased and amost squashed thing is available here:

https://github.com/pabeni/mptcp/tree/fwestpha-mptcp_export_rebase_19_fallba=
ck_cleanup_2

It build on each commit. Not tested yet, sent-out early for review's
sake.

Note that some patches after MP_JOIN required some relevant rework,
see:

https://github.com/pabeni/mptcp/commit/0a84b5b3547cba0bea6186402d0eed4981b6=
174a
https://github.com/pabeni/mptcp/commit/481d3137ce456df2dc93f4b64f0204201d6f=
ee7f

@Florian, WDYT?

Thanks,

Paolo

--===============8872327604383671324==--
