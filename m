Content-Type: multipart/mixed; boundary="===============2800889579609773197=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC v3 00/15] TCP Extra-option framework for TCP-MD5 and
 SMC
Date: Tue, 12 Dec 2017 15:40:20 -0800
Message-ID: <alpine.OSX.2.21.1712121535250.15459@sjweber-mobl.amr.corp.intel.com>
In-Reply-To: 20171211214218.35868-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 248

--===============2800889579609773197==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 11 Dec 2017, Christoph Paasch wrote:

> 3rd version of the set.
>
> Now, fully tested and bugs fixed.
>

One more question - can you elaborate on the testing you did? Were the =

keys set before connecting, modified or deleted during while connected, =

etc.? Did you build with KASAN or lockdep?

Thanks,

--
Mat Martineau
Intel OTC

--===============2800889579609773197==--
