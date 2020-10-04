Content-Type: multipart/mixed; boundary="===============0046226280002439800=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 0/2] net: Constify struct genl_ops
Date: Sun, 04 Oct 2020 15:06:05 -0700
Message-ID: <20201004.150605.23325138792161072.davem@davemloft.net>
In-Reply-To: 20201004215810.26872-1-rikard.falkeborn@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6185

--===============0046226280002439800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Rikard Falkeborn <rikard.falkeborn(a)gmail.com>
Date: Sun,  4 Oct 2020 23:58:08 +0200

> Make a couple of static struct genl_ops const to allow the compiler to put
> them in read-only memory. Patches are independent.

These do not apply cleanly to net-next, please respin.
--===============0046226280002439800==--
