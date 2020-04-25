Content-Type: multipart/mixed; boundary="===============1358140791519358476=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 0/5] mptcp: more incoming option fixes
Date: Fri, 24 Apr 2020 17:03:12 -0700
Message-ID: <alpine.OSX.2.22.394.2004241639510.64783@zzhu12-mobl.amr.corp.intel.com>
In-Reply-To: cover.1587738345.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4246

--===============1358140791519358476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 24 Apr 2020, Paolo Abeni wrote:

> This is a very early RFC showcasing the fix discussed in yday mtg - the
> first 3 patches. It contains also fix/warkaround for the last warn() I'm
> able to hit with syzbot repro provided by Christoph.
>
> With this series and https://marc.info/?l=3Dlinux-netdev&m=3D158772695009=
150&w=3D2
> on top of -net I haven't hit any of the 'known' oops/warn so far, but
> I'm hitting a WARN_ONCE("Bad mapping: "...) I'm unsure it's
> introduced here or not.
>

+1 on the suboption approach and adding mptcp_init_options().

While the accessors are more verbose, I do agree that it makes things more =

readable. In a way I think checking/setting the bits directly might make =

it more obvious that the changes are minor, but it seems like it would get =

merged either way.

--
Mat Martineau
Intel
--===============1358140791519358476==--
