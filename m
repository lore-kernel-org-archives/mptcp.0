Content-Type: multipart/mixed; boundary="===============8553725681742206962=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net-next 10/16] mptcp: add RM_ADDR related
 mibs
Date: Thu, 24 Sep 2020 17:21:24 -0700
Message-ID: <alpine.OSX.2.23.453.2009241721080.62831@mmahler-mobl1.amr.corp.intel.com>
In-Reply-To: 644420f22ba6f0b9f9f3509c081d8d639ff4bbf3.1600853093.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6034

--===============8553725681742206962==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Sep 2020, Geliang Tang wrote:

> This patch added two new mibs for RM_ADDR, named MPTCP_MIB_RMADDR and
> MPTCP_MIB_RMSUBFLOW, when the RM_ADDR suboption is received, increase
> the first mib counter, when the local subflow is removed, increase the
> second mib counter.
>
> Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> Acked-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/mib.c        | 2 ++
> net/mptcp/mib.h        | 2 ++
> net/mptcp/pm_netlink.c | 5 +++++
> 3 files changed, 9 insertions(+)

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============8553725681742206962==--
