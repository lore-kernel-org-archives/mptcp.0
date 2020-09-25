Content-Type: multipart/mixed; boundary="===============5907473055958156251=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net-next 11/16] mptcp: add
 mptcp_destroy_common helper
Date: Thu, 24 Sep 2020 17:23:39 -0700
Message-ID: <alpine.OSX.2.23.453.2009241723250.62831@mmahler-mobl1.amr.corp.intel.com>
In-Reply-To: fcebccadfa3127e0f55103cc7ee4cd00841e2ea0.1600853093.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6035

--===============5907473055958156251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Sep 2020, Geliang Tang wrote:

> This patch added a new helper named mptcp_destroy_common containing the
> shared code between mptcp_destroy() and mptcp_sock_destruct().
>
> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/protocol.c | 11 ++++++++---
> net/mptcp/protocol.h |  1 +
> net/mptcp/subflow.c  |  4 +---
> 3 files changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============5907473055958156251==--
