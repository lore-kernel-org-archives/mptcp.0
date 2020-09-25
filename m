Content-Type: multipart/mixed; boundary="===============6970709104310940619=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net-next 02/16] mptcp: add the outgoing
 RM_ADDR support
Date: Thu, 24 Sep 2020 17:17:22 -0700
Message-ID: <alpine.OSX.2.23.453.2009241717100.62831@mmahler-mobl1.amr.corp.intel.com>
In-Reply-To: e3c9ab612d773465ddf78cef0482208c73a0ca07.1600853093.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6030

--===============6970709104310940619==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Sep 2020, Geliang Tang wrote:

> This patch added a new signal named rm_addr_signal in PM. On outgoing pat=
h,
> we called mptcp_pm_should_rm_signal to check if rm_addr_signal has been
> set. If it has been, we sent out the RM_ADDR option.
>
> Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/options.c  | 29 +++++++++++++++++++++++++++++
> net/mptcp/pm.c       | 25 +++++++++++++++++++++++++
> net/mptcp/protocol.h |  9 +++++++++
> 3 files changed, 63 insertions(+)

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============6970709104310940619==--
