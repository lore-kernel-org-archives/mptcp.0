Content-Type: multipart/mixed; boundary="===============4323351135076412488=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: RFCv2 for netdev: what's missing?
Date: Tue, 01 Oct 2019 16:58:42 +0200
Message-ID: <933b5545ffbbf3c207c4880953b01cc7302fb4c4.camel@redhat.com>
In-Reply-To: 0af3b2f0-48cc-ccba-7d50-dd98e2009257@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1950

--===============4323351135076412488==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for raising this topic!

On Tue, 2019-10-01 at 16:37 +0200, Matthieu Baerts wrote:
> At the last meeting, we said it would be good to send a new RFCv2 to
> netdev before the next meeting while windows are closed. I guess today
> would be good, no?

Agreed ;)

> What do we still need to do?
> - the cover letter: Mat is it still OK to do it on your side?
> - any other patches to apply before this?

I personally think we can go even with the current git tree.
If we want to flush part of the pending backlog I would go only for
already accepted patches:

[...]
> - mptcp: allow dumping subflow context to userspace: can be applied
> - mptcp: allow MPTCP sockets by default: can be applied

The above ones: ^^^

The above to avoid possible last minute issues.

Other opinions more than welcome!

Cheers,

Paolo

--===============4323351135076412488==--
