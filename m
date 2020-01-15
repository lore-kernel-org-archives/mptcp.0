Content-Type: multipart/mixed; boundary="===============2058228745553845419=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] subflow: remove unneded memory barriers
Date: Tue, 14 Jan 2020 17:34:47 -0800
Message-ID: <alpine.OSX.2.21.2001141645470.26562@ndoyal-mobl1.amr.corp.intel.com>
In-Reply-To: 20200114231949.20106-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3358

--===============2058228745553845419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Jan 2020, Florian Westphal wrote:

> squashto: mptcp: Implement MPTCP receive path
>
> The bit set operation has no prior dependencies, so
> smp_mb__before_atomic() is not needed.
>
> It has no followup depenency: the woken task will always see the
> bit set, plus wakeup code (called via sk_data_ready) acquires a spinlock.
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> net/mptcp/subflow.c | 4 ----
> 1 file changed, 4 deletions(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index abd97d1a8645..ae9173040f17 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -712,9 +712,7 @@ static void subflow_data_ready(struct sock *sk)
> 	}
>
> 	if (mptcp_subflow_data_available(sk)) {
> -		smp_mb__before_atomic();
> 		set_bit(MPTCP_DATA_READY, &mptcp_sk(parent)->flags);
> -		smp_mb__after_atomic();
>
> 		parent->sk_data_ready(parent);
> 	}
> @@ -869,9 +867,7 @@ static void subflow_state_change(struct sock *sk)
> 	 * the data available machinery here.
> 	 */
> 	if (parent && subflow->mp_capable && mptcp_subflow_data_available(sk)) {
> -		smp_mb__before_atomic();
> 		set_bit(MPTCP_DATA_READY, &mptcp_sk(parent)->flags);
> -		smp_mb__after_atomic();
>
> 		parent->sk_data_ready(parent);
> 	}
> -- =

> 2.24.1

I agree that these barriers are not needed.

--
Mat Martineau
Intel
--===============2058228745553845419==--
