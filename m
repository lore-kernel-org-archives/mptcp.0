Content-Type: multipart/mixed; boundary="===============5276538595823266288=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next 5/5] mptcp: add netlink event support
Date: Wed, 20 Jan 2021 18:19:21 +0100
Message-ID: <20210120171921.GQ19605@breakpoint.cc>
In-Reply-To: e9d41ab0-1672-e581-e1e3-495399600011@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7462

--===============5276538595823266288==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> > +	sk_err =3D ssk->sk_err;
> =

> Could we have an error set on the msk? (sk->sk_err)

Userspace interacts with the msk so it should already
get proper errnos via syscalls, no?
--===============5276538595823266288==--
