Content-Type: multipart/mixed; boundary="===============4114120300306802716=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 09/13] mptcp: move address attribute
 into mptcp_addr_info
Date: Mon, 14 Sep 2020 11:08:32 -0700
Message-ID: <alpine.OSX.2.23.453.2009141108150.57764@ningale-mobl.amr.corp.intel.com>
In-Reply-To: 16790a7f9e2919325d3f2e684597337c5e0833d9.1599854632.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5857

--===============4114120300306802716==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Sep 2020, Paolo Abeni wrote:

> So that can be accessed easily from the subflow creation
> helper. No functional change intended.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/pm_netlink.c | 39 ++++++++++++++++++++-------------------
> net/mptcp/protocol.h   |  5 +++--
> net/mptcp/subflow.c    |  5 ++---
> 3 files changed, 25 insertions(+), 24 deletions(-)
>

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============4114120300306802716==--
