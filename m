Content-Type: multipart/mixed; boundary="===============0314166102307115414=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 0/2] net: Constify struct
 genl_small_ops
Date: Sun, 04 Oct 2020 21:15:09 -0700
Message-ID: <20201004.211509.1806096319887910594.davem@davemloft.net>
In-Reply-To: 20201004234417.12768-1-rikard.falkeborn@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6191

--===============0314166102307115414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Rikard Falkeborn <rikard.falkeborn(a)gmail.com>
Date: Mon,  5 Oct 2020 01:44:15 +0200

> Make a couple of static struct genl_small_ops const to allow the compiler
> to put them in read-only memory. Patches are independent.
> =

> v2: Rebase on net-next, genl_ops -> genl_small_ops

Applied, thank you.
--===============0314166102307115414==--
