Content-Type: multipart/mixed; boundary="===============0375977475001496178=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/2] uapi: update linux/mptcp.h
Date: Tue, 14 Apr 2020 12:02:10 +0200
Message-ID: <6a98a756c131b8d6cca2d42cb4ebf987f08d1207.camel@redhat.com>
In-Reply-To: 46efbc7d07ec2e52eb100e3237c23213637b0ab7.1586444916.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4163

--===============0375977475001496178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-04-14 at 10:24 +0200, Paolo Abeni wrote:
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  include/uapi/linux/mptcp.h | 88 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 include/uapi/linux/mptcp.h
> =

> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> new file mode 100644
> index 00000000..dfd6674c
> --- /dev/null
> +++ b/include/uapi/linux/mptcp.h
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +#ifndef _UAPI_MPTCP_H
> +#define _UAPI_MPTCP_H
> +
> +#include <linux/types.h>
> +
> +#define MPTCP_SUBFLOW_FLAG_MCAP_REM		BIT(0)
> +#define MPTCP_SUBFLOW_FLAG_MCAP_LOC		BIT(1)
> +#define MPTCP_SUBFLOW_FLAG_JOIN_REM		BIT(2)
> +#define MPTCP_SUBFLOW_FLAG_JOIN_LOC		BIT(3)
> +#define MPTCP_SUBFLOW_FLAG_BKUP_REM		BIT(4)
> +#define MPTCP_SUBFLOW_FLAG_BKUP_LOC		BIT(5)
> +#define MPTCP_SUBFLOW_FLAG_FULLY_ESTABLISHED	BIT(6)
> +#define MPTCP_SUBFLOW_FLAG_CONNECTED		BIT(7)
> +#define MPTCP_SUBFLOW_FLAG_MAPVALID		BIT(8)

Davide just noted I used to old/wrong uapi header, will sync-up in the
next iteration - possibly directly upstream.

> +
> +enum {
> +	MPTCP_SUBFLOW_ATTR_UNSPEC,
> +	MPTCP_SUBFLOW_ATTR_TOKEN_REM,
> +	MPTCP_SUBFLOW_ATTR_TOKEN_LOC,
> +	MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ,
> +	MPTCP_SUBFLOW_ATTR_MAP_SEQ,
> +	MPTCP_SUBFLOW_ATTR_MAP_SFSEQ,
> +	MPTCP_SUBFLOW_ATTR_SSN_OFFSET,
> +	MPTCP_SUBFLOW_ATTR_MAP_DATALEN,
> +	MPTCP_SUBFLOW_ATTR_FLAGS,
> +	MPTCP_SUBFLOW_ATTR_ID_REM,
> +	MPTCP_SUBFLOW_ATTR_ID_LOC,
> +	MPTCP_SUBFLOW_ATTR_PAD,
> +	__MPTCP_SUBFLOW_ATTR_MAX
> +};
> +
> +#define MPTCP_SUBFLOW_ATTR_MAX (__MPTCP_SUBFLOW_ATTR_MAX - 1)
> +
> +/* netlink interface */
> +#define MPTCP_PM_NAME		"mptcp_pm"
> +#define MPTCP_PM_CMD_GRP_NAME	"mptcp_pm_cmds"
> +#define MPTCP_PM_VER		0x1
> +
> +/*
> + * ATTR types defined for MPTCP
> + */
> +enum {
> +	MPTCP_PM_ATTR_UNSPEC,
> +
> +	MPTCP_PM_ATTR_ADDR,				/* nested address */
> +	MPTCP_PM_ATTR_RCV_ADD_ADDRS,			/* u32 */
> +	MPTCP_PM_ATTR_SUBFLOWS,				/* u32 */
> +
> +	__MPTCP_PM_ATTR_MAX
> +};
> +
> +#define MPTCP_PM_ATTR_MAX (__MPTCP_PM_ATTR_MAX - 1)
> +
> +enum {
> +	MPTCP_PM_ADDR_ATTR_UNSPEC,
> +
> +	MPTCP_PM_ADDR_ATTR_FAMILY,			/* u16 */
> +	MPTCP_PM_ADDR_ATTR_ID,				/* u8 */
> +	MPTCP_PM_ADDR_ATTR_ADDR4,			/* struct in_addr */
> +	MPTCP_PM_ADDR_ATTR_ADDR6,			/* struct in6_addr */
> +	MPTCP_PM_ADDR_ATTR_PORT,			/* u16 */
> +	MPTCP_PM_ADDR_ATTR_FLAGS,			/* u32 */
> +	MPTCP_PM_ADDR_ATTR_IF_IDX,			/* s32 */
> +
> +	__MPTCP_PM_ADDR_ATTR_MAX
> +};
> +
> +#define MPTCP_PM_ADDR_ATTR_MAX (__MPTCP_PM_ADDR_ATTR_MAX - 1)
> +
> +#define MPTCP_PM_ADDR_FLAG_SIGNAL			(1 << 0)
> +#define MPTCP_PM_ADDR_FLAG_SUBFLOW			(1 << 1)
> +#define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
> +
> +enum {
> +	MPTCP_PM_CMD_UNSPEC,
> +
> +	MPTCP_PM_CMD_ADD_ADDR,
> +	MPTCP_PM_CMD_DEL_ADDR,
> +	MPTCP_PM_CMD_GET_ADDR,
> +	MPTCP_PM_CMD_FLUSH_ADDRS,
> +	MPTCP_PM_CMD_SET_LIMITS,
> +	MPTCP_PM_CMD_GET_LIMITS,
> +
> +	__MPTCP_PM_CMD_AFTER_LAST
> +};
> +
> +#endif /* _UAPI_MPTCP_H */


--===============0375977475001496178==--
