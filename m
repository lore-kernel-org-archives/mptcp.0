Content-Type: multipart/mixed; boundary="===============7242709342769390390=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: allow dumping subflow context to userspace
Date: Tue, 01 Oct 2019 14:35:13 +0200
Message-ID: <d323dda76beac31d7bbd4e6edccefe27977fad1c.camel@redhat.com>
In-Reply-To: e628f5128065284ac238adcc1ada646e5de1872a.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1976

--===============7242709342769390390==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-09-30 at 18:28 +0200, Paolo Abeni wrote:
> On Fri, 2019-09-27 at 22:51 +0200, Davide Caratti wrote:
> > add ulp-specific diagnostic functions, so that subflow information can =
be
> > dumped to userspace programs like 'ss'.
> > =

> > Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> =

> LGTM, thanks Davide!
> =

> Time for a iproute-net-next-mptcp git repo?!? :-P

yes, I'm just waiting for the maintainer of iproute2-next to update the
UAPI definitions (mostly INET_DIAG_ULP_INFO), then I will fork the repo.


-- =

davide



--===============7242709342769390390==--
