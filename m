Content-Type: multipart/mixed; boundary="===============3905643479770317580=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net-next 03/16] mptcp: add the incoming
 RM_ADDR support
Date: Thu, 24 Sep 2020 17:19:50 -0700
Message-ID: <alpine.OSX.2.23.453.2009241718510.62831@mmahler-mobl1.amr.corp.intel.com>
In-Reply-To: bf7aca2bee20de148728e30343734628aee6d779.1600853093.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6031

--===============3905643479770317580==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Sep 2020, Geliang Tang wrote:

> This patch added the RM_ADDR option parsing logic:
>
> We parsed the incoming options to find if the rm_addr option is received,
> and called mptcp_pm_rm_addr_received to schedule PM work to a new status,
> named MPTCP_PM_RM_ADDR_RECEIVED.
>
> PM work got this status, and called mptcp_pm_nl_rm_addr_received to handle
> it.
>
> In mptcp_pm_nl_rm_addr_received, we closed the subflow matching the rm_id,
> and updated PM counter.
>
> Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/options.c    |  5 +++++
> net/mptcp/pm.c         | 12 ++++++++++++
> net/mptcp/pm_netlink.c | 34 ++++++++++++++++++++++++++++++++++
> net/mptcp/protocol.c   | 12 ++++++++----
> net/mptcp/protocol.h   |  7 +++++++
> 5 files changed, 66 insertions(+), 4 deletions(-)

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============3905643479770317580==--
