Content-Type: multipart/mixed; boundary="===============4773278180120079066=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 09/20] mptcp: Rename tw_lock to mpcb_list_lock
Date: Fri, 14 Sep 2018 17:21:11 -0700
Message-ID: <alpine.OSX.2.21.1809141719040.12208@abuanzol-mobl1.amr.corp.intel.com>
In-Reply-To: 20180914172524.67961-12-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 747

--===============4773278180120079066==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 14 Sep 2018, Christoph Paasch wrote:

> The lock is going to cover more than just the tw-list.
> Namely, the subflow-list stored in the mpcb.
>
> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> (cherry picked from commit 411ffb5c2b2a42d578f11b800c97f23db1cb77ee)
> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> ---
> include/net/mptcp.h    |  4 +++-
> net/mptcp/mptcp_ctrl.c | 14 +++++++-------
> 2 files changed, 10 insertions(+), 8 deletions(-)
>

I haven't found any issues with the patch set up to this point, and will =

continue reviewing on Monday.

--
Mat Martineau
Intel OTC

--===============4773278180120079066==--
