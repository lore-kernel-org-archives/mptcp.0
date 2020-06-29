Content-Type: multipart/mixed; boundary="===============3353325910443712290=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 4/6] mptcp: create first subflow at msk
 creation time
Date: Mon, 29 Jun 2020 16:30:37 -0700
Message-ID: <alpine.OSX.2.23.453.2006291630190.11066@jlbliss-mobl.amr.corp.intel.com>
In-Reply-To: ce0a43c723147d86dec5ea47f86fa877bf5371b7.1593461586.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4857

--===============3353325910443712290==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Jun 2020, Davide Caratti wrote:

> From: Paolo Abeni <pabeni(a)redhat.com>
>
> This cleans the code a bit and makes the behavior more consistent.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
> net/mptcp/protocol.c | 53 +++++++++++++++++---------------------------
> 1 file changed, 20 insertions(+), 33 deletions(-)
>

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============3353325910443712290==--
