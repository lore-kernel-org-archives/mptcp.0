Content-Type: multipart/mixed; boundary="===============3417871439049900609=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 05/13] mptcp: introduce and use
 mptcp_try_coalesce()
Date: Mon, 14 Sep 2020 11:06:18 -0700
Message-ID: <alpine.OSX.2.23.453.2009141105320.57764@ningale-mobl.amr.corp.intel.com>
In-Reply-To: 39b392036de70a64726b19e7bb851a53ec90f134.1599854632.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5853

--===============3417871439049900609==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Sep 2020, Paolo Abeni wrote:

> Factor-out existing code, will be re-used by the
> next patch.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 31 +++++++++++++++++++------------
> 1 file changed, 19 insertions(+), 12 deletions(-)
>

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============3417871439049900609==--
