Content-Type: multipart/mixed; boundary="===============9116429477414452389=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3] mptcp: Basic single-subflow DATA_FIN
Date: Mon, 25 Nov 2019 18:00:40 +0100
Message-ID: <932db8d3875db21b310fb231d03596e77af21633.camel@redhat.com>
In-Reply-To: 20191122230130.11594-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2689

--===============9116429477414452389==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-11-22 at 15:01 -0800, Mat Martineau wrote:
> Send a DATA_FIN along with any subflow TCP FIN flag when the MPTCP
> socket is closing or shutting down writes.
> =

> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

The patch LGTM, thanks!

Paolo

--===============9116429477414452389==--
