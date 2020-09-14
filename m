Content-Type: multipart/mixed; boundary="===============3083879216886321845=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 04/13] mptcp: basic sndbuf autotuning
Date: Mon, 14 Sep 2020 11:04:22 -0700
Message-ID: <alpine.OSX.2.23.453.2009141103540.57764@ningale-mobl.amr.corp.intel.com>
In-Reply-To: 3f5500f120bf9a196abf3b7b1b307a1e48f8c715.1599854632.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5852

--===============3083879216886321845==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Sep 2020, Paolo Abeni wrote:

> Let the msk sendbuf track the size of the larger subflow's
> send window, so that we ensure mptcp_sendmsg() does not
> exceed MPTCP-level send window.
>
> The update is performed just before try to send any data.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 17 +++++++++++++----
> 1 file changed, 13 insertions(+), 4 deletions(-)
>

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============3083879216886321845==--
