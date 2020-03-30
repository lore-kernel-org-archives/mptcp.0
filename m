Content-Type: multipart/mixed; boundary="===============4276749531537780175=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 1/1] selftests:mptcp: fix failure due to
 whitespace damage
Date: Mon, 30 Mar 2020 10:27:52 -0700
Message-ID: <20200330.102752.2020625896267237076.davem@davemloft.net>
In-Reply-To: 20200330142354.563259-2-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4111

--===============4276749531537780175==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Date: Mon, 30 Mar 2020 16:23:54 +0200

> 'pm_nl_ctl' was adding a trailing whitespace after having printed the
> IP. But at the end, the IP element is currently always the last one.
> =

> The bash script launching 'pm_nl_ctl' had trailing whitespaces in the
> expected result on purpose. But these whitespaces have been removed when
> the patch has been applied upstream. To avoid trailing whitespaces in
> the bash code, 'pm_nl_ctl' and expected results have now been adapted.
> =

> The MPTCP PM selftest can now pass again.
> =

> Fixes: eedbc685321b (selftests: add PM netlink functional tests)
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Applied, thanks.
--===============4276749531537780175==--
