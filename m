Content-Type: multipart/mixed; boundary="===============6188385821635673261=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 3/4] mptcp: add MPTCP socket diag
 interface
Date: Thu, 09 Jul 2020 10:34:05 -0700
Message-ID: <20200709103405.0075678b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: 7f9e6a085163dcb0669b9dd8aace1c62373279db.1594292774.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4961

--===============6188385821635673261==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu,  9 Jul 2020 15:12:41 +0200 Paolo Abeni wrote:
> exposes basic inet socket attribute, plus some MPTCP socket
> fields comprising PM status and MPTCP-level sequence numbers.
> =

> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Any idea why sparse says this:

include/net/sock.h:1612:31: warning: context imbalance in 'mptcp_diag_get_i=
nfo' - unexpected unlock

? =F0=9F=A4=A8
--===============6188385821635673261==--
