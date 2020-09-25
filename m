Content-Type: multipart/mixed; boundary="===============2497811928016444810=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net-next 09/16] mptcp: implement
 mptcp_pm_remove_subflow
Date: Thu, 24 Sep 2020 17:21:03 -0700
Message-ID: <alpine.OSX.2.23.453.2009241720500.62831@mmahler-mobl1.amr.corp.intel.com>
In-Reply-To: 5018fd495529e058ea866e8d8edbe0bb98ec733a.1600853093.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6033

--===============2497811928016444810==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Sep 2020, Geliang Tang wrote:

> This patch implemented the local subflow removing function,
> mptcp_pm_remove_subflow, it simply called mptcp_pm_nl_rm_subflow_received
> under the PM spin lock.
>
> We use mptcp_pm_remove_subflow to remove a local subflow, so change it's
> argument from remote_id to local_id.
>
> We check subflow->local_id in mptcp_pm_nl_rm_subflow_received to remove
> a subflow.
>
> Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/pm.c         |  9 +++++++--
> net/mptcp/pm_netlink.c | 33 +++++++++++++++++++++++++++++++++
> net/mptcp/protocol.h   |  3 ++-
> 3 files changed, 42 insertions(+), 3 deletions(-)

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============2497811928016444810==--
