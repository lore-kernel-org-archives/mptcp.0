Content-Type: multipart/mixed; boundary="===============5343854666313198525=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 10/13] mptcp: allow creating
 non-backup subflows
Date: Mon, 14 Sep 2020 11:08:52 -0700
Message-ID: <alpine.OSX.2.23.453.2009141108400.57764@ningale-mobl.amr.corp.intel.com>
In-Reply-To: 263d1338783f1995a46f13fbae804568ee18cb0d.1599854632.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5858

--===============5343854666313198525==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Sep 2020, Paolo Abeni wrote:

> Currently the 'backup' attribute of local endpoint
> is ignored. Let's use it for the MP_JOIN handshake
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/subflow.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============5343854666313198525==--
