Content-Type: multipart/mixed; boundary="===============0088704925796701352=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] net: mptcp: make DACK4/DACK8 usage consistent
 among all subflows
Date: Fri, 09 Oct 2020 08:35:56 -0700
Message-ID: <20201009083556.4fc32c0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: 70c96303d6d9931aae1b1028aed016d807df0e20.1602001119.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6272

--===============0088704925796701352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue,  6 Oct 2020 18:26:17 +0200 Davide Caratti wrote:
> using packetdrill it's possible to observe the same MPTCP DSN being acked
> by different subflows with DACK4 and DACK8. This is in contrast with what
> specified in RFC8684 =C2=A73.3.2: if an MPTCP endpoint transmits a 64-bit=
 wide
> DSN, it MUST be acknowledged with a 64-bit wide DACK. Fix 'use_64bit_ack'
> variable to make it a property of MPTCP sockets, not TCP subflows.
> =

> Fixes: a0c1d0eafd1e ("mptcp: Use 32-bit DATA_ACK when possible")
> Acked-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>

Applied, thanks!
--===============0088704925796701352==--
