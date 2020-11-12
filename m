Content-Type: multipart/mixed; boundary="===============2633049747419579560=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 2/2] mptcp: rename
 add_addr_signal and mptcp_add_addr_status
Date: Thu, 12 Nov 2020 15:56:41 -0800
Message-ID: <fa7c9de-21b3-ce99-e7eb-467e23973b6b@linux.intel.com>
In-Reply-To: 2a154d3ce605aac31539c0e1c5798bd8ff44b409.1604935892.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6709

--===============2633049747419579560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Nov 2020, Geliang Tang wrote:

> Since the RM_ADDR signal had been reused with add_addr_signal, it's not
> suitable to call it add_addr_signal or mptcp_add_addr_status. So this
> patch renamed add_addr_signal to addr_signal, and renamed
> mptcp_add_addr_status to mptcp_addr_signal_status.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/pm.c         | 14 +++++++-------
> net/mptcp/pm_netlink.c |  4 ++--
> net/mptcp/protocol.h   | 14 +++++++-------
> 3 files changed, 16 insertions(+), 16 deletions(-)
>

Looks good to me!

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============2633049747419579560==--
