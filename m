Content-Type: multipart/mixed; boundary="===============6552416703547584882=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH RFC 10/11] mptcp: enable JOIN requests even if
 cookies are in use
Date: Tue, 28 Jul 2020 00:59:31 +0200
Message-ID: <20200727225931.GM23458@breakpoint.cc>
In-Reply-To: 79ee0796e2bcf48e4d84c119c1118c436b05c6e9.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5331

--===============6552416703547584882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> > Why would I need to add pm->subflows?
> =

> Currently the PM netlink does not accept any additional subflows
> when pm->subflows >=3D pm->subflows_max.

What about mptcp_can_accept_new_subflow() helper?  Is that enough?
--===============6552416703547584882==--
