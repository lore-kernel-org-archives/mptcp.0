Content-Type: multipart/mixed; boundary="===============3200238913585038668=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH iproute2-next 2/2] ss: mptcp: add msk diag
 interface support
Date: Tue, 30 Jun 2020 16:27:38 -0700
Message-ID: <alpine.OSX.2.23.453.2006301625150.31270@lferrari-mobl.amr.corp.intel.com>
In-Reply-To: f394b8400bd46e4b00f669e8ec41865091b2f1e8.1593081210.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4877

--===============3200238913585038668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 25 Jun 2020, Paolo Abeni wrote:

> This implement support for MPTCP sockets type, comprising
> extended socket info. Note that we need to add an extended
> attribute carrying the actual protocol number to the diag
> request.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> misc/ss.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++-----
> 1 file changed, 105 insertions(+), 10 deletions(-)
>
> diff --git a/misc/ss.c b/misc/ss.c
> index f3d01812..3ccd1586 100644
> --- a/misc/ss.c
> +++ b/misc/ss.c
> @@ -63,6 +63,10 @@
> #define AF_VSOCK PF_VSOCK
> #endif
>
> +#ifndef IPPROTO_MPTCP
> +#define IPPROTO_MPTCP 262
> +#endif
> +

With IPPROTO_MPTCP defined in include/uapi/linux/in.h (in this repo) does =

it need to be redefined here?

Otherwise, series looks good. Thanks!

--
Mat Martineau
Intel
--===============3200238913585038668==--
