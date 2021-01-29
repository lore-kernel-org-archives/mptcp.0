Content-Type: multipart/mixed; boundary="===============6157067327817173041=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][RFC mptcp-next 4/6] mptcp: add
 mptcpi_local_addr_* in mptcp_info
Date: Fri, 29 Jan 2021 16:39:31 +0100
Message-ID: <e60345a055ae858211b9186e0cb1907d30419ef7.camel@redhat.com>
In-Reply-To: 54bb5802527e4b8b52f8fc9d0a8e561218e25637.1611667027.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7532

--===============6157067327817173041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-01-26 at 21:21 +0800, Geliang Tang wrote:
> Add mptcpi_local_addr_used and mptcpi_local_addr_max in struct mptcp_info,
> and rename mptcpi_add_addr_signal to mptcpi_add_addr_signaled.
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

This patch could possibly live by its own merit, independently from the
tracepoint patches.

> ---
>  include/uapi/linux/mptcp.h | 4 +++-
>  net/mptcp/mptcp_diag.c     | 4 +++-
>  net/mptcp/pm_netlink.c     | 3 ++-
>  net/mptcp/protocol.h       | 1 +
>  4 files changed, 9 insertions(+), 3 deletions(-)
> =

> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index 3674a451a18c..43b674458747 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -92,11 +92,13 @@ enum {
>  =

>  struct mptcp_info {
>  	__u8	mptcpi_subflows;
> -	__u8	mptcpi_add_addr_signal;
> +	__u8	mptcpi_add_addr_signaled;
>  	__u8	mptcpi_add_addr_accepted;
> +	__u8	mptcpi_local_addr_used;
>  	__u8	mptcpi_subflows_max;
>  	__u8	mptcpi_add_addr_signal_max;
>  	__u8	mptcpi_add_addr_accepted_max;
> +	__u8	mptcpi_local_addr_max;
>  	__u32	mptcpi_flags;
>  	__u32	mptcpi_token;
>  	__u64	mptcpi_write_seq;

Beware: new fields of uapi exposed struct must be appended, or user
space tools (e.g. iproute) reading the struct will mis-interpret the
fields when running on top of kernels with/without this patch.

/P

--===============6157067327817173041==--
