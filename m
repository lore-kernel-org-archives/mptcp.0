Content-Type: multipart/mixed; boundary="===============0430607255228366976=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC net] mptcp: fallback in case of simultaneous connect
Date: Wed, 10 Jun 2020 08:25:30 -0700
Message-ID: <20200610152530.GO3048@MacBook-Pro-64.local>
In-Reply-To: 086c2cb689bdadbceb25e9b5a78937460eb934ef.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4642

--===============0430607255228366976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 06/10/20 - 11:59, Davide Caratti wrote:
> On Tue, 2020-06-09 at 15:00 -0700, Mat Martineau wrote:
> > Does it also make sense to set subflow->conn_finished to match more =

> > closely what happens in subflow_finish_connect()? Looks like this would =

> > mainly affect the MPTCP_SUBFLOW_FLAG_CONNECTED that gets reported to =

> > userspace in diag.c
> =

> yes, it makes sense: I will respin a v2 with:
> =

> - this addition
> - the typo fixed in the commit message
> - the subject prefix targeting the correct branch: since it depends on the
> fallback rework, it should target net-next, not net (and I would have
> difficulties in detecting a proper 'Fixes:' tag),
> =

> thanks for looking at this!

syzkaller found another WARNING in subflow_data_ready():

https://github.com/multipath-tcp/mptcp_net-next/issues/39

Seems to be different than the on in issue/35.


Christoph

--===============0430607255228366976==--
