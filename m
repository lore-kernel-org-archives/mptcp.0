Content-Type: multipart/mixed; boundary="===============6482766732899214005=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 3/6] mptcp: add set_flags
 command in PM netlink
Date: Thu, 10 Dec 2020 17:27:58 -0800
Message-ID: <675d76c9-0ed-563-56a7-3c811496f526@linux.intel.com>
In-Reply-To: 3639b094ea3ddc00ace88c000285558031d5951e.1607501232.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7141

--===============6482766732899214005==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Dec 2020, Geliang Tang wrote:

> This patch added a new command MPTCP_PM_CMD_SET_FLAGS in PM netlink:
>
> In mptcp_nl_cmd_set_flags, parse the input address, get the backup value
> according to whether the address's FLAG_BACKUP flag is set from the
> user-space. Then check whether this address had been added in the local
> address list. If it had been, then call mptcp_nl_addr_backup to deal with
> this address.
>
> In mptcp_nl_addr_backup, traverse all the existing msk sockets to find
> the relevant sockets, and call mptcp_pm_nl_mp_prio_send_ack to send out
> a MP_PRIO ACK packet.
>
> Finally in mptcp_nl_cmd_set_flags, set or clear the address's FLAG_BACKUP
> flag.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> include/uapi/linux/mptcp.h |  1 +
> net/mptcp/pm_netlink.c     | 65 ++++++++++++++++++++++++++++++++++++++
> 2 files changed, 66 insertions(+)
>

One more thing: we should have iproute2 patches ready before sending this =

series to netdev.

--
Mat Martineau
Intel
--===============6482766732899214005==--
