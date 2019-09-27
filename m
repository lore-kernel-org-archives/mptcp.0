Content-Type: multipart/mixed; boundary="===============8156422540368063310=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: some squashing needed?
Date: Fri, 27 Sep 2019 16:27:03 -0700
Message-ID: <ca648d0a233d0bc7de018d6bc7284daa97c7cd9a.camel@linux.intel.com>
In-Reply-To: 0be9a3a0-5ced-d826-3fbc-79d4da477e61@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1946

--===============8156422540368063310==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-09-27 at 17:02 +0200, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 26/09/2019 19:20, Paolo Abeni wrote:
> > On Thu, 2019-09-26 at 17:05 +0200, Florian Westphal wrote:
> =

> [...]
> =

> > > from Paolo.
> > > =

> > > But I figured it would make sense to share this now and discuss
> > > how to proceed from here first.
> > =

> > The above branch is based on mptcp_net-next export branch hash
> > a45bdbe6701b
> =

> Great, still the last one. So everything is in it.
> =

> > There is a small diff vs such hash, see below. Mostily checkpack fixes,
> > a trivial functional fix in mptcp_setsockopt(), and a bunch of likely
> > not interesting debug messages dropped - side note: we may want remove
> > more of them.
> =

> I guess that we indeed need to remove most of these pr_debug() at some
> points. Thank you for having done that!
> Also great to have looked at checkpatch and making sure each commit can
> compile :-)
> =

> For the fix in mptcp_setsockopt(), was it due to a bad "squash"?
> =

> For the diff, it looks good to me.
> =

> *@Peter/@Mat*: is it also OK for you?

I don't see the above sha, but I did a diff between 0921 and 0927 tags in
export and I am satisfied with the minor diffs. =


Peter.

> =

> Cheers,
> Matt

--===============8156422540368063310==--
