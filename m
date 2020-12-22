Content-Type: multipart/mixed; boundary="===============7629667570557332102=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 3/3] selftests: mptcp: add
 testcases for newly added addresses
Date: Tue, 22 Dec 2020 13:46:47 +0100
Message-ID: <8dfd69143c6d41a5f2b8225183200e3b1c74b613.camel@redhat.com>
In-Reply-To: e83e5301785ccd2964462087d6677d92d5719724.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7242

--===============7629667570557332102==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-12-22 at 10:56 +0100, Paolo Abeni wrote:
> On Fri, 2020-12-18 at 23:24 +0800, Geliang Tang wrote:
> > This patch added the testcases to create subflows or signal addresses
> > for the newly added IPv4 or IPv6 addresses.
> > =

> > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > ---

[...]

> Side note: I fear that mptcp_join.sh is becoming too big, containing
> many different/quite unrelated tests. =

> =

> Perhaps we could split it in smaller chunk ?!? e.g. all subflows only
> test, all other addr related tests, syncookies

also, it would be nice to allow running a single test item in standalone
(I had a small patch for that somewhere, let me see if I can find it :)
)

we might also think about decommissioning pm_nl_ctl and use iproute2
instead, wdyt?

-- =

davide


--===============7629667570557332102==--
