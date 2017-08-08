Content-Type: multipart/mixed; boundary="===============3936718598296052421=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] MPTCP upstreaming strategy and design
Date: Tue, 08 Aug 2017 15:50:44 -0700
Message-ID: <20170808225044.GS3648@Chimay.local>
In-Reply-To: alpine.OSX.2.21.1708081507150.13062@jcclaybu-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 75

--===============3936718598296052421==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 08/08/17 - 15:10:48, Mat Martineau wrote:
> =

> On Tue, 1 Aug 2017, Christoph Paasch wrote:
> =

> > On my side, I will be able to spend more cycles now on Linux. I will st=
art
> > by porting the code from multipath-tcp.org up to upstream's version (we=
 have
> > been lagging behind quite a bit again).
> =

> Which version or branch do you think you'll merge up to? Latest stable (or
> stable LTS) release?

I will jump from LTS to LTS. First, 4.9 it will stay there for a bit to
prepare the new stable release but then move up to 4.14 (which will be the =
next one).

My goal is to track linux-stable more closely - meaning merge as soon as the
rc come out.


Christoph


--===============3936718598296052421==--
