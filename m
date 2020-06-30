Content-Type: multipart/mixed; boundary="===============6014725044580015519=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: do nonce initialization at
 subflow creation time
Date: Tue, 30 Jun 2020 10:39:20 -0700
Message-ID: <alpine.OSX.2.23.453.2006301034001.27064@ptcotton-mobl1.amr.corp.intel.com>
In-Reply-To: cc811b8707d488492fb8e33ed651aab456de6f72.1593527763.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4870

--===============6014725044580015519==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 30 Jun 2020, Paolo Abeni wrote:

> This clean-up the code a bit, reduces the number of
> used hooks and indirect call requested, and allow
> better error reporting from __mptcp_subflow_connect()
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/subflow.c | 54 +++++++++++++++++----------------------------
> 1 file changed, 20 insertions(+), 34 deletions(-)
>

Thanks Paolo, cleanup looks good and it's nice to not rely on the =

rebuild_header hook for this initialization.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============6014725044580015519==--
