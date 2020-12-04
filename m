Content-Type: multipart/mixed; boundary="===============1367692451095770190=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v7 mptcp-next 1/7] mptcp: create the
 listening socket for new port
Date: Thu, 03 Dec 2020 17:47:10 -0800
Message-ID: <6816d41f-9856-10f1-8b61-8ca75ac1dbc@linux.intel.com>
In-Reply-To: 9bfd982aa08d39d84846b7fa655230dc11e91f1c.1606716547.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7034

--===============1367692451095770190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 30 Nov 2020, Geliang Tang wrote:

> This patch created a listening socket when an address with a port-number
> is added by PM netlink. Then binded the new port to the socket, and
> listened for the connection.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/pm_netlink.c | 58 ++++++++++++++++++++++++++++++++++++++++++
> net/mptcp/protocol.c   |  2 +-
> net/mptcp/protocol.h   |  3 +++
> net/mptcp/subflow.c    |  4 +--
> 4 files changed, 64 insertions(+), 3 deletions(-)
>

Another thing I don't think we discussed yet with this "extra listening =

socket" approach: what do we do about socket options?

Are there any options we should be concerned about on this listening =

socket? Should SO_REUSEADDR be set by default?

--
Mat Martineau
Intel
--===============1367692451095770190==--
