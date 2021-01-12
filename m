Content-Type: multipart/mixed; boundary="===============2313279549204120358=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next 2/4] mptcp: re-enable sndbuf autotune
Date: Mon, 11 Jan 2021 17:01:52 -0800
Message-ID: <29c696a-c2a5-23d4-de1d-f559d61fcf0@linux.intel.com>
In-Reply-To: ac2c6974c3b150a94a80e3b92b07afb9d97f601a.1610359105.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7318

--===============2313279549204120358==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Jan 2021, Paolo Abeni wrote:

> After commit 6e628cd3a8f7 ("mptcp: use mptcp release_cb for
> delayed tasks"), MPTCP never sets the flag bit SOCK_NOSPACE
> on its subflow. As a side effect, autotune never takes place,
> as it happens inside tcp_new_space(), which in turn is called
> only when the mentioned bit is set.
>
> Let's sendmsg() set the subflows NOSPACE bit when looking for
> more memory. Additionally, cleanup the sndbuf propagation from
> subflow into the msk, leveraging the subflow write space callback
> and dropping a bunch of duplicate code.
>
> This also makes the SNDBUF_LIMITED chrono relevant again
> for MPTCP subflows.
>
> Fixes: 6e628cd3a8f7 ("mptcp: use mptcp release_cb for delayed tasks")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> v1 -> v2:
> - leverage the previous commit, so we can always simply set the nospace
>   bit on the msk/parent socket
> ---
> net/mptcp/protocol.c | 57 +++++++++++++++++++-------------------------
> net/mptcp/protocol.h | 20 ++++++++++++++++
> net/mptcp/subflow.c  | 10 +++++++-
> 3 files changed, 53 insertions(+), 34 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ada69495a51b..a64b2f6fb17b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

> @@ -1421,7 +1410,8 @@ static struct sock *mptcp_subflow_get_send(struct m=
ptcp_sock *msk,
> 		 send_info[1].ssk, send_info[1].ratio);
>
> 	/* pick the best backup if no other subflow is active */
> -	if (!nr_active)
> +	msk->use_backup =3D !nr_active;
> +	if (msk->use_backup)

This is the only place msk->use_backup is read. Is this a leftover from =

v1?


--
Mat Martineau
Intel
--===============2313279549204120358==--
