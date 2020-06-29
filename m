Content-Type: multipart/mixed; boundary="===============2245731530971004528=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 3/6] mptcp: check for plain TCP sock at
 accept time
Date: Mon, 29 Jun 2020 16:30:17 -0700
Message-ID: <alpine.OSX.2.23.453.2006291629590.11066@jlbliss-mobl.amr.corp.intel.com>
In-Reply-To: 821ad8ad1581b906b6706426c1ba0c3b837cf60d.1593461586.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4856

--===============2245731530971004528==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Jun 2020, Davide Caratti wrote:

> From: Paolo Abeni <pabeni(a)redhat.com>
>
> This cleanup the code a bit and avoid corrupted states
> on weird syscall sequence (accept(), connect()).
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
> net/mptcp/protocol.c | 69 +++++---------------------------------------
> 1 file changed, 7 insertions(+), 62 deletions(-)
>

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============2245731530971004528==--
