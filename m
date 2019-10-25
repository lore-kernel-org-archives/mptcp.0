Content-Type: multipart/mixed; boundary="===============1837196092690180931=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/4] mptcp: switch mptcp_poll to use parent
 sock wait queue
Date: Fri, 25 Oct 2019 17:34:44 +0200
Message-ID: <20191025153444.GY25052@breakpoint.cc>
In-Reply-To: 21a80919-4765-c8dd-cdc2-8535bf0b6198@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2322

--===============1837196092690180931==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> > > =

> > > I think we could include patch 3/4 in the "first chunk"/preparatory
> > > patches - e.g. apply just after "tcp, ulp: Add clone operation to
> > > tcp_ulp_ops" - and squash 4/4 in "mptcp: add mptcp_poll"
> > > =

> > > WDYT?
> > =

> > Seems good, yes.
> =

> Where can I apply patch 1/4 and 2/4? At the end?

1 could probably be squashed with "mptcp: Implement MPTCP receive path",
given that patch adds sk_data_ready for subflows.

Patch 2 I'd add at the end, we might be able to revert it eventually.
--===============1837196092690180931==--
