Content-Type: multipart/mixed; boundary="===============0159628868719969728=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] net: mptcp: make DACK4/DACK8 usage consistent
 among all subflows
Date: Tue, 06 Oct 2020 16:58:58 -0700
Message-ID: <alpine.OSX.2.23.453.2010061656560.22542@ccarpent-mobl.amr.corp.intel.com>
In-Reply-To: 70c96303d6d9931aae1b1028aed016d807df0e20.1602001119.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6234

--===============0159628868719969728==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Oct 2020, Davide Caratti wrote:

> using packetdrill it's possible to observe the same MPTCP DSN being acked
> by different subflows with DACK4 and DACK8. This is in contrast with what
> specified in RFC8684 =C2=A73.3.2: if an MPTCP endpoint transmits a 64-bit=
 wide
> DSN, it MUST be acknowledged with a 64-bit wide DACK. Fix 'use_64bit_ack'
> variable to make it a property of MPTCP sockets, not TCP subflows.
>
> Fixes: a0c1d0eafd1e ("mptcp: Use 32-bit DATA_ACK when possible")
> Acked-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
> net/mptcp/options.c  | 2 +-
> net/mptcp/protocol.h | 2 +-
> net/mptcp/subflow.c  | 3 +--
> 3 files changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel

--===============0159628868719969728==--
