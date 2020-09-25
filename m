Content-Type: multipart/mixed; boundary="===============3223447068484569492=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net-next 08/16] mptcp: remove addr and
 subflow in PM netlink
Date: Thu, 24 Sep 2020 17:20:43 -0700
Message-ID: <alpine.OSX.2.23.453.2009241720290.62831@mmahler-mobl1.amr.corp.intel.com>
In-Reply-To: 37f2befac450fb46367f62446a4bb2c9d0a5986a.1600853093.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6032

--===============3223447068484569492==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Sep 2020, Geliang Tang wrote:

> This patch implements the remove announced addr and subflow logic in PM
> netlink.
>
> When the PM netlink removes an address, we traverse all the existing msk
> sockets to find the relevant sockets.
>
> We add a new list named anno_list in mptcp_pm_data, to record all the
> announced addrs. In the traversing, we check if it has been recorded.
> If it has been, we trigger the RM_ADDR signal.
>
> We also check if this address is in conn_list. If it is, we remove the
> subflow which using this local address.
>
> Since we call mptcp_pm_free_anno_list in mptcp_destroy, we need to move
> __mptcp_init_sock before the mptcp_is_enabled check in mptcp_init_sock.
>
> Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> Acked-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/pm.c         |   7 ++-
> net/mptcp/pm_netlink.c | 122 +++++++++++++++++++++++++++++++++++++++--
> net/mptcp/protocol.c   |   9 +--
> net/mptcp/protocol.h   |   2 +
> net/mptcp/subflow.c    |   1 +
> 5 files changed, 130 insertions(+), 11 deletions(-)

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============3223447068484569492==--
