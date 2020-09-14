Content-Type: multipart/mixed; boundary="===============2720053124113709028=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 02/13] mptcp: set data_ready status
 bit in subflow_check_data_avail()
Date: Mon, 14 Sep 2020 11:03:03 -0700
Message-ID: <alpine.OSX.2.23.453.2009141102090.57764@ningale-mobl.amr.corp.intel.com>
In-Reply-To: 10b65904849e08dfccab8da33219d2081341f581.1599854632.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5850

--===============2720053124113709028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Sep 2020, Paolo Abeni wrote:

> This simplify mptcp_subflow_data_available() and will
> made follow-up patches simpler.
>
> Additionally remove the unneeded checks on subflow copied_seq:
> we always whole skbs out of subflows.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/subflow.c | 19 ++++++++-----------
> 1 file changed, 8 insertions(+), 11 deletions(-)
>

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============2720053124113709028==--
