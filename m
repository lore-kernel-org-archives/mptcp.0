Content-Type: multipart/mixed; boundary="===============6148111223268583290=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC v3 00/15] TCP Extra-option framework for TCP-MD5 and
 SMC
Date: Tue, 12 Dec 2017 16:05:16 -0800
Message-ID: <20171213000516.GQ85539@da0602a-dhcp135.apple.com>
In-Reply-To: alpine.OSX.2.21.1712121535250.15459@sjweber-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 252

--===============6148111223268583290==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 12/12/17 - 15:40:20, Mat Martineau wrote:
> =

> On Mon, 11 Dec 2017, Christoph Paasch wrote:
> =

> > 3rd version of the set.
> > =

> > Now, fully tested and bugs fixed.
> > =

> =

> One more question - can you elaborate on the testing you did? Were the ke=
ys
> set before connecting, modified or deleted during while connected, etc.? =
Did
> you build with KASAN or lockdep?

Yes, built with KASAN and full lockdep debugging.

I did tests where I set the keys on one side, not the other one and check
the connections got rejected.

Then I tested setting the keys at the beginning.

I will do an additional test where I change the keys half-way through the
connection.


Christoph


--===============6148111223268583290==--
