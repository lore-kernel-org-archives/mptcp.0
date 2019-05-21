Content-Type: multipart/mixed; boundary="===============7518444328121282025=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [GIT] Sync with net-next: conflict
Date: Tue, 21 May 2019 16:10:50 +0200
Message-ID: <43510c949ddad0101165e31a7c6b37ad4cd3d1f3.camel@redhat.com>
In-Reply-To: 19598e54-ed65-a32f-26ae-b2b06193dd58@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1210

--===============7518444328121282025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-05-21 at 16:09 +0200, Matthieu Baerts wrote:
> On 21/05/2019 16:03, Paolo Abeni wrote:
> > On Tue, 2019-05-21 at 14:26 +0200, Matthieu Baerts wrote:
> > > The commit 8b2e02e94442 (tcp: clean ext on tx recycle) from Paolo was
> > > conflicting with a new one from upstream:  (tcp: do not
> > > recycle cloned skbs) from Eric Dumazet.
> > > =

> > > I simply added the new condition (&& !skb_cloned(skb)). I hope it is
> > > alright: a73376082e4c6e3c9a48fd887f759ab1e4118477
> > =

> > The conflict resolution LGTM, thanks!
> > =

> > Not sure if the following actually makes any sense, if the merge commit
> > could be squashed into "tcp: clean ext on tx recycle" that would
> > =

> Sorry, the commit I mentioned is one from the topgit tree. During the
> export, it is "squashed" correctly:
> =

> https://github.com/multipath-tcp/mptcp_net-next/commit/eddf1c63aa7f382376=
638ab96082dc773c30eb50
> =

> Is it fine for you?

Yep, perfect, thanks!

Paolo


--===============7518444328121282025==--
