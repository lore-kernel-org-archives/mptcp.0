Content-Type: multipart/mixed; boundary="===============0271974883803670039=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] net: mptcp: make DACK4/DACK8 usage consistent
 among all subflows
Date: Tue, 06 Oct 2020 15:07:45 +0200
Message-ID: <7ceabb97898fbcd06d6d746be96e29ffb2944613.camel@redhat.com>
In-Reply-To: bf93c52f5b3e93ad3ba851dd8d76b80adda95e98.1601986828.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6219

--===============0271974883803670039==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-10-06 at 14:22 +0200, Davide Caratti wrote:
> using packetdrill it's possible to observe the same MPTCP DSN being acked
> by different subflows with DACK4 and DACK8. This is in contrast with what
> specified in RFC8684 =C2=A73.3.2: if an MPTCP endpoint transmits a 64-bit=
 wide
> DSN, it MUST be acknowledged with a 64-bit wide DACK. Fix 'use_64bit_ack'
> variable to make it a property of MPTCP sockets, not TCP subflows.
> =

> Fixes: a0c1d0eafd1e ("mptcp: Use 32-bit DATA_ACK when possible")
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>

LGTM, thanks Davide!

/P

--===============0271974883803670039==--
