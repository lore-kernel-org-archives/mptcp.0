Content-Type: multipart/mixed; boundary="===============3797967584856284011=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] selftests:mptcp:pm: rm the right tmp file
Date: Fri, 15 May 2020 10:34:14 -0700
Message-ID: <20200515.103414.148979892967430448.davem@davemloft.net>
In-Reply-To: 20200515155442.1910397-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4397

--===============3797967584856284011==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Date: Fri, 15 May 2020 17:54:41 +0200

> "$err" is a variable pointing to a temp file. "$out" is not: only used
> as a local variable in "check()" and representing the output of a
> command line.
> =

> Fixes: eedbc685321b (selftests: add PM netlink functional tests)
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Applied, thanks.
--===============3797967584856284011==--
