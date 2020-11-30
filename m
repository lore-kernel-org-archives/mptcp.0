Content-Type: multipart/mixed; boundary="===============3346782990164114774=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 6/6] mptcp: use mptcp release_cb for
 delayed tasks
Date: Mon, 30 Nov 2020 15:45:18 -0800
Message-ID: <98a5b8cf-4c8a-bd28-111-9261d743a3bd@linux.intel.com>
In-Reply-To: b62cc1e06a7924ac60e9c320e6535e2ec9900065.1606413118.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6997

--===============3346782990164114774==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Nov 2020, Paolo Abeni wrote:

> We have some tasks triggered by the subflow receive path
> which require to access the msk socket status, specifically:
> mptcp_clean_una() and mptcp_push_pending()
>
> We have almost everything in place to defer to the msk
> release_cb such tasks when the msk sock is owned.
>
> Since the worker is no more used to clean the acked data,
> for fallback sockets we need to explicitly flush them.
>
> As an added bonus we can move the wake-up code in __mptcp_clean_una(),
> simplify a lot mptcp_poll() and move the timer update under
> the data lock.
>
> The worker is now used only to process and send DATA_FIN
> packets and do the mptcp-level retransmissions.
>
> Acked-by: Florian Westphal <fw(a)strlen.de>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/options.c  |  18 +++-
> net/mptcp/protocol.c | 250 ++++++++++++++++++++++++++-----------------
> net/mptcp/protocol.h |   3 +
> net/mptcp/subflow.c  |  14 +--
> 4 files changed, 168 insertions(+), 117 deletions(-)

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============3346782990164114774==--
