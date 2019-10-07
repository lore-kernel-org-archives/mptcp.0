Content-Type: multipart/mixed; boundary="===============2273747211168574709=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: allow dumping subflow context to userspace
Date: Mon, 07 Oct 2019 12:24:38 +0200
Message-ID: <75528dc15827259bfcfaeeb803755e568115aeec.camel@redhat.com>
In-Reply-To: d323dda76beac31d7bbd4e6edccefe27977fad1c.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2029

--===============2273747211168574709==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-01 at 14:35 +0200, Davide Caratti wrote:
> On Mon, 2019-09-30 at 18:28 +0200, Paolo Abeni wrote:
> > On Fri, 2019-09-27 at 22:51 +0200, Davide Caratti wrote:
> > > add ulp-specific diagnostic functions, so that subflow information ca=
n be
> > > dumped to userspace programs like 'ss'.
> > > =

> > > Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> > =

> > LGTM, thanks Davide!
> > =

> > Time for a iproute-net-next-mptcp git repo?!? :-P
> =

> yes, I'm just waiting for the maintainer of iproute2-next to update the
> UAPI definitions (mostly INET_DIAG_ULP_INFO), then I will fork the repo.

update: I've just sent out [1] to prepare the 'ss' support.
-- =

davide


https://lore.kernel.org/netdev/2531403b243c1c60afc175c164a02096ffcf89a5.157=
0442363.git.dcaratti(a)redhat.com/T/#u


--===============2273747211168574709==--
