Content-Type: multipart/mixed; boundary="===============7351325724493728825=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net-next 15/16] mptcp: add
 sk_stop_timer_sync helper
Date: Thu, 24 Sep 2020 17:26:33 -0700
Message-ID: <alpine.OSX.2.23.453.2009241726230.62831@mmahler-mobl1.amr.corp.intel.com>
In-Reply-To: 31247220b62d6759de9eb91b841be449714b9d69.1600853093.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6039

--===============7351325724493728825==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Sep 2020, Geliang Tang wrote:

> This patch added a new helper sk_stop_timer_sync, it deactivates a timer
> like sk_stop_timer, but waits for the handler to finish.
>
> Acked-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> include/net/sock.h | 2 ++
> net/core/sock.c    | 7 +++++++
> 2 files changed, 9 insertions(+)

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============7351325724493728825==--
