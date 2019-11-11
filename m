Content-Type: multipart/mixed; boundary="===============1360229679042497262=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/4] mptcp: some cleanups
Date: Mon, 11 Nov 2019 14:49:47 -0800
Message-ID: <alpine.OSX.2.21.1911111449010.7818@mjmartin-mac01.local>
In-Reply-To: cover.1573471403.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2474

--===============1360229679042497262==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 11 Nov 2019, Paolo Abeni wrote:

> This address the build issue we currently have on patch
> "mptcp: Add key generation and token tree", plus move around some related
> code for consistency.
>
> No differences in the resulting code vs current git tree.
> The tree should build on each patch now.
>
> Paolo Abeni (1):
>  1/4 mptcp: drop most of mptcp_init_sock() impl
>  2/4 mptcp: use customary name for tcp_sock variable
>  3/4 mptcp: init ctx->icsk_af_ops in subflow_ulp_init()
>  4/4 mptcp: init new_ctx->icsk_af_ops() in subflow_ulp_clone()
>
> net/mptcp/protocol.c | 13 +------------
> 1 file changed, 1 insertion(+), 12 deletions(-)
>

Paolo -

The series looks good to me. Thank you.


--
Mat Martineau
Intel
--===============1360229679042497262==--
