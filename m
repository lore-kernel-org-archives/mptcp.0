Content-Type: multipart/mixed; boundary="===============6877763075875337903=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC v3 00/15] TCP Extra-option framework for TCP-MD5 and
 SMC
Date: Fri, 15 Dec 2017 11:00:46 -0800
Message-ID: <20171215190046.GE36076@Chimay.local>
In-Reply-To: 20171213000516.GQ85539@da0602a-dhcp135.apple.com
X-Status: 
X-Keywords:                  
X-UID: 267

--===============6877763075875337903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 12/12/17 - 16:05:16, Christoph Paasch wrote:
> On 12/12/17 - 15:40:20, Mat Martineau wrote:
> > =

> > On Mon, 11 Dec 2017, Christoph Paasch wrote:
> > =

> > > 3rd version of the set.
> > > =

> > > Now, fully tested and bugs fixed.
> > > =

> > =

> > One more question - can you elaborate on the testing you did? Were the =
keys
> > set before connecting, modified or deleted during while connected, etc.=
? Did
> > you build with KASAN or lockdep?
> =

> Yes, built with KASAN and full lockdep debugging.
> =

> I did tests where I set the keys on one side, not the other one and check
> the connections got rejected.
> =

> Then I tested setting the keys at the beginning.
> =

> I will do an additional test where I change the keys half-way through the
> connection.

FYI, just tested starting with a key set on client and listener, then after
accept() and a write/read, I set the key to 0 (thus removing MD5). Then
after a bunch of reads/writes I set again a different key.

Works as expected.


Christoph


--===============6877763075875337903==--
