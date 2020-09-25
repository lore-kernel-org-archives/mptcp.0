Content-Type: multipart/mixed; boundary="===============3923290585478237264=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net-next 01/16] mptcp: rename addr_signal
 and the related functions
Date: Thu, 24 Sep 2020 17:17:06 -0700
Message-ID: <alpine.OSX.2.23.453.2009241716300.62831@mmahler-mobl1.amr.corp.intel.com>
In-Reply-To: bfecdd638bb74a02de1c3f1c84239911e304fcc3.1600853093.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6029

--===============3923290585478237264==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Sep 2020, Geliang Tang wrote:

> This patch renamed addr_signal and the related functions with the explicit
> word "add".
>
> Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/options.c  | 14 +++++++-------
> net/mptcp/pm.c       | 12 ++++++------
> net/mptcp/protocol.h | 10 +++++-----
> 3 files changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============3923290585478237264==--
