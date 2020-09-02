Content-Type: multipart/mixed; boundary="===============7144696871902971440=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] selftests: mptcp: fix typo in
 mptcp_connect usage
Date: Wed, 02 Sep 2020 14:14:49 -0700
Message-ID: <20200902.141449.1995923435946574076.davem@davemloft.net>
In-Reply-To: 6c43e5404c41f91ed9324e20c35a4e4fdb0ed1de.1599046871.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5708

--===============7144696871902971440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Davide Caratti <dcaratti(a)redhat.com>
Date: Wed,  2 Sep 2020 13:44:24 +0200

> in mptcp_connect, 's' selects IPPROTO_MPTCP / IPPROTO_TCP as the value of
> 'protocol' in socket(), and 'm' switches between different send / receive
> modes. Fix die_usage(): swap 'm' and 's' and add missing 'sendfile' mode.
> =

> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>

Applied, thank you.
--===============7144696871902971440==--
