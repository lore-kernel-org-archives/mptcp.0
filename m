Content-Type: multipart/mixed; boundary="===============4122702179770777385=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/4] crypto: refactor sha code
Date: Mon, 25 Nov 2019 17:40:27 -0800
Message-ID: <34770161d5294b5244b8a8b64e57f4507aa72c01.camel@linux.intel.com>
In-Reply-To: 3fccdf1a-1b4f-a52c-f362-c4e0105d2a5f@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2691

--===============4122702179770777385==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Paolo, Matt - =


On Sat, 2019-11-23 at 09:25 +0100, Matthieu Baerts wrote:
> Hi Peter, Paolo,
> =

> On 22/11/2019 19:16, Peter Krystad wrote:
> > Hi Paolo & Matt -
> > =

> > On Fri, 2019-11-22 at 17:47 +0100, Matthieu Baerts wrote:
> > > Hi Paolo,
> > > =

> > > On 22/11/2019 17:41, Paolo Abeni wrote:
> > > > On Fri, 2019-11-22 at 17:26 +0100, Matthieu Baerts wrote:
> > > > > Hi Paolo,
> > > > > =

> > > > > On 22/11/2019 15:30, Paolo Abeni wrote:
> > > > > > On Fri, 2019-11-22 at 15:26 +0100, Paolo Abeni wrote:
> > > > > > > patch 1/4 refactor the crypto code to make it easier transiti=
oning to
> > > > > > > sha256. It includes feedback from Peter about helper renaming.
> > > > > =

> > > > > Thank you for this new version!
> > > > > =

> > > > > It looks good to me after a very very quick review (but the first=
 patch
> > > > > is hard to read).
> > > > > =

> > > > > > > The following patches update the rest of the tree to the new =
helper name.
> > > > > > > Overall this should generate 3 conflicts along the rebase.
> > > > > > =

> > > > > > Addendum:
> > > > > > =

> > > > > > The squashed tree is avaialble here:
> > > > > > =

> > > > > > https://github.com/pabeni/mptcp/tree/sha_cleanup_2
> > > > > > =

> > > > > > I verified the new code ensuring that the genrated seq number m=
atched
> > > > > > the expectation of the wireshark dissector.
> > > > > =

> > > > > Great!
> > > > > =

> > > > > Because it looks OK and you checked different stuffs, do you want=
 me to:
> > > > > - replace the tree with the commits from your branch? (if needed,=
 we can
> > > > > of course do other fixes later)
> > > > > - stop the CI job, wait for a proper review and then replace the =
tree?
> > > > > - or wait for a proper review and then I apply the changes, looki=
ng at
> > > > > your branch in case of conflict but doing all of that with TopGit=
 to
> > > > > ease the review? :)
> > > > =

> > > > I think the first 2 options are the better ones.
> > > > =

> > > > It would be nice if someone give this an additional review ;)
> > > =

> > > OK for me!
> > > =

> > > I just paused the CI job then. I hope not for too long :-)
> > =

> > This looks good to me. I'll double-check interop with mptcp.org after i=
t is
> > merged.

mptcp.org interop is OK.

Peter.

> Great, thank you for the patches and the reviews!
> =

> I just recreated the tree using Paolo's branch. Tests are still OK!
> =

> Syncing with the latest net-next now and checking that all commits can =

> still compile.
> =

> Cheers,
> Matt

--===============4122702179770777385==--
