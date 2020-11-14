Content-Type: multipart/mixed; boundary="===============3062244996767751688=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 01/13] tcp: factor out tcp_build_frag()
Date: Sat, 14 Nov 2020 13:02:39 -0800
Message-ID: <20201114130239.006cf4c5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: 3a20827d0a695b646579c94b7bbf2a185a3226dc.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6730

--===============3062244996767751688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Nov 2020 11:38:13 +0100 Paolo Abeni wrote:
> > Is there a chance someone could look into adding annotations to socket
> > locking?  =

> =

> Annotating lock_sock_fast()/unlock_sock_fast() as they would
> unconditionally acquire/release the socket spinlock removes the warning
> related to fast lock - at least for me;).
> =

> Hopefully that does not interact with lockdep, but perhpas is a bit too
> extreme/rusty?

I'm not a sparse expert, do we need both __acquire and __acquires?

Would you mind submitting officially and CCing the sparse ML?
--===============3062244996767751688==--
