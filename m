Content-Type: multipart/mixed; boundary="===============3824734300249869275=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next 4/5] genetlink: add CAP_NET_ADMIN
 test for multicast bind
Date: Tue, 26 Jan 2021 08:55:46 -0800
Message-ID: <62cac863-4050-a5b6-832-28afe88a3a1e@linux.intel.com>
In-Reply-To: 20210120154337.27997-5-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7491

--===============3824734300249869275==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Jan 2021, Florian Westphal wrote:

> genetlink sets NL_CFG_F_NONROOT_RECV for its netlink socket so anyone can
> subscribe to multicast messages.
>
> rtnetlink doesn't allow this unconditionally,  rtnetlink_bind() restricts
> bind requests to CAP_NET_ADMIN for a few groups.
>
> This allows to set GENL_UNS_ADMIN_PERM flag on genl mcast groups to
> mandate CAP_NET_ADMIN.
>
> This will be used by the upcoming mptcp netlink event facility which
> exposes the token (mptcp connection identifier) to userspace.
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> include/net/genetlink.h |  1 +
> net/netlink/genetlink.c | 32 ++++++++++++++++++++++++++++++++
> 2 files changed, 33 insertions(+)
>

Acked-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============3824734300249869275==--
