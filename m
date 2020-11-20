Content-Type: multipart/mixed; boundary="===============3009629236649369358=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v4 mptcp-next 1/2] mptcp: drop
 rm_addr_signal flag
Date: Fri, 20 Nov 2020 13:56:15 -0800
Message-ID: <cb456719-2967-8346-925e-b1722a69be29@linux.intel.com>
In-Reply-To: 3d9cfa584f992f387bf4722693f4edfc79b9f6af.1605866519.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6885

--===============3009629236649369358==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 20 Nov 2020, Geliang Tang wrote:

> This patch reused add_addr_signal for the RM_ADDR announcing signal, by
> defining a new ADD_ADDR status named MPTCP_RM_ADDR_SIGNAL. Then the flag
> rm_addr_signal in PM could be dropped.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/pm.c       | 18 +++++++++++++++---
> net/mptcp/protocol.h |  4 ++--
> 2 files changed, 17 insertions(+), 5 deletions(-)
>

Looks good to me, thanks Geliang.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============3009629236649369358==--
