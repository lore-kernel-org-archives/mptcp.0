Content-Type: multipart/mixed; boundary="===============2048334975380374097=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 1/4] mptcp: add __init annotation on
 setup functions
Date: Fri, 26 Jun 2020 14:24:39 -0700
Message-ID: <alpine.OSX.2.23.453.2006261423070.66996@redsall-mobl2.amr.corp.intel.com>
In-Reply-To: 37cfccea23f199a5e11497a11373786b0f3e078a.1593192442.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4833

--===============2048334975380374097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 26 Jun 2020, Paolo Abeni wrote:

> Add the missing annotation in some setup-only
> functions.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/pm.c         |  2 +-
> net/mptcp/pm_netlink.c |  2 +-
> net/mptcp/protocol.c   |  4 ++--
> net/mptcp/protocol.h   | 10 +++++-----
> net/mptcp/subflow.c    |  2 +-
> 5 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============2048334975380374097==--
