Content-Type: multipart/mixed; boundary="===============2503313749918900937=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net-next 12/16] selftests: mptcp: add
 remove cfg in mptcp_connect
Date: Thu, 24 Sep 2020 17:24:15 -0700
Message-ID: <alpine.OSX.2.23.453.2009241723580.62831@mmahler-mobl1.amr.corp.intel.com>
In-Reply-To: aa4ffb8cb7f8c135e5704eb11cfce7cb0bf7ecd4.1600853093.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6036

--===============2503313749918900937==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Sep 2020, Geliang Tang wrote:

> This patch added a new cfg, named cfg_remove in mptcp_connect. This new
> cfg_remove is copied from cfg_join. The only difference between them is in
> the do_rnd_write function. Here we slow down the transfer process of all
> data to let the RM_ADDR suboption can be sent and received completely.
> Otherwise the remove address and subflow test cases don't work.
>
> Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> Acked-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> .../selftests/net/mptcp/mptcp_connect.c        | 18 +++++++++++++++---
> 1 file changed, 15 insertions(+), 3 deletions(-)

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============2503313749918900937==--
